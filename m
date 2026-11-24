Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561234;
	b=oBeZX0bxtCvhwGe3VE7iNXViLx+kSFo0WLoqG0AU9H9g9l1HeNEIyHmAny7rI6i2UrNN
	 BLvQFpo3cj2Cy/aRf77pors0ebd4FlxHlTDpiAPaibbUfsxd61Q+TMnLrxg1o5NsFewXf
	 H3we6alvunGmZfjoI2J1af1Cn7qCAAkJxaMQ7BdW6r0z/D8HtS422FVA+dl73xn7VygXh
	 IqOpSKTD6CzVpTRhKKr5llYVPscUWMC8+SImbq40Qvghfjw/FOzSMyAOrGgvbW4zX7dCH
	 m7Ob6SfKRloDSt0iCg9x4RUtlHIBmMFe4tnpvfers+6dpDMIxOd7Ql46WhVyMw4shmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561234;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eNV8rJH4Kk9+o13rpAbYwrbNyiuK+XJchQZ6VUpEriQ=;
	b=5XTO05vrcmyoZ/2LWR62r9MdH02+i9QtUQQkiFcl2XoSp5GdTBb/oJxVnS33lWr8T1MA
	 WVG1aei/Q7qnvYWB5j/OgF7yDRn5wPsn3AJmIdwXv5VtkfoXHhKbaShRDnZOF3U9ZQPvI
	 1+kKatCl454OTf8xv32wIRZalcvbfr0Q49MvwXugtH9KGjQDEoAEUQzgAkv6Khe12x/lM
	 nPotDqCTGwfHDE+7P+8rk2Qeegk7CMMy2vz/4ihZc19EW6ly9BVkj0+eD5JLDNRxO2yg6
	 3oxL4zfbJ6v7WE+FElq6wUMh3rWEC/exMOXUSj8mRtF7fil+aRv6ISjC3DUJG3ww9+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIkuXiXe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E4B606A321;
	Tue, 24 Nov 2026 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIkuXiXe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2405E1F0156C;
	Tue, 24 Nov 2026 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561233;
	bh=eNV8rJH4Kk9+o13rpAbYwrbNyiuK+XJchQZ6VUpEriQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GIkuXiXeLvYf1n/C5+5N/d5eZjBkiqNux/gyQkp/+9VmYKXhbEjjLjdnxAFAi95mt
	 hNn98Mxho2aVW4wsAkYiZ14NHRv08FXyDzzobCk9qc2EXsfb/h6AQJ8uGTV0ZQ4ghV
	 IKw715rUHNztCMHH6uurR1xfSDlUD6L/nhhl/98PicsPX4oNyfChyzlLmijosxr4oU
	 V6MHG9ejkFn8lg114adbkEN9bbOLz4QwR76VVRfLCzCiHwcn9+v1eXUYfAbCqpBoFF
	 t0QamGt2Sp51vUsfBWuK2ROeTXyuYafbdeW1UHWGzr43WrBMX9tZCuJUYuNKpmpwNr
	 1mM63G/Fr6H6Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:40 +0100
