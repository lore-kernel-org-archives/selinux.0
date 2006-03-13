Subject: [SECURITY] SELinux ptrace bug (CVE-2006-1052)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 10:35:43 -0500
Message-Id: <1142264143.24555.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

While looking at some patches in -mm that modify proc permission
checking, I realized that there is a security-relevant bug in the
existing SELinux ptrace handling.  The bug was introduced in Linux 2.6.6
by a prior patch by me to address a race condition in the SELinux ptrace
handling logic, see:
http://marc.theaimsgroup.com/?l=git-commits-head&m=108305094908582&w=2
and
http://marc.theaimsgroup.com/?l=selinux&m=108307458611219&w=2
for that patch and associated discussion.

The problem with that patch is that selinux_ptrace is also called by
proc to apply permission checking outside of the context of an actual
ptrace attach, so the tracer SID saved and used by that patch could be
replaced by the SID of another process that happens to read or attempt
to read certain proc files (/proc/pid/environ, /proc/pid/mem) of the
traced process, leading to that SID being used in subsequent ptrace
revalidation at execve time.  This issue has been assigned
CVE-2006-1052.  

Preconditions for a successful exploitation of this bug include: a)
Attacker must have ptrace permission to some domain (e.g. his own) so
that he can perform an initial attach to a process, b) Attacker must be
able to wait for or induce a privileged process that has ptrace
permission to the "target" domain (i.e. the domain he wishes to ptrace
but lacks direct ptrace permission for) to try to read
the /proc/pid/environ or /proc/pid/mem files of his own traced process,
thereby resetting the tracer SID to the SID of the privileged process,
and c) the Attacker must have execute permission to a program authorized
to enter the "target" domain and transition permission to the "target"
domain.

Note that even if all preconditions are met, the bug only affects
SELinux ptrace handling, not the base Linux DAC ptrace handling; thus,
the usual restrictions on setuid/setgid still apply and the attacker may
end up with control over a domain that is allowed certain capabilities
by SELinux policy without possessing the base Linux capabilities,
rendering the attack unsuccessful, since a process must pass both Linux
DAC checking and SELinux MAC checking.

A simple patch for this bug has been upstreamed, see:
http://marc.theaimsgroup.com/?l=git-commits-head&m=114210002712363&w=2
(also included below for reference) and is included in Linux 2.6.16-rc6.
This patch changes the selinux_ptrace logic to only set the tracer SID
if the process is not already being traced.  A cleaner solution that
splits the security_ptrace hook into two separate hooks to eliminate the
need for side effects from a permission checking hook is planned for
future kernels, with one of the two hooks only being called upon actual
ptrace attach operations.  Patch follows.

---

Fix SELinux to not reset the tracer SID when the child is already
being traced, since selinux_ptrace is also called by proc for
access checking outside of the context of a ptrace attach.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.183
diff -u -p -r1.183 hooks.c
--- linux-2.6/security/selinux/hooks.c	14 Feb 2006 20:37:32 -0000	1.183
+++ linux-2.6/security/selinux/hooks.c	10 Mar 2006 14:41:53 -0000
@@ -1261,7 +1261,7 @@ static int selinux_ptrace(struct task_st
 
 	rc = task_has_perm(parent, child, PROCESS__PTRACE);
 	/* Save the SID of the tracing process for later use in apply_creds. */
-	if (!rc)
+	if (!(child->ptrace & PT_PTRACED) && !rc)
 		csec->ptrace_sid = psec->sid;
 	return rc;
 }


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
