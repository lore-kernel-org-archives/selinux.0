Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3078E6F
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GJ30cUda"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67f848f38c4so5372206d6.3
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197573; x=1703802373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQuSDmWFxcLkod2Im+Of1w3BFGxT9hiMH4ndyJFlnjY=;
        b=GJ30cUdaNoYcBz0Jjkh5kDh7NnMWa7hDTswS2JTUjuJOsh9LPN3U3bR6N2q6IjolKV
         KwaW4nG5MFPCYxLNdhmfJ54UGWaK4g2PXKBN9W8hYnWKWscDFJpIbOZr4xa6iENZyc42
         EJojQEiWnFVKb+XN8MXAHyFKG4pfXVjqIJFH0r+8yNPwCZ45WDxbT5Ua4TQHx+L/YlyR
         ktDdi4bg5grtVgTukkFNIBo0nVgq8bQ/zzHRWAZ+B2oFt4Z4BQaW4SfRgAoAUj/Su8fO
         wY7EN9+Ly2ynJKzZJuoh58jASQqlC6r6ish95q0c8Z4LKIWrVS477Dxwt+wSjFziHJaZ
         3/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197573; x=1703802373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQuSDmWFxcLkod2Im+Of1w3BFGxT9hiMH4ndyJFlnjY=;
        b=VE/xHcC+PoQqcPjG9nra1lh0cOhqf1jXxZ+jDWH8z+HMmT3q1Y9Iv6p2skWJSYaPw0
         o84oWlRUDQ9ckNr1/gqSk9+IyDb7qegSpYc/kIU1wXshxpoxJ4uxwIXjk364PyOIKzVp
         1H8IeK/bELRUdf4ESyxKtm69JpxsS6TqVtIkVeJ1m55Z9b15EduxEA8sRa+s7v4aHhkb
         ZoKqwhTJFro69nny/Y2+RbYWJj50Sdu5QRxKyejBT4Qq/SoEyoSYONtLGrAYqdxPylE2
         jk/2ckxxyOSieokAYJNMmbL2YEYHMAhBArGfMnVGfXF4jdc+4BJxwqj6+V9GAIiLplHK
         QG9g==
X-Gm-Message-State: AOJu0YxIg/QXccfXzRq8iyAS4SXkFHlkGzJf+WgpO0JTyFnrzSPg8+c/
	7vJR05+hcH9wB1JHO302+crm10B/gZNc7sgOxAA7Jgi/Aw==
X-Google-Smtp-Source: AGHT+IEOxhonApYEvLK6mdwKFTnW2IVoV/MjHq/49xmr8EgypVg2HW6tQe1dkoUBnqmlxLx+3wUTsw==
X-Received: by 2002:a05:6214:f05:b0:67f:31aa:284b with SMTP id gw5-20020a0562140f0500b0067f31aa284bmr636317qvb.1.1703197572897;
        Thu, 21 Dec 2023 14:26:12 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id v13-20020a0cf90d000000b0067f19f17629sm921143qvn.82.2023.12.21.14.26.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:12 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 13/15] selinux: fix style issues in security/selinux/include/security.h
Date: Thu, 21 Dec 2023 17:18:56 -0500
Message-ID: <20231221222342.334026-30-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11069; i=paul@paul-moore.com; h=from:subject; bh=ImIhNkB7KITANA3+LXOsw7VHrQfXEJ7bfgD1Ywb4ozk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLtfkL60UA4EEZJcZ9VX8nWhNJn398Od++ncU N5sn+cbZyiJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7XwAKCRDqIPLalzeJ c2YGD/wNmt1mA5sElOoPVXzY4Xi1dFeM6IA1vxmGMsizXiYYoT0STGtSTwGx56wMcS2yzUerd2X 9FByFTVwDUTJ33DI/Vx5t+nwK6zhG+juMp1o9JCaO92BwLZJNmmOhgfjACN6gHSn9pu0MPOhH9p nUHJLWEWhlgnzGVI1cl+10X8ItFeZSckDfAO5whD1ZamTKjFXWcNWrLlAXhrkojTCj73UckyTW7 Th1KzAY/AQjWhRM6AyT0gasIo7Yd+qNVKDsJ10GCYW7+QS8lR/eOwAEBNcfNceOHgIO4emgDDyX +TDRdurXiQTWRLkpVohi2c9tFxKXI7ZzXmOGRRoyE1FIV5UncztFMBg7qWW2PsHuUlDzGxQribA s9Wizy5ptQIYX3vfETdp6b/CCRYhn53LHUpMnkutJMroX+DPJ1FFwpb2XWW4xObnY5oPyIv/rzq xOXN2V5yzE5uOdLcdN+uYbBatH5rr3RLGVprMqvigH/dIGBsLqerMS8xN6Zp3pgtVwjRdCualUn rZVvX0uuoU4PqMvPFvnELGJ+T3Uo4/dM2Al4DBk2uZPBTIaYcBLryIEBbwhG2kyEiYAZt9TWQQo RLIdg/eKD7i2PimraCw7n8BuiBeuaF+vh0RKSvCCs3Z5TAkt6yfH4x0gQHJ1am7CiBMN0pUpnWo tIFSQY28FcRmLGA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/security.h | 155 ++++++++++++++--------------
 1 file changed, 75 insertions(+), 80 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 074d439fe9ad..289bf9233f71 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -21,57 +21,57 @@
 #include "flask.h"
 #include "policycap.h"
 
