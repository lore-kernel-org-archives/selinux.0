Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LEVRAf016579
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 10:31:27 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LEVQTB001441
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:31:26 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 9/9] LSM: Use derived creds for accessing an executable's
 interpreter and binary loader
To: serge.hallyn@canonical.com, eparis@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        David Howells <dhowells@redhat.com>
Date: Thu, 21 Apr 2011 15:31:20 +0100
Message-ID: <20110421143120.31318.4511.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently, the caller must be able to open the script interpreter and/or the
binary loader that an executable wants to make use of, even if the executable
will be transitioned to a different context that can make use of that
interpreter or loader when the caller's context does not permit it.

Override credentials in open_exec() and kernel_read() with the currently
constructed new credentials so that if the executable file or its interpreter
specifies a transition to a different security context (DAC or MAC), then the
caller only has to provide access to the file to be executed, and not to the
interpreter (e.g. perl) or binary loader (e.g. ld.so) for the executable or
interpreter.

This means that if the caller does not have access to a script interpreter or
binary loader, it can still use scripts and executables that transition to a
security context that do.


For the initial opening of the executable file specified to execve(), this
won't make much difference as the new creds at that point are a clone of the
old ones (except that the new creds do not have thread or process keyrings).

For the opening of script interpreters (e.g. /bin/sh), the file will be opened
with the credentials-to-be rather than the credentials of the caller of
execve() by the script binfmt passing the bprm to open_exec(), and the file
will be reopened on the subsequent pass through prepare_binprm() if a security
context transition takes place.

For the opening of binary loaders (e.g. ld-linux.so), the file will be opened
with the credentials-to-be rather than the credentials of the caller of
execve() by the binary binfmt passing the bprm to open_exec().

If we publish the new credentials by making use of them, however, we may not
change them thereafter.  This relies on the previous patches to make the cred
pointer in struct linux_binfmt semi-committed once it's assigned there.

Note that reopen_exec() uses dentry_open() rather than do_file_open().  To use
the latter, prepare_binprm() has to be furnished with a pointer to the filename
for whatever was opened for bprm->file and the core SELinux policy requires an
additional rule:

	allow setfiles_t bin_t:lnk_file read;

so that /sbin/setfiles can be exec'd as /sbin/restorecon (which is a symlink).


To make the SELinux testsuite work after this patch, the following two rules
need to be added to the policy:

	[policy/test_ptrace.te]
	allow test_ptrace_traced_t bin_t:file { execute read open };

	[policy/test_file.te]
	allow fileop_t fileop_exec_t:file { execute read open };

The first allows the ptrace test to use the perl interpreter (labelled bin_t)
to run a perl script and the second allows the SIGIO file test's wait program
to use its binary (labelled fileop_exec_t).

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/exec.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e1584c6..c40a126 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -741,6 +741,7 @@ EXPORT_SYMBOL(setup_arg_pages);
  */
 struct file *open_exec(const char *name, struct linux_binprm *bprm)
 {
+	const struct cred *saved_cred;
 	struct file *file;
 	int err;
 	static const struct open_flags open_exec_flags = {
@@ -749,7 +750,9 @@ struct file *open_exec(const char *name, struct linux_binprm *bprm)
 		.intent = LOOKUP_OPEN
 	};
 
+	saved_cred = override_creds(bprm->cred);
 	file = do_filp_open(AT_FDCWD, name, &open_exec_flags, LOOKUP_FOLLOW);
+	revert_creds(saved_cred);
 	if (IS_ERR(file))
 		goto out;
 
@@ -789,15 +792,22 @@ int kernel_read(struct linux_binprm *bprm,
 		struct file *file, loff_t offset,
 		void *addr, unsigned long count)
 {
+	const struct cred *saved_cred = NULL;
 	mm_segment_t old_fs;
 	loff_t pos = offset;
 	int result;
 
+	if (bprm && bprm->cred)
+		saved_cred = override_creds(bprm->cred);
+
 	old_fs = get_fs();
 	set_fs(get_ds());
 	/* The cast to a user pointer is valid due to the set_fs() */
 	result = vfs_read(file, (void __user *)addr, count, &pos);
 	set_fs(old_fs);
+
+	if (saved_cred)
+		revert_creds(saved_cred);
 	return result;
 }
 EXPORT_SYMBOL(kernel_read);
@@ -1231,11 +1241,65 @@ int check_unsafe_exec(struct linux_binprm *bprm)
 	return res;
 }
 
-/* 
- * Fill the binprm structure from the inode. 
- * Check permissions, then read the first 128 (BINPRM_BUF_SIZE) bytes
+/*
+ * Reopen the file currently held by bprm->file with the newly calculated
+ * credentials.
+ *
+ * It's possible we should use open_exec() here instead, but that requires at
+ * least one additional SELinux rule.
+ */
+static int reopen_exec(struct linux_binprm *bprm)
+{
+	struct file *file;
+	int retval;
+
+	dget(bprm->file->f_path.dentry);
+	mntget(bprm->file->f_path.mnt);
+	file = dentry_open(bprm->file->f_path.dentry,
+			   bprm->file->f_path.mnt,
+			   bprm->file->f_flags,
+			   bprm->cred);
+
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	fsnotify_open(file);
+	retval = deny_write_access(file);
+	if (retval < 0) {
+		fput(file);
+		return retval;
+	}
+
+	allow_write_access(bprm->file);
+	fput(bprm->file);
+	bprm->file = file;
+	return 0;
+}
+
+/**
+ * prepare_binprm - Set up the program execution state.
+ * @bprm: The exec state
+ *
+ * Set up the execution state for this particular iteration of the program
+ * execution procedure (there may be multiple iterations due to scripts and
+ * other interpreted executables).
+ *
+ * The proposed new credentials for the process are generated at this stage and
+ * may not be modified thereafter until and unless prepare_binprm() is called
+ * again - say for a script interpreter.
+ *
+ * The permissions on the file to be read (previously opened and attached to
+ * bprm->file) are checked at this point and credential transitions, such as
+ * SGID, SUID, capability escalations and LSM label changes are handled here
+ * too.
  *
- * This may be called multiple times for binary chains (scripts for example).
+ * bprm->file will be reopened with the new credentials so that mappings made
+ * with it will belong to the same security context as the new program and
+ * bprm->file->f_cred will refer to the new creds and not the old creds.
+ *
+ * The first chunk of the file to be executed is read and placed in bprm->buf
+ * for the binfmt drivers to examine.  It is presumed that this will be
+ * sufficient to provide the magic number and script interpreter filename.
  */
 int prepare_binprm(struct linux_binprm *bprm)
 {
@@ -1293,14 +1357,18 @@ int prepare_binprm(struct linux_binprm *bprm)
 	bprm->cred_prepared = 1;
 	put_cred(old);
 
-	/* TODO: Reopen the executable image file if any significant security
-	 * data changed during calculation of the new credentials
+	/* Reopen the executable image file if any significant security data
+	 * changed during calculation of the new credentials
 	 */
+	if (reopen_file) {
+		retval = reopen_exec(bprm);
+		if (retval < 0)
+			return retval;
+	}
 
 	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
 	return exec_read_header(bprm, bprm->file);
 }
-
 EXPORT_SYMBOL(prepare_binprm);
 
 /*


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
