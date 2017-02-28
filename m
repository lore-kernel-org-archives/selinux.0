From: Stephen Smalley <sds@tycho.nsa.gov>
To: james.l.morris@oracle.com
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com, jslaby@suse.cz,
 selinux@tycho.nsa.gov, xiaolong.ye@intel.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: fix kernel BUG on prlimit(..., NULL, NULL)
Date: Tue, 28 Feb 2017 09:35:08 -0500
Message-Id: <1488292508-32506-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit 79bcf325e6b32b3c ("prlimit,security,selinux: add a security hook
for prlimit") introduced a security hook for prlimit() and implemented it
for SELinux.  However, if prlimit() is called with NULL arguments for both
the new limit and the old limit, then the hook is called with 0 for the
read/write flags, since the prlimit() will neither read nor write the
process' limits.  This would in turn lead to calling avc_has_perm() with 0
for the requested permissions, which triggers a BUG_ON() in
avc_has_perm_noaudit() since the kernel should never be invoking
avc_has_perm() with no permissions.  Fix this in the SELinux hook by
returning immediately if the flags are 0.  Arguably prlimit64() itself
ought to return immediately if both old_rlim and new_rlim are NULL since
it is effectively a no-op in that case.

Reported by the lkp-robot based on trinity testing.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4a80bd8..af1ff15 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3922,6 +3922,8 @@ int selinux_task_prlimit(const struct cred *cred, const struct cred *tcred,
 {
 	u32 av = 0;
 
+	if (!flags)
+		return 0;
 	if (flags & LSM_PRLIMIT_WRITE)
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
-- 
2.7.4
