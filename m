Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA05783
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 09:23:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA15289
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 13:22:47 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id NAA15281
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 13:22:46 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: audit bug in fd handling
Date: Wed, 10 Jul 2002 09:23:20 -0400
Message-ID: <007501c22814$f5949e90$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020710074550.C3E6D106@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Perhaps this is why mail is the #1 exploited service.  So what's the
solution?  

Ed

=> -----Original Message-----
=> From: owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov] On
=> Behalf Of Russell Coker
=> Sent: Wednesday, July 10, 2002 3:46 AM
=> To: SE Linux
=> Subject: audit bug in fd handling
=> 
=> It seems that when a file handle open read/write is inherited by a
domain
=> that is permitted read access only, an error about write access will
be
=> logged - even if there is a dontaudit rule!
=> 
=> Here's the dmesg log:
=> avc:  denied  { write } for  pid=4731 exe=/usr/sbin/sendmail
=> path=/spool/fcron/fcrjob-Ldo3Uf (deleted) dev=03:08 ino=27923
=> scontext=system_u:system_r:system_mail_t
=> tcontext=system_u:object_r:system_crond_tmp_t tclass=file
=> 
=> Here's a grep from policy.conf:
=> dontaudit system_mail_t system_crond_tmp_t:file write;
=> 
=> 
=> Incidentally I'm changing the way mail sending operates.  Having
daemons
=> send
=> mail as sysadm_mail_t is ugly, and having them send mail as
user_mail_t
=> is
=> wrong.  I've created a new system_mail_t for this.
=> 
=> --
=> I do not get viruses because I do not use MS software.
=> If you use Outlook then please do not put my email address in your
=> address-book so that WHEN you get a virus it won't use my address in
the
=> >From field.
=> 
=> --
=> You have received this message because you are subscribed to the
selinux
=> list.
=> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
=> with
=> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
