Content-Type: text/plain;
  charset="us-ascii"
From: Bill Laut <wlsel@verizon.net>
To: SELinux@tycho.nsa.gov
Subject: Q on nonuniform "recvfrom" avc message
Date: Tue, 8 Jul 2003 12:24:41 -0400
MIME-Version: 1.0
Message-Id: <200307081224.41939.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


First of all, thank you for the advice on my previous newbie question about 
the disappearing boot messages.  I'm now going through to edit my policy 
files to resolve the AVC messages.  

While reviewing the syslog output, I came across something else I was 
wondering if someone could please explain to me?  I'm connecting through a 
DSL with dynamic IP, and accordingly the DHCP server is polling me every two 
hours to reconfirm my lease on the address.  The incoming UDP packet is being 
silently logged and dropped by NetFilter, and in this case wouldn't matter 
because dhcpcd doesn't create a UDP socket on port 68 anyway.

Sporadically, I'm seeing an AVC message which suggests that kjournald is 
trying to receive the packet.  Below is a snippet from my syslog:

Jul  7 21:57:26 vortex kernel: UDP_rules: IN=eth1 OUT=
   MAC=00:50:ba:5e:22:f7:00:02:3b:00:db:ee:08:00 SRC=209.244.127.6
   DST=4.46.245.145 LEN=339 TOS=0x00 PREC=0x00 TTL=249 ID=53845 DF
   PROTO=UDP SPT=67 DPT=68 LEN=319

Jul  7 23:57:26 vortex kernel: UDP_rules: IN=eth1 OUT=
   MAC=00:50:ba:5e:22:f7:00:02:3b:00:db:ee:08:00 SRC=209.244.127.6
   DST=4.46.245.145 LEN=339 TOS=0x00 PREC=0x00 TTL=249 ID=41215 DF 
   PROTO=UDP SPT=67 DPT=68 LEN=319

Jul  8 01:57:26 vortex kernel: avc:  denied  { recvfrom } for  pid=11
   comm=kjournald saddr=209.244.127.6 source=17664 daddr=4.46.245.145 dest=339
   netif=eth1 scontext=system_u:system_r:initrc_t
   tcontext=system_u:object_r:netmsg_eth1_t tclass=packet_socket

Jul  8 01:57:26 vortex kernel: UDP_rules: IN=eth1 OUT=
   MAC=00:50:ba:5e:22:f7:00:02:3b:00:db:ee:08:00 SRC=209.244.127.6
   DST=4.46.245.145 LEN=339 TOS=0x00 PREC=0x00 TTL=249 ID=28605 DF PROTO=UDP
   SPT=67 DPT=68 LEN=319

Jul  8 03:57:26 vortex kernel: UDP_rules: IN=eth1 OUT=
   MAC=00:50:ba:5e:22:f7:00:02:3b:00:db:ee:08:00 SRC=209.244.127.6
   DST=4.46.245.145 LEN=339 TOS=0x00 PREC=0x00 TTL=249 ID=15995 DF PROTO=UDP
   SPT=67 DPT=68 LEN=319


Why is SELinux reporting that kjournald is trying to receive this packet?  Is 
it because the violation occured in the kernel while kjournald happened to be 
the currently executing process?  Or is SELinux telling me that there's a 
possible Trojan/BO/whatever buried inside of kjournald?

So far, this has occured in only two processes:  kjournald and klogd.  That's 
what sent my antennae up.

Finally, what is the "source=" and "dest=" reporting?  Are they supposed to be 
the source/destination port numbers?  It appears that there might be an error 
as the dest= number appears to be the packet length.

Thank you in advance for your advice.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
