Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16446
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 15:58:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA12106
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 19:56:43 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA12100
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 19:56:43 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g9NJvu201650
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 15:57:56 -0400 (EDT)
Date: Wed, 23 Oct 2002 15:57:56 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: Updated Release
In-Reply-To: <200210231416.KAA04799@coalpipe.epoch.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0210231555590.25774-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The updated release (2002102211) has been imported and merged into the
sourceforge selinux CVS tree under the 'nsa' module.  As usual, you can
check out a copy via:

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa

On Wed, 23 Oct 2002, Howard Holm wrote:

> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated. The site includes a new release of the
> LSM-based SELinux prototype. The base 2.5 kernel version has been
> updated to 2.5.44. The base 2.4 kernel version remains at 2.4.19, but
> many changes have been made to the 2.4 LSM patch and to the 2.4 SELinux
> module since the last release. The modified login, sshd and crond
> programs have been updated to use a new configuration scheme. Socket
> handling has been improved. Internally, precondition functions have
> been removed in favor of early initialization support. The modified tar
> has been updated to tar-1.13.25. A number of other improvements, bug
> fixes and policy enhancements have taken place.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
