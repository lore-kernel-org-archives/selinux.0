Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA13607
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 08:53:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA22464
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 12:52:20 GMT
Received: from mailgate5.cinetic.de (mailgate5.cinetic.de [217.72.192.165])
	by jazzswing.ncsc.mil  with ESMTP id MAA22460
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 12:52:19 GMT
Received: from web.de (fmomail01.dlan.cinetic.de [172.20.1.45])
	by mailgate5.cinetic.de (8.11.2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id g7SCrQX31618
	for selinux@tycho.nsa.gov; Wed, 28 Aug 2002 14:53:27 +0200
Date: Wed, 28 Aug 2002 14:53:27 +0200
Message-Id: <200208281253.g7SCrQX31618@mailgate5.cinetic.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?Mark=20M=FCller?= <trusted@web.de>
To: selinux@tycho.nsa.gov
Subject: Direct logins (via local and ssh) as httpd_admin_r?
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I can't login directly as httpd_admin_r. The default_context is set properly, but the following error occurs:

Local login:

avc:  denied  { transition } for  pid=2178 exe=/bin/login path=/bin/bash dev=08:07 ino=46120 scontext=system_u:system_r:local_login_t tcontext=webadmin:httpd_admin_r:httpd_admin_t tclass=process

SSH login:
avc:  denied  { transition } for  pid=2183 exe=/usr/sbin/sshd path=/bin/bash dev=08:07 ino=46120 scontext=system_u:system_r:sshd_t tcontext=webadmin:httpd_admin_r:httpd_admin_t tclass=process

I cannot solve this neither with:
allow sshd_t httpd_admin_t:process { transition };

nor with
domain_trans(sshd_t, shell_exec_t, httpd_admin_t)

(Login as user_t and newrole -r httpd_admin_r works)

Any solutions? 

Thanks in advance.
______________________________________________________________________________
Die witzigsten E-Mail-Adressen der Welt! Schon ab 2 Zeichen!
Jetzt auswahlen unter http://digitaledienste.web.de/MyAdress/?mc=021101


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
