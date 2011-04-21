Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LEV03f016413
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 10:31:06 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LEV5TB001313
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:31:05 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 6/9] LSM: Pass linux_binprm pointer to kernel_read() so creds
 are available
To: serge.hallyn@canonical.com, eparis@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        David Howells <dhowells@redhat.com>
Date: Thu, 21 Apr 2011 15:31:00 +0100
Message-ID: <20110421143100.31318.30265.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Pass the exec state (struct linux_binprm) pointer to kernel_read() so new creds
are available for a later patch to use.

Also:

 (1) Provide a wrapper function - exec_read_header() - for filling the bprm
     buffer from a file.

 (2) Move the declaration of kernel_read() to linux/binfmts.h.

 (3) Make the buffer pointer of kernel_read() of 'void *' type and drop the
     casts required of some callers.

 (4) Stick a kerneldoc banner comment on kernel_read() describing it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/ia32/ia32_aout.c           |    2 +-
 fs/binfmt_aout.c                    |    2 +-
 fs/binfmt_elf.c                     |   24 +++++++++++++-----------
 fs/binfmt_elf_fdpic.c               |   17 +++++++++--------
 fs/binfmt_misc.c                    |    2 +-
 fs/binfmt_som.c                     |    4 ++--
 fs/coda/dir.c                       |    2 +-
 fs/exec.c                           |   18 ++++++++++++++----
 include/linux/binfmts.h             |    9 +++++++++
 include/linux/fs.h                  |    1 -
 net/9p/trans_fd.c                   |    2 +-
 security/integrity/ima/ima_crypto.c |    2 +-
 12 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index fd84387..a8dddd2 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -445,7 +445,7 @@ static int load_aout_library(struct file *file)
 	inode = file->f_path.dentry->d_inode;
 
 	retval = -ENOEXEC;
-	error = kernel_read(file, 0, (char *) &ex, sizeof(ex));
+	error = kernel_read(NULL, file, 0, &ex, sizeof(ex));
 	if (error != sizeof(ex))
 		goto out;
 
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index a6395bd..8890161 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -379,7 +379,7 @@ static int load_aout_library(struct file *file)
 	inode = file->f_path.dentry->d_inode;
 
 	retval = -ENOEXEC;
-	error = kernel_read(file, 0, (char *) &ex, sizeof(ex));
+	error = kernel_read(NULL, file, 0, &ex, sizeof(ex));
 	if (error != sizeof(ex))
 		goto out;
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5dd78d1..c8060bb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -375,7 +375,8 @@ static unsigned long total_mapping_size(struct elf_phdr *cmds, int nr)
    is only provided so that we can read a.out libraries that have
    an ELF header */
 
