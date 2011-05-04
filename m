Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p44GS19r005120
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 12:28:01 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p44GS0aJ005502
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 16:28:00 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20110504144558.GC917@mail.hallyn.com>
References: <20110504144558.GC917@mail.hallyn.com> <20110428200218.GB9186@hallyn.com> <20110421143020.31318.59457.stgit@warthog.procyon.org.uk> <2560.1304511146@redhat.com>
To: Serge Hallyn <serge.hallyn@canonical.com>
Cc: dhowells@redhat.com, eparis@redhat.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/9] Open loaders and interpreters with new creds during exec
Date: Wed, 04 May 2011 17:27:53 +0100
Message-ID: <15728.1304526473@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge Hallyn <serge.hallyn@canonical.com> wrote:

> Thanks, David.  I've also compiled and done some basic boot testing.  I did
> need to add #include <linux/binfmts.h> to fs/coda/dir.c (this again may have
> been in one of your follow-on emails, but I didn't notice it).

Good point.  Hmmm...  I wonder if I should move kernel_read() to be next to
vfs_read() in fs/read_write.c and make a new function read_exec() to take a
bprm and call kernel_read() with the cred override applied.  See the attached
patch.

This way non-binfmt stuff isn't calling into exec code.

Also, kernel_read() and read_exec() really ought to take a size_t count and
return an ssize_t value, though it isn't really a problem via count isn't too
big.

David
---
diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index a8dddd2..6deedd3 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -445,7 +445,7 @@ static int load_aout_library(struct file *file)
 	inode = file->f_path.dentry->d_inode;
 
 	retval = -ENOEXEC;
-	error = kernel_read(NULL, file, 0, &ex, sizeof(ex));
+	error = kernel_read(file, 0, &ex, sizeof(ex));
 	if (error != sizeof(ex))
 		goto out;
 
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index 8890161..aef4f91 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -379,7 +379,7 @@ static int load_aout_library(struct file *file)
 	inode = file->f_path.dentry->d_inode;
 
 	retval = -ENOEXEC;
