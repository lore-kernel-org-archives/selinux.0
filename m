From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux@tycho.nsa.gov
Subject: tcpdump
Date: Sun, 13 Apr 2003 20:07:45 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304132007.45102.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just tried using a machine as a router when it didn't have the correct SE 
policy for network access.
I get messages such as the following:
avc:  denied  { rawip_send } for  saddr=210.49.228.68 daddr=61.95.69.3 
netif=eth0 scontext=system_u:object_r:netmsg_eth1_t 
tcontext=system_u:object_r:netif_eth0_t tclass=netif
AVC: 4 messages suppressed.

Also while doing a tcpdump on eth1 (which is receiving the packets) I see the 
following:

20:13:00.281497 0:0:0:0:0:60 1:80:c2:0:0:1 8808 60:
                         0001 0000 0000 8808 0001 0000 0000 8808
                         0001 0000 0000 8808 0001 0000 0000 8808
                         0001 0000 0000 8808 0001 0000 0000
20:13:00.323438 0:0:0:0:0:60 1:80:c2:0:0:1 8808 60:
                         0001 0000 0000 8808 0001 0000 0000 8808
                         0001 0000 0000 8808 0001 0000 0000 8808
                         0001 0000 0000 8808 0001 0000 0000
20:13:00.365378 0:0:0:0:0:60 1:80:c2:0:0:1 8808 60:
                         0001 0000 0000 8808 0001 0000 0000 8808
                         0001 0000 0000 8808 0001 0000 0000 8808
                         0001 0000 0000 8808 0001 0000 0000

It seems that there is some confusion between the code for packet capture and 
the SE Linux code as to what exactly is being blocked.  Presumably there 
should be no packets received by tcpdump if things are operating correctly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
