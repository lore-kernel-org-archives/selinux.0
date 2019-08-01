Return-Path: <SRS0=gk/B=V5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E6C433FF
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 14:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA79520665
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 14:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="KeAu67n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfHAOnW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:43:22 -0400
Received: from usfb19pa15.eemsg.mail.mil ([214.24.26.86]:24555 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfHAOnW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Aug 2019 10:43:22 -0400
X-EEMSG-check-017: 245058026|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Aug 2019 14:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1564670598; x=1596206598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ebrp0P6Xp73r3LIo97c1dng8ljHVkfn8VYNNQOORwbY=;
  b=KeAu67n5qDHYZFemMgKc3hdPepkEfRk8oQnIXY/G4EUbQKFdLAQiBE3K
   xpB2/QWZYqa6hp2jzhnp58sP4IHgGcBeVHtXH+/LbDzcmOngdYLhf6xly
   kc3j7be98Q9t0Kkw4KWw/qwwNaUCTkjknPG0jqORzsipaj6Dn3fKnnJTD
   nvZsC+Qu+UVdFUMi3BTuc0PJKvY+lD7xVGn43JJp6LISDZFx6SO1/Dlp4
   huyYY+U5w6gmfu4ca8GDx+NLbOQkZehhuQB2qBxQNmnT7dKCoNPBOd0pk
   cT7AiYeXhyZONYSRFaZi46QiGxnYUu7OgfpqwLl8QEijzdW8QgWMysDDr
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="26344762"
IronPort-PHdr: =?us-ascii?q?9a23=3AlE2uExadKWIBK2vJuW8TW/f/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps+9bB7h7PlgxGXEQZ/co6odzbaP6eaxBidfvd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6twHcu8sZjYZgJas61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IOoBa6AAWhAv7kxD1ViX/sxaA00/?=
 =?us-ascii?q?ovHxzI0gIjGNwBv3vaoc7pOKoRS+250LPFwSnfY/5QxDzz6JLIchckofyUQb?=
 =?us-ascii?q?9/a9DRyU4pFwjYj1uQro3lMC6L2eQJrmOW6PBvWv6gi24gqgF+vyagy9wwio?=
 =?us-ascii?q?jJmo0VylfE+T9/wIYuP9K0UkF7Ydm6EJZJsSyRKoh4Qts6Tm11tys3xacKtJ?=
 =?us-ascii?q?6mcCQQ1pgqyADTZ+aaf4WO/xntTvyeIS1ii3JgYL+/ghGy/lW+xeDkTcm01U?=
 =?us-ascii?q?pKrjJCktnRqnABzxzT5daDSvt65kqhxSyA1xrS6uFZOkA4j7bbKp49zb4wkZ?=
 =?us-ascii?q?ofq0LDETPtmErqlqOWc0Qk+uyw5+TmZLXpuIOcOpdphgzxPakigMyyDfkiPg?=
 =?us-ascii?q?QQUGWX5/6w2KD78U38WrpKj/k2kqfDsJDdIMQWvrS2DBNa0oYk6hawEimp3c?=
 =?us-ascii?q?8EnXgHMF1FeBWHg5LvO1HVOv/0F/i/g1OykDtz3fDJIqXhAonRLnjEiLrhZ7?=
 =?us-ascii?q?l95FVHxQop099Q+pJUBasdIP7pRkDxs9nYBAcjMwOo2+bnFMl91oQGVGKKBa?=
 =?us-ascii?q?+ZKr/SsViO5uIqOOSDeI8VuCz6K/gg5v7ukHo5lUUafamz0psdcGq4Eeh+I0?=
 =?us-ascii?q?WFfXrshc8MHnsQsQolUuPriEaPUSVPaHayRa08+z87CIa4AofZX4yinKaO0D?=
 =?us-ascii?q?2nEZ1RY2BMEkqMHmvwd4WYR/cMbzqfIs1mkjwEU7itUY0h1RautADgzbpnNf?=
 =?us-ascii?q?Tb+isDuJ3/ztd14erTlRcz9TNoFcud13uBQH1znmMNXzU2xrxwoVRhylef1q?=
 =?us-ascii?q?h1m+dYGsJJ5/NGTAg3Lp7cwPZ+C9D2WgPBeM2FR0qhQtWjGTsxVM4+w8cSY0?=
 =?us-ascii?q?ZhHNWvlhPD0DS0DL8Oi7OLA5s08qHH0nftJ8Z90XHG1Kwgj1k7R8tDL2qmhr?=
 =?us-ascii?q?Rw9wLLHY7Gj12Zl7q2daQbxCPN9mKDzW2UvEFCUQ5wSr7IXXYFaUvTs9v551?=
 =?us-ascii?q?nOT7i0CbQoKgFB09KNKrNWat31ilVLXPPjOMnCY2K2gGq/HxOIyamQY4XwY2?=
 =?us-ascii?q?Ud3TndB1IAkwwJ+3aJKxQ+DD+7o23CFDxuCU7vY0T0/Ol6qXO7SFI0zg6TY0?=
 =?us-ascii?q?16ybW65gMVheadS/MP3rMIoSIhqzJpE1ag29LZFcGNpxRufKpCe9Mx+lRH2n?=
 =?us-ascii?q?zDtwx7IJOgK7puhlkEcwR4p0nuzQl4Cp1ckcg2q3Mn1BFyJryc0FNAcTOYwJ?=
 =?us-ascii?q?/xN6bJKmn94h+vcbTa2lLA39aM/KcA9vA4p0/kvAGzGUoo629n3MVN03uA+p?=
 =?us-ascii?q?XKCxIfUYrrXUYq8xh3vKnabTMg54PQzHFsNK60sjjY2903Hucq1hGgf9IMeJ?=
 =?us-ascii?q?+DQRf7DskyH8GzLKkvnF+zY1QPO+UB2rQzOpaPfuGB3uaEO+dskTbu2W1M74?=
 =?us-ascii?q?d83k+k6zt3SumO2Y0Mhf6fwF3UBH/HkF69v5Wvysh/bjYIEz/6kHW1CQ=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2DyFACL+UJd/wHyM5BeCB4BBgcGgWeBbiqBPgEyKpNaT?=
 =?us-ascii?q?QEBAQEBAQaCNIhligKFNIFnCQEBAQEBAQEBARsZAQIBAYRAglcjOBMBAwEBA?=
 =?us-ascii?q?QQBAQEBBQEBbIUqgjopAYMUCwFGMBiBCYJjP4F3FK4FM4hrgUiBNIcJhFcXe?=
 =?us-ascii?q?IEHgRGCXXODfyBkhSQEqxQJghyLUIg/DBuYGi2nCSGBWCsIAhgIIQ+DJ4JOF?=
 =?us-ascii?q?449IwMwgQYBAY41AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 01 Aug 2019 14:43:17 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x71EhFox009798;
        Thu, 1 Aug 2019 10:43:15 -0400
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, jmorris@namei.org, sds@tycho.nsa.gov,
        keescook@chromium.org, serge@hallyn.com,
        john.johansen@canonical.com, casey@schaufler-ca.com,
        mortonm@chromium.org, rgb@redhat.com,
        Nicholas Franck <nhfran2@tycho.nsa.gov>,
        Aaron Goidel <acgoide@tycho.nsa.gov>
Subject: [RFC PATCH v2] security,capability: pass object information to security_capable
Date:   Thu,  1 Aug 2019 10:43:13 -0400
Message-Id: <20190801144313.1014-1-acgoide@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Nicholas Franck <nhfran2@tycho.nsa.gov>

At present security_capable does not pass any object information
and therefore can neither audit the particular object nor take it
into account. Augment the security_capable interface to support
passing supplementary data. Use this facility initially to convey
the inode for capability checks relevant to inodes. This only
addresses capable_wrt_inode_uidgid calls; other capability checks
relevant to inodes will be addressed in subsequent changes. In the
future, this will be further extended to pass object information for
other capability checks such as the target task for CAP_KILL.

In SELinux this new information is leveraged here to include the inode
in the audit message. In the future, it could also be used to perform
a per inode capability checks.

It would be possible to fold the existing opts argument into this new
supplementary data structure. This was omitted from this change to
minimize changes.

Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
---
v2:
- Changed order of audit prints so optional information comes second
---
 include/linux/capability.h             |  7 ++++++
 include/linux/lsm_audit.h              |  5 +++-
 include/linux/lsm_hooks.h              |  3 ++-
 include/linux/security.h               | 23 +++++++++++++-----
 kernel/capability.c                    | 33 ++++++++++++++++++--------
 kernel/seccomp.c                       |  2 +-
 security/apparmor/capability.c         |  8 ++++---
 security/apparmor/include/capability.h |  4 +++-
 security/apparmor/ipc.c                |  2 +-
 security/apparmor/lsm.c                |  5 ++--
 security/apparmor/resource.c           |  2 +-
 security/commoncap.c                   | 11 +++++----
 security/lsm_audit.c                   | 21 ++++++++++++++--
 security/safesetid/lsm.c               |  3 ++-
 security/security.c                    |  5 ++--
 security/selinux/hooks.c               | 20 +++++++++-------
 security/smack/smack_access.c          |  2 +-
 17 files changed, 110 insertions(+), 46 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index ecce0f43c73a..f72de64c179d 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -211,6 +211,8 @@ extern bool capable(int cap);
 extern bool ns_capable(struct user_namespace *ns, int cap);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
 extern bool ns_capable_setid(struct user_namespace *ns, int cap);
+extern bool ns_capable_inode(struct user_namespace *ns, int cap,
+			     const struct inode *inode);
 #else
 static inline bool has_capability(struct task_struct *t, int cap)
 {
@@ -246,6 +248,11 @@ static inline bool ns_capable_setid(struct user_namespace *ns, int cap)
 {
 	return true;
 }
+static bool ns_capable_inode(struct user_namespace *ns, int cap,
+			     const struct inode *inode)
+{
+	return true;
+}
 #endif /* CONFIG_MULTIUSER */
 extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode);
 extern bool capable_wrt_inode_uidgid(const struct inode *inode, int cap);
diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 915330abf6e5..15d2a62639f0 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -79,7 +79,10 @@ struct common_audit_data {
 		struct dentry *dentry;
 		struct inode *inode;
 		struct lsm_network_audit *net;
-		int cap;
+		struct  {
+			int cap;
+			struct cap_aux_data *cad;
+		} cap_struct;
 		int ipc_id;
 		struct task_struct *tsk;
 #ifdef CONFIG_KEYS
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ead98af9c602..3270b8af3498 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1472,7 +1472,8 @@ union security_list_options {
 	int (*capable)(const struct cred *cred,
 			struct user_namespace *ns,
 			int cap,
-			unsigned int opts);
+			unsigned int opts,
+			struct cap_aux_data *cad);
 	int (*quotactl)(int cmds, int type, int id, struct super_block *sb);
 	int (*quota_on)(struct dentry *dentry);
 	int (*syslog)(int type);
diff --git a/include/linux/security.h b/include/linux/security.h
index 7d9c1da1f659..a37377065401 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -77,9 +77,18 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+
+struct cap_aux_data {
+	char type;
+#define CAP_AUX_DATA_INODE	1
+	union	{
+		const struct inode *inode;
+	} u;
+};
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
-		       int cap, unsigned int opts);
+		       int cap, unsigned int opts, struct cap_aux_data *cad);
 extern int cap_settime(const struct timespec64 *ts, const struct timezone *tz);
 extern int cap_ptrace_access_check(struct task_struct *child, unsigned int mode);
 extern int cap_ptrace_traceme(struct task_struct *parent);
