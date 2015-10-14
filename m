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
Subject: [PATCH v4 02/11] lsm: /proc/$PID/attr/label_map file and
 getprocattr_seq hook
Date: Wed, 14 Oct 2015 14:41:56 +0200
Message-id: <1444826525-9758-3-git-send-email-l.pawelczyk@samsung.com>
In-reply-to: <1444826525-9758-1-git-send-email-l.pawelczyk@samsung.com>
References: <1444826525-9758-1-git-send-email-l.pawelczyk@samsung.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This commit adds a new proc attribute, label_map that is required by an
upcoming Smack namespace. In general it can be used to hold a map of
labels, e.g. to be used in namespaces.

Due to the nature of this file, the standard getprocattr hook might not
be enough to handle it. The map's output can in principle be greater
than page size to which the aforementioned hook is limited.
To handle this properly a getprocattr_seq LSM hook has been added that
makes it possible to handle any chosen proc attr by seq operations.

See the documentation in the patch below for the details about how to
use the hook.

Signed-off-by: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 fs/proc/base.c            | 81 +++++++++++++++++++++++++++++++++++++++++++----
 include/linux/lsm_hooks.h | 15 +++++++++
 include/linux/security.h  |  9 ++++++
 security/security.c       |  8 +++++
 4 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b25eee4..9ec88b8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2327,20 +2327,77 @@ out:
 }
 
 #ifdef CONFIG_SECURITY
+static int proc_pid_attr_open(struct inode *inode, struct file *file)
+{
+	const char *name = file->f_path.dentry->d_name.name;
+	const struct seq_operations *ops;
+	struct task_struct *task;
+	struct seq_file *seq;
+	int ret;
+
+	file->private_data = NULL;
+
+	task = get_proc_task(inode);
+	if (!task)
+		return -ESRCH;
+
+	/* don't use seq_ops if they are not provided by LSM */
+	ret = security_getprocattr_seq(task, name, &ops);
+	if (ret == -EOPNOTSUPP) {
+		ret = 0;
+		goto put_task;
+	}
+	if (ret)
+		goto put_task;
+
+	ret = seq_open(file, ops);
+	if (ret)
+		goto put_task;
+
+	seq = file->private_data;
+	seq->private = task;
+
+	return 0;
+
+put_task:
+	put_task_struct(task);
+	return ret;
+}
+
+static int proc_pid_attr_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	struct task_struct *task;
+
+	/* don't use seq_ops if they were not provided by LSM */
+	if (file->private_data == NULL)
+		return 0;
+
+	seq = file->private_data;
+	task = seq->private;
+	put_task_struct(task);
+
+	return seq_release(inode, file);
+}
+
 static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 				  size_t count, loff_t *ppos)
 {
-	struct inode * inode = file_inode(file);
+	struct inode *inode = file_inode(file);
+	const char *name = file->f_path.dentry->d_name.name;
 	char *p = NULL;
 	ssize_t length;
-	struct task_struct *task = get_proc_task(inode);
+	struct task_struct *task;
 
+	/* use seq_ops if they were provided by LSM */
+	if (file->private_data)
+		return seq_read(file, buf, count, ppos);
+
+	task = get_proc_task(inode);
 	if (!task)
 		return -ESRCH;
 
-	length = security_getprocattr(task,
-				      (char*)file->f_path.dentry->d_name.name,
-				      &p);
+	length = security_getprocattr(task, (char *)name, &p);
 	put_task_struct(task);
 	if (length > 0)
 		length = simple_read_from_buffer(buf, count, ppos, p, length);
@@ -2348,6 +2405,15 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 	return length;
 }
 
