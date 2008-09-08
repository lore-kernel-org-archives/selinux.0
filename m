Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m88EECuv010737
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 10:14:12 -0400
Received: from mho-02-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m88EECGU000254
	for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2008 14:14:12 GMT
Received: from cpe-66-68-165-162.austin.res.rr.com ([66.68.165.162] helo=[192.168.20.230])
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1KchVL-000A98-3k
	for selinux@tycho.nsa.gov; Mon, 08 Sep 2008 14:14:11 +0000
Message-Id: <CE80DD8E-3D41-45C7-9F4B-04CD31F43767@nall.com>
From: Joe Nall <joe@nall.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Why are the socket mls constraints are different between ipsec and netlabel?
Date: Mon, 8 Sep 2008 09:14:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

IPSec and netlabel sockets behave differently if the ranges of the two  
sides of the connection are not identical. In the netlabel denial  
below, InputLog is single level and has no mls attributes, icm is  
ranged and has mlsnetread. This works with labeled IPSec.

type=AVC msg=audit(1220880975.110:308): avc:  denied  { recvfrom }  
for  pid=2341 comm="InputLog" saddr=192.168.20.247 src=10308  
daddr=192.168.20.247 dest=60897 netif=lo  
scontext=system_u:system_r:jcdx_ilog_t:s5:c0.c511  
tcontext=system_u:system_r:jcdx_icm_t:s0-s15:c0.c1023 tclass=tcp_socket

The source of the difference is in the recvfrom constraint. From  
policy/mls:
...
mlsconstrain association { recvfrom }
         ((( l1 dom l2 ) and ( l1 domby h2 )) or
          (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
          ( t1 == mlsnetread ) or
          ( t2 == unlabeled_t ));

...
# used by netlabel to restrict normal domains to same level connections
mlsconstrain { tcp_socket udp_socket rawip_socket } recvfrom
         (( l1 eq l2 ) or
          (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
          ( t1 == mlsnetread ));
...

If I use
# used by netlabel to restrict normal domains to same level connections
mlsconstrain { tcp_socket udp_socket rawip_socket } recvfrom
         ((( l1 dom l2 ) and ( l1 domby h2 )) or
          (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
          ( t1 == mlsnetread ));
...
then netlabel sockets behave like their IPSec brethren.

Is the difference intentional?

What purpose does the ( l1 domby h2 ) serve?

Should there be a netlabel constraint on sendto to match the IPSec  
sendto constraint?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