@@ -215,9 +224,10 @@ int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *inheritable,
 		    const kernel_cap_t *permitted);
 int security_capable(const struct cred *cred,
-		       struct user_namespace *ns,
-		       int cap,
-		       unsigned int opts);
+		     struct user_namespace *ns,
+		     int cap,
+		     unsigned int opts,
+		     struct cap_aux_data *cad);
 int security_quotactl(int cmds, int type, int id, struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
@@ -478,9 +488,10 @@ static inline int security_capset(struct cred *new,
 static inline int security_capable(const struct cred *cred,
 				   struct user_namespace *ns,
 				   int cap,
-				   unsigned int opts)
+				   unsigned int opts,
+				   struct cap_aux_data *cad)
 {
-	return cap_capable(cred, ns, cap, opts);
+	return cap_capable(cred, ns, cap, opts, NULL);
 }
 
 static inline int security_quotactl(int cmds, int type, int id,
diff --git a/kernel/capability.c b/kernel/capability.c
index 1444f3954d75..c3723443904a 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -297,7 +297,7 @@ bool has_ns_capability(struct task_struct *t,
 	int ret;
 
 	rcu_read_lock();
-	ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NONE);
+	ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NONE, NULL);
 	rcu_read_unlock();
 
 	return (ret == 0);
@@ -338,7 +338,7 @@ bool has_ns_capability_noaudit(struct task_struct *t,
 	int ret;
 
 	rcu_read_lock();
-	ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NOAUDIT);
+	ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NOAUDIT, NULL);
 	rcu_read_unlock();
 
 	return (ret == 0);
