Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rBCMWunx030834
	for <selinux@tycho.nsa.gov>; Thu, 12 Dec 2013 17:32:56 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux fixes for 3.13
Date: Thu, 12 Dec 2013 17:32:50 -0500
Message-ID: <2686888.TAheoMSe76@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi James,

Here are a few patches to fix problems in 3.13-rcX.  One some memory leak fix 
for patches introduced in 3.13 and four patches to resolve a long standing 
issue with TCP SYN-ACKs.  All of these patches have been part of linux-next 
for at least a day and pass the SELinux testsuite without issue.

Enjoy,
-Paul

---
The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:

  Linux 3.12 (2013-11-03 15:41:51 -0800)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux_fixes master

for you to fetch changes up to c0828e50485932b7e019df377a6b0a8d1ebd3080:

  selinux: process labeled IPsec TCP SYN-ACK packets properly in
           selinux_ip_postroute() (2013-12-12 17:21:31 -0500)

----------------------------------------------------------------
Geyslan G. Bem (1):
      selinux: fix possible memory leak

Paul Moore (5):
      Merge tag 'v3.12'
      selinux: handle TCP SYN-ACK packets correctly in selinux_ip_output()
      selinux: handle TCP SYN-ACK packets correctly in selinux_ip_postroute()
      selinux: look for IPsec labels on both inbound and outbound packets
      selinux: process labeled IPsec TCP SYN-ACK packets properly in
               selinux_ip_postroute()

 security/selinux/hooks.c        |  137 +++++++++++++++++++++++++++++++-------
 security/selinux/include/xfrm.h |    8 +-
 security/selinux/xfrm.c         |   62 ++++++++++++++----
 3 files changed, 165 insertions(+), 42 deletions(-)

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
