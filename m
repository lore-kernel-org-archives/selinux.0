Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n67ICZT3026472
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 14:12:35 -0400
Received: from g5t0008.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n67ICHOj010052
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 18:12:17 GMT
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g5t0008.atlanta.hp.com (Postfix) with ESMTP id E2DD4240ED
	for <selinux@tycho.nsa.gov>; Tue,  7 Jul 2009 18:12:33 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH] selinux: Cleanup the socket handling functions
To: selinux@tycho.nsa.gov
Date: Tue, 07 Jul 2009 14:12:22 -0400
Message-ID: <20090707181222.8063.54143.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A few small cleanups to the SELinux sock/socket hooks:

 * Remove sk_alloc_security() by moving the code into the
   selinux_sk_alloc_security() hook, move the
   selinux_netlbl_sk_security_reset() up above the sk->sk_security assignment
   while we are at it
 * Remove sk_free_security() by movingthe code into the
   selinux_sk_free_security() hook
 * Make use of current_security() in selinux_socket_create() and
   selinux_socket_post_create()

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/hooks.c |   59 ++++++++++++++++------------------------------
 1 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 15c2a08..aa2d3fd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -298,32 +298,6 @@ static void superblock_free_security(struct super_block *sb)
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
@@ -3651,30 +3625,24 @@ out:
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	u32 sid, newsid;
 	u16 secclass;
-	int err = 0;
 
 	if (kern)
-		goto out;
+		return 0;
 
 	sid = tsec->sid;
 	newsid = tsec->sockcreate_sid ?: sid;
-
 	secclass = socket_type_to_security_class(family, type, protocol);
-	err = avc_has_perm(sid, newsid, secclass, SOCKET__CREATE, NULL);
 
-out:
-	return err;
+	return avc_has_perm(sid, newsid, secclass, SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	struct inode_security_struct *isec;
 	struct sk_security_struct *sksec;
 	u32 sid, newsid;
@@ -4189,12 +4157,27 @@ out:
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
-	return sk_alloc_security(sk, family, priority);
+	struct sk_security_struct *ssec;
+
+	ssec = kzalloc(sizeof(*ssec), priority);
+	if (!ssec)
+		return -ENOMEM;
+
+	ssec->peer_sid = SECINITSID_UNLABELED;
+	ssec->sid = SECINITSID_UNLABELED;
+	selinux_netlbl_sk_security_reset(ssec);
+	sk->sk_security = ssec;
+
+	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	sk_free_security(sk);
+	struct sk_security_struct *ssec = sk->sk_security;
+
+	sk->sk_security = NULL;
+	selinux_netlbl_sk_security_free(ssec);
+	kfree(ssec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
