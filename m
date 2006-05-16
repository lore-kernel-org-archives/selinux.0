Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4GFZP6Q019582
	for <selinux@tycho.nsa.gov>; Tue, 16 May 2006 11:35:25 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4GFZNf8014473
	for <selinux@tycho.nsa.gov>; Tue, 16 May 2006 15:35:23 GMT
Subject: Re: Latest diffs in policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4469E561.9070306@redhat.com>
References: <4468A509.50207@redhat.com> <1147719382.31984.11.camel@sgc>
	 <4468EA7C.5050708@redhat.com> <1147786502.31984.22.camel@sgc>
	 <4469E561.9070306@redhat.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 11:37:00 -0400
Message-Id: <1147793821.31984.27.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-16 at 10:44 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Mon, 2006-05-15 at 16:54 -0400, Daniel J Walsh wrote:    
> >> Required for LSPP.  auditadm is not allowed to do anything but manage 
> >> audit subsystem.
> >> secadmin can only manage selinux stuff.  sysadmin can only do everything 
> >> not done by auditadm
> >> and secadm.
> >>     
> >
> > I don't see how we're accomplishing this if secadm, auditadm, and sysadm
> > are using the admin_user_template().  It gives a lot of access including
> > raw disk access, signalling all domains, managing the source and binary
> > policies (explicitly given), and managing all files in general except
> > shadow, and running insmod.  The current implementation doesn't allow
> > for fine grained role definition yet (it is a planned improvement).
> >
> >   
> Yes I am about to remove secadm and auditadm from admin_user_template to 
> remove these privs.

In addition, I think it would be cleaner if sysadm were allowed to
manage all non-security files instead of just non-shadow files on MLS.
That would be a cleaner way to prevent sysadm from accessing the audit
files, but still allow appropriate behaviors for tools, and filesystem
association, etc.  The access to at least the binary policy file should
probably be removed on MLS too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
