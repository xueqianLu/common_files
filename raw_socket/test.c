// Last Update:2018-03-23 14:49:00
/**
 * @file test.c
 * @brief 
 * @author luxueqian
 * @version 0.1.00
 * @date 2018-03-22
 */

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <linux/if.h>
#include <linux/if_packet.h>
#include <linux/sockios.h>
#include <linux/if_ether.h>
#include <sys/ioctl.h>
#include <string.h>

#define PROTOCOL_TYPE 0x8d8d

int print_eth(struct ethhdr *eth)
{
    // custom defined type.
    if(ntohs(eth->h_proto) == PROTOCOL_TYPE )
    {
        printf("\nEthernet Header\n");
        printf("\t|-Source Address : %.2X-%.2X-%.2X-%.2X-%.2X-%.2X\n",eth->h_source[0],eth->h_source[1],eth->h_source[2],eth->h_source[3],eth->h_source[4],eth->h_source[5]);
        printf("\t|-Destination Address : %.2X-%.2X-%.2X-%.2X-%.2X-%.2X\n",eth->h_dest[0],eth->h_dest[1],eth->h_dest[2],eth->h_dest[3],eth->h_dest[4],eth->h_dest[5]);
        printf("\t|-Protocol : 0x%04x\n",ntohs(eth->h_proto));
        return 1;
    }
    else 
        return 0;
}

void print_data(unsigned char *p_data, int len)
{
    int i = 1;
    printf("\nEthernet Data\n");
    printf("\t|-Data : ");
    while(i <= len)
    {
        printf("%.2X",p_data[i]);
        if(i%16==0)
        {
            printf("\n");
            printf("\t|-Data : ");
        }
        i++;
        if(i > 128)
        {
            printf("\nStop for length 128.\n");
            break;
        }
    }
    printf("\n");
}

int main(int argc, char *argv[])
{
    int sock_r;
    int type = PROTOCOL_TYPE;
    sock_r = socket(AF_PACKET, SOCK_RAW, htons(type));
    if(sock_r < 0)
    {
        printf("socket error.\n");
        return 1;
    }
    unsigned char *buffer = (unsigned char *) malloc(65535);
    memset(buffer, 0, 65535);
    struct sockaddr saddr;
    int saddr_len = sizeof(saddr);
    while(1)
    {
        int buflen = recvfrom(sock_r, buffer, 65535, 0, &saddr, (socklen_t *)&saddr_len);
        if(buflen < 0)
        {
            printf("recvfrom error.\n");
            return -1;
        }
        struct ethhdr *eth = (struct ethhdr*)buffer;
        unsigned char *p_data = buffer + sizeof(struct ethhdr);
        if(print_eth(eth))
        {
            print_data(p_data, buflen - sizeof(struct ethhdr));
            sleep(2);
        }
        usleep(500*100);
    }

    return 0;
}
