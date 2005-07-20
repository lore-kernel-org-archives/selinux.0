Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KFHXgA017279
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 11:17:34 -0400 (EDT)
Received: from register.uatop.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KFD6Dg008979
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 15:13:07 GMT
Received: from skipped_antispam (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id A6828307E9
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 18:12:48 +0300 (EEST)
Received: from [85.202.172.7] (ip.85.202.172.7.dyn.pool-4.broadband.voliacable.com [85.202.172.7])
	by register.uatop.com (Postfix) with ESMTP id 800A7308B4
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 18:11:33 +0300 (EEST)
Message-ID: <42DE6997.6060704@keeper.org.ua>
Date: Wed, 20 Jul 2005 18:11:19 +0300
From: Yevheniy Yevtushenko <keeper@keeper.org.ua>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: console param in kernel boot string causes deadlock
Content-Type: text/plain; charset=KOI8-U; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello!

I have faced problem with kernel boot log redirect. I tried to add 
'console=/dev/tty8 selinux=1 enforcing=1' and got immediate kernel hung 
up. It looks like deadlock or endless loop. There is no difference what 
value is in parameter ( /dev/tty0, /dev/console, /dev/null or whatever 
else). There is no output besides of grub boot message.
I have tried with FC3 kernel and FC4 kernel. There is no difference. But 
in permissive mode system boots up. And output goes to tty8. There is no 
corresponding avc messages in logs. make enableaudit does not show 
anything useful.
Have anybody either faced with it? Is this anything known?

-- 
Kind regards, Yevheniy Yevtushenko


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
