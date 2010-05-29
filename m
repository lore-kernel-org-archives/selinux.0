Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4TLrxTH025360
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 17:53:59 -0400
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4TLtKoD018107
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:55:20 GMT
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0016.houston.hp.com (Postfix) with ESMTP id 0FDD814114
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:53:58 +0000 (UTC)
Subject: [PATCH 6/6] selinux: Use current_security() when possible
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Sat, 29 May 2010 17:53:56 -0400
Message-ID: <20100529215356.4042.16646.stgit@flek.lan>
In-Reply-To: <20100529214628.4042.88276.stgit@flek.lan>
References: <20100529214628.4042.88276.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There were a number of places using the following code pattern:

  struct cred *cred = current_cred();
  struct task_security_struct *tsec = cred->security;

... which were simplified to the following:

  struct task_security_struct *tsec = current_security();

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/hooks.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 409839d..fe84364 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -188,7 +188,7 @@ static inline u32 task_sid(const struct task_struct *task)
  */
 static inline u32 current_sid(void)
 {
-	const struct task_security_struct *tsec = current_cred()->security;
+	const struct task_security_struct *tsec = current_security();
 
 	return tsec->sid;
 }
@@ -1558,8 +1558,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -2157,8 +2156,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 static int selinux_bprm_secureexec(struct linux_binprm *bprm)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	u32 sid, osid;
 	int atsecure = 0;
 
@@ -2533,8 +2531,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       char **name, void **value,
 				       size_t *len)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid, clen;
@@ -3710,8 +3707,7 @@ static int sock_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	u32 newsid;
 	u16 secclass;
 
@@ -3726,8 +3722,7 @@ static int selinux_socket_create(int family, int type,
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
 	struct sk_security_struct *sksec;
 	int err = 0;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
