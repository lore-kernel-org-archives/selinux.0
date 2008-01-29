Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0T2LD2E030675
	for <selinux@tycho.nsa.gov>; Mon, 28 Jan 2008 21:21:13 -0500
Received: from QMTA01.emeryville.ca.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0T2L8HG014425
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 02:21:09 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH] SELinux: Fix double free in selinux_netlbl_sock_setsid()
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, stable@kernel.org,
        bunk@kernel.org, jmorris@namei.org
Date: Mon, 28 Jan 2008 21:20:26 -0500
Message-ID: <20080129022026.7930.18782.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As pointed out by Adrian Bunk, commit 45c950e0f839fded922ebc0bfd59b1081cc71b70
caused a double-free when security_netlbl_sid_to_secattr() fails.  This patch
fixes this by removing the netlbl_secattr_destroy() call from that function
since we are already releasing the secattr memory in
selinux_netlbl_sock_setsid().

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/ss/services.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4bf715d..3a16aba 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2629,7 +2629,6 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 
 netlbl_sid_to_secattr_failure:
 	POLICY_RDUNLOCK;
-	netlbl_secattr_destroy(secattr);
 	return rc;
 }
 #endif /* CONFIG_NETLABEL */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
