Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5PLG8Yv014511
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 17:16:08 -0400
Received: from g1t0027.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5PLG75a002952
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 21:16:07 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g1t0027.austin.hp.com (Postfix) with ESMTP id 3C6AF38059
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 21:16:07 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g4t0009.houston.hp.com (Postfix) with ESMTP id E61407C464
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 21:16:06 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 6F6D139C084
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 15:16:06 -0600 (MDT)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jSFYaRH5R5xV for <selinux@tycho.nsa.gov>;
	Wed, 25 Jun 2008 15:16:03 -0600 (MDT)
Received: from flek.lan (squirrel.fc.hp.com [15.11.146.57])
	by ldl.fc.hp.com (Postfix) with ESMTP id 4FF6039C082
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 15:16:02 -0600 (MDT)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: ANN: netlabel_tools version 0.18
Date: Wed, 25 Jun 2008 17:15:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806251715.56536.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello everyone,

I just released netlabel_tools version 0.18 which can be downloaded from 
SourceForge at the URL below.  There are a lot of changes in this 
release including bug fixes and support for the static/fallback labels 
added to the 2.6.25 kernel; the changelog is pasted below.  If you have 
any questions or run into any problems don't hesitate to send me mail.

 * http://netlabel.sf.net

Changelog:
o Fixed some problems when printing CIPSOv4 and map information when not 
using the '-p' flag
o Always display an error message if an error occurred, based on patch 
from Klaus Weidner <klaus@atsec.com>
o Included a patch from Hagen Paul Pfeifer <pfeifer@netlab.nec.de> to 
fix a problem when building with LIBNL_VERSION >= 1006
o Only use size_t and not ssize_t to specify datum sizes/lengths
o Updated the netlabelctl man page with more text and examples
o Removed the RPM specfile which included all contributions by Steve 
Grubb <sgrubb@redhat.com>
o Updated copyright notice to GPLv2 only, received explicit approval 
from both Klaus Weidner <klaus@atsec.com> and Hagen Paul Pfeifer 
<pfeifer@netlab.nec.de>
o Updated the README
o Add libnl v 1.0-pre8 compatible code and make it the default (needed 
for Fedora Rawhide post F8)
o Renamed the CIPSOv4 'std' mapping to 'trans' to better reflect it's 
usage, 'std' still works but is marked as deprecated
o Merged the 'static-label' branch which provides fallback/static 
labeling support
o Renamed the 'nlbl_mgmt_domain' structure to 'nlbl_dommap'
o Converted the the same tab/ident spacing as the Linux kernel
o Removed the structure typedefs in libnetlabel.h
o Added some crude documentation to the types defined in libnetlabel.h

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
