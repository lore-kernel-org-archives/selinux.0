Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0HLTrXf009527
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 16:29:53 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0HLTmRq010985
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 21:29:49 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 16:31:06 -0500
Message-Id: <1137533466.29815.299.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
SourceForge from http://serefpolicy.sourceforge.net.  The primary
activity for this release has been converting modules needed for Fedora
Core 5's MLS policy.  The change log follows at the bottom of the email.

Again, for those that are interesting in contributing, right now the
best help would be to convert existing policies over to reference
policy; there is a list of modules on the reference policy status page
on SourceForge.

* Tue Jan 17 2006 Chris PeBenito <selinux@tresys.com> - 20060117
- Adds support for generating corenetwork interfaces based on attributes 
  in addition to types.
- Permit the listing of multiple nodes in a network_node() that will be
  given the same type.
- Add two new permission sets for stream sockets.
- Rename file type transition interfaces verb from create to
  filetrans to differentiate it from create interfaces without
  type transitions.
- Fix expansion of interfaces from disabled modules.
- Rsync can be long running from init, added rules to allow this.
- Add polyinstantiation build option.
- Add setcontext to the association object class.
- Add apache relay and db connect tunables.
- Rename texrel_shlib_t to textrel_shlib_t.
- Add swat to samba module.
- Numerous miscellaneous fixes from Dan Walsh.
- Added modules:
	alsa
	automount
	cdrecord
	daemontools (Petre Rodan)
	ddcprobe
	djbdns (Petre Rodan)
	fetchmail
	irc
	java
	lockdev
	logwatch (Dan Walsh)
	openct
	prelink (Dan Walsh)
	publicfile (Petre Rodan)
	readahead
	roundup
	screen
	slocate (Dan Walsh)
	slrnpull
	smartmon
	sysstat
	ucspitcp (Petre Rodan)
	usbmodules
	vbetool (Dan Walsh)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
