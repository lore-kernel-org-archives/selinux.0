Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o43MBtoc018985
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 18:11:55 -0400
Received: from g4t0014.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o43MCxbl004957
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 22:12:59 GMT
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0014.houston.hp.com (Postfix) with ESMTP id 5857724111
	for <selinux@tycho.nsa.gov>; Mon,  3 May 2010 22:11:54 +0000 (UTC)
Subject: [RFC PATCH v1 6/6] selinux: Use current_security() when possible
To: selinux@tycho.nsa.gov
From: Paul Moore <paul.moore@hp.com>
Date: Mon, 03 May 2010 18:11:53 -0400
Message-ID: <20100503221153.8177.49205.stgit@flek.lan>
In-Reply-To: <20100503220455.8177.91177.stgit@flek.lan>
References: <20100503220455.8177.91177.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There were a number of places using the following code pattern:

  struct cred *cred = current_cred();
  struct task_security_struct *tsec = cred->security;

... which were simplified to the following:

  struct task_security_struct *tsec = current_security();

Signed-off-by: XXX
---
 security/selinux/hooks.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4f2c9ec..ccc8e0e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -193,7 +193,7 @@ static inline u32 task_sid(const struct task_struct *task)
  */
 static inline u32 current_sid(void)
 {
-	const struct task_security_struct *tsec = current_cred()->security;
+	const struct task_security_struct *tsec = current_security();
 
 	return tsec->sid;
 }
@@ -1580,8 +1580,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -2179,8 +2178,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 static int selinux_bprm_secureexec(struct linux_binprm *bprm)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	u32 sid, osid;
 	int atsecure = 0;
 
@@ -2555,8 +2553,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       char **name, void **value,
 				       size_t *len)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid, clen;
@@ -3728,8 +3725,7 @@ static int socket_has_perm(struct task_struct *task, struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct cred *cred = current_cred();
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = current_security();
 	u32 newsid;
 	u16 secclass;
 
@@ -3744,8 +3740,7 @@ static int selinux_socket_create(int family, int type,
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
