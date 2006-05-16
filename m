Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4GDXQUR016250
	for <selinux@tycho.nsa.gov>; Tue, 16 May 2006 09:33:26 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4GDXPf8023480
	for <selinux@tycho.nsa.gov>; Tue, 16 May 2006 13:33:25 GMT
Subject: Re: Latest diffs in policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4468EA7C.5050708@redhat.com>
References: <4468A509.50207@redhat.com> <1147719382.31984.11.camel@sgc>
	 <4468EA7C.5050708@redhat.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 09:35:02 -0400
Message-Id: <1147786502.31984.22.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-15 at 16:54 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> >> Separation of the auditadm from secadm and sysadm changes for auditd files.
> >>     
> >
> > Filesystem association is missing.  This also brings along more problems
> > like labeling.  There isn't much real separation between auditadm from
> > the other admin roles, so this doesn't seem to have real benefits.
> >   
> Required for LSPP.  auditadm is not allowed to do anything but manage 
> audit subsystem.
> secadmin can only manage selinux stuff.  sysadmin can only do everything 
> not done by auditadm
> and secadm.

I don't see how we're accomplishing this if secadm, auditadm, and sysadm
are using the admin_user_template().  It gives a lot of access including
raw disk access, signalling all domains, managing the source and binary
policies (explicitly given), and managing all files in general except
shadow, and running insmod.  The current implementation doesn't allow
for fine grained role definition yet (it is a planned improvement).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
