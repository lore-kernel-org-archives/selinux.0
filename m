Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5U5X7ix024972
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 01:33:07 -0400
Received: from mho-02-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5U5X67j013454
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 05:33:06 GMT
Received: from cpe-66-25-156-148.austin.res.rr.com ([66.25.156.148] helo=[192.168.20.230])
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1KDC0g-000OvZ-27
	for selinux@tycho.nsa.gov; Mon, 30 Jun 2008 05:33:06 +0000
Message-Id: <4EE2EE24-1926-4370-A83E-C52101EE3254@nall.com>
From: Joe Nall <joe@nall.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: range_transition question
Date: Mon, 30 Jun 2008 00:33:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to get the X server running as  
user_u:user_r:user_xserver_t:s0-s15:c0.c1023 using a ranged transition.

...
mls_rangetrans_source(user_t)
mls_rangetrans_target(user_xserver_t)
domtrans_pattern(user_t,xserver_exec_t,user_xserver_t)
range_transition user_t xserver_exec_t:process s0 - s15:c0.c1023;
...

but I'm still seeing the following avc:

type=AVC msg=audit(1214800869.443:84): avc:  denied  { transition }  
for  pid=2298 comm="xinit" path="/usr/bin/Xorg" dev=dm-0 ino=549292  
scontext=user_u:user_r:user_t:s0  
tcontext=user_u:user_r:user_xserver_t:s0-s15:c0.c1023 tclass=process

The transition works in permissive, so I'm apparently violating a  
constraint. What am I missing?

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