-	error = kernel_read(NULL, file, 0, &ex, sizeof(ex));
+	error = kernel_read(file, 0, &ex, sizeof(ex));
 	if (error != sizeof(ex))
 		goto out;
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 9f08098..5f19711 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -416,7 +416,7 @@ static unsigned long load_elf_interp(struct linux_binprm *bprm,
 	if (!elf_phdata)
 		goto out;
 
-	retval = kernel_read(NULL, interpreter, interp_elf_ex->e_phoff,
+	retval = kernel_read(interpreter, interp_elf_ex->e_phoff,
 			     elf_phdata, size);
 	error = -EIO;
 	if (retval != size) {
@@ -612,8 +612,8 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 	if (!elf_phdata)
 		goto out;
 
-	retval = kernel_read(bprm, bprm->file, loc->elf_ex.e_phoff,
-			     elf_phdata, size);
+	retval = read_exec(bprm, bprm->file, loc->elf_ex.e_phoff,
+			   elf_phdata, size);
 	if (retval != size) {
 		if (retval >= 0)
 			retval = -EIO;
@@ -646,10 +646,10 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 			if (!elf_interpreter)
 				goto out_free_ph;
 
-			retval = kernel_read(bprm, bprm->file,
-					     elf_ppnt->p_offset,
-					     elf_interpreter,
-					     elf_ppnt->p_filesz);
+			retval = read_exec(bprm, bprm->file,
+					   elf_ppnt->p_offset,
+					   elf_interpreter,
+					   elf_ppnt->p_filesz);
 			if (retval != elf_ppnt->p_filesz) {
 				if (retval >= 0)
 					retval = -EIO;
@@ -1007,7 +1007,7 @@ static int load_elf_library(struct file *file)
 	struct elfhdr elf_ex;
 
 	error = -ENOEXEC;
-	retval = kernel_read(NULL, file, 0, &elf_ex, sizeof(elf_ex));
+	retval = kernel_read(file, 0, &elf_ex, sizeof(elf_ex));
 	if (retval != sizeof(elf_ex))
 		goto out;
 
@@ -1031,7 +1031,7 @@ static int load_elf_library(struct file *file)
 
 	eppnt = elf_phdata;
 	error = -ENOEXEC;
-	retval = kernel_read(NULL, file, elf_ex.e_phoff, eppnt, j);
+	retval = kernel_read(file, elf_ex.e_phoff, eppnt, j);
 	if (retval != j)
 		goto out_free_ph;
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a8e07b9..fb7bab1 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -138,8 +138,8 @@ static int elf_fdpic_fetch_phdrs(struct linux_binprm *bprm,
 	if (!params->phdrs)
 		return -ENOMEM;
 
-	retval = kernel_read(bprm, file, params->hdr.e_phoff,
-			     (char *) params->phdrs, size);
+	retval = read_exec(bprm, file, params->hdr.e_phoff,
+			   params->phdrs, size);
 	if (unlikely(retval != size))
 		return retval < 0 ? retval : -ENOEXEC;
 
@@ -218,10 +218,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm,
 			if (!interpreter_name)
 				goto error;
 
-			retval = kernel_read(bprm, bprm->file,
-					     phdr->p_offset,
-					     interpreter_name,
-					     phdr->p_filesz);
+			retval = read_exec(bprm, bprm->file,
+					   phdr->p_offset,
+					   interpreter_name,
+					   phdr->p_filesz);
 			if (unlikely(retval != phdr->p_filesz)) {
 				if (retval >= 0)
 					retval = -ENOEXEC;
diff --git a/fs/binfmt_som.c b/fs/binfmt_som.c
index e27f6ad..7663575 100644
--- a/fs/binfmt_som.c
+++ b/fs/binfmt_som.c
@@ -211,8 +211,8 @@ load_som_binary(struct linux_binprm * bprm, struct pt_regs * regs)
 	if (!hpuxhdr)
 		goto out;
 
-	retval = kernel_read(bprm, bprm->file, som_ex->aux_header_location,
-			     hpuxhdr, size);
+	retval = read_exec(bprm, bprm->file, som_ex->aux_header_location,
+			   hpuxhdr, size);
 	if (retval != size) {
 		if (retval >= 0)
 			retval = -EIO;
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index e0c7f4a..b363d77 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -482,7 +482,7 @@ static int coda_venus_readdir(struct file *coda_file, void *buf,
 	}
 	while (1) {
 		/* read entries from the directory file */
-		ret = kernel_read(NULL, host_file, coda_file->f_pos - 2, vdir,
+		ret = kernel_read(host_file, coda_file->f_pos - 2, vdir,
 				  sizeof(*vdir));
 		if (ret < 0) {
 			printk(KERN_ERR "coda readdir: read dir %s failed %d\n",
diff --git a/fs/exec.c b/fs/exec.c
index c40a126..7b66a5d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -779,7 +779,7 @@ exit:
 EXPORT_SYMBOL(open_exec);
 
 /**
- * kernel_read - Read data from an executable
+ * read_exec - Read data from an executable
  * @bprm: Execution state (or NULL if after the point of no return)
  * @file: File to read from
  * @offset: File offset to read from
@@ -788,29 +788,20 @@ EXPORT_SYMBOL(open_exec);
  *
  * Read some data from an executable
  */
-int kernel_read(struct linux_binprm *bprm,
-		struct file *file, loff_t offset,
-		void *addr, unsigned long count)
+ssize_t read_exec(struct linux_binprm *bprm,
+		  struct file *file, loff_t offset, void *addr, size_t count)
 {
 	const struct cred *saved_cred = NULL;
-	mm_segment_t old_fs;
-	loff_t pos = offset;
-	int result;
+	ssize_t result;
 
-	if (bprm && bprm->cred)
+	if (bprm->cred)
 		saved_cred = override_creds(bprm->cred);
-
-	old_fs = get_fs();
-	set_fs(get_ds());
-	/* The cast to a user pointer is valid due to the set_fs() */
-	result = vfs_read(file, (void __user *)addr, count, &pos);
-	set_fs(old_fs);
-
+	result = kernel_read(file, offset, addr, count);
 	if (saved_cred)
 		revert_creds(saved_cred);
 	return result;
 }
-EXPORT_SYMBOL(kernel_read);
+EXPORT_SYMBOL(read_exec);
 
 static int exec_mmap(struct mm_struct *mm)
 {
diff --git a/fs/read_write.c b/fs/read_write.c
index 5520f8a..875dbfc 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -333,6 +333,27 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 
 EXPORT_SYMBOL(vfs_read);
 
+/**
+ * kernel_read - Read data to a kernel buffer
+ * @file: File to read from
+ * @offset: File offset to read from
+ * @addr: The buffer to read into
+ * @count: The amount of data to read
+ */
+ssize_t kernel_read(struct file *file, loff_t offset, void *addr, size_t count)
+{
+	mm_segment_t old_fs = get_fs();
+	loff_t pos = offset;
+	ssize_t result;
+
+	set_fs(get_ds());
+	/* The cast to a user pointer is valid due to the set_fs() */
+	result = vfs_read(file, (void __user *)addr, count, &pos);
+	set_fs(old_fs);
+	return result;
+}
+EXPORT_SYMBOL(kernel_read);
+
 ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
 {
 	struct iovec iov = { .iov_base = (void __user *)buf, .iov_len = len };
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 57ea660..b394f85 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -135,8 +135,8 @@ extern int copy_strings_kernel(int argc, const char *const *argv,
 extern int prepare_bprm_creds(struct linux_binprm *bprm);
 extern struct file *open_exec(const char *filename, struct linux_binprm *bprm);
 extern void install_exec_creds(struct linux_binprm *bprm);
-extern int kernel_read(struct linux_binprm *, struct file *,
-		       loff_t, void *, unsigned long);
+extern ssize_t read_exec(struct linux_binprm *, struct file *,
+			 loff_t, void *, unsigned long);
 extern void install_exec_creds(struct linux_binprm *bprmw);
 extern void do_coredump(long signr, int exit_code, struct pt_regs *regs);
 extern void set_binfmt(struct linux_binfmt *new);
@@ -144,7 +144,7 @@ extern void free_bprm(struct linux_binprm *);
 
 static inline int exec_read_header(struct linux_binprm *bprm, struct file *file)
 {
-	return kernel_read(bprm, file, 0, bprm->buf, BINPRM_BUF_SIZE);
+	return read_exec(bprm, file, 0, bprm->buf, BINPRM_BUF_SIZE);
 
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e1a44a9..42a1be2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1610,6 +1610,7 @@ extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *);
 extern ssize_t vfs_writev(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *);
+extern ssize_t kernel_read(struct file *, loff_t, void *, size_t);
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 6877035..aa5672b 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -277,7 +277,7 @@ static int p9_fd_read(struct p9_client *client, void *v, int len)
 	if (!(ts->rd->f_flags & O_NONBLOCK))
 		P9_DPRINTK(P9_DEBUG_ERROR, "blocking read ...\n");
 
-	ret = kernel_read(NULL, ts->rd, ts->rd->f_pos, v, len);
+	ret = kernel_read(ts->rd, ts->rd->f_pos, v, len);
 	if (ret <= 0 && ret != -ERESTARTSYS && ret != -EAGAIN)
 		client->status = Disconnected;
 	return ret;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 0c93027..9b3ade7 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -63,7 +63,7 @@ int ima_calc_hash(struct file *file, char *digest)
 	while (offset < i_size) {
 		int rbuf_len;
 
-		rbuf_len = kernel_read(NULL, file, offset, rbuf, PAGE_SIZE);
+		rbuf_len = kernel_read(file, offset, rbuf, PAGE_SIZE);
 		if (rbuf_len < 0) {
 			rc = rbuf_len;
 			break;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
