Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74CpPIe004559
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 08:51:25 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66D433B709
 for <selinux@tycho.nsa.gov>; Thu,  4 Aug 2016 12:51:03 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/sepolicy: Check get_rpm_nvr_list() return
 value
Date: Thu,  4 Aug 2016 14:50:53 +0200
Message-Id: <1470315053-18483-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

get_rpm_nvr_list can fail to get the version of selinux-policy rpm
package, which leads to error during spec file creation (attempt to
invoke __getitem__ of "None" object).

This patch sets the policy number to "0.0.0" in case rpm failed to
get it. This change should be safe because it affects only an example
of spec file.

Variable "POLICYCOREUTILSVER" was removed (unused).

fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1321499

Failed to retrieve rpm info for selinux-policy
Traceback (most recent call last):
  File "/bin/selinux-polgengui", line 360, in forward
    self.generate_policy()
  File "/bin/selinux-polgengui", line 506, in generate_policy
    self.info(my_policy.generate(outputdir))
  File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1382, in generate
    out += "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
  File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1228, in write_spec
    fd.write(self.generate_spec())
  File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 1190, in generate_spec
    selinux_policyver = get_rpm_nvr_list("selinux-policy")[1]
  TypeError: 'NoneType' object has no attribute '__getitem__'

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 policycoreutils/sepolicy/sepolicy/generate.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
index a92783a..1c67d99 100644
--- a/policycoreutils/sepolicy/sepolicy/generate.py
+++ b/policycoreutils/sepolicy/sepolicy/generate.py
@@ -1184,8 +1184,12 @@ allow %s_t %s_t:%s_socket name_%s;
     def generate_spec(self):
         newspec = ""
 
-        selinux_policyver = get_rpm_nvr_list("selinux-policy")[1]
-        POLICYCOREUTILSVER = get_rpm_nvr_list("checkpolicy")[1]
+        selinux_policynvr = get_rpm_nvr_list("selinux-policy")
+
+        if selinux_policynvr is None:
+            selinux_policyver = "0.0.0"
+        else:
+            selinux_policyver = selinux_policynvr[1]
 
         newspec += spec.header_comment_section
         if self.type in APPLICATIONS:
-- 
2.5.5
