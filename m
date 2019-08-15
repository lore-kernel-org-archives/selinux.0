Return-Path: <SRS0=R+7g=WL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408E0C3A589
	for <selinux@archiver.kernel.org>; Thu, 15 Aug 2019 20:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28462083B
	for <selinux@archiver.kernel.org>; Thu, 15 Aug 2019 20:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="D1RC/i3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfHOUZV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:25:21 -0400
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:5194 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfHOUZV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Aug 2019 16:25:21 -0400
X-EEMSG-check-017: 13687716|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,389,1559520000"; 
   d="scan'208";a="13687716"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Aug 2019 20:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565900700; x=1597436700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BipBCkLOysXzj8OYo5S0qhONqOdwaJ1CdsW7//SmH0Y=;
  b=D1RC/i3j9SaGAfVaE0q938QLPobUkJRhrTF8bJ43kCFRBHIv8yYtYriw
   hdYrFwF+zmkBACjCXfxSu8Kz0mtJgHaeg7TGLcLOimX7JFOBiacUNOas5
   OXLZXAtx2Zn43wIDttSbd41kDpx+t+75qjTI+hAwD4IlL07B9OThNDZHR
   jU1Mg0zvZFiXfdev+RNj3CP8RJI/KNFPWWHwhP/Ng5EMXk3xpiA3tiTkR
   vRJnPB0Pwi6Vz29ovkkCYvEkgtxFvx1knBEcAd2bcm+ltSQU9soGvPDgu
   98qILrqqx5Ry0Q9uemooX8w+gAEU7aO0GC4gtLIlh0Iiem4ox7LnmmJGQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,389,1559520000"; 
   d="scan'208";a="26854008"
IronPort-PHdr: =?us-ascii?q?9a23=3AuPkohBEQqgy3/QZj1Jch051GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pcS/bnLW6fgltlLVR4KTs6sC17OM9fm7ACdZvcrJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQu6oR/MusQYnIduJbs9xx?=
 =?us-ascii?q?TGr3BVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7W/YitZ0jKlGvhyvoRJxyJPQbI2MNPdzeqbRcNUHTm?=
 =?us-ascii?q?RDQ8lRTTRMDIOiYYUSAeQPPuFWoIbyqVYVsRezBhOhCP/1xzNUmnP727Ax3e?=
 =?us-ascii?q?Q7EQHB2QwtB84Dv27OrNXyMqcZTOG7zK7JzTrecfxW3Sr25Y/SfR89rvGMWr?=
 =?us-ascii?q?NwftfPxkQ0CwPEjkmfqYziPz+P0OQNqHKU4/BvVeKolW4qsgd8qSWsyMc0ko?=
 =?us-ascii?q?TFm40Yx1/e+Sh53Yo5P8O0RUFlbdK+DZddsTyROZFsTcM4WW5ovT43yrgBuZ?=
 =?us-ascii?q?GmYicH0I8nxxvDa/yfdIiI/w7jWP6RIThmgHJlf6qyhwqo/ki6y+38S9K03E?=
 =?us-ascii?q?xWritFjtbMtncN2wbV6sebUfty4l2t2TOO1wDX8u1EIEY0mrTHK5M537I9mZ?=
 =?us-ascii?q?UevV7DEyPrgkn6kqCbels+9uS18+jnZ6/ppp6YN496kAH+NaEul9SlDuskPQ?=
 =?us-ascii?q?gOWGmb9vmi27D44U34QKlFjv0xkqXDtpDaPt4UqrS2Aw9SzIYv8wy/ACu+0N?=
 =?us-ascii?q?QEgXkHK0pIeAmZgIjzNFHBPuv1DfeljFSolDdqx/bGMqf9DZXKK3jJiK3hcq?=
 =?us-ascii?q?pl605A1AozyshS55ZVCrEHPfLyVVb9u8bFDhAkMgy03/3qCM9j2YwDWWKAGL?=
 =?us-ascii?q?OZPLnOvl+P4+IlO/OMa5MNuDbhN/gl4ObjjXs4mV8bYKmo0oIbaGumEft6Pk?=
 =?us-ascii?q?WZe3vsgssBEGsTuwo+S/HliECGUTFNfHuyQa086S8hCI68DofMWJqtgLqf0y?=
 =?us-ascii?q?e/BJFWYXpGCl+UG3fya4qEQ+sMaD6VIsJ5ljwESKShS4g62B60sQ/10aZoIf?=
 =?us-ascii?q?DM+i0ZqZLsztx16/fVlR4s6Tx+F96d3H2VT2FogmMIQCc73KJ6oUx60FeDy6?=
 =?us-ascii?q?l4g+dDGNxV/fxJVxk1NZ/Gw+x9EdDyVRrLfs2VR1a+XtWmHTYxQ8oqw9AQZ0?=
 =?us-ascii?q?Z9GtOijg3M3iexHb8VmKKEBIYu/qLfwXfxPcB9xGjC1KU7iFkmWMRPP3W8hq?=
 =?us-ascii?q?Fj7wjTG5LJk0KBmqaocqQc3CjN+H2BzWqJvEFXSghwUb7bUnAZfUbZsc725k?=
 =?us-ascii?q?XFT7+oCLQoLhFOycqYJqRWbd3piE1MRO3/N9TGf2Kxh2CwCA6NxrOLdorqZ2?=
 =?us-ascii?q?Id3CPYCEUfjw8T/WyGNQ87BiegvmLeCSZiFVX1Y0Pj6eN+sm+0TlcozwGWaE?=
 =?us-ascii?q?1sz6C1+hEOivGHUfMcwK8LuCc7pDVoBlqyw9XWC9+YrQp7YKpcec894EtA1W?=
 =?us-ascii?q?/BrwxyJIGgL6R5i14GaQt3okfu2wxyCoVHlsgqtm0lwBBuJqKf1VMSPw+fiI?=
 =?us-ascii?q?j5J7n/MmDv+FWqbKnM1xfV19PF1L0I7aERok/kukmGEUsu/nEvh9Be3Hyd6p?=
 =?us-ascii?q?jiEBsZUZW3VF0+sRd9ueeJMWEG+4rI2Cg0YuGPuTjY1odsWboo?=
