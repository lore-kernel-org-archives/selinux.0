Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5P5GC3E027444
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 01:16:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5P5FOss001153
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 05:15:24 GMT
Received: from monk.verbum.org (mx-outgoing.verbum.org [216.226.142.159])
	by jazzswing.ncsc.mil  with ESMTP id h5P5FOhY001150
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 05:15:24 GMT
Subject: Re: local policy changes, /var/lib access, syslogd
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200306251422.26574.russell@coker.com.au>
References: <1056505792.29159.43.camel@columbia>
	 <200306251354.20028.russell@coker.com.au> <1056514151.744.8.camel@columbia>
	 <200306251422.26574.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1056518166.744.20.camel@columbia>
Mime-Version: 1.0
Date: 25 Jun 2003 01:16:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-06-25 at 00:22, Russell Coker wrote:
> On Wed, 25 Jun 2003 14:09, Colin Walters wrote:
> > > Is sshd configured to have a privsep directory under /var/lib?
> >
> > I don't have any privsep stuff in my sshd config, no.
> >
> > > I suspect that postfix_master_t is trying to copy files around to setup a
> > > chroot environment.  For my machines I configure postfix to not use
> > > chroot.
> >
> > I did that as well on the advice of weasel (from #selinux irc).  But I
> > still get that message.
> 
> Please give me the full log details from dmesg, 

It just looks like this (for example):

avc:  denied  { search } for  pid=5269 exe=/usr/lib/postfix/tlsmgr path=/lib dev=16:01 ino=32769 scontext=system_u:system_r:postfix_master_t tcontext=system_u:object_r:var_lib_t tclass=dir
 
avc:  denied  { search } for  pid=5340 exe=/usr/lib/postfix/master path=/lib dev=16:01 ino=32769 scontext=system_u:system_r:postfix_master_t tcontext=system_u:object_r:var_lib_t tclass=dir

> and tell me what operations 
> are necessary to cause it (restart of daemon, make connection, etc).

Restarting postfix causes it for me.

> Maybe libnss_db.

Ok, interesting.  After I remove the 'db' lines in /etc/nsswitch.conf,
the avc denial for /usr/lib/postfix/master goes away, but the one for
/usr/lib/postfix/tlsmgr stays!  I guess I'm going to have to resort to
stracing it here...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
