Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w39NgkWx015773
 for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2018 19:42:46 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, SElinux list <selinux@tycho.nsa.gov>,
 Linux Security Module list <linux-security-module@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Date: Mon,  9 Apr 2018 19:36:31 -0400
Message-Id: <eb67b174e6a3d0fe174cc738d9109cd7fda96a9b.1523316291.git.rgb@redhat.com>
Subject: [PATCH ghak47 V1] audit: normalize MAC_POLICY_LOAD record
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The audit MAC_POLICY_LOAD record had redundant dangling keywords and was
missing information about which LSM was responsible and its completion
status.  While this record is only issued on success, the parser expects
the res= field to be present.

Old record:
type=MAC_POLICY_LOAD msg=audit(1479299795.404:43): policy loaded auid=0 ses=1

Delete the redundant dangling keywords, add the lsm= field and the res=
field.

New record:
type=MAC_POLICY_LOAD msg=audit(1523293846.204:894): auid=0 ses=1 lsm=selinux res=1

See: https://github.com/linux-audit/audit-kernel/issues/47
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 00b21b2..496915a 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -531,7 +531,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 out1:
 	audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
-		"policy loaded auid=%u ses=%u",
+		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
 out:
-- 
1.8.3.1
