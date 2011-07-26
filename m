Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6QFUBlf006845
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2011 11:30:11 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6QFUAP9015196
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2011 15:30:10 GMT
Message-ID: <4E2EDD81.8080608@tresys.com>
Date: Tue, 26 Jul 2011 11:30:09 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Bumping Version Numbers
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A while ago ago we discussed bumping the minor version number and
resetting the revision version number when we do a release [1]. We are
now preparing for a release and wanted some feedback before we bumped
the version numbers.

We're thinking of only bumping minor version numbers if the revision
version number is non-zero.

So the version numbers will become:

checkpolicy-2.1.0
libselinux-2.1.0
libsepol-2.1.0
libsemanage-2.1.0
policycoreutils-2.1.0
sepolgen-1.1.0

We could alternatively always bump minor version numbers even if the
revision number was zero (i.e. no changes since the last release). This
has the advantange that all releases share the same version number. If
we do that, it might make sense to bump sepolgen to 2.1.0 this release
as well, unless there is some significance between 1.x and 2.x with
sepolgen.

Thoughts?

- Steve

[1] http://marc.info/?t=129962368300001&r=1&w=2

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
