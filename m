Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EHLsu7010974
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 13:21:54 -0400
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8EHL0Jg013240
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 17:21:01 GMT
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 14 Sep 2006 19:21:51 +0200
From: selinux770@tortenboxer.de
Message-ID: <20060914172151.119780@gmx.net>
MIME-Version: 1.0
Subject: Cannot find your entry in the shadow passwd file
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hey there,

i've got a strange problem. I created a new user on my system which is
not able to switch between different roles. Looks like this:

~ $ id -Z
setester:user_r:user_t
~ $ newrole -r staff_r
Authenticating setester.
Cannot find your entry in the shadow passwd file.
~ $

This happens to all users except root:

~# id -Z
root:staff_r:staff_t
~# newrole -r sysadm_r
Authenticating root.
Password:
~# id -Z
root:sysadm_r:sysadm_t

Any suggestions what is wrong? Could that be a misfunction in pam?

-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
