Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBLHu3Xf019290
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 12:56:03 -0500 (EST)
Received: from web51515.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id jBLHu1Ue006070
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 17:56:01 GMT
Message-ID: <20051221175602.98478.qmail@web51515.mail.yahoo.com>
Date: Wed, 21 Dec 2005 09:56:02 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Adding audit messge to newrole
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1135181946.18223.78.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>In addition to the comments on the patch, it doesn't seem to work for me
>on rawhide, either as root or a non-root user:

You may need an appropriately patched kernel. I am testing on the lspp.4 kernel
from:  http://david.woodhou.se/lspp/kernel/

this is what I get:

[root@localhost ~]# newrole -r system_r -t unconfined_t
Authenticating root.
Password:
[root@localhost ~]# ausearch -ts 12:44:00 -m USER_ROLE_CHANGE
----
time->Wed Dec 21 12:45:08 2005
type=USER_ROLE_CHANGE msg=audit(1135187108.964:67): user pid=2549 uid=0 auid=0
msg='newrole: old context=root:system_r:unconfined_t:SystemLow-SystemHigh new
context=root:system_r:unconfined_t:SystemLow-SystemHig: exe="/usr/bin/newrole"
(hostname=?, addr=?, terminal=/dev/tty1 res=success)'

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
