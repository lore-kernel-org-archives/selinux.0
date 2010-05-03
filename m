Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o43MBasf018941
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 18:11:43 -0400
Received: from g4t0017.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o43MB6QB021397
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 22:11:06 GMT
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id 3643C3845D
	for <selinux@tycho.nsa.gov>; Mon,  3 May 2010 22:11:42 +0000 (UTC)
Subject: [RFC PATCH v1 4/6] selinux: Shuffle the sk_security_struct alloc and
	free routines
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Mon, 03 May 2010 18:11:40 -0400
Message-ID: <20100503221140.8177.78844.stgit@flek.lan>
In-Reply-To: <20100503220455.8177.91177.stgit@flek.lan>
References: <20100503220455.8177.91177.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The sk_alloc_security() and sk_free_security() functions were only being
called by the selinux_sk_alloc_security() and selinux_sk_free_security()
functions so we just move the guts of the alloc/free routines to the
callers and eliminate a layer of indirection.

Signed-off-by: XXX
---
 security/selinux/hooks.c |   45 +++++++++++++++++----------------------------
 1 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4034a3a..ce6c017 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -291,32 +291,6 @@ static void superblock_free_security(struct super_block *sb)
 	kfree(sbsec);
 }
 
-static int sk_alloc_security(struct sock *sk, int family, gfp_t priority)
-{
-	struct sk_security_struct *ssec;
-
-	ssec = kzalloc(sizeof(*ssec), priority);
-	if (!ssec)
-		return -ENOMEM;
-
-	ssec->peer_sid = SECINITSID_UNLABELED;
-	ssec->sid = SECINITSID_UNLABELED;
-	sk->sk_security = ssec;
-
-	selinux_netlbl_sk_security_reset(ssec);
-
-	return 0;
-}
-
-static void sk_free_security(struct sock *sk)
-{
-	struct sk_security_struct *ssec = sk->sk_security;
-
-	sk->sk_security = NULL;
-	selinux_netlbl_sk_security_free(ssec);
-	kfree(ssec);
-}
-
 /* The security server must be initialized before
    any labeling or access decisions can be provided. */
 extern int ss_initialized;
@@ -4281,12 +4255,27 @@ out:
 
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
