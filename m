Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i67LGOrT009094
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 17:16:24 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i67LG5Cu005647
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 21:16:05 GMT
Message-Id: <200407072116.i67LGASf001842@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>,
   "'Fedora SELinux support list for users & developers.'" <fedora-selinux-list@redhat.com>
Cc: <selinux-dev@tresys.com>
Subject: [ANN] setools 1.4.1 release
Date: Wed, 7 Jul 2004 17:16:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Setools version 1.4.1 has been released. It is available from the Tresys
webpage at http://www.tresys.com/selinux/ or the SELinux CVS repository on
sourceforge.

This is a minor bug fix release. The changes include:

- Support for version 18 policies.

- A fix for a time zone related bug in seaudit.

- The addition of the makefile target 'install-dev' that installs the
libraries and headers necessary for third party developers to use the
setools libraries (libapol, libseuser, libseaudit).

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
