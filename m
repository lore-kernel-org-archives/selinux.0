Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23237
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 09:13:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA16477
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 14:11:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA16473
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 14:11:55 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id JAA26780
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 09:11:32 -0500 (EST)
Date: Tue, 26 Dec 2000 09:11:31 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: anyone out there?
In-Reply-To: <Pine.LNX.4.30.0012230037590.28695-100000@biocserver.BIOC.CWRU.Edu>
Message-ID: <Pine.SOL.3.95.1001226082905.26114A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Sat, 23 Dec 2000, Jose Nazario wrote:

> it seems i have to reload the policy file if i add or modify a user's
> name, yes? it makes sense.. i just want to make sure that this is right.

Yes, you need to modify the policy/users file and run "make load"
in the policy directory (after logging into the sysadm_r role and
sysadm_t domain or using newrole to transition to that role and domain).

> also, the new programming calls make it seem like policying an app could
> be a small matter, much like SOCKifying an app. is this also correct?

In many cases, the security policy can be completely transparent to
the application.  The security policy can be configured to automatically
cause a transition to an appropriate process security context by default
when a particular application is executed.  The security policy can also
be configured to automatically label files created by an application with
a particular security context by default.  Different file labeling 
defaults can be defined for an application based on the label of
the containing directory.  The kernel controls can be used to
transparently protect and control an application.

Depending on your security objectives for the application, it
may be necessary to use the new system calls provided by
the process management, file system, or networking subsystems to
explicitly get or set the security context of a subject or an object.
If you want the application to act as a policy-enforcing
object manager for the abstractions managed by the application,
then the application will need to use the new system calls
provided by the security server to obtain policy decisions.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