@@ -363,7 +363,8 @@ bool has_capability_noaudit(struct task_struct *t, int cap)
 
 static bool ns_capable_common(struct user_namespace *ns,
 			      int cap,
-			      unsigned int opts)
+			      unsigned int opts,
+			      struct cap_aux_data *cad)
 {
 	int capable;
 
@@ -372,7 +373,7 @@ static bool ns_capable_common(struct user_namespace *ns,
 		BUG();
 	}
 
-	capable = security_capable(current_cred(), ns, cap, opts);
+	capable = security_capable(current_cred(), ns, cap, opts, cad);
 	if (capable == 0) {
 		current->flags |= PF_SUPERPRIV;
 		return true;
@@ -393,7 +394,7 @@ static bool ns_capable_common(struct user_namespace *ns,
  */
 bool ns_capable(struct user_namespace *ns, int cap)
 {
-	return ns_capable_common(ns, cap, CAP_OPT_NONE);
+	return ns_capable_common(ns, cap, CAP_OPT_NONE, NULL);
 }
 EXPORT_SYMBOL(ns_capable);
 
@@ -411,7 +412,7 @@ EXPORT_SYMBOL(ns_capable);
  */
 bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 {
-	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT);
+	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT, NULL);
 }
 EXPORT_SYMBOL(ns_capable_noaudit);
 
@@ -430,7 +431,7 @@ EXPORT_SYMBOL(ns_capable_noaudit);
  */
 bool ns_capable_setid(struct user_namespace *ns, int cap)
 {
-	return ns_capable_common(ns, cap, CAP_OPT_INSETID);
+	return ns_capable_common(ns, cap, CAP_OPT_INSETID, NULL);
 }
 EXPORT_SYMBOL(ns_capable_setid);
 
@@ -470,7 +471,7 @@ bool file_ns_capable(const struct file *file, struct user_namespace *ns,
 	if (WARN_ON_ONCE(!cap_valid(cap)))
 		return false;
 
-	if (security_capable(file->f_cred, ns, cap, CAP_OPT_NONE) == 0)
+	if (security_capable(file->f_cred, ns, cap, CAP_OPT_NONE, NULL) == 0)
 		return true;
 
 	return false;
@@ -503,7 +504,8 @@ bool capable_wrt_inode_uidgid(const struct inode *inode, int cap)
 {
 	struct user_namespace *ns = current_user_ns();
 
-	return ns_capable(ns, cap) && privileged_wrt_inode_uidgid(ns, inode);
+	return ns_capable_inode(ns, cap, inode) &&
+		privileged_wrt_inode_uidgid(ns, inode);
 }
 EXPORT_SYMBOL(capable_wrt_inode_uidgid);
 
@@ -524,7 +526,18 @@ bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns)
 	cred = rcu_dereference(tsk->ptracer_cred);
 	if (cred)
 		ret = security_capable(cred, ns, CAP_SYS_PTRACE,
-				       CAP_OPT_NOAUDIT);
+				       CAP_OPT_NOAUDIT, NULL);
 	rcu_read_unlock();
 	return (ret == 0);
 }
