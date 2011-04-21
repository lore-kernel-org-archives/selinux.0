Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LEV03k016413
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 10:31:20 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LEVJTB001406
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:31:19 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 8/9] LSM: Pass linux_binprm pointer to open_exec() so creds
 are available
To: serge.hallyn@canonical.com, eparis@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        David Howells <dhowells@redhat.com>
Date: Thu, 21 Apr 2011 15:31:14 +0100
Message-ID: <20110421143114.31318.3353.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Pass the exec state (struct linux_binprm) pointer to open_exec() so new creds
are available for a later patch to use.

Also:

 (1) Move the declaration of open_exec() to linux/binfmts.h.

 (2) Stick a kerneldoc banner comment on open_exec() describing it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/alpha/kernel/binfmt_loader.c |    2 +-
 fs/binfmt_elf.c                   |    2 +-
 fs/binfmt_elf_fdpic.c             |    2 +-
 fs/binfmt_em86.c                  |    2 +-
 fs/binfmt_flat.c                  |   17 ++++++-----------
 fs/binfmt_misc.c                  |    2 +-
 fs/binfmt_script.c                |    2 +-
 fs/compat.c                       |    2 +-
 fs/exec.c                         |   23 +++++++++++++++++++++--
 include/linux/binfmts.h           |    1 +
 include/linux/fs.h                |    2 --
 11 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/arch/alpha/kernel/binfmt_loader.c b/arch/alpha/kernel/binfmt_loader.c
index 3fcfad4..1d19a44 100644
--- a/arch/alpha/kernel/binfmt_loader.c
+++ b/arch/alpha/kernel/binfmt_loader.c
@@ -24,7 +24,7 @@ static int load_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 
 	loader = bprm->vma->vm_end - sizeof(void *);
 
-	file = open_exec("/sbin/loader");
+	file = open_exec("/sbin/loader", bprm);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		return retval;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index c8060bb..9f08098 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -660,7 +660,7 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 			if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
 				goto out_free_interp;
 
-			interpreter = open_exec(elf_interpreter);
+			interpreter = open_exec(elf_interpreter, bprm);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
 				goto out_free_interp;
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index eee4f70..a8e07b9 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -235,7 +235,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm,
 			kdebug("Using ELF interpreter %s", interpreter_name);
 
 			/* replace the program with the interpreter */
-			interpreter = open_exec(interpreter_name);
+			interpreter = open_exec(interpreter_name, bprm);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter)) {
 				interpreter = NULL;
diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
index b8e8b0a..44f3bb7 100644
--- a/fs/binfmt_em86.c
+++ b/fs/binfmt_em86.c
@@ -80,7 +80,7 @@ static int load_em86(struct linux_binprm *bprm,struct pt_regs *regs)
 	 * Note that we use open_exec() as the name is now in kernel
 	 * space, and we don't need to copy it.
 	 */
-	file = open_exec(interp);
+	file = open_exec(interp, bprm);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 397d305..e9fe5bb 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -823,29 +823,24 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 	/* Create the file name */
 	sprintf(buf, "/lib/lib%d.so", id);
 
+	bprm.cred = (struct cred *)get_current_cred();
+
 	/* Open the file up */
 	bprm.filename = buf;
-	bprm.file = open_exec(bprm.filename);
+	bprm.file = open_exec(bprm.filename, bprm);
 	res = PTR_ERR(bprm.file);
 	if (IS_ERR(bprm.file))
-		return res;
-
-	bprm.cred = prepare_exec_creds();
-	res = -ENOMEM;
-	if (!bprm.cred)
-		goto out;
+		goto out_cred;
 
 	res = prepare_binprm(&bprm);
 
 	if (!IS_ERR_VALUE(res))
 		res = load_flat_file(&bprm, libs, id, NULL);
 
-	abort_creds(bprm.cred);
-
-out:
 	allow_write_access(bprm.file);
 	fput(bprm.file);
-
+out_cred:
+	put_creds(bprm.cred);
 	return(res);
 }
 
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 5209293..36a3297 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -178,7 +178,7 @@ static int load_misc_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 
 	bprm->interp = iname;	/* for binfmt_script */
 
-	interp_file = open_exec (iname);
+	interp_file = open_exec (iname, bprm);
 	retval = PTR_ERR (interp_file);
 	if (IS_ERR (interp_file))
 		goto _error;
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 396a988..78d7d47 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -87,7 +87,7 @@ static int load_script(struct linux_binprm *bprm,struct pt_regs *regs)
 	/*
 	 * OK, now restart the process with the interpreter's dentry.
 	 */
-	file = open_exec(interp);
+	file = open_exec(interp, bprm);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
diff --git a/fs/compat.c b/fs/compat.c
index 72fe6cd..4b10306 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -1461,7 +1461,7 @@ int compat_do_execve(char * filename,
 	clear_in_exec = retval;
 	current->in_execve = 1;
 
-	file = open_exec(filename);
+	file = open_exec(filename, bprm);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_unmark;
diff --git a/fs/exec.c b/fs/exec.c
index 4c47395..e1584c6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -720,7 +720,26 @@ EXPORT_SYMBOL(setup_arg_pages);
 
 #endif /* CONFIG_MMU */
 
-struct file *open_exec(const char *name)
+/**
+ * open_exec - Open an executable binary, loader, script or interpreter file
+ * @name: The path of the file to open
+ * @bprm: The exec state
+ *
+ * Open an executable binary, loader, script or interpreter file for program
+ * execution to process.
+ *
+ * The file is opened with the currently proposed credentials for execution.
+ * This means that the file specified to execve() is opened with the caller's
+ * current credentials, but files opened after that - such as binary loaders
+ * (e.g. ld-config.so) and script interpreters (e.g. /bin/sh) - will be opened
+ * with the credentials that will be installed if that executable is the thing
+ * actually run.
+ *
+ * Note that each iteration through prepare_binprm() may further modify the
+ * credentials to be.  The credentials at the time the returned file is opened
+ * will remain attached to file->f_cred until the file is closed.
+ */
+struct file *open_exec(const char *name, struct linux_binprm *bprm)
 {
 	struct file *file;
 	int err;
@@ -1440,7 +1459,7 @@ int do_execve(const char * filename,
 	clear_in_exec = retval;
 	current->in_execve = 1;
 
-	file = open_exec(filename);
+	file = open_exec(filename, bprm);
 	retval = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out_unmark;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 82577f7..57ea660 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -133,6 +133,7 @@ extern int bprm_mm_init(struct linux_binprm *bprm);
 extern int copy_strings_kernel(int argc, const char *const *argv,
 			       struct linux_binprm *bprm);
 extern int prepare_bprm_creds(struct linux_binprm *bprm);
+extern struct file *open_exec(const char *filename, struct linux_binprm *bprm);
 extern void install_exec_creds(struct linux_binprm *bprm);
 extern int kernel_read(struct linux_binprm *, struct file *,
 		       loff_t, void *, unsigned long);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 74543c9..e1a44a9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2224,8 +2224,6 @@ extern struct file *create_read_pipe(struct file *f, int flags);
 extern struct file *create_write_pipe(int flags);
 extern void free_write_pipe(struct file *);
 
-extern struct file * open_exec(const char *);
- 
 /* fs/dcache.c -- generic fs support functions */
 extern int is_subdir(struct dentry *, struct dentry *);
 extern int path_is_under(struct path *, struct path *);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
