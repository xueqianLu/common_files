// Last Update:2018-04-08 11:04:16
/**
 * @file client.cpp
 * @brief 
 * @author luxueqian
 * @version 0.1.00
 * @date 2018-03-22
 */

#include <stdio.h>
#include<errno.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<netdb.h>
#include<linux/if.h>
#include<linux/if_packet.h>
#include<linux/sockios.h>
#include<linux/if_ether.h>
#include <sys/ioctl.h>
#include<string.h>

#define PROTOCOL_TYPE 0x8d8d

struct socks {
    int fd;
    struct sockaddr_ll addr;
} dp_socket;


unsigned char source_mac[6] = {0};

const unsigned char d_mac_1[6] = {0xb0,0xd5,0xcc,0x45,0x19,0xc9}; // arm-demo
const unsigned char d_mac_2[6] = {0x00,0x0c,0x29,0x8b,0xe1,0xd8}; // vm
const unsigned char d_mac_3[6] = {0xe4,0x70,0xb8,0x42,0x65,0x1c}; // pc
const unsigned char d_mac_4[6] = {0x0c,0xb2,0xb7,0xae,0x0c,0x43}; // arm-eth0
const unsigned char d_mac_5[6] = {0x0c,0xb2,0xb7,0xae,0x0c,0x45}; // arm-eth1

int create_sockets(char *ethname)
{
    struct ifreq       ifr;
    struct sockaddr_ll addr;
    int                retval;
    int                s;
    __u16              type;

    type = htons(PROTOCOL_TYPE);
    dp_socket.fd = -1;
    s = socket (PF_PACKET, SOCK_RAW, type);

    if (s < 0) {
        printf("socket error, you need root permission, errno = %d.\n", errno);
        return (s);
    }

    memset ((void*)&ifr, 0, sizeof (ifr));

    snprintf (ifr.ifr_name, sizeof (ifr.ifr_name), ethname);
    retval = ioctl (s, SIOCGIFINDEX, &ifr);
    if (retval < 0) {
        close (s);
        printf("ioctl error.\n");
        return (retval);
    }

    memset (&addr, 0, sizeof (addr));
    addr.sll_family   = AF_PACKET;
    addr.sll_ifindex  = ifr.ifr_ifindex;
    addr.sll_protocol = type;

    //get source macaddress.
    retval = ioctl (s, SIOCGIFHWADDR, &ifr);
    if (retval < 0) {
        close (s);
        printf("ioctl error.\n");
        return (retval);
    }
    memcpy(source_mac,ifr.ifr_hwaddr.sa_data,ETH_ALEN);

    retval = bind (s, (struct sockaddr *) &addr, sizeof (addr));
    if (retval < 0) {
        close (s);
        printf("bind error.\n");
        return (retval);
    }

    dp_socket.fd = s;
    memset(&dp_socket.addr, 0, sizeof(dp_socket.addr));

    dp_socket.addr.sll_family  = AF_PACKET;
    dp_socket.addr.sll_ifindex = ifr.ifr_ifindex;
    dp_socket.addr.sll_protocol = type;
    return 0;
}

int main(int argc, char *argv[])
{
    int i;
    int ret;
    char wbuf[512];
    struct ethhdr *whdr = (struct ethhdr *)wbuf;

    // example: ./s_test eth0 10 0
    char *ethname = NULL;
    if(argc < 2)
        ethname = "eth0";
    else
        ethname = argv[1];

    create_sockets(ethname);

    memset(wbuf + sizeof(*whdr), 0, 512 - sizeof(*whdr));
    memcpy(wbuf + sizeof(*whdr), "coming", 7);


    int count = 10;
    if(argc > 2) count = atoi(argv[2]);

    int client = 0;
    if(argc > 3) client = atoi(argv[3]);

    // set ethernet header.
    if(client == 0)
        memcpy(whdr->h_dest, d_mac_1, ETH_ALEN);
    else if (client == 1)
        memcpy(whdr->h_dest, d_mac_2, ETH_ALEN);
    else if (client == 2)
        memcpy(whdr->h_dest, d_mac_3, ETH_ALEN);
    else if (client == 3)
        memcpy(whdr->h_dest, d_mac_4, ETH_ALEN);
    else if (client == 4)
        memcpy(whdr->h_dest, d_mac_5, ETH_ALEN);

    memcpy(whdr->h_source, source_mac, ETH_ALEN);
    whdr->h_proto = htons(PROTOCOL_TYPE);

    while (count > 0) {
        ret = write(dp_socket.fd, wbuf, 7+sizeof(*whdr));
        printf("after write, write ret = %d..\n", ret);
        count--;
        sleep(1);
    }
    printf("write finished.\n");

    return 0;
}
