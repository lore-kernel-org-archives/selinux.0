Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6RK2n1w020974
	for <selinux@tycho.nsa.gov>; Wed, 27 Jul 2011 16:02:49 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6RK2mgx012468
	for <selinux@tycho.nsa.gov>; Wed, 27 Jul 2011 20:02:49 GMT
Message-ID: <4E306EE8.6070106@tresys.com>
Date: Wed, 27 Jul 2011 16:02:48 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: ANN: SELinux Userspace Release
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux userspace project has updated a release. As usual, you can
find it at http://userspace.selinuxproject.org/trac/wiki/Releases

Changes in this release include:

* Add support for optional file name in type_transition rules by Eric Paris
* Add class field in role_transition rules by Harry Ciao
* Add role attribute support by Harry Ciao
* Add file_context.subs_dist for distro specific filecon substitutions
by Daniel Walsh
* Give correct names to mount points in load_policy by Daniel Walsh
* Make sure selinux state is reported correctly if selinux is disabled
or fails to load by Daniel Walsh
* Fix crash if selinux_key_create was never called by Daniel Walsh
* Use correct color range in mcstrand by Richard Haines
* Update man pages for selinux_color_* functions by Richard Haines
* Add db_language object class support for selabel_lookup from KaiGai Kohei
* Add selinux_status_* interfaces for /selinux/status from KaiGai Kohei
* Allow filesystem names to start with a digit by James Carter
* Allow single digit module versions by Daniel Walsh

For git users, this release has been tagged 20110727 in the repository
on userspace.selinuxproject.org

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
