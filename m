Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA07928
	for <selinux@tycho.nsa.gov>; Sun, 2 Sep 2001 18:06:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA15183
	for <selinux@tycho.nsa.gov>; Sun, 2 Sep 2001 22:06:22 GMT
Received: from windowpane.com (ip56.gte1.rb1.bel.nwlink.com [209.20.131.56])
	by jazzband.ncsc.mil  with ESMTP id WAA15179
	for <selinux@tycho.nsa.gov>; Sun, 2 Sep 2001 22:06:21 GMT
Message-ID: <001b01c133fb$8d6e0490$3a8314d1@nwlink.com>
Reply-To: "Conan Callen" <ccallen@windowpane.com>
From: "Conan Callen" <ccallen@windowpane.com>
To: <selinux@tycho.nsa.gov>
References: <200109021627.SAA09636@donald.oleane.net>
Subject: Re: Question regarding security policy configuration
Date: Sun, 2 Sep 2001 15:06:44 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Paul,

I too am new to selinux. I had it installed, and everything was working fine
until Friday. I had two hard-drives go out on me! (there old timers).
Stephen Smalley sent me the message below on fixing the errors you have
encountered. I havent had a chance to work through it yet. I've finally got
some replacement hard-drives working and am now building the new kernel.

My first time through I had missed a step or two, and had some other strange
problems. This time I am going very carefully.

Conan


--- Message from Stephen Smalley ---


Ok, let's go through these:

avc:  denied  { write search } for  pid=1504 exe=/usr/sbin/sendmail
path=/var/spool/mqueue dev=03:41 ino=32194
      scontext=system_u:system_r:system_crond_t
      tcontext=system_u:object_r:mqueue_spool_t
      tclass=dir

The root cause of this access denial (and several of the subsequent
denials) is that crond is running sendmail without transitioning into
an appropriate domain.  The question is why is sendmail being run
from one of your system cron jobs?  Anyway, if you want to do this,
just add the following to policy/domains/system/crond.te and
do a 'make load' in your policy directory:
domain_auto_trans(system_crond_t, sendmail_exec_t, user_mail_t)

avc:  denied  { getattr } for  pid=1932 exe=/usr/bin/slocate dev=00:06
ino=1582
      kernel:    scontext=system_u:system_r:system_crond_t
      kernel:    tcontext=system_u:object_r:unlabeled_t
      kernel:    tclass=dir

This is probably because you are running the automounter.  Unless you
really need it, shut it off.

avc:  denied  { write } for  pid=2003 exe=/usr/local/bin/logtail
path=/var/log/messages.offset dev=03:41 ino=81507
      scontext=system_u:system_r:system_crond_t
      tcontext=system_u:object_r:var_log_t
      tclass=file

So, what is /usr/local/bin/logtail?  And why is it run from crond,
and why is it trying to write to /var/log?  Anyway, if you want to
allow this, you can use the logrotate_t domain as an example.
You can either label /usr/local/bin/logtail with logrotate_exec_t
if it just needs the same permissions as logrotate, or you can
define a separate domain for it that is similar.

avc:  denied  { execute } for  pid=2327 exe=/bin/bash path=/usr/bin/which
dev=03:41 ino=351008
      scontext=system_u:system_r:atd_t
      tcontext=system_u:object_r:bin_t
      tclass=file

The atd domain is just a stub, because we don't use it for anything (why
not just use cron?).  If you really want to use atd, then you'll need to
add some permissions to it.  Also, you may even want to extend atd in the
same way that we changed crond so that it runs in different security
contexts depending on what it is doing.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