+
+bool ns_capable_inode(struct user_namespace *ns, int cap,
+			const struct inode *inode)
+{
+	struct cap_aux_data cad;
+
+	cad.type = CAP_AUX_DATA_INODE;
+	cad.u.inode = inode;
+	return ns_capable_common(ns, cap, CAP_OPT_NONE, &cad);
+}
+EXPORT_SYMBOL(ns_capable_inode);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 811b4a86cdf6..d59dd7079ece 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -446,7 +446,7 @@ static struct seccomp_filter *seccomp_prepare_filter(struct sock_fprog *fprog)
 	 */
 	if (!task_no_new_privs(current) &&
 	    security_capable(current_cred(), current_user_ns(),
-				     CAP_SYS_ADMIN, CAP_OPT_NOAUDIT) != 0)
+			     CAP_SYS_ADMIN, CAP_OPT_NOAUDIT, NULL) != 0)
 		return ERR_PTR(-EACCES);
 
 	/* Allocate a new seccomp_filter */
diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index 752f73980e30..c45192a16733 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -50,7 +50,7 @@ static void audit_cb(struct audit_buffer *ab, void *va)
 	struct common_audit_data *sa = va;
 
 	audit_log_format(ab, " capname=");
-	audit_log_untrustedstring(ab, capability_names[sa->u.cap]);
+	audit_log_untrustedstring(ab, capability_names[sa->u.cap_struct.cap]);
 }
 
 /**
@@ -148,13 +148,15 @@ static int profile_capable(struct aa_profile *profile, int cap,
  *
  * Returns: 0 on success, or else an error code.
  */
