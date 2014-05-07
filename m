Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s47ILWDH029219
 for <selinux@tycho.nsa.gov>; Wed, 7 May 2014 14:21:33 -0400
From: Petre Rodan <petre.rodan@simplex.ro>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] add ekeyd related rules
Date: Wed,  7 May 2014 21:21:20 +0300
Message-Id: <1399486880-12744-2-git-send-email-petre.rodan@simplex.ro>
In-Reply-To: <1399486880-12744-1-git-send-email-petre.rodan@simplex.ro>
References: <1399486880-12744-1-git-send-email-petre.rodan@simplex.ro>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petre Rodan <petre.rodan@simplex.ro>
---

ekey domain transitions

 policy/modules/roles/sysadm.te | 4 ++++
 policy/modules/system/udev.te  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/policy/modules/roles/sysadm.te b/policy/modules/roles/sysadm.te
index 7e3d23e..2fee4d0 100644
--- a/policy/modules/roles/sysadm.te
+++ b/policy/modules/roles/sysadm.te
@@ -152,6 +152,10 @@ optional_policy(`
 ')
 
 optional_policy(`
+	ekey_tool_run(sysadm_t, sysadm_r)
+')
+
+optional_policy(`
 	firstboot_run(sysadm_t, sysadm_r)
 ')
 
diff --git a/policy/modules/system/udev.te b/policy/modules/system/udev.te
index b0aa655..741272f 100644
--- a/policy/modules/system/udev.te
+++ b/policy/modules/system/udev.te
@@ -262,6 +262,10 @@ optional_policy(`
 ')
 
 optional_policy(`
+	ekey_tool_domtrans(udev_t)
+')
+
+optional_policy(`
 	lvm_domtrans(udev_t)
 ')
 
-- 
1.8.5.5