-static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
+static unsigned long load_elf_interp(struct linux_binprm *bprm,
+		struct elfhdr *interp_elf_ex,
 		struct file *interpreter, unsigned long *interp_map_addr,
 		unsigned long no_base)
 {
@@ -415,8 +416,8 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	if (!elf_phdata)
 		goto out;
 
-	retval = kernel_read(interpreter, interp_elf_ex->e_phoff,
-			     (char *)elf_phdata, size);
+	retval = kernel_read(NULL, interpreter, interp_elf_ex->e_phoff,
+			     elf_phdata, size);
 	error = -EIO;
 	if (retval != size) {
 		if (retval < 0)
@@ -611,8 +612,8 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 	if (!elf_phdata)
 		goto out;
 
-	retval = kernel_read(bprm->file, loc->elf_ex.e_phoff,
-			     (char *)elf_phdata, size);
+	retval = kernel_read(bprm, bprm->file, loc->elf_ex.e_phoff,
+			     elf_phdata, size);
 	if (retval != size) {
 		if (retval >= 0)
 			retval = -EIO;
@@ -645,7 +646,8 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 			if (!elf_interpreter)
 				goto out_free_ph;
 
-			retval = kernel_read(bprm->file, elf_ppnt->p_offset,
+			retval = kernel_read(bprm, bprm->file,
+					     elf_ppnt->p_offset,
 					     elf_interpreter,
 					     elf_ppnt->p_filesz);
 			if (retval != elf_ppnt->p_filesz) {
@@ -671,8 +673,7 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 			if (file_permission(interpreter, MAY_READ) < 0)
 				bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
 
-			retval = kernel_read(interpreter, 0, bprm->buf,
-					     BINPRM_BUF_SIZE);
+			retval = exec_read_header(bprm, interpreter);
 			if (retval != BINPRM_BUF_SIZE) {
 				if (retval >= 0)
 					retval = -EIO;
@@ -882,7 +883,8 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 	if (elf_interpreter) {
 		unsigned long uninitialized_var(interp_map_addr);
 
-		elf_entry = load_elf_interp(&loc->interp_elf_ex,
+		elf_entry = load_elf_interp(bprm,
+					    &loc->interp_elf_ex,
 					    interpreter,
 					    &interp_map_addr,
 					    load_bias);
@@ -1005,7 +1007,7 @@ static int load_elf_library(struct file *file)
 	struct elfhdr elf_ex;
 
 	error = -ENOEXEC;
-	retval = kernel_read(file, 0, (char *)&elf_ex, sizeof(elf_ex));
+	retval = kernel_read(NULL, file, 0, &elf_ex, sizeof(elf_ex));
 	if (retval != sizeof(elf_ex))
 		goto out;
 
@@ -1029,7 +1031,7 @@ static int load_elf_library(struct file *file)
 
 	eppnt = elf_phdata;
 	error = -ENOEXEC;
-	retval = kernel_read(file, elf_ex.e_phoff, (char *)eppnt, j);
+	retval = kernel_read(NULL, file, elf_ex.e_phoff, eppnt, j);
 	if (retval != j)
 		goto out_free_ph;
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a7ddd4e..eee4f70 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -57,7 +57,8 @@ typedef char *elf_caddr_t;
 MODULE_LICENSE("GPL");
 
 static int load_elf_fdpic_binary(struct linux_binprm *, struct pt_regs *);
-static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *, struct file *);
+static int elf_fdpic_fetch_phdrs(struct linux_binprm *,
+				 struct elf_fdpic_params *, struct file *);
 static int elf_fdpic_map_file(struct elf_fdpic_params *, struct file *,
 			      struct mm_struct *, const char *);
 
@@ -119,7 +120,8 @@ static int is_elf_fdpic(struct elfhdr *hdr, struct file *file)
 /*
  * read the program headers table into memory
  */
-static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
+static int elf_fdpic_fetch_phdrs(struct linux_binprm *bprm,
+				 struct elf_fdpic_params *params,
 				 struct file *file)
 {
 	struct elf32_phdr *phdr;
@@ -136,7 +138,7 @@ static int elf_fdpic_fetch_phdrs(struct elf_fdpic_params *params,
 	if (!params->phdrs)
 		return -ENOMEM;
 
-	retval = kernel_read(file, params->hdr.e_phoff,
+	retval = kernel_read(bprm, file, params->hdr.e_phoff,
 			     (char *) params->phdrs, size);
 	if (unlikely(retval != size))
 		return retval < 0 ? retval : -ENOEXEC;
@@ -194,7 +196,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm,
 		goto error;
 
 	/* read the program header table */
-	retval = elf_fdpic_fetch_phdrs(&exec_params, bprm->file);
+	retval = elf_fdpic_fetch_phdrs(bprm, &exec_params, bprm->file);
 	if (retval < 0)
 		goto error;
 
@@ -216,7 +218,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm,
 			if (!interpreter_name)
 				goto error;
 
-			retval = kernel_read(bprm->file,
+			retval = kernel_read(bprm, bprm->file,
 					     phdr->p_offset,
 					     interpreter_name,
 					     phdr->p_filesz);
@@ -248,8 +250,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm,
 			if (file_permission(interpreter, MAY_READ) < 0)
 				bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
 
-			retval = kernel_read(interpreter, 0, bprm->buf,
-					     BINPRM_BUF_SIZE);
+			retval = exec_read_header(bprm, interpreter);
 			if (unlikely(retval != BINPRM_BUF_SIZE)) {
 				if (retval >= 0)
 					retval = -ENOEXEC;
@@ -281,7 +282,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm,
 		interp_params.flags = ELF_FDPIC_FLAG_PRESENT;
 
 		/* read the interpreter's program header table */
-		retval = elf_fdpic_fetch_phdrs(&interp_params, interpreter);
+		retval = elf_fdpic_fetch_phdrs(bprm, &interp_params, interpreter);
 		if (retval < 0)
 			goto error;
 	}
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 1befe2e..5209293 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -190,7 +190,7 @@ static int load_misc_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 		 * done.  bprm->buf is stale, update from interp_file.
 		 */
 		memset(bprm->buf, 0, BINPRM_BUF_SIZE);
-		retval = kernel_read(bprm->file, 0, bprm->buf, BINPRM_BUF_SIZE);
+		retval = exec_read_header(bprm, bprm->file);
 	} else
 		retval = prepare_binprm (bprm);
 
diff --git a/fs/binfmt_som.c b/fs/binfmt_som.c
index cc8560f..e27f6ad 100644
--- a/fs/binfmt_som.c
+++ b/fs/binfmt_som.c
@@ -211,8 +211,8 @@ load_som_binary(struct linux_binprm * bprm, struct pt_regs * regs)
 	if (!hpuxhdr)
 		goto out;
 
-	retval = kernel_read(bprm->file, som_ex->aux_header_location,
-			(char *) hpuxhdr, size);
+	retval = kernel_read(bprm, bprm->file, som_ex->aux_header_location,
+			     hpuxhdr, size);
 	if (retval != size) {
 		if (retval >= 0)
 			retval = -EIO;
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 2b8dae4..e0c7f4a 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -482,7 +482,7 @@ static int coda_venus_readdir(struct file *coda_file, void *buf,
 	}
 	while (1) {
 		/* read entries from the directory file */
-		ret = kernel_read(host_file, coda_file->f_pos - 2, (char *)vdir,
+		ret = kernel_read(NULL, host_file, coda_file->f_pos - 2, vdir,
 				  sizeof(*vdir));
 		if (ret < 0) {
 			printk(KERN_ERR "coda readdir: read dir %s failed %d\n",
diff --git a/fs/exec.c b/fs/exec.c
index f0ddc51..84625a1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -756,8 +756,19 @@ exit:
 }
 EXPORT_SYMBOL(open_exec);
 
-int kernel_read(struct file *file, loff_t offset,
-		char *addr, unsigned long count)
+/**
+ * kernel_read - Read data from an executable
+ * @bprm: Execution state (or NULL if after the point of no return)
+ * @file: File to read from
+ * @offset: File offset to read from
+ * @addr: The buffer to read into
+ * @count: The amount of data to read
+ *
+ * Read some data from an executable
+ */
+int kernel_read(struct linux_binprm *bprm,
+		struct file *file, loff_t offset,
+		void *addr, unsigned long count)
 {
 	mm_segment_t old_fs;
 	loff_t pos = offset;
@@ -770,7 +781,6 @@ int kernel_read(struct file *file, loff_t offset,
 	set_fs(old_fs);
 	return result;
 }
-
 EXPORT_SYMBOL(kernel_read);
 
 static int exec_mmap(struct mm_struct *mm)
@@ -1262,7 +1272,7 @@ int prepare_binprm(struct linux_binprm *bprm)
 	put_cred(old);
 
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
-	return kernel_read(bprm->file, 0, bprm->buf, BINPRM_BUF_SIZE);
+	return exec_read_header(bprm, bprm->file);
 }
 
 EXPORT_SYMBOL(prepare_binprm);
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index fc3bc19..82577f7 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -134,9 +134,18 @@ extern int copy_strings_kernel(int argc, const char *const *argv,
 			       struct linux_binprm *bprm);
 extern int prepare_bprm_creds(struct linux_binprm *bprm);
 extern void install_exec_creds(struct linux_binprm *bprm);
+extern int kernel_read(struct linux_binprm *, struct file *,
+		       loff_t, void *, unsigned long);
+extern void install_exec_creds(struct linux_binprm *bprmw);
 extern void do_coredump(long signr, int exit_code, struct pt_regs *regs);
 extern void set_binfmt(struct linux_binfmt *new);
 extern void free_bprm(struct linux_binprm *);
 
+static inline int exec_read_header(struct linux_binprm *bprm, struct file *file)
+{
+	return kernel_read(bprm, file, 0, bprm->buf, BINPRM_BUF_SIZE);
+
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_BINFMTS_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dbd860a..74543c9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2224,7 +2224,6 @@ extern struct file *create_read_pipe(struct file *f, int flags);
 extern struct file *create_write_pipe(int flags);
 extern void free_write_pipe(struct file *);
 
-extern int kernel_read(struct file *, loff_t, char *, unsigned long);
 extern struct file * open_exec(const char *);
  
 /* fs/dcache.c -- generic fs support functions */
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index aa5672b..6877035 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -277,7 +277,7 @@ static int p9_fd_read(struct p9_client *client, void *v, int len)
 	if (!(ts->rd->f_flags & O_NONBLOCK))
 		P9_DPRINTK(P9_DEBUG_ERROR, "blocking read ...\n");
 
-	ret = kernel_read(ts->rd, ts->rd->f_pos, v, len);
+	ret = kernel_read(NULL, ts->rd, ts->rd->f_pos, v, len);
 	if (ret <= 0 && ret != -ERESTARTSYS && ret != -EAGAIN)
 		client->status = Disconnected;
 	return ret;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 9b3ade7..0c93027 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -63,7 +63,7 @@ int ima_calc_hash(struct file *file, char *digest)
 	while (offset < i_size) {
 		int rbuf_len;
 
-		rbuf_len = kernel_read(file, offset, rbuf, PAGE_SIZE);
+		rbuf_len = kernel_read(NULL, file, offset, rbuf, PAGE_SIZE);
 		if (rbuf_len < 0) {
 			rc = rbuf_len;
 			break;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