-int aa_capable(struct aa_label *label, int cap, unsigned int opts)
+int aa_capable(struct aa_label *label, int cap, unsigned int opts,
+	       struct cap_aux_data *cad)
 {
 	struct aa_profile *profile;
 	int error = 0;
 	DEFINE_AUDIT_DATA(sa, LSM_AUDIT_DATA_CAP, OP_CAPABLE);
 
-	sa.u.cap = cap;
+	sa.u.cap_struct.cap = cap;
+	sa.u.cap_struct.cad = cad;
 	error = fn_for_each_confined(label, profile,
 			profile_capable(profile, cap, opts, &sa));
 
diff --git a/security/apparmor/include/capability.h b/security/apparmor/include/capability.h
index 1b3663b6ab12..d888f09d76d1 100644
--- a/security/apparmor/include/capability.h
+++ b/security/apparmor/include/capability.h
@@ -20,6 +20,7 @@
 #include "apparmorfs.h"
 
 struct aa_label;
+struct cap_aux_data;
 
 /* aa_caps - confinement data for capabilities
  * @allowed: capabilities mask
@@ -40,7 +41,8 @@ struct aa_caps {
 
 extern struct aa_sfs_entry aa_sfs_entry_caps[];
 
-int aa_capable(struct aa_label *label, int cap, unsigned int opts);
+int aa_capable(struct aa_label *label, int cap, unsigned int opts,
+	       struct cap_aux_data *cad);
 
 static inline void aa_free_cap_rules(struct aa_caps *caps)
 {
diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
index aacd1e95cb59..deb5267ca695 100644
--- a/security/apparmor/ipc.c
+++ b/security/apparmor/ipc.c
@@ -108,7 +108,7 @@ static int profile_tracer_perm(struct aa_profile *tracer,
 	aad(sa)->peer = tracee;
 	aad(sa)->request = 0;
 	aad(sa)->error = aa_capable(&tracer->label, CAP_SYS_PTRACE,
-				    CAP_OPT_NONE);
+				    CAP_OPT_NONE, NULL);
 
 	return aa_audit(AUDIT_APPARMOR_AUTO, tracer, sa, audit_ptrace_cb);
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 87500bde5a92..82790accb679 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -172,14 +172,15 @@ static int apparmor_capget(struct task_struct *target, kernel_cap_t *effective,
 }
 
 static int apparmor_capable(const struct cred *cred, struct user_namespace *ns,
-			    int cap, unsigned int opts)
+			    int cap, unsigned int opts,
+			    struct cap_aux_data *cad)
 {
 	struct aa_label *label;
 	int error = 0;
 
 	label = aa_get_newest_cred_label(cred);
 	if (!unconfined(label))
-		error = aa_capable(label, cap, opts);
+		error = aa_capable(label, cap, opts, cad);
 	aa_put_label(label);
 
 	return error;
diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index 552ed09cb47e..9b3d4b4437f2 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -124,7 +124,7 @@ int aa_task_setrlimit(struct aa_label *label, struct task_struct *task,
 	 */
 
 	if (label != peer &&
-	    aa_capable(label, CAP_SYS_RESOURCE, CAP_OPT_NOAUDIT) != 0)
+	    aa_capable(label, CAP_SYS_RESOURCE, CAP_OPT_NOAUDIT, NULL) != 0)
 		error = fn_for_each(label, profile,
 				audit_resource(profile, resource,
 					       new_rlim->rlim_max, peer,
diff --git a/security/commoncap.c b/security/commoncap.c
index c477fb673701..1860ea50f473 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -68,7 +68,7 @@ static void warn_setuid_and_fcaps_mixed(const char *fname)
  * kernel's capable() and has_capability() returns 1 for this case.
  */
 int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
-		int cap, unsigned int opts)
+		int cap, unsigned int opts, struct cap_aux_data *cad)
 {
 	struct user_namespace *ns = targ_ns;
 
@@ -226,7 +226,7 @@ static inline int cap_inh_is_capped(void)
 	 * capability
 	 */
 	if (cap_capable(current_cred(), current_cred()->user_ns,
-			CAP_SETPCAP, CAP_OPT_NONE) == 0)
+			CAP_SETPCAP, CAP_OPT_NONE, NULL) == 0)
 		return 0;
 	return 1;
 }