-#define SECSID_NULL			0x00000000 /* unspecified SID */
-#define SECSID_WILD			0xffffffff /* wildcard SID */
-#define SECCLASS_NULL			0x0000 /* no class */
+#define SECSID_NULL   0x00000000 /* unspecified SID */
+#define SECSID_WILD   0xffffffff /* wildcard SID */
+#define SECCLASS_NULL 0x0000 /* no class */
 
 /* Identify specific policy version changes */
-#define POLICYDB_VERSION_BASE		15
-#define POLICYDB_VERSION_BOOL		16
-#define POLICYDB_VERSION_IPV6		17
-#define POLICYDB_VERSION_NLCLASS	18
-#define POLICYDB_VERSION_VALIDATETRANS	19
-#define POLICYDB_VERSION_MLS		19
-#define POLICYDB_VERSION_AVTAB		20
-#define POLICYDB_VERSION_RANGETRANS	21
-#define POLICYDB_VERSION_POLCAP		22
-#define POLICYDB_VERSION_PERMISSIVE	23
-#define POLICYDB_VERSION_BOUNDARY	24
-#define POLICYDB_VERSION_FILENAME_TRANS	25
-#define POLICYDB_VERSION_ROLETRANS	26
-#define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	27
-#define POLICYDB_VERSION_DEFAULT_TYPE	28
-#define POLICYDB_VERSION_CONSTRAINT_NAMES	29
-#define POLICYDB_VERSION_XPERMS_IOCTL	30
-#define POLICYDB_VERSION_INFINIBAND		31
-#define POLICYDB_VERSION_GLBLUB		32
-#define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitions */
+#define POLICYDB_VERSION_BASE		     15
+#define POLICYDB_VERSION_BOOL		     16
+#define POLICYDB_VERSION_IPV6		     17
+#define POLICYDB_VERSION_NLCLASS	     18
+#define POLICYDB_VERSION_VALIDATETRANS	     19
+#define POLICYDB_VERSION_MLS		     19
+#define POLICYDB_VERSION_AVTAB		     20
+#define POLICYDB_VERSION_RANGETRANS	     21
+#define POLICYDB_VERSION_POLCAP		     22
+#define POLICYDB_VERSION_PERMISSIVE	     23
+#define POLICYDB_VERSION_BOUNDARY	     24
+#define POLICYDB_VERSION_FILENAME_TRANS	     25
+#define POLICYDB_VERSION_ROLETRANS	     26
+#define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS 27
+#define POLICYDB_VERSION_DEFAULT_TYPE	     28
+#define POLICYDB_VERSION_CONSTRAINT_NAMES    29
+#define POLICYDB_VERSION_XPERMS_IOCTL	     30
+#define POLICYDB_VERSION_INFINIBAND	     31
+#define POLICYDB_VERSION_GLBLUB		     32
+#define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename transitions */
 
 /* Range of policy versions we understand*/
-#define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COMP_FTRANS
+#define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
+#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COMP_FTRANS
 
 /* Mask for just the mount related flags */
-#define SE_MNTMASK	0x0f
+#define SE_MNTMASK 0x0f
 /* Super block security struct flags for mount options */
 /* BE CAREFUL, these need to be the low order bits for selinux_get_mnt_opts */
 #define CONTEXT_MNT	0x01
 #define FSCONTEXT_MNT	0x02