X-IPAS-Result: =?us-ascii?q?A2CzEQASv1Vd/wHyM5BdCB0BAQUBBwUBgWeBbiqBPgEyK?=
 =?us-ascii?q?pN4AQEBAQEBBoI0iGyKBIU3gWcJAQEBAQEBAQEBGxkBAgEBhD+DFiM4EwIEA?=
 =?us-ascii?q?QEBBAEBAQMBBgMBAWyFM4I6KYMIDQsBRjAYgQmCYz+BdxSrJDOIb4FJgTSHE?=
 =?us-ascii?q?IRZF3iBB4ERgl1zg38gZIUkBJRBlwwJgh+LYIhHDBuYPi2nPSGBWCsIAhgII?=
 =?us-ascii?q?Q+DJ4JOF44+IwMwgQYBAY4hAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Aug 2019 20:24:09 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7FKO0IM020622;
        Thu, 15 Aug 2019 16:24:02 -0400
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     rgb@redhat.com, mortonm@chromium.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, jmorris@namei.org, luto@amacapital.net,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        nhfran2@tycho.nsa.gov, serge@hallyn.com, sds@tycho.nsa.gov,
        Aaron Goidel <acgoide@tycho.nsa.gov>
Subject: [RFC PATCH v3] security,capability: pass object information to security_capable
Date:   Thu, 15 Aug 2019 16:23:57 -0400
Message-Id: <20190815202357.4238-1-acgoide@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Nicholas Franck <nhfran2@tycho.nsa.gov>

At present security_capable does not pass any object information and
therefore can neither audit the particular object nor take it into
account. Augment the security_capable interface to support passing
supplementary data. Use this facility initially to convey the inode for
capability checks relevant to inodes. This only addresses
capable_wrt_inode_uidgid() calls; other capability checks relevant to
inodes will be addressed in subsequent changes. In the future, this will
be further extended to pass object information for other capability
checks such as the target task for CAP_KILL.

In SELinux this new information is leveraged here to perform an
additional inode based check for capabilities relevant to inodes. Since
the inode provided to capable_wrt_inode_uidgid() is a const argument,
this also required propagating const down to dump_common_audit_data() and
dropping the use of d_find_alias() to find an alias for the inode. This
was sketchy to begin with and should be obsoleted by a separate change
that will allow LSMs to trigger audit collection for all file-related
information.

A new security class is defined for the inode capability permission
checks. This is because the existing file-related classes were already
too close to being full to support the addition of these permissions.
This has the limitation of not supporting per-file-class distinctions
(e.g. distinguishing regular files from directories or special files if
they have the same security label). An alternative would be to
instantiate a separate class for every existing file class, or, to widen
access vectors to 64 bits. Neither seems justified.

It would be possible to fold the existing opts argument into this new
supplementary data structure. This was omitted from this change to
minimize changes.

Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
---
v3:
  - No longer change the audit record for capability checks
  - Introduce an inode-based check in selinux_capable
  - Drop attempts to find dentry when only inode is available
v2:
  - Changed order of audit prints so optional information comes second 
