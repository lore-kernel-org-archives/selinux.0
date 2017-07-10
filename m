Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6A7vipw011214
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 03:57:44 -0400
Received: by mail-pf0-f179.google.com with SMTP id e7so45977948pfk.0
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 00:57:42 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
 David Howells <dhowells@redhat.com>, Serge Hallyn <serge@hallyn.com>,
 John Johansen <john.johansen@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Michal Hocko <mhocko@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
 Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Rik van Riel <riel@redhat.com>,
 James Morris <james.l.morris@oracle.com>,
 Greg Ungerer <gerg@linux-m68k.org>, Ingo Molnar <mingo@kernel.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Vivek Goyal <vgoyal@redhat.com>,
 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH v2 2/8] exec: Move security_bprm_secureexec() earlier
Date: Mon, 10 Jul 2017 00:57:25 -0700
Message-Id: <1499673451-66160-3-git-send-email-keescook@chromium.org>
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There are several places where exec needs to know if a privilege-gain has
happened. These should be using the results of security_bprm_secureexec()
but it is getting (needlessly) called very late.

Instead, move this earlier in the exec code, to the start of the point
of no return in setup_new_exec(). Here, the new creds have already
been calculated (and stored in bprm->cred), which is normally what
security_bprm_secureexec() wants to examine. Since it's moved earlier,
LSMs hooking bprm_secureexec() need to be adjusted to use the creds in
bprm:

$ git grep LSM_HOOK_INIT.*bprm_secureexec
apparmor/lsm.c:    LSM_HOOK_INIT(bprm_secureexec, apparmor_bprm_secureexec),
commoncap.c:       LSM_HOOK_INIT(bprm_secureexec, cap_bprm_secureexec),
selinux/hooks.c:   LSM_HOOK_INIT(bprm_secureexec, selinux_bprm_secureexec),
smack/smack_lsm.c: LSM_HOOK_INIT(bprm_secureexec, smack_bprm_secureexec),

AppArmor does not access creds in apparmor_bprm_secureexec.

Capabilities needed to be adjusted to use bprm creds.

SELinux needed to be adjusted to use bprm creds for the security structure.

Smack needed to be adjusted to use bprm creds for the security structure.

The result of the bprm_secureexec() hook is saved in a new bprm field
"secureexec" so it can be queried later (just AT_SECURE currently).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c            | 2 +-
 fs/binfmt_elf_fdpic.c      | 2 +-
 fs/exec.c                  | 5 +++++
 include/linux/binfmts.h    | 3 ++-
 include/linux/lsm_hooks.h  | 3 ++-
 security/commoncap.c       | 4 +---
 security/selinux/hooks.c   | 2 +-
 security/smack/smack_lsm.c | 2 +-
 8 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5075fd5c62c8..7f6ec4dac13d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -254,7 +254,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
 	NEW_AUX_ENT(AT_GID, from_kgid_munged(cred->user_ns, cred->gid));
 	NEW_AUX_ENT(AT_EGID, from_kgid_munged(cred->user_ns, cred->egid));
- 	NEW_AUX_ENT(AT_SECURE, security_bprm_secureexec(bprm));
+	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
 	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
 #ifdef ELF_HWCAP2
 	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index cf93a4fad012..5aa9199dfb13 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -650,7 +650,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
 	NEW_AUX_ENT(AT_GID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->gid));
 	NEW_AUX_ENT(AT_EGID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->egid));
-	NEW_AUX_ENT(AT_SECURE,	security_bprm_secureexec(bprm));
+	NEW_AUX_ENT(AT_SECURE,	bprm->secureexec);
 	NEW_AUX_ENT(AT_EXECFN,	bprm->exec);
 
 #ifdef ARCH_DLINFO
diff --git a/fs/exec.c b/fs/exec.c
index 7842ae661e34..b92e37fb53aa 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1337,6 +1337,11 @@ EXPORT_SYMBOL(would_dump);
 
 void setup_new_exec(struct linux_binprm * bprm)
 {
+	if (security_bprm_secureexec(bprm)) {
+		/* Record for AT_SECURE. */
+		bprm->secureexec = 1;
+	}
+
 	arch_pick_mmap_layout(current->mm);
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 05488da3aee9..1afaa303cad0 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -27,9 +27,10 @@ struct linux_binprm {
 	unsigned int
 		cred_prepared:1,/* true if creds already prepared (multiple
 				 * preps happen for interpreters) */
-		cap_effective:1;/* true if has elevated effective capabilities,
+		cap_effective:1,/* true if has elevated effective capabilities,
 				 * false if not; except for init which inherits
 				 * its parent's caps anyway */
+		secureexec:1;	/* true when gaining privileges */
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 080f34e66017..d1bd24fb4a33 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -72,7 +72,8 @@
  *	Return a boolean value (0 or 1) indicating whether a "secure exec"
  *	is required.  The flag is passed in the auxiliary table
  *	on the initial stack to the ELF interpreter to indicate whether libc
- *	should enable secure mode.
+ *	should enable secure mode. Called before bprm_committing_creds(),
+ *	so pending credentials are in @bprm->cred.
  *	@bprm contains the linux_binprm structure.
  *
  * Security hooks for filesystem operations.
diff --git a/security/commoncap.c b/security/commoncap.c
index 7abebd782d5e..482d3aac2fc6 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -624,12 +624,10 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
  * Determine whether a secure execution is required, return 1 if it is, and 0
  * if it is not.
  *
- * The credentials have been committed by this point, and so are no longer
- * available through @bprm->cred.
  */
 int cap_bprm_secureexec(struct linux_binprm *bprm)
 {
-	const struct cred *cred = current_cred();
+	const struct cred *cred = bprm->cred;
 	kuid_t root_uid = make_kuid(cred->user_ns, 0);
 
 	if (!uid_eq(cred->uid, root_uid)) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 819fd6858b49..9381c8474cf4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2420,7 +2420,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 static int selinux_bprm_secureexec(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = bprm->cred->security;
 	u32 sid, osid;
 	int atsecure = 0;
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 658f5d8c7e76..13cf9e66d5fe 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -975,7 +975,7 @@ static void smack_bprm_committing_creds(struct linux_binprm *bprm)
  */
 static int smack_bprm_secureexec(struct linux_binprm *bprm)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = bprm->cred->security;
 
 	if (tsp->smk_task != tsp->smk_forked)
 		return 1;
-- 
2.7.4