Subject: [PATCH RFC 17/19] proc: look up map_files vma without
 exec_update_lock held
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-work-exec-update_lock-v1-17-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cECZa0eQtjLytpPlR2SBCNYBSmdlP+dulEopZzDPwU8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziZ38aPZaYe2ujs2Lvi0+foDN9Mb8v8p/Rb+kPJhlo
 M70fUnKpI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJNGkz/I95dT/wwE3Hks9r
 FiyIXfTs1blSaT7OZxcPpZ24mbxqd1ECw/+sO1WZodnqt+P0nshFpbAc92RaceuQgcafZwue3Vn
 IuoADAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since commit 6255da28d4bb ("proc: protect ptrace_may_access() with
exec_update_lock (FD links)") the links in /proc/<pid>/map_files are
resolved with exec_update_lock of the task held. To find the file
map_files_get_link() looks up the vma and for that it waits for the mmap
lock of the mm.

So whoever reads such a link makes an exec of the task wait for the mmap
lock of its old mm although exec_mmap() doesn't take that lock anymore.
And everyone else who wants to look at the task queues up behind the
exec.

The lock is only needed for the access check and to get at the mm the
check was made for. So only do that with the lock held and look up the
vma afterwards.

The links don't go through call_proc_get_link() anymore so they don't
need ->proc_get_link().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/base.c | 68 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7685660c36241..b28bd6c57e1d8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2228,18 +2228,40 @@ static const struct dentry_operations tid_map_files_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int map_files_get_link(struct dentry *dentry, struct path *path,
-			      struct task_struct *task)
+/* Check the access and pin the mm with exec_update_lock held. */
+static struct mm_struct *map_files_mm(struct inode *inode)
+{
+	struct task_struct *task __free(put_task) = NULL;
+	struct mm_struct *mm;
+	int err;
+
+	task = get_proc_task(inode);
+	if (!task)
+		return ERR_PTR(-ENOENT);
+
+	err = down_read_killable(&task->signal->exec_update_lock);
+	if (err)
+		return ERR_PTR(err);
+	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+		mm = get_task_mm(task) ?: ERR_PTR(-ENOENT);
+	else
+		mm = ERR_PTR(-EACCES);
+	up_read(&task->signal->exec_update_lock);
+	return mm;
+}
+
+/* The vma lookup waits for the mmap lock so do it without exec_update_lock. */
+static int map_files_get_link(struct dentry *dentry, struct inode *inode,
+			      struct path *path)
 {
 	unsigned long vm_start, vm_end;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	int rc;
 
-	rc = -ENOENT;
-	mm = get_task_mm(task);
-	if (!mm)
-		goto out;
+	mm = map_files_mm(inode);
+	if (IS_ERR(mm))
+		return PTR_ERR(mm);
 
 	rc = dname_to_vma_addr(dentry, &vm_start, &vm_end);
 	if (rc)
@@ -2260,7 +2282,6 @@ static int map_files_get_link(struct dentry *dentry, struct path *path,
 
 out_mmput:
 	mmput(mm);
-out:
 	return rc;
 }
 
@@ -2280,17 +2301,36 @@ proc_map_files_get_link(struct dentry *dentry,
 			struct inode *inode,
 		        struct delayed_call *done)
 {
+	struct path path;
+	int error;
+
 	if (!checkpoint_restore_ns_capable(&init_user_ns))
 		return ERR_PTR(-EPERM);
 
-	return proc_pid_get_link(dentry, inode, done);
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+	error = map_files_get_link(dentry, inode, &path);
+	if (!error)
+		error = nd_jump_link(&path);
+	return ERR_PTR(error);
+}
+
+static int proc_map_files_readlink(struct dentry *dentry, char __user *buffer,
+				   int buflen)
+{
+	struct path path;
+	int error;
+
+	error = map_files_get_link(dentry, d_inode(dentry), &path);
+	if (!error) {
+		error = do_proc_readlink(&path, buffer, buflen);
+		path_put(&path);
+	}
+	return error;
 }
 
-/*
- * Identical to proc_pid_link_inode_operations except for get_link()
- */
 static const struct inode_operations proc_map_files_link_inode_operations = {
-	.readlink	= proc_pid_readlink,
+	.readlink	= proc_map_files_readlink,
 	.get_link	= proc_map_files_get_link,
 	.setattr	= proc_nochmod_setattr,
 };
@@ -2300,7 +2340,6 @@ proc_map_files_instantiate(struct dentry *dentry,
 			   struct task_struct *task, const void *ptr)
 {
 	fmode_t mode = (fmode_t)(unsigned long)ptr;
-	struct proc_inode *ei;
 	struct inode *inode;
 
 	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK |
@@ -2309,9 +2348,6 @@ proc_map_files_instantiate(struct dentry *dentry,
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
-	ei = PROC_I(inode);
-	ei->op.proc_get_link = map_files_get_link;
-
 	inode->i_op = &proc_map_files_link_inode_operations;
 	inode->i_size = 64;
 

-- 
2.53.0

