Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA28893
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 14:59:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA09923
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 19:58:56 GMT
Received: from smtppop1pub.verizon.net (smtppop1pub.gte.net [206.46.170.20])
	by jazzswing.ncsc.mil  with ESMTP id TAA09919
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 19:58:55 GMT
Received: from mail1.bellatlantic.net (pool-141-157-103-60.balt.east.verizon.net [141.157.103.60])
	by smtppop1pub.verizon.net  with ESMTP
	for <selinux@tycho.nsa.gov>; id NAA49859184
	Tue, 20 Nov 2001 13:57:59 -0600 (CST)
Message-Id: <5.1.0.14.0.20011120145757.009e7820@impop.bellatlantic.net>
Date: Tue, 20 Nov 2001 14:58:57 -0500
To: selinux@tycho.nsa.gov
From: Dan Berberich <dberb@bellatlantic.net>
Subject: sendmail config question
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When simply sending mail from root to user or form user to user on 
localhost I get an avc denial message
avc: denied { remove_name search } for pid=675 exc=/bin/mail 
path=/var/spool/mail/user_02 dev=03:05 ino=310085
	scontext=user_02:user_r:user_t
	tcontext=system_u:object:r:mail_spool_t
t	class=dir
BUT, mail to root does not get denied.
Looking at sendmail.te there is the line:
	allow sendmail_t mail_spool_t:dir rw_dir_perms
how would I add the remove_name search (and other additional permissions 
for the directory file class)
I cannot seem to find the macro definition for them.

thank you
-Dan Berberich


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