-#define ROOTCONTEXT_MNT	0x04
+#define ROOTCONTEXT_MNT 0x04
 #define DEFCONTEXT_MNT	0x08
 #define SBLABEL_MNT	0x10
 /* Non-mount related flags */
-#define SE_SBINITIALIZED	0x0100
-#define SE_SBPROC		0x0200
-#define SE_SBGENFS		0x0400
-#define SE_SBGENFS_XATTR	0x0800
-#define SE_SBNATIVE		0x1000
+#define SE_SBINITIALIZED 0x0100
+#define SE_SBPROC	 0x0200
+#define SE_SBGENFS	 0x0400
+#define SE_SBGENFS_XATTR 0x0800
+#define SE_SBNATIVE	 0x1000
 
 #define CONTEXT_STR	"context"
 #define FSCONTEXT_STR	"fscontext"
-#define ROOTCONTEXT_STR	"rootcontext"
+#define ROOTCONTEXT_STR "rootcontext"
 #define DEFCONTEXT_STR	"defcontext"
-#define SECLABEL_STR "seclabel"
+#define SECLABEL_STR	"seclabel"
 
 struct netlbl_lsm_secattr;
 
@@ -81,11 +81,11 @@ extern int selinux_enabled_boot;
  * type_datum properties
  * available at the kernel policy version >= POLICYDB_VERSION_BOUNDARY
  */
-#define TYPEDATUM_PROPERTY_PRIMARY	0x0001
-#define TYPEDATUM_PROPERTY_ATTRIBUTE	0x0002
+#define TYPEDATUM_PROPERTY_PRIMARY   0x0001
+#define TYPEDATUM_PROPERTY_ATTRIBUTE 0x0002
 
 /* limitation of boundary depth  */
-#define POLICYDB_BOUNDS_MAXDEPTH	4
+#define POLICYDB_BOUNDS_MAXDEPTH 4
 
 struct selinux_policy;
 
@@ -220,12 +220,12 @@ struct av_decision {
 	u32 flags;
 };
 
-#define XPERMS_ALLOWED 1
+#define XPERMS_ALLOWED	  1
 #define XPERMS_AUDITALLOW 2
-#define XPERMS_DONTAUDIT 4
+#define XPERMS_DONTAUDIT  4
 
-#define security_xperm_set(perms, x) ((perms)[(x) >> 5] |= 1 << ((x) & 0x1f))
-#define security_xperm_test(perms, x) (1 & ((perms)[(x) >> 5] >> ((x) & 0x1f)))
+#define security_xperm_set(perms, x)  ((perms)[(x) >> 5] |= 1 << ((x)&0x1f))
+#define security_xperm_test(perms, x) (1 & ((perms)[(x) >> 5] >> ((x)&0x1f)))
 struct extended_perms_data {
 	u32 p[8];
 };
@@ -239,23 +239,22 @@ struct extended_perms_decision {
 };
 
 struct extended_perms {
-	u16 len;	/* length associated decision chain */
+	u16 len; /* length associated decision chain */
 	struct extended_perms_data drivers; /* flag drivers that are used */
 };
 
 /* definitions of av_decision.flags */
-#define AVD_FLAGS_PERMISSIVE	0x0001
+#define AVD_FLAGS_PERMISSIVE 0x0001
 
-void security_compute_av(u32 ssid, u32 tsid,
-			 u16 tclass, struct av_decision *avd,
+void security_compute_av(u32 ssid, u32 tsid, u16 tclass,
+			 struct av_decision *avd,
 			 struct extended_perms *xperms);
 
-void security_compute_xperms_decision(u32 ssid, u32 tsid, u16 tclass,
-				      u8 driver,
+void security_compute_xperms_decision(u32 ssid, u32 tsid, u16 tclass, u8 driver,
 				      struct extended_perms_decision *xpermd);
 
-void security_compute_av_user(u32 ssid, u32 tsid,
-			      u16 tclass, struct av_decision *avd);
+void security_compute_av_user(u32 ssid, u32 tsid, u16 tclass,
+			      struct av_decision *avd);
 
 int security_transition_sid(u32 ssid, u32 tsid, u16 tclass,
 			    const struct qstr *qstr, u32 *out_sid);
@@ -294,8 +293,7 @@ int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid);
 
 int security_netif_sid(char *name, u32 *if_sid);
 
-int security_node_sid(u16 domain, void *addr, u32 addrlen,
-		      u32 *out_sid);
+int security_node_sid(u16 domain, void *addr, u32 addrlen, u32 *out_sid);
 
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 				 u16 tclass);
@@ -307,50 +305,47 @@ int security_bounded_transition(u32 oldsid, u32 newsid);
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
-int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
-				 u32 xfrm_sid,
+int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type, u32 xfrm_sid,
 				 u32 *peer_sid);
 
