Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26609
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 10:06:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA13705
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 14:05:04 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA13701
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 14:05:03 GMT
Date: Fri, 3 May 2002 10:06:15 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Howard Holm <hdholm@epoch.ncsc.mil>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Updated Release
In-Reply-To: <200205022032.QAA16755@coalpipe.epoch.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0205031000070.16931-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The updated release (2002050211) has been imported and merged into the
sourceforge selinux CVS tree, under the 'nsa' module.  As usual, you can
access it via:

export CVSROOT=:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux
cvs -z3 co nsa

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com

On Thu, 2 May 2002, Howard Holm wrote:

> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated.  Two new technical reports are available
> in the documentation: a document describing the policy language and a
> document describing the current LSM implementation of SELinux.  The
> site also includes a new release of the LSM-based SELinux prototype.
> The stable (2.4) LSM-based SELinux prototype remains at kernel 2.4.18.
> The development (2.5) LSM-based SELinux prototype was updated to kernel
> 2.5.10.  A number of policy improvements, minor feature enhancements
> and bug fixes have also been made.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