@@ -1211,7 +1211,8 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 		    || (cap_capable(current_cred(),
 				    current_cred()->user_ns,
 				    CAP_SETPCAP,
-				    CAP_OPT_NONE) != 0)			/*[4]*/
+				    CAP_OPT_NONE,
+				    NULL) != 0)				/*[4]*/
 			/*
 			 * [1] no changing of bits that are locked
 			 * [2] no unlocking of locks
@@ -1307,7 +1308,7 @@ int cap_vm_enough_memory(struct mm_struct *mm, long pages)
 	int cap_sys_admin = 0;
 
 	if (cap_capable(current_cred(), &init_user_ns,
-				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT) == 0)
+				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT, NULL) == 0)
 		cap_sys_admin = 1;
 
 	return cap_sys_admin;
@@ -1328,7 +1329,7 @@ int cap_mmap_addr(unsigned long addr)
 
 	if (addr < dac_mmap_min_addr) {
 		ret = cap_capable(current_cred(), &init_user_ns, CAP_SYS_RAWIO,
-				  CAP_OPT_NONE);
+				  CAP_OPT_NONE, NULL);
 		/* set PF_SUPERPRIV if it turns out we allow the low mmap */
 		if (ret == 0)
 			current->flags |= PF_SUPERPRIV;
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 33028c098ef3..18cc7c956b69 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -229,9 +229,26 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	case LSM_AUDIT_DATA_IPC:
 		audit_log_format(ab, " key=%d ", a->u.ipc_id);
 		break;
