Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB7GibMA000733
	for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2005 11:44:37 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB7GbK44021878
	for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2005 16:37:20 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 11:40:07 -0500
Message-Id: <1133973607.8185.10.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
SourceForge from http://serefpolicy.sourceforge.net.  The primary
activity for this release has been preparing and testing Reference
Policy for inclusion in Fedora Core 5 as it's targeted policy.  In
addition, several build issues have been fixed.  The change log follows
at the bottom of the email.

Again, for those that are interesting in contributing, right now the
best help would be to convert existing policies over to reference
policy; there is a list of modules on the reference policy status page
on SourceForge.

* Wed Dec 07 2005 Chris PeBenito <selinux@tresys.com> - 20051207
- Add unlabeled IPSEC association rule to domains with
  networking permissions.
- Merge systemuser back in to users, as these files
  do not need to be split.
- Add check for duplicate interface/template definitions.
- Move domain, files, and corecommands modules to kernel
  layer to resolve some layering inconsistencies.
- Move policy build options out of Makefile into build.conf.
- Add yppasswd to nis module.
- Change optional_policy() to refer to the module name
  rather than modulename.te.
- Fix labeling targets to use installed file_contexts rather
  than partial file_contexts in the policy source directory.
- Fix build process to use make's internal vpath functions
  to detect modules rather than using subshells and find.
- Add install target for modular policy.
- Add load target for modular policy.
- Add appconfig dependency to the load target.
- Miscellaneous fixes from Dan Walsh.
- Fix corenetwork gen_context()'s to expand during the policy
  build phase instead of during the generation phase.  
- Added policies:
	amanda
	avahi
	canna
	cyrus
	dbskk
	dovecot
	distcc
	i18n_input
	irqbalance
	lpd
	networkmanager
	pegasus
	postfix
	procmail
	radius
	rdisc
	rpc
	spamassassin
	timidity
	xdm
	xfs


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
