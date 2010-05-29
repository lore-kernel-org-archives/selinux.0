Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4TLroIN025249
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 17:53:50 -0400
Received: from g1t0026.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4TLt7oD018080
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:55:07 GMT
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g1t0026.austin.hp.com (Postfix) with ESMTP id A1E20C0C9
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:53:45 +0000 (UTC)
Subject: [PATCH 4/6] selinux: Shuffle the sk_security_struct alloc and free
	routines
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Sat, 29 May 2010 17:53:44 -0400
Message-ID: <20100529215344.4042.74670.stgit@flek.lan>
In-Reply-To: <20100529214628.4042.88276.stgit@flek.lan>
References: <20100529214628.4042.88276.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The sk_alloc_security() and sk_free_security() functions were only being
called by the selinux_sk_alloc_security() and selinux_sk_free_security()
functions so we just move the guts of the alloc/free routines to the
callers and eliminate a layer of indirection.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/hooks.c |   45 +++++++++++++++++----------------------------
 1 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a4a0660..aa4e11c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -279,32 +279,6 @@ static void superblock_free_security(struct super_block *sb)
 	kfree(sbsec);
 }
 
-static int sk_alloc_security(struct sock *sk, int family, gfp_t priority)
-{
-	struct sk_security_struct *sksec;
-
-	sksec = kzalloc(sizeof(*sksec), priority);
-	if (!sksec)
-		return -ENOMEM;
-
-	sksec->peer_sid = SECINITSID_UNLABELED;
-	sksec->sid = SECINITSID_UNLABELED;
-	sk->sk_security = sksec;
-
-	selinux_netlbl_sk_security_reset(sksec);
-
-	return 0;
-}
-
-static void sk_free_security(struct sock *sk)
-{
-	struct sk_security_struct *sksec = sk->sk_security;
-
-	sk->sk_security = NULL;
-	selinux_netlbl_sk_security_free(sksec);
-	kfree(sksec);
-}
-
 /* The security server must be initialized before
    any labeling or access decisions can be provided. */
 extern int ss_initialized;
@@ -4265,12 +4239,27 @@ out:
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
-	return sk_alloc_security(sk, family, priority);
+	struct sk_security_struct *sksec;
+
+	sksec = kzalloc(sizeof(*sksec), priority);
+	if (!sksec)
+		return -ENOMEM;
+
+	sksec->peer_sid = SECINITSID_UNLABELED;
+	sksec->sid = SECINITSID_UNLABELED;
+	selinux_netlbl_sk_security_reset(sksec);
+	sk->sk_security = sksec;
+
+	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	sk_free_security(sk);
+	struct sk_security_struct *sksec = sk->sk_security;
+
+	sk->sk_security = NULL;
+	selinux_netlbl_sk_security_free(sksec);
+	kfree(sksec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