-	case LSM_AUDIT_DATA_CAP:
-		audit_log_format(ab, " capability=%d ", a->u.cap);
+	case LSM_AUDIT_DATA_CAP: {
+		const struct inode *inode;
+
+		audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
+		if (a->u.cap_struct.cad) {
+			switch (a->u.cap_struct.cad->type) {
+			case CAP_AUX_DATA_INODE: {
+				inode = a->u.cap_struct.cad->u.inode;
+
+				audit_log_format(ab, " dev=");
+				audit_log_untrustedstring(ab,
+					inode->i_sb->s_id);
+				audit_log_format(ab, " ino=%lu",
+					inode->i_ino);
+				break;
+			}
+			}
+		}
 		break;
+	}
 	case LSM_AUDIT_DATA_PATH: {
 		struct inode *inode;
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index cecd38e2ac80..c74ed83e9501 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -80,7 +80,8 @@ static bool check_setuid_policy_hashtable_key_value(kuid_t parent,
 static int safesetid_security_capable(const struct cred *cred,
 				      struct user_namespace *ns,
 				      int cap,
-				      unsigned int opts)
+				      unsigned int opts,
+				      struct cap_aux_data *cad)
 {
 	if (cap == CAP_SETUID &&
 	    check_setuid_policy_hashtable_key(cred->uid)) {
diff --git a/security/security.c b/security/security.c
index 30687e1366b7..e5e0637f43ac 100644
--- a/security/security.c
+++ b/security/security.c
@@ -691,9 +691,10 @@ int security_capset(struct cred *new, const struct cred *old,
 int security_capable(const struct cred *cred,
 		     struct user_namespace *ns,
 		     int cap,
-		     unsigned int opts)
+		     unsigned int opts,
+		     struct cap_aux_data *cad)
 {
-	return call_int_hook(capable, 0, cred, ns, cap, opts);
+	return call_int_hook(capable, 0, cred, ns, cap, opts, cad);
 }
 
 int security_quotactl(int cmds, int type, int id, struct super_block *sb)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a1aaf79421df..1816402a6b8a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1620,7 +1620,10 @@ static inline u32 signal_to_av(int sig)
 
 /* Check whether a task is allowed to use a capability. */
 static int cred_has_capability(const struct cred *cred,
-			       int cap, unsigned int opts, bool initns)
+				int cap,
+				unsigned int opts,
+				bool initns,
+				struct cap_aux_data *cad)
 {
 	struct common_audit_data ad;
 	struct av_decision avd;
@@ -1630,7 +1633,8 @@ static int cred_has_capability(const struct cred *cred,
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_CAP;
-	ad.u.cap = cap;
+	ad.u.cap_struct.cad = cad;
+	ad.u.cap_struct.cap = cap;
 
 	switch (CAP_TO_INDEX(cap)) {
 	case 0:
@@ -2167,9 +2171,9 @@ static int selinux_capset(struct cred *new, const struct cred *old,
  */
 
 static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
-			   int cap, unsigned int opts)
+			   int cap, unsigned int opts, struct cap_aux_data *cad)
 {
-	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
+	return cred_has_capability(cred, cap, opts, ns == &init_user_ns, cad);
 }
 
 static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
@@ -2243,7 +2247,7 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 	int rc, cap_sys_admin = 0;
 
 	rc = cred_has_capability(current_cred(), CAP_SYS_ADMIN,
-				 CAP_OPT_NOAUDIT, true);
+				 CAP_OPT_NOAUDIT, true, NULL);
 	if (rc == 0)
 		cap_sys_admin = 1;
 
@@ -3103,9 +3107,9 @@ static bool has_cap_mac_admin(bool audit)
 	const struct cred *cred = current_cred();
 	unsigned int opts = audit ? CAP_OPT_NONE : CAP_OPT_NOAUDIT;
 
-	if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, opts))
+	if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, opts, NULL))
 		return false;
-	if (cred_has_capability(cred, CAP_MAC_ADMIN, opts, true))
+	if (cred_has_capability(cred, CAP_MAC_ADMIN, opts, true, NULL))
 		return false;
 	return true;
 }
@@ -3609,7 +3613,7 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	case KDSKBENT:
 	case KDSKBSENT:
 		error = cred_has_capability(cred, CAP_SYS_TTY_CONFIG,
-					    CAP_OPT_NONE, true);
+					    CAP_OPT_NONE, true, NULL);
 		break;
 
 	/* default case assumes that the command will go
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index fe2ce3a65822..e961bfe8f00a 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -640,7 +640,7 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
 	struct smack_known_list_elem *sklep;
 	int rc;
 
-	rc = cap_capable(cred, &init_user_ns, cap, CAP_OPT_NONE);
+	rc = cap_capable(cred, &init_user_ns, cap, CAP_OPT_NONE, NULL);
 	if (rc)
 		return false;
 
-- 
2.21.0

