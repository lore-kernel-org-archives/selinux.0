Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7BDYHHD003465
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 09:34:17 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7BDXx7f019149
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 13:33:59 GMT
Subject: [PATCH 0/3] Separate local file contexts into file_contexts.local
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 09:34:27 -0400
Message-Id: <1155303267.8722.60.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patches stop the local file contexts created by semanage
from being merged into the main file_contexts.  The local file contexts
will be written to file_contexts.local for appropriate priority over
file_contexts and file_contexts.homedir in
matchpathcon/setfiles/restorecon.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
