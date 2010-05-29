Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4TLroIL025249
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 17:53:50 -0400
Received: from g1t0028.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4TLqslY001170
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:52:54 GMT
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g1t0028.austin.hp.com (Postfix) with ESMTP id 082DA1C118
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:53:39 +0000 (UTC)
Subject: [PATCH 3/6] selinux: Consolidate sockcreate_sid logic
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Sat, 29 May 2010 17:53:37 -0400
Message-ID: <20100529215337.4042.66498.stgit@flek.lan>
In-Reply-To: <20100529214628.4042.88276.stgit@flek.lan>
References: <20100529214628.4042.88276.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Consolidate the basic sockcreate_sid logic into a single helper function
which allows us to do some cleanups in the related code.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/hooks.c |   32 ++++++++++++--------------------
 1 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ead0984..a4a0660 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3712,6 +3712,12 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 }
 
 /* socket security operations */
+
+static u32 socket_sockcreate_sid(const struct task_security_struct *tsec)
+{
+	return tsec->sockcreate_sid ? : tsec->sid;
+}
+
 static int socket_has_perm(struct task_struct *task, struct socket *sock,
 			   u32 perms)
 {
@@ -3739,21 +3745,15 @@ static int selinux_socket_create(int family, int type,
 {
 	const struct cred *cred = current_cred();
 	const struct task_security_struct *tsec = cred->security;
-	u32 sid, newsid;
+	u32 newsid;
 	u16 secclass;
-	int err = 0;
 
 	if (kern)
-		goto out;
-
-	sid = tsec->sid;
-	newsid = tsec->sockcreate_sid ?: sid;
+		return 0;
 
+	newsid = socket_sockcreate_sid(tsec);
 	secclass = socket_type_to_security_class(family, type, protocol);
-	err = avc_has_perm(sid, newsid, secclass, SOCKET__CREATE, NULL);
-
-out:
-	return err;
+	return avc_has_perm(tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
@@ -3761,22 +3761,14 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 {
 	const struct cred *cred = current_cred();
 	const struct task_security_struct *tsec = cred->security;
-	struct inode_security_struct *isec;
+	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
 	struct sk_security_struct *sksec;
-	u32 sid, newsid;
 	int err = 0;
 
-	sid = tsec->sid;
-	newsid = tsec->sockcreate_sid;
-
-	isec = SOCK_INODE(sock)->i_security;
-
 	if (kern)
 		isec->sid = SECINITSID_KERNEL;
-	else if (newsid)
-		isec->sid = newsid;
 	else
-		isec->sid = sid;
+		isec->sid = socket_sockcreate_sid(tsec);
 
 	isec->sclass = socket_type_to_security_class(family, type, protocol);
 	isec->initialized = 1;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
