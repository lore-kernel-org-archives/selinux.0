From: Eric Paris <eparis@redhat.com>
Subject: [PATCH -v3 4/4] SELinux: use new cap_noaudit interface
To: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Cc: sds@tycho.nsa.gov, jmorris@nameil.org, serue@us.ibm.com, morgan@kernel.org,
        casey@schaufler-ca.com, esandeen@redhat.com
Date: Fri, 07 Nov 2008 10:23:43 -0500
Message-ID: <20081107152343.10328.60753.stgit@paris.rdu.redhat.com>
In-Reply-To: <20081107152326.10328.44330.stgit@paris.rdu.redhat.com>
References: <20081107152326.10328.44330.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently SELinux jumps through some ugly hoops to not audit a capbility
check when determining if a process has additional powers to override
memory limits or when trying to read/write illegal file labels.  Use
the new noaudit call instead.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0d4ee8c..d3fd051 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1978,16 +1978,8 @@ static int selinux_syslog(int type)
 static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 {
 	int rc, cap_sys_admin = 0;
-	struct task_security_struct *tsec = current->security;
-
-	rc = secondary_ops->capable(current, CAP_SYS_ADMIN, SECURITY_CAP_NOAUDIT);
-	if (rc == 0)
-		rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
-					  SECCLASS_CAPABILITY,
-					  CAP_TO_MASK(CAP_SYS_ADMIN),
-					  0,
-					  NULL);
 
+	rc = selinux_capable(current, CAP_SYS_ADMIN, SECURITY_CAP_NOAUDIT);
 	if (rc == 0)
 		cap_sys_admin = 1;
 
@@ -2812,7 +2804,6 @@ static int selinux_inode_getsecurity(const struct inode *inode, const char *name
 	u32 size;
 	int error;
 	char *context = NULL;
-	struct task_security_struct *tsec = current->security;
 	struct inode_security_struct *isec = inode->i_security;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
@@ -2827,13 +2818,7 @@ static int selinux_inode_getsecurity(const struct inode *inode, const char *name
 	 * and lack of permission just means that we fall back to the
 	 * in-core context value, not a denial.
 	 */
-	error = secondary_ops->capable(current, CAP_MAC_ADMIN, SECURITY_CAP_NOAUDIT);
-	if (!error)
-		error = avc_has_perm_noaudit(tsec->sid, tsec->sid,
-					     SECCLASS_CAPABILITY2,
-					     CAPABILITY2__MAC_ADMIN,
-					     0,
-					     NULL);
+	error = selinux_capable(current, CAP_MAC_ADMIN, SECURITY_CAP_NOAUDIT);
 	if (!error)
 		error = security_sid_to_context_force(isec->sid, &context,
 						      &size);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
