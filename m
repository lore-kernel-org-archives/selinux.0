Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i15J1BRb018522
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 14:01:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i15IZLl5009606
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 18:59:41 GMT
Received: from internode.on.net (bep1.adl2.internode.on.net [203.16.214.212])
	by jazzswing.ncsc.mil  with ESMTP id i158Cmlx022220
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 08:12:49 GMT
From: "keen" <keen@internode.on.net>
Reply-to: keen@internode.on.net
To: selinux@tycho.nsa.gov
Subject: make relabel error
Date: Thu, 05 Feb 2004 18:40:30 +1050
Message-id: <4021fa76.336.47d3.1608314121@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, while I am still using the README in
selinux-usr/selinux-doc of the december release as a guide
to setup selinux with a Fedora Core 1 box and a 2.6.2 kernel
from kernel.org, I have experienced some problem.

At step 5) of the readme which said to do a make relabel, I
encountered the following:

/usr/sbin/setfiles file_contexts/file_contexts `mount | awk
'/ext[23]/{print $3}'`
/usr/sbin/setfiles:  read 600 specifications
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_exec_t on line number 587
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_exec_t on line number 588
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_child_exec_t on line number 589
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_child_exec_t on line number 590
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_log_t on line number 591
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_child_exec_t on line number 722
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_child_exec_t on line number 723
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_child_exec_t on line number 724
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_child_exec_t on line number 725
/usr/sbin/setfiles:  invalid context
system_u:object_r:inetd_child_exec_t on line number 726
Exiting after 10 errors.
make: *** [relabel] Error 1

What have I missed? Could anyone help me on this? Your
attention is greatly appreciated. Thank you.

Regards,
Keen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
