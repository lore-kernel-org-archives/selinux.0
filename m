Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA13486
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 10:35:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA13049
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 15:34:44 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA13045
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 15:34:43 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id KAA26707
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 10:33:55 -0500 (EST)
Date: Mon, 8 Jan 2001 10:33:55 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: Embedded SE Linux
In-Reply-To: <Pine.LNX.4.30.0101071510010.5312-100000@ausmac.net>
Message-ID: <Pine.SOL.3.95.1010108095352.22464J-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> Are there any plans to create an embedded se linux
> kernel ?

There are currently no plans to create an embedded SELinux kernel.

> I wasn't aware that Security Enhanced Linux added any cryptographic
> features to the Linux kernel - as far as I was aware it makes an attempt
> to remove the need for a single, omnipotent "root" user by assigning
> administration capabilities to other users.

Yes and no.  SELinux does not add any cryptographic features to the
kernel, but it is not simply a mechanism for decomposing the Unix
superuser.  SELinux provides flexible mandatory access controls
in the kernel.  Hence, it can enforce the separation of information
based on confidentiality and integrity requirements.  It can protect
against the unauthorized modification or disclosure of data.  It can 
protect applications against tampering or bypass.  It can prevent
the execution of untrustworthy applications.  It can protect
processes from interference by other processes.  It can confine
the potential damage caused by malicious or flawed programs.

> (A question for the SE Linux team while I'm here, if that's okay...
> Although it's been somewhat irrationally debated on Slashdot (nuff said),
> was there any particular technical reason for selecting Linux over
> OpenBSD or contributing to TrustedBSD (which is a set of patches for
> FreeBSD)?  Even putting the issue of security and crypto enhancements
> in OpenBSD aside, I'd have thought the "whole system" approach would make
> it easier to supply a kernel and userland patch that users could apply to
> /usr/src (as opposed to the "packager" model that alot of Linux distros
> tend to follow).)

There was no particular technical reason for using Linux rather than
one of the BSD variants.  Linux was simply viewed as the best 
platform for transferring the technology to a larger developer
and user community.  Since the SELinux development team is
small, it was not practical to create both a Linux-based and
a BSD-based implementation simultaneously.  

Robert Watson of the TrustedBSD project has expressed the intention
of drawing from the SELinux work for TrustedBSD on the trustedbsd-discuss
mailing list.  Hopefully, his work will produce an independent
implementation of kernel mandatory access controls for BSD that is
comparable to SELinux.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
