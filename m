Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA01390
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 09:13:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA12852
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 14:12:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA12848
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 14:12:38 GMT
Date: Thu, 22 Feb 2001 09:12:11 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: jgko@etri.re.kr
cc: selinux@tycho.nsa.gov
Subject: Re: questions...
In-Reply-To: <NEBBKCIACMGHCEFINOAEGELOCAAA.jgko@etri.re.kr>
Message-ID: <Pine.SOL.3.95.1010222090308.12837C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> I am wondering whether or not SELINUX checks DAC which supported 
> by orginal LINUX for access control decision..
> if so... is there any priority between Type Enforcement and DAC
> otherwise,  all policy should be allowed...?

The SELinux mandatory access controls are performed independently
of the existing Linux discretionary access controls.  Both forms
of access control must approve an operation in order for it to
be performed.  At some point, we may experiment with extending
the mandatory access control architecture to permit the mandatory
access control policy to override discretionary access denials
to provide a similar mechanism to the Linux capabilities.  In
one of the predecessors of SELinux (the DTOS system), the NSA
implemented this kind of extension, and used it to allow the
Type Enforcement policy to override discretionary denials.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
