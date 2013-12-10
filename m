Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rBAJrbGv025342
	for <selinux@tycho.nsa.gov>; Tue, 10 Dec 2013 14:53:38 -0500
Subject: [PATCH 0/2] Additional TCP SYN-ACK fixes for labeled IPsec
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: janak.desai@gtri.gatech.edu
Date: Tue, 10 Dec 2013 14:53:11 -0500
Message-ID: <20131210195150.3404.61178.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In addition to the patches posted earlier, there are two additional
labeled IPsec patches needed to fix up the SYN-ACK issue.

---

Paul Moore (2):
      selinux: look for IPsec labels on both inbound and outbound packets
      selinux: process labeled IPsec TCP SYN-ACK packets properly in selinux_ip_postroute()


 security/selinux/hooks.c        |   44 ++++++++++++++++++++++++++++------
 security/selinux/include/xfrm.h |    8 ++++--
 security/selinux/xfrm.c         |   51 +++++++++++++++++++++++++++++++--------
 3 files changed, 82 insertions(+), 21 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
