Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5CEGpH7024179
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2012 10:16:52 -0400
Message-ID: <4FD74F51.50809@tresys.com>
Date: Tue, 12 Jun 2012 10:16:49 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH 0/2] libsepol: fix segfault for missing initial sid context
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In working with the seandroid policy, I found that if you are missing an initial sid labeling statement, e.g.

sid devnull u:object_r:null_device:s0

the compiler will segfault during expand in context_copy().  This patch set moves the context_copy() to after the switch block in ocontext_copy_*(), and then adds a check in the initial sid case of the switch.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
