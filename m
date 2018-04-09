Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w39Nej7w015352
 for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2018 19:40:45 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, SElinux list <selinux@tycho.nsa.gov>,
 Linux Security Module list <linux-security-module@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Date: Mon,  9 Apr 2018 19:34:22 -0400
Message-Id: <6b939250a519668af109adf877d85ff018b217d7.1523316267.git.rgb@redhat.com>
Subject: [PATCH ghak46 V1] audit: normalize MAC_STATUS record
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There were two formats of the audit MAC_STATUS record, one of which was more
standard than the other.  One listed enforcing status changes and the
other listed enabled status changes with a non-standard label.  In
addition, the record was missing information about which LSM was
responsible and the operation's completion status.  While this record is
only issued on success, the parser expects the res= field to be present.

old enforcing/permissive:
type=MAC_STATUS msg=audit(1523312831.378:24514): enforcing=0 old_enforcing=1 auid=0 ses=1
old enable/disable:
type=MAC_STATUS msg=audit(1523312831.378:24514): selinux=0 auid=0 ses=1

List both sets of status and old values and add the lsm= field and the
res= field.

Here is the new format:
type=MAC_STATUS msg=audit(1523293828.657:891): enforcing=0 old_enforcing=1 auid=0 ses=1 enabled=1 old-enabled=1 lsm=selinux res=1

This record already accompanied a SYSCALL record.

See: https://github.com/linux-audit/audit-kernel/issues/46
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 security/selinux/selinuxfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 00eed84..00b21b2 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -145,10 +145,11 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		if (length)
 			goto out;
 		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
-			"enforcing=%d old_enforcing=%d auid=%u ses=%u",
+			"enforcing=%d old_enforcing=%d auid=%u ses=%u"
+			" enabled=%d old-enabled=%d lsm=selinux res=1",
 			new_value, selinux_enforcing,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
-			audit_get_sessionid(current));
+			audit_get_sessionid(current), selinux_enabled, selinux_enabled);
 		selinux_enforcing = new_value;
 		if (selinux_enforcing)
 			avc_ss_reset(0);
@@ -272,9 +273,11 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 		if (length)
 			goto out;
 		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
-			"selinux=0 auid=%u ses=%u",
+			"enforcing=%d old_enforcing=%d auid=%u ses=%u"
+			" enabled=%d old-enabled=%d lsm=selinux res=1",
+			selinux_enforcing, selinux_enforcing,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
-			audit_get_sessionid(current));
+			audit_get_sessionid(current), 0, 1);
 	}
 
 	length = count;
-- 
1.8.3.1
