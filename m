Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4PLBAw7025085
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2010 17:11:10 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o4PLCS4f003451
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2010 21:12:28 GMT
Date: Tue, 25 May 2010 17:11:08 -0400
Subject: [ANN] SELinux Userspace release
From: Chad Sellers <csellers@tresys.com>
To: SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C821B52C.B8230%csellers@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux userspace project has updated a release. As usual you can find
it at http://userspace.selinuxproject.org/trac/wiki/Releases.

New features in this release include:

semodule enable/disable support
audit2allow support for generating dontaudit rules
Improved support across distributions
Improved man pages and help output
Improved handling of auditing in userspace object managers when
dontaudit/auditallow rules are involved
Support for running genhomedircon without examining /etc/passwd

For git users this release has been tagged 20100525 in the repository on
userspace.selinuxproject.org.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
