From: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
To: "David S. Miller" <davem@davemloft.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Calvin Owens <calvinowens@fb.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Eric Paris <eparis@parisplace.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>, Jann Horn <jann@thejh.net>,
 Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
 John Johansen <john.johansen@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 NeilBrown <neilb@suse.de>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 containers@lists.linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Lukasz Pawelczyk <havner@gmail.com>
Subject: [PATCH v4 03/11] lsm: add file opener's cred to a setprocattr
 arguments
Date: Wed, 14 Oct 2015 14:41:57 +0200
Message-id: <1444826525-9758-4-git-send-email-l.pawelczyk@samsung.com>
In-reply-to: <1444826525-9758-1-git-send-email-l.pawelczyk@samsung.com>
References: <1444826525-9758-1-git-send-email-l.pawelczyk@samsung.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

setprocattr hook for Smack's label_map attribute needs to know the
capabilities of file opener. Add those credentials to the hook's
arguments.

While at it add documentation on get/setprocattr hooks.

Signed-off-by: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 fs/proc/base.c             |  2 +-
 include/linux/lsm_hooks.h  | 18 ++++++++++++++++--
 include/linux/security.h   |  7 +++++--
 security/apparmor/lsm.c    |  5 +++--
 security/security.c        |  6 ++++--
 security/selinux/hooks.c   |  2 +-
 security/smack/smack_lsm.c |  4 ++--
 7 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9ec88b8..2b38969 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2447,7 +2447,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (length < 0)
 		goto out_free;
 
-	length = security_setprocattr(task,
+	length = security_setprocattr(task, file->f_cred,
 				      (char*)file->f_path.dentry->d_name.name,
 				      (void*)page, count);
 	mutex_unlock(&task->signal->cred_guard_mutex);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7049db0..4f16640 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1220,6 +1220,20 @@
  *	Return 0 if @name is to be handled by seq, EOPNOTSUPP if getprocattr()
  *	should be used. Other errors will be passed to user-space.
  *
+ * @getprocattr:
+ *	Get a value of a proc security attribute in /proc/$PID/attr/.
+ *	@p a task associated with the proc file.
+ *	@name a name of the file in question.
+ *	@value a pointer where to return the attribute's value.
+ *
+ * @setprocattr:
+ *	Set a value of a proc security attribute in /proc/$PID/attr/.
+ *	@p a task associated with the proc file.
+ *	@f_cred credentials of a file's opener.
+ *	@name a name of the file in question.
+ *	@value a pointer where a value to set is kept.
+ *	@size a number of bytes to read from the @value pointer.
+ *
  * @secid_to_secctx:
  *	Convert secid to security context.  If secdata is NULL the length of
  *	the result will be returned in seclen, but no secdata will be returned.
@@ -1540,8 +1554,8 @@ union security_list_options {
 	int (*getprocattr_seq)(struct task_struct *p, const char *name,
 			       const struct seq_operations **ops);
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
-	int (*setprocattr)(struct task_struct *p, char *name, void *value,
-				size_t size);
+	int (*setprocattr)(struct task_struct *p, const struct cred *f_cred,
+			   char *name, void *value, size_t size);
 	int (*ismaclabel)(const char *name);
 	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
 	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
diff --git a/include/linux/security.h b/include/linux/security.h
index dddea2f..12bd011 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -348,7 +348,8 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode);
 int security_getprocattr_seq(struct task_struct *p, const char *name,
 			     const struct seq_operations **ops);
 int security_getprocattr(struct task_struct *p, char *name, char **value);
-int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size);
+int security_setprocattr(struct task_struct *p, const struct cred *f_cred,
+			 char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
@@ -1071,7 +1072,9 @@ static inline int security_getprocattr(struct task_struct *p, char *name, char *
 	return -EINVAL;
 }
 
-static inline int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+static inline int security_setprocattr(struct task_struct *p,
+				       const struct cred *f_cred,
+				       char *name, void *value, size_t size)
 {
 	return -EINVAL;
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index dec607c..1212927 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -518,8 +518,9 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	return error;
 }
 
-static int apparmor_setprocattr(struct task_struct *task, char *name,
-				void *value, size_t size)
+static int apparmor_setprocattr(struct task_struct *task,
+				const struct cred *f_cred,
+				char *name, void *value, size_t size)
 {
 	struct common_audit_data sa;
 	struct apparmor_audit_data aad = {0,};
diff --git a/security/security.c b/security/security.c
index da2bcd4..abfc207 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1132,9 +1132,11 @@ int security_getprocattr(struct task_struct *p, char *name, char **value)
 	return call_int_hook(getprocattr, -EINVAL, p, name, value);
 }
 
-int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+int security_setprocattr(struct task_struct *p, const struct cred *f_cred,
+			 char *name, void *value, size_t size)
 {
-	return call_int_hook(setprocattr, -EINVAL, p, name, value, size);
+	return call_int_hook(setprocattr, -EINVAL, p, f_cred,
+			     name, value, size);
 }
 
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e4369d8..470eff8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5603,7 +5603,7 @@ invalid:
 	return -EINVAL;
 }
 
-static int selinux_setprocattr(struct task_struct *p,
+static int selinux_setprocattr(struct task_struct *p, const struct cred *f_cred,
 			       char *name, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c2d66ca..c439370 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3549,8 +3549,8 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_setprocattr(struct task_struct *p, char *name,
-			     void *value, size_t size)
+static int smack_setprocattr(struct task_struct *p, const struct cred *f_cred,
+			     char *name, void *value, size_t size)
 {
 	struct task_smack *tsp;
 	struct cred *new;
-- 
2.4.3