-int security_get_classes(struct selinux_policy *policy,
-			 char ***classes, u32 *nclasses);
-int security_get_permissions(struct selinux_policy *policy,
-			     const char *class, char ***perms, u32 *nperms);
+int security_get_classes(struct selinux_policy *policy, char ***classes,
+			 u32 *nclasses);
+int security_get_permissions(struct selinux_policy *policy, const char *class,
+			     char ***perms, u32 *nperms);
 int security_get_reject_unknown(void);
 int security_get_allow_unknown(void);
 
-#define SECURITY_FS_USE_XATTR		1 /* use xattr */
-#define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
-#define SECURITY_FS_USE_TASK		3 /* use task SIDs, e.g. pipefs/sockfs */
-#define SECURITY_FS_USE_GENFS		4 /* use the genfs support */
-#define SECURITY_FS_USE_NONE		5 /* no labeling support */
-#define SECURITY_FS_USE_MNTPOINT	6 /* use mountpoint labeling */
-#define SECURITY_FS_USE_NATIVE		7 /* use native label support */
-#define SECURITY_FS_USE_MAX		7 /* Highest SECURITY_FS_USE_XXX */
+#define SECURITY_FS_USE_XATTR	 1 /* use xattr */
+#define SECURITY_FS_USE_TRANS	 2 /* use transition SIDs, e.g. devpts/tmpfs */
+#define SECURITY_FS_USE_TASK	 3 /* use task SIDs, e.g. pipefs/sockfs */
+#define SECURITY_FS_USE_GENFS	 4 /* use the genfs support */
+#define SECURITY_FS_USE_NONE	 5 /* no labeling support */
+#define SECURITY_FS_USE_MNTPOINT 6 /* use mountpoint labeling */
+#define SECURITY_FS_USE_NATIVE	 7 /* use native label support */
+#define SECURITY_FS_USE_MAX	 7 /* Highest SECURITY_FS_USE_XXX */
 
 int security_fs_use(struct super_block *sb);
 
 int security_genfs_sid(const char *fstype, const char *path, u16 sclass,
 		       u32 *sid);
 
-int selinux_policy_genfs_sid(struct selinux_policy *policy,
-		       const char *fstype, const char *path, u16 sclass,
-		       u32 *sid);
+int selinux_policy_genfs_sid(struct selinux_policy *policy, const char *fstype,
+			     const char *path, u16 sclass, u32 *sid);
 
 #ifdef CONFIG_NETLABEL
 int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 				   u32 *sid);
 
-int security_netlbl_sid_to_secattr(u32 sid,
-				   struct netlbl_lsm_secattr *secattr);
+int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr);
 #else
-static inline int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
-					    u32 *sid)
+static inline int
+security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr, u32 *sid)
 {
 	return -EIDRM;
 }
 
-static inline int security_netlbl_sid_to_secattr(u32 sid,
-					 struct netlbl_lsm_secattr *secattr)
+static inline int
+security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 {
 	return -ENOENT;
 }
@@ -363,13 +358,13 @@ const char *security_get_initial_sid_context(u32 sid);
  */
 extern struct page *selinux_kernel_status_page(void);
 
-#define SELINUX_KERNEL_STATUS_VERSION	1
+#define SELINUX_KERNEL_STATUS_VERSION 1
 struct selinux_kernel_status {
-	u32	version;	/* version number of the structure */
-	u32	sequence;	/* sequence number of seqlock logic */
-	u32	enforcing;	/* current setting of enforcing mode */
-	u32	policyload;	/* times of policy reloaded */
-	u32	deny_unknown;	/* current setting of deny_unknown */
+	u32 version; /* version number of the structure */
+	u32 sequence; /* sequence number of seqlock logic */
+	u32 enforcing; /* current setting of enforcing mode */
+	u32 policyload; /* times of policy reloaded */
+	u32 deny_unknown; /* current setting of deny_unknown */
 	/*
 	 * The version > 0 supports above members.
 	 */
-- 
2.43.0

