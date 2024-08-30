Received: from sonic312-31.consmr.mail.ne1.yahoo.com (sonic312-31.consmr.mail.ne1.yahoo.com [66.163.191.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F35672
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978671; cv=none; b=n8/J4/qUtLcXk1itONGWWCekGPMRZeR1PtJxoWmp1X/T+ZYXUWQ+i6ikC+HVFAWLiYeLVIsvkZxOoJdjnzYrSkdgp+ynxmeANKxvmIMs9RMnUNKN2HbN5gFJTqL4E+hh3CTriPFFkD2w9YFWm4UieKI9rlTm1mFm0AJ9oJ/hi88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978671; c=relaxed/simple;
	bh=5i/utsKdzmAP/kmD3J3bFCcoRqBsiuWXAxRyrMgYleg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIuv0aHgHoQk4viJtvoFo8Gy4EUAUVMMvkiZn5jZzfw3HUzzYQRZSl67Cf05fy98kYp/sr9Uu7gEblS76+fspNfMzBzCU1Qkn1FJbEPoE9IOIK2mSJ1GHstO4nCvoYbacQtY4jcj4eci5bBW7eDwRQfSQ0ZEv6xl7FwRCpBbZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=X3LJeTR8; arc=none smtp.client-ip=66.163.191.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="X3LJeTR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978668; bh=2QisATgn2zatcIkI+LrtVFsk+P4khN+6xkfTqAVDMTM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=X3LJeTR8RT1ovoVr8bB15XTe7pEFxrHrH3iEGEb+JR9ixjVvqbozISBY6LUca6AYVyraV7idDqDPvbLZ+nNBzx4W6sluoRtq6yeWcMItdcnHK/zKUudX7xi1U9THABvm8/oZNHl3fXnpRaCcEAUzc6z2VOxdvj+tv9ODiHmWo3q5QwH56PWBkFGVA3oOxFRG327pSTyGl3p750Ah0xjHYWCNC2ta47PHZJAL4H/Zfe1OOen/BkZHqIi4SXxfrI96bL79iryCcHEjKwynpm1AXvAcQ6XjQtMUKOU/YI865oRZFSFQBRG6fMDRVUq06ULPowuiV0rTxDONSKEd7o9/dw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978668; bh=8+HwmIpxVSIwTyWlNIWjy/hqZn3wFHlBjLvVG4AoZaP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jdYKHcoVHUtzIC2HXCgyf8Nwm/7lL1yTXSC0v4LFCdLKVTdw9XyeUn0wACuAIXDH69j3tXDizg2j2hH62WZ379kVrS9LWdVn9dME6z4AFjb8NFtRUCcJdMOtxJf16iQydKo1ayRWUZff5PG5xPyTt7aeU1ADUwS4n5SzRPkPjK0OJ0te6nvHVSTp9jHWEoibJyXze3X32zwBH6ts9Jd2j2CSlLGAWAH9M3ZVjGJjEdK0gq3z8NAFWLi0YvwGCB160eghjbD/UMkkkIN95GREIaxIKI0P8dtAnQ523KXL3SgWnJH4QnowchACveUlcFtwWkb/K7FCH/Obj1BKby5fqA==
X-YMail-OSG: YYVzUfkVM1lfwkcIV7TZJMCj0TIWYKu9LJGTja0XxOX3y6CfLcHG30Ugl7TkK9w
 WMuNWgYNGVpy57EfD1IZdeLxN7TBSEew7AyGNRYxjdrZpLet3jWZ6JMiJeNuWiOXjXgQ1Ikd6ZOD
 GUdzbQHcOtrY3RycDWoNCl3v9XHYaOaaOclEKoa6HO4TnJe9EmJaPOu5I6lrsHizti.scApxO1Ga
 8cEbtBthLeNCq.aklDmPYLj4OYmtOAGU6u65lQZt7LlIO.1Mz8sy2GAmXdebHVjpRq3RJUubWEeW
 6gq1eJyssQXPqUjjtJn1FPrHTZwB_eA41JeamkxOkU85yR47JDZh4uJSTOzJqNMCv_vfBLDa61kj
 Q2GtY2aaMNgDUDkGzECZV9UBJrHxqhIyH8.NrZSn4JBkhQvbDPzaA_Qr1nEeZ5zVp.tFz7BjYS1u
 icA83xKlbg4B.ZvERoREjf2KcmFwnC9_TB00U.YOBdGLirHcvMVtUQZpMxztHf8Dla3JlZ7VV09u
 RSfplnS6iFF8gPCvW0_aSl9vxpx_LaeMB6PcSt_IkdRBnwhqTxbx7.dFZzafAMNY3bCjJCOh.AcE
 3V6od4znnHkRpeqqSw6oLJHqaYY1iYAb9ik_6dtQx6x_m1txi0FNfG_8gvs2Nd.IEzKkUweABIuL
 D3ZGPXQmvGxItT3NVKhh5PX3W2joiN6ZtxL6pWzQeoYG82LTwpmPdB15JQbhTF5VfgB1IDNYPVHI
 2hQgM9X2O3vmQl3in.ySXZdRu1RPBiMPdlC.7DiliUWlsK3GMZ5kRDQZPzAOKgE1EsZTgQFsKXk.
 TmkTAnT57xUT3zX5x9if_0WPNinmsv_nP.jzNrzt8i5sFOpHQ0eBFZkHK0IA0S1sjWS.csIoc.7R
 pbxv_hhZMcY4nPl1AdMfQx36XR1qEYX2SSxJoM31N9MwHQcUK1SfB5k7ytmLrB1qJbqgQqKwocL3
 ep4FNVotZbE93Pgtiv8Xg90a4JUXCzTIOMOxSUIw_sTEpAu67fjfzgr8MAJ3ih6sgJb13XC_nAl1
 Y02KoHNwlMKhrTBS8G6tRhT2UHZiKCjpqAi4KiGf6gWdDi9rxrMP5yAYxVg_ExjiCveAObVyEZ8x
 KO9Yn9fSEHMOmgyr4GARqtVicF7_t4AKTGGOieZJQFY9R7YqY9X644mM2sJct5ebDTPaWHc4Mceh
 1NoRfm9vCRfmVxXy7_YwQ9FB8RZW9fE9zmlP6oFadpvKIKpe1sg74QM17CaOmMGCNjn3OzspBxaA
 6_SafJsfAzEp8YDd0TrRII7x57_tHk591nZBOaQY2Z0SKLaGF3sCVgToo0fSfMrCIHU0AZ0Dlg5A
 edciza5.ggLQaW041IkCzKFp0.C8xygzX.I2XTRcS849BSkMhcbVL6Y0VvBMoblgdk8SEloN9dXE
 u8pVOTFUpZQh7ap.ov_HUUZNktFzccMdjSko2HWLzV_.nfGk85kzBpHoIlqg4OU4U6WLd2cv4aBd
 HBcOUVa61P8EV8cLqhvNG5fh8k38o4DsJd9K8p24g6kCRwGttyz7oTdfq8LdEACWZZsjtMXXKbnA
 FCWc74r1oBmVxNmaMZzxRCYoL341ziMXYr_3R3CvazxrA.3ZlWlJwMWwMWIbTzOteWFDQQYDZ4yk
 EoShXUFy0rKXH9uALENk1X46mRHJYF4ELOHN8s7S5CxcWNU7eNnFE6DTE0XO8yq0R6aTNG4Hnwgj
 I00zFQGZXdxB8gWv8hL8UYYDYBSGo8xSjUE7ZmahJPPTQSzfmyfFWQgArz7keC9mEcSBKoFoAFtC
 X3KBoJkCQDPZ0Agr0RtPtpQKujX8fHGCscndW0Ds7HiJo6ADLs8xiPBJ5i0zGA2mQFkP8Z214zcv
 tlfVeG_SOKQzPF2urDrtCw1q5XPuvRahxYIUDrRAVNBN_9Oy7593FXDI6dnnZDvdt9wmkqBpAmKZ
 K.Jj03MfK1C0DQitNcOkvONnNB5YBCduXgL9P33fnUz9wloROwdemhQ2nKDGYpa48Wt8tBRRKXgB
 EHi1xQfw5KtmRTwYlWXmmWRznPcteZEqKPVBZY2EPcGBMb0OPgtOug2A3YafjfnYlMBPP.0i_.Ff
 I92tlvoaz5F9YpNIH_kAqAdX6qv4YSMOyHsNcWCwJKT4cn4n3DGkUY6FPcjEbKFPiEqGHMSgHoGm
 ZYqtPYF7xgdfmUcogk4I5FLuxKoZS7jWXZ4BU5HgmsitA7yuhvA5AOC.kiOkBPTWXJbL4NCFUyjR
 tEM780FbkStD1Qd79C2xOJKigg2kCFMMn8WR29cv0Pfx2A1tEZD_IzYS84SOYwb1cj7YHXvI2Jsd
 ZMh_jymxXVM0BZHXwJTZVdKU4vb_8BTRM4w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 053e8715-dae5-4eff-baae-808d9e5b2d56
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:44:28 +0000
Received: by hermes--production-gq1-5d95dc458-gnv6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5da78dbe3e0c562970426cfb16ce357c;
          Fri, 30 Aug 2024 00:34:16 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org
Subject: [PATCH v2 01/13] LSM: Add the lsmblob data structure.
Date: Thu, 29 Aug 2024 17:33:59 -0700
Message-ID: <20240830003411.16818-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830003411.16818-1-casey@schaufler-ca.com>
References: <20240830003411.16818-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When more than one security module is exporting data to audit and
networking sub-systems a single 32 bit integer is no longer
sufficient to represent the data. Add a structure to be used instead.

The lsmblob structure definition is intended to keep the LSM
specific information private to the individual security modules.
The module specific information is included in a new set of
header files under include/lsm. Each security module is allowed
to define the information included for its use in the lsmblob.
SELinux includes a u32 secid. Smack includes a pointer into its
global label list. The conditional compilation based on feature
inclusion is contained in the include/lsm files.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: apparmor@lists.ubuntu.com
Cc: bpf@vger.kernel.org
Cc: selinux@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 include/linux/lsm/apparmor.h | 17 +++++++++++++++++
 include/linux/lsm/bpf.h      | 16 ++++++++++++++++
 include/linux/lsm/selinux.h  | 16 ++++++++++++++++
 include/linux/lsm/smack.h    | 17 +++++++++++++++++
 include/linux/security.h     | 20 ++++++++++++++++++++
 5 files changed, 86 insertions(+)
 create mode 100644 include/linux/lsm/apparmor.h
 create mode 100644 include/linux/lsm/bpf.h
 create mode 100644 include/linux/lsm/selinux.h
 create mode 100644 include/linux/lsm/smack.h

diff --git a/include/linux/lsm/apparmor.h b/include/linux/lsm/apparmor.h
new file mode 100644
index 000000000000..11521f66d548
--- /dev/null
+++ b/include/linux/lsm/apparmor.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * AppArmor presents single pointer to an aa_label structure.
+ */
+#ifndef __LINUX_LSM_APPARMOR_H
+#define __LINUX_LSM_APPARMOR_H
+
+struct aa_label;
+
+struct lsmblob_apparmor {
+#ifdef CONFIG_SECURITY_APPARMOR
+	struct aa_label *label;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_APPARMOR_H */
diff --git a/include/linux/lsm/bpf.h b/include/linux/lsm/bpf.h
new file mode 100644
index 000000000000..48abdcd82ded
--- /dev/null
+++ b/include/linux/lsm/bpf.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * BPF may present a single u32 value.
+ */
+#ifndef __LINUX_LSM_BPF_H
+#define __LINUX_LSM_BPF_H
+#include <linux/types.h>
+
+struct lsmblob_bpf {
+#ifdef CONFIG_BPF_LSM
+	u32 secid;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_BPF_H */
diff --git a/include/linux/lsm/selinux.h b/include/linux/lsm/selinux.h
new file mode 100644
index 000000000000..fd16456b36ac
--- /dev/null
+++ b/include/linux/lsm/selinux.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * SELinux presents a single u32 value which is known as a secid.
+ */
+#ifndef __LINUX_LSM_SELINUX_H
+#define __LINUX_LSM_SELINUX_H
+#include <linux/types.h>
+
+struct lsmblob_selinux {
+#ifdef CONFIG_SECURITY_SELINUX
+	u32 secid;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_SELINUX_H */
diff --git a/include/linux/lsm/smack.h b/include/linux/lsm/smack.h
new file mode 100644
index 000000000000..2018f288302f
--- /dev/null
+++ b/include/linux/lsm/smack.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module interface to other subsystems.
+ * Smack presents a pointer into the global Smack label list.
+ */
+#ifndef __LINUX_LSM_SMACK_H
+#define __LINUX_LSM_SMACK_H
+
+struct smack_known;
+
+struct lsmblob_smack {
+#ifdef CONFIG_SECURITY_SMACK
+	struct smack_known *skp;
+#endif
+};
+
+#endif /* ! __LINUX_LSM_SMACK_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 1390f1efb4f0..0057a22137e8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -34,6 +34,10 @@
 #include <linux/sockptr.h>
 #include <linux/bpf.h>
 #include <uapi/linux/lsm.h>
+#include <linux/lsm/selinux.h>
+#include <linux/lsm/smack.h>
+#include <linux/lsm/apparmor.h>
+#include <linux/lsm/bpf.h>
 
 struct linux_binprm;
 struct cred;
@@ -140,6 +144,22 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
+/* scaffolding */
+struct lsmblob_scaffold {
+	u32 secid;
+};
+
+/*
+ * Data exported by the security modules
+ */
+struct lsmblob {
+	struct lsmblob_selinux selinux;
+	struct lsmblob_smack smack;
+	struct lsmblob_apparmor apparmor;
+	struct lsmblob_bpf bpf;
+	struct lsmblob_scaffold scaffold;
+};
+
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 extern u32 lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
-- 
2.46.0