+static loff_t proc_pid_attr_lseek(struct file *file, loff_t offset, int whence)
+{
+	/* use seq_ops if they were provided by LSM */
+	if (file->private_data)
+		return seq_lseek(file, offset, whence);
+
+	return generic_file_llseek(file, offset, whence);
+}
+
 static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 				   size_t count, loff_t *ppos)
 {
@@ -2394,9 +2460,11 @@ out_no_task:
 }
 
 static const struct file_operations proc_pid_attr_operations = {
+	.open		= proc_pid_attr_open,
+	.release	= proc_pid_attr_release,
 	.read		= proc_pid_attr_read,
+	.llseek		= proc_pid_attr_lseek,
 	.write		= proc_pid_attr_write,
-	.llseek		= generic_file_llseek,
 };
 
 static const struct pid_entry attr_dir_stuff[] = {
@@ -2406,6 +2474,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	REG("fscreate",   S_IRUGO|S_IWUGO, proc_pid_attr_operations),
 	REG("keycreate",  S_IRUGO|S_IWUGO, proc_pid_attr_operations),
 	REG("sockcreate", S_IRUGO|S_IWUGO, proc_pid_attr_operations),
+	REG("label_map",  S_IRUGO|S_IWUGO, proc_pid_attr_operations),
 };
 
 static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 18c9160..7049db0 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1208,6 +1208,18 @@
  *	@name full extended attribute name to check against
  *	LSM as a MAC label.
  *
+ * @getprocattr_seq:
+ *	An alternative to the getprocattr, that makes it possible for an attr
+ *	file to be handled by seq operations. If this function returns valid
+ *	@ops for a specific @name, those operations will be used and
+ *	getprocattr will not be called.
+ *	A proper task for the file is then passed in seq_file->private.
+ *	@p a task associated with the proc file.
+ *	@name name of the attr file under /proc/$PID/attr/ to be handled.
+ *	@ops (out) seq_operations to be used for @name.
+ *	Return 0 if @name is to be handled by seq, EOPNOTSUPP if getprocattr()
+ *	should be used. Other errors will be passed to user-space.
+ *
  * @secid_to_secctx:
  *	Convert secid to security context.  If secdata is NULL the length of
  *	the result will be returned in seclen, but no secdata will be returned.
@@ -1525,6 +1537,8 @@ union security_list_options {
 
 	void (*d_instantiate)(struct dentry *dentry, struct inode *inode);
 
+	int (*getprocattr_seq)(struct task_struct *p, const char *name,
+			       const struct seq_operations **ops);
 	int (*getprocattr)(struct task_struct *p, char *name, char **value);
 	int (*setprocattr)(struct task_struct *p, char *name, void *value,
 				size_t size);
@@ -1774,6 +1788,7 @@ struct security_hook_heads {
 	struct list_head sem_semop;
 	struct list_head netlink_send;
 	struct list_head d_instantiate;
+	struct list_head getprocattr_seq;
 	struct list_head getprocattr;
 	struct list_head setprocattr;
 	struct list_head ismaclabel;
diff --git a/include/linux/security.h b/include/linux/security.h
index 91ffba2..dddea2f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -345,6 +345,8 @@ int security_sem_semctl(struct sem_array *sma, int cmd);
 int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
+int security_getprocattr_seq(struct task_struct *p, const char *name,
+			     const struct seq_operations **ops);
 int security_getprocattr(struct task_struct *p, char *name, char **value);
 int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
@@ -1057,6 +1059,13 @@ static inline int security_sem_semop(struct sem_array *sma,
 static inline void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 { }
 
+static inline int security_getprocattr_seq(struct task_struct *p,
+					   const char *name,
+					   const struct seq_operations **ops)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_getprocattr(struct task_struct *p, char *name, char **value)
 {
 	return -EINVAL;
diff --git a/security/security.c b/security/security.c
index e571127..da2bcd4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1121,6 +1121,12 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+int security_getprocattr_seq(struct task_struct *p, const char *name,
+			     const struct seq_operations **ops)
+{
+	return call_int_hook(getprocattr_seq, -EOPNOTSUPP, p, name, ops);
+}
+
 int security_getprocattr(struct task_struct *p, char *name, char **value)
 {
 	return call_int_hook(getprocattr, -EINVAL, p, name, value);
@@ -1774,6 +1780,8 @@ struct security_hook_heads security_hook_heads = {
 	.netlink_send =	LIST_HEAD_INIT(security_hook_heads.netlink_send),
 	.d_instantiate =
 		LIST_HEAD_INIT(security_hook_heads.d_instantiate),
+	.getprocattr_seq =
+		LIST_HEAD_INIT(security_hook_heads.getprocattr_seq),
 	.getprocattr =	LIST_HEAD_INIT(security_hook_heads.getprocattr),
 	.setprocattr =	LIST_HEAD_INIT(security_hook_heads.setprocattr),
 	.ismaclabel =	LIST_HEAD_INIT(security_hook_heads.ismaclabel),
-- 
2.4.3
