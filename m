Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83KLurT010606
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 16:21:56 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83KL5FY029768
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 20:21:05 GMT
Message-Id: <200409032021.i83KLmSf008254@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: <selinux-dev@tresys.com>
Subject: ANN: binary policy modules initial prototype
Date: Fri, 3 Sep 2004 16:21:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An initial release of the binary policy module infrastructure is available
from http://www.tresys.com/selinux/. The binary policy module project aims
to ease policy management by developing tools for creating binary policy
modules that can be safely linked together on a production system to create
a system policy. To the end user, managing binary policy modules will be
similar to managing software with a binary package manager like RPM. More
information can be found on the website.

This infrastructure will include a module compiler (checkmodule) and a set
of programs for policy management (linkmodule, expandmodule, and semodule).
This release is a snapshot of the current development tree and is not
intended for use. It is being released to generate community feedback and
discussion. The tools in this release include checkmodule, linkmodule and
expandmodule.

Comments and questions are welcome.

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
