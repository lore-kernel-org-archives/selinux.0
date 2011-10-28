From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: audit failed attempts to set invalid labels
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, dwalsh@redhat.com, kyle@moffetthome.net
Date: Fri, 28 Oct 2011 17:10:18 -0400
Message-ID: <20111028211017.20366.65070.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We know that some yum operation is causing CAP_MAC_ADMIN failures.  This
implies that an RPM is laying down (or attempting to lay down) a file with
an invalid label.  The problem is that we don't have any information to
track down the cause.  This patch with cause such a failure to report the
failed label in an SELINUX_ERR audit message.  This is similar to the
SELINUX_ERR reports on invalid transitions and things like that.  It should
help run down problems on what is trying to set invalid labels in the
future.

Resulting records look something like:
type=AVC msg=audit(1319659241.138:71): avc:  denied  { mac_admin } for pid=2594 comm="chcon" capability=33 scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=capability2
type=SELINUX_ERR msg=audit(1319659241.138:71): op=setxattr invalid_context=unconfined_u:object_r:hello:s0
type=SYSCALL msg=audit(1319659241.138:71): arch=c000003e syscall=188 success=no exit=-22 a0=a2c0e0 a1=390341b79b a2=a2d620 a3=1f items=1 ppid=2519 pid=2594 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=1 comm="chcon" exe="/usr/bin/chcon" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=CWD msg=audit(1319659241.138:71):  cwd="/root" type=PATH msg=audit(1319659241.138:71): item=0 name="test" inode=785879 dev=fc:03 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:admin_home_t:s0

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2887517..d4fcd1e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2767,8 +2767,25 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 
 	rc = security_context_to_sid(value, size, &newsid);
 	if (rc == -EINVAL) {
-		if (!capable(CAP_MAC_ADMIN))
+		if (!capable(CAP_MAC_ADMIN)) {
+			struct audit_buffer *ab;
+			size_t audit_size;
+			const char *str;
+
+			/* We strip a nul only if it is at the end, otherwise the
+			 * context contains a nul and we should audit that */
+			str = value;
+			if (str[size - 1] == '\0')
+				audit_size = size - 1;
+			else
+				audit_size = size;
+			ab = audit_log_start(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR);
+			audit_log_format(ab, "op=setxattr invalid_context=");
+			audit_log_n_untrustedstring(ab, value, audit_size);
+			audit_log_end(ab);
+
 			return rc;
+		}
 		rc = security_context_to_sid_force(value, size, &newsid);
 	}
 	if (rc)
@@ -5277,8 +5294,23 @@ static int selinux_setprocattr(struct task_struct *p,
 		}
 		error = security_context_to_sid(value, size, &sid);
 		if (error == -EINVAL && !strcmp(name, "fscreate")) {
-			if (!capable(CAP_MAC_ADMIN))
+			if (!capable(CAP_MAC_ADMIN)) {
+				struct audit_buffer *ab;
+				size_t audit_size;
+
+				/* We strip a nul only if it is at the end, otherwise the
+				 * context contains a nul and we should audit that */
+				if (str[size - 1] == '\0')
+					audit_size = size - 1;
+				else
+					audit_size = size;
+				ab = audit_log_start(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR);
+				audit_log_format(ab, "op=fscreate invalid_context=");
+				audit_log_n_untrustedstring(ab, value, audit_size);
+				audit_log_end(ab);
+
 				return error;
+			}
 			error = security_context_to_sid_force(value, size,
 							      &sid);
 		}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
