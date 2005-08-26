Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7QFuaOb025503
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 11:56:36 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7QFuWLr005498
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 15:56:32 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 11:57:40 -0400
Message-Id: <1125071860.18700.22.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
Sourceforge from http://serefpolicy.sourceforge.net.  The change log
follows at the bottom of the email.  In particular, Makefile support for
building loadable policy modules has been added, in addition to several
policies.

Again, for those that are interesting in contributing, right now the
best help would be to convert existing policies over to reference
policy; there is a list of modules on the status page on Sourceforge.
We are using the NSA example policy 1.23.2 as a baseline for the
policies (also available on the download page), and we ask that these
policies are used when converting modules.  After all of the policies
are converted over, then we will update reference policy to the current
NSA CVS policy.

- Add Makefile support for building loadable modules.
- Add genclassperms.py tool to add require blocks
  for loadable modules.
- Change sedoctool to make required modules part of base
  by default, otherwise make as modules, in modules.conf.
- Fix segenxml to handle modules with no interfaces.
- Rename ipsec connect interface for consistency.
- Add missing parts of unix stream socket connect interface
  of ipsec.
- Rename inetd connect interface for consistency.
- Rename interface for purging contents of tmp, for clarity,
  since it allows deletion of classes other than file.
- Misc. cleanups.
- Added policies:
	acct
	bind
	firstboot
	gpm
	howl
	ldap
	loadkeys
	mysql
	privoxy
	quota
	rshd
	rsync
	su
	sudo
	tcpd
	tmpreaper
	updfstab

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
