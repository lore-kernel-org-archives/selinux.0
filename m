Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBLKdFeI012655
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2010 15:39:15 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id oBLKdEiA020542
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2010 20:39:14 GMT
Date: Tue, 21 Dec 2010 15:39:12 -0500
Subject: [ANN] SELinux Userspace release
From: Chad Sellers <csellers@tresys.com>
To: SELinux <selinux@tycho.nsa.gov>
Message-ID: <C9367AA0.BBC1A%csellers@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux userspace project has updated a release. As usual you can find
it at http://userspace.selinuxproject.org/trac/wiki/Releases.

New features in this release include:

* Support for on-the-fly sandboxing of applications, including X
applications
* Support for MLS/MCS translations
* Improved robustness in multithreaded processes
* Support for building under GCC 4.6
* Simplification of login context computation logic
* newrole support for libcap-ng
* Improved robustness in label computation

For git users this release has been tagged 20101221 in the repository on
userspace.selinuxproject.org.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