---
 include/linux/capability.h             |  7 +++
 include/linux/lsm_audit.h              |  2 +-
 include/linux/lsm_hooks.h              |  3 +-
 include/linux/security.h               | 23 ++++++---
 kernel/capability.c                    | 33 +++++++++----
 kernel/seccomp.c                       |  2 +-
 security/apparmor/capability.c         |  3 +-
 security/apparmor/include/capability.h |  4 +-
 security/apparmor/ipc.c                |  2 +-
 security/apparmor/lsm.c                |  5 +-
 security/apparmor/resource.c           |  2 +-
 security/commoncap.c                   | 11 +++--
 security/lsm_audit.c                   | 10 +---
 security/safesetid/lsm.c               |  3 +-
 security/security.c                    |  5 +-
 security/selinux/hooks.c               | 66 +++++++++++++++++++++++---
 security/selinux/include/classmap.h    |  3 ++
 security/smack/smack_access.c          |  2 +-
 18 files changed, 136 insertions(+), 50 deletions(-)

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
index 915330abf6e5..dc7d00c7ee67 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -77,7 +77,7 @@ struct common_audit_data {
 	union 	{
 		struct path path;
 		struct dentry *dentry;
-		struct inode *inode;
+		const struct inode *inode;
 		struct lsm_network_audit *net;
 		int cap;
 		int ipc_id;
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
index 752f73980e30..eb4a63fa9888 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -148,7 +148,8 @@ static int profile_capable(struct aa_profile *profile, int cap,
  *
  * Returns: 0 on success, or else an error code.
  */
-int aa_capable(struct aa_label *label, int cap, unsigned int opts)
+int aa_capable(struct aa_label *label, int cap, unsigned int opts,
+	       struct cap_aux_data *cad)
 {
 	struct aa_profile *profile;
 	int error = 0;
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
index 33028c098ef3..67c2d02cd722 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -288,17 +288,9 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		break;
 	}
 	case LSM_AUDIT_DATA_INODE: {
-		struct dentry *dentry;
-		struct inode *inode;
+		const struct inode *inode;
 
 		inode = a->u.inode;
-		dentry = d_find_alias(inode);
-		if (dentry) {
-			audit_log_format(ab, " name=");
-			audit_log_untrustedstring(ab,
-					 dentry->d_name.name);
-			dput(dentry);
-		}
 		audit_log_format(ab, " dev=");
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
 		audit_log_format(ab, " ino=%lu", inode->i_ino);
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
index d55571c585ff..093d17f9d500 100644
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
@@ -1653,6 +1656,55 @@ static int cred_has_capability(const struct cred *cred,
 		if (rc2)
 			return rc2;
 	}
+
+	if (rc)
+		return rc;
+
+	if (cad && cad->type == CAP_AUX_DATA_INODE) {
+		const struct inode *inode = cad->u.inode;
+		struct inode_security_struct *isec = selinux_inode(inode);
+
+		switch (cap) {
+		case CAP_DAC_OVERRIDE:
+			av = INODE_CAP__DAC_OVERRIDE;
+			break;
+		case CAP_CHOWN:
+			av = INODE_CAP__CHOWN;
+			break;
+		case CAP_FSETID:
+			av = INODE_CAP__FSETID;
+			break;
+		case CAP_DAC_READ_SEARCH:
+			av = INODE_CAP__DAC_READ_SEARCH;
+			break;
+		case CAP_FOWNER:
+			av = INODE_CAP__FOWNER;
+			break;
+		case CAP_SETFCAP:
+			av = INODE_CAP__SETFCAP;
+			break;
+		default:
+			pr_err("SELinux: Unknown capability for inode %d\n",
+									cap);
+			return -EINVAL;
+		}
+
+		rc = avc_has_perm_noaudit(&selinux_state, sid, isec->sid,
+				SECCLASS_INODE_CAP, av, 0, &avd);
+		if (!(opts & CAP_OPT_NOAUDIT)) {
+			int rc2;
+
+			ad.type = LSM_AUDIT_DATA_INODE;
+			ad.u.inode = inode;
+			rc2 = avc_audit(&selinux_state, sid, isec->sid,
+					SECCLASS_INODE_CAP, av, &avd,
+					rc, &ad, 0);
+			if (rc2)
+				return rc2;
+		}
+	}
+
+
 	return rc;
 }
 
@@ -2167,9 +2219,9 @@ static int selinux_capset(struct cred *new, const struct cred *old,
  */
 
 static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
-			   int cap, unsigned int opts)
+			   int cap, unsigned int opts, struct cap_aux_data *cad)
 {
-	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
+	return cred_has_capability(cred, cap, opts, ns == &init_user_ns, cad);
 }
 
 static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
@@ -2243,7 +2295,7 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 	int rc, cap_sys_admin = 0;
 
 	rc = cred_has_capability(current_cred(), CAP_SYS_ADMIN,
-				 CAP_OPT_NOAUDIT, true);
+				 CAP_OPT_NOAUDIT, true, NULL);
 	if (rc == 0)
 		cap_sys_admin = 1;
 
@@ -3103,9 +3155,9 @@ static bool has_cap_mac_admin(bool audit)
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
@@ -3609,7 +3661,7 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	case KDSKBENT:
 	case KDSKBSENT:
 		error = cred_has_capability(cred, CAP_SYS_TTY_CONFIG,
-					    CAP_OPT_NONE, true);
+					    CAP_OPT_NONE, true, NULL);
 		break;
 
 	/* default case assumes that the command will go
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 32e9b03be3dd..09b3ac77fe97 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -244,6 +244,9 @@ struct security_class_mapping secclass_map[] = {
 	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "inode_cap",
+	  { "dac_override", "chown", "fsetid", "fowner",
+	    "dac_read_search", "setfcap", NULL } },
 	{ NULL }
   };
 
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

