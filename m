Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA15842
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 09:59:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA17691
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 14:56:30 GMT
Received: from prserv.net (asmtp1.prserv.net [32.97.166.51])
	by jazzswing.ncsc.mil  with ESMTP id OAA17687
	for <selinux@tycho.nsa.gov>; Sun, 22 Dec 2002 14:56:30 GMT
Message-Id: <200212221456.OAA17687@jazzswing.ncsc.mil>
Date: Sun, 22 Dec 2002 9:58:31 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: selinux <selinux@tycho.nsa.gov>
Subject: avc: denied
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Finally I got booted the SELinux image for the first time and saw quite a few messages with "avc: denied"

I am at step 13 in the README file.  In the policy directory I did "make relabel" and got similar type of messages.  These
are the same type of messages I saw at boot up time.

===================
avc:  denied  { search } for  pid=848 exe=/usr/bin/perl path=/var/www/mrtg dev=03:01 ino=272926 scontext=system_u:system_r:crond_t tcontext=system_u:object_r:httpd_sys_content_t tclass=dir

avc:  denied  { remove_name } for  pid=848 exe=/usr/bin/perl path=/var/lock/mrtg/_etc_mrtg.cfg_l_848 dev=03:01 ino=337074 scontext=system_u:system_r:crond_t tcontext=system_u:object_r:var_lock_mrtg_t tclass=dir

avc:  denied  { unlink } for  pid=848 exe=/usr/bin/perl path=/var/lock/mrtg/_etc_mrtg.cfg_l_848 dev=03:01 ino=337074 scontext=system_u:system_r:crond_t tcontext=system_u:object_r:var_lock_mrtg_t tclass=file

avc:  denied  { write } for  pid=848 exe=/usr/bin/perl path=/var/lib/mrtg/_etc_mrtg.cfg dev=03:01 ino=337333 scontext=system_u:system_r:crond_t tcontext=system_u:object_r:var_lib_mrtg_t tclass=file
===================

What part of the policy do I need to look at to avoid these messages?  Or is this a standard security message?

Subba Rao
sailorn@attglobal.net
2002-12-22



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
