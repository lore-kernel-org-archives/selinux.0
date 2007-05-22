Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4MILxEN031503
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 14:22:00 -0400
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4MILwk3002516
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 18:21:58 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <6AA1314E-2718-446E-BFC9-6961DE951E09@sf-net.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: AVC: IPv6 problems
Date: Tue, 22 May 2007 20:22:09 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

periodically I receive the following AVC denial:

audit(1179815459.477:213): avc:  denied  { rawip_send } for   
saddr=fe80:0000:0000:0000:0211:d8ff:feea:XXXX  
daddr=fe80:0000:0000:0000:0211:24ff:fee1:YYYY netif=eth0  
scontext=system_u:system_r:kernel_t:s15:c0.c255  
tcontext=system_u:object_r:link_local_node_t:s0 tclass=node

My local rule-set:

allow kernel_t link_local_node_t:node rawip_send;
# another AVC denial which often raises up
allow kernel_t compat_ipv4_node_t:node rawip_send;

The rules seem to be ignored. Every day I receive some of the  
mentioned AVC denials despite the fact that the TE rules are loaded.  
Is this a known problem with IPv6 traffic in LANs? Is there even a  
solution out?

Best regards,
Stefan

PS: I'm using Debian (etch) with refpolicy-20061212.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
