Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1RK0Mg6005128
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2009 15:00:22 -0500
Received: from g4t0015.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1RJuojj014237
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2009 19:56:51 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH] selinux: Fix a panic in selinux_netlbl_inode_permission()
To: selinux@tycho.nsa.gov
Cc: rick.mcneal@lsi.com
Date: Fri, 27 Feb 2009 15:00:03 -0500
Message-ID: <20090227200003.14235.99157.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rick McNeal from LSI identified a panic in selinux_netlbl_inode_permission()
caused by a certain sequence of SUNRPC operations.  The problem appears to be
due to the lack of NULL pointer checking in the function; this patch adds the
pointer checks so the function will exit safely in the cases where the socket
is not completely initialized.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/netlabel.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 3f4b266..350794a 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -386,11 +386,12 @@ int selinux_netlbl_inode_permission(struct inode *inode, int mask)
 	if (!S_ISSOCK(inode->i_mode) ||
 	    ((mask & (MAY_WRITE | MAY_APPEND)) == 0))
 		return 0;
-
 	sock = SOCKET_I(inode);
 	sk = sock->sk;
+	if (sk == NULL)
+		return 0;
 	sksec = sk->sk_security;
-	if (sksec->nlbl_state != NLBL_REQUIRE)
+	if (sksec == NULL || sksec->nlbl_state != NLBL_REQUIRE)
 		return 0;
 
 	local_bh_disable();


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
