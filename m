Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8243E06B
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843531; cv=none; b=hM0swp42CYfmT43EpX9M3yKd6htQlzQjsjvk3KIMIQWGfNnU4MurY0pwsAA3WQi0Y4gYLQg/qMS28xZLBOrRQFISNYHT5NYxNYnPvMa0MvqKmDv4CXFE9W4LMmcLByg1fW4oObL6mhqBApCUo0/LGtEL3V7uaYnkYHLPLBphYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843531; c=relaxed/simple;
	bh=CgkliXob0bU6VbUcRPQHmvChR0iaIuYG6nMKVSZpAgE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EnfcFH1EYyyD/wrrYkn058VPeG3OZBB8U9iXS/lwWjWvwx+LIkFFqa3IzrUV8VeOfYFPaFkzwLIX2gYFRtxNs/dv9iPheH5AW0ZzE9RCXx6y/fzLE6H8q6Yc3cUdmlG+2mkY29SJKoRKuPpoNJKDRenZ7oG7cbpAMvMwVrDfhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UrpAPET8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UrpAPET8"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-517dc520840so19318891cf.3
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787843529; x=1788448329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tgUWWkIU0CVtlRV3/6mSZB+EejhAKhSA6KedhPizEe0=;
        b=UrpAPET8sQOTwE/eFO5ZtLr6DCb++pYkN2xmxKn8xcbc5sOl1Rzg7tZuXYf8RHKzou
         F+uRlMJYorExmlw6hsOhCp6TTkWMSrwyr/eiZDY1lroFyZOfaa1XxHZHdzeuWhLE9UgC
         YPvSfOuo81U+6U099igEpP/lq+UqEjDVPDRZT1jRCoDM+5yrUGh8qz0XS62U+gQ95W8s
         ctB6nZxs2PXMZkgYgDq++e+eHwqsqJvP6YciJaRuk5uTKMkzq14b9xMeEFnnrp9lgSQx
         dxa781qqmoc2x9Sf4shBei8ocABdmewgeQ891YVvwtYooXleYuyUhMmAVKUOdvHRxVlQ
         fcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843529; x=1788448329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tgUWWkIU0CVtlRV3/6mSZB+EejhAKhSA6KedhPizEe0=;
        b=Zic8mpRfUZ9Lc6Kua24XJTT7o/zB8EQWWPpKcbX3fqcxGcQdGDqwvgNFY25Scl1ULo
         Apk6c84jy1ANpz7g11F32lcgi1+zPv2MHcvdPiwM2NIp8lb1OuJIc9ECfp8V3sVs+gcN
         Sex1VwWEjb1R6nZpVWB4aRS3EGOJkMXEC1OXg64U5/OVkr79KFZ2rKUMuzF8l7VukxPJ
         XTPPNbx5dwpEE+aI+sPIcK3aeyjw+7Ygv6EaAkaFOGjvcp6tPytpj8uR9iu3/arOcAQL
         7pCemIwVTCNVUKBYXLWkro6SX6QnqKDtxEgpBWKNuu46EzGff2fbjZjMKgjYk/ExzrsI
         WgcA==
X-Gm-Message-State: AFuF++mE/xBja6wYCfhsRzMdEM1gXS55y7dN/Saa+KXsWkwy3Gvso6l2
	HwtoWvTVJx2r9OM+T5egsK4+gPVU3SogV36sOEDgwaREbWnOLGO4KbJi+aoRhFB1t///+Tw0dHd
	r25XK9g==
X-Gm-Gg: AR+sD110qR+XastytAdVVfrM/3/z1ORS2hdXJNiJOLOs7zwMdr9fC2Bte695ieZjaH9
	n6VqB1kuBkDP+MGPEQRcbMa8Dw01uN5vdi9VC2bw8tpBd3D44jH8iKrns7Ews03DyYU6s3KZ1n9
	SLAqxJT/5ZBZMXmxwK550YNCGsC4wmyBjvQvIOKx9zqAjNSsYnpk5FxWDnpIyomznesO+9dWrJw
	cji6kh7jCE4L7SITiLUQuBXj6XOcJjPd4inplk/16PAUtagnZ7lwTQNTi4OCd0o4ECnq8oLAZ+j
	hM5VQSgHLaGfAig3KYS7018MpH+8Ek3d8zyQuM41kraJaKGTk4CD1nj+Tdj20cQMNxYXKXMozbS
	HXVOIy3WyAdT9rkYLmVLswxaUZ7YbtkH8W3UlvWDo56uD51kIdX5YQFEl8lB5Zau5RziHx1LE/5
	mpX+8PD086j0S2aJZb0KhVBDc+8zRP4CHmADMayBxI+VjABRg5tqQHJ5QMxOCQ2CotNzMvHd6OX
	sCoikmBys8DcrmJpfz93q1jJw6wiSOzjw==
X-Received: by 2002:a05:622a:3d4:b0:52d:7b2a:93f with SMTP id d75a77b69052e-52e422d73camr159701261cf.3.1787843528246;
        Thu, 27 Aug 2026 08:12:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e424140ffsm39602561cf.0.2026.08.27.08.12.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:12:07 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: convert selinuxfs inode numbers from unsigned long to u64
Date: Thu, 27 Aug 2026 11:12:04 -0400
Message-ID: <20260827151203.108111-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5116; i=paul@paul-moore.com; h=from:subject; bh=CgkliXob0bU6VbUcRPQHmvChR0iaIuYG6nMKVSZpAgE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqkFPDnnskPAZE775O5kTVRYdKDoLkNC4OdCCjo GZIERiRz1+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCapBTwwAKCRDqIPLalzeJ c6SFEACamI0CHAOcKVc6cBv/giTCvX/2JifJtS2sDkYkXwRI/kkvLqqVj9hHA3r/XpMk9qtAKV1 xfiytwVk4Gv8D28VRrtTOKnnoE5twzJh9tT2Crkz1JYmw/8f4yyO+IQN7iZSgATtrclinxVR9kO l4nSaHxvGu8ioMgmuhHh6y7Zkgztg7bZ07jVmlnJw5mV7IX069gpXY0PFGQp+gNK4NtWQRhrc0G Z38u+f08gRQhdY2Nm7gr4Vv/05jY7r7JqbfUFFMgRrXOwnhyIgEvKpmvVLxksfBW++8vXRiFB18 qOE02PzzTpaG2vS6vRZqRqhi3W01IVc83ewSLKez0EqjekPjeZg7fjVfHyXcjJmvsglDKb5V9Gz cZ+PtZn+yU0ePuPisCpw/rX2NfrJCADyU13fsYF8jSt273rdFjmKNO+g6NQESbIJO9jwCpdkdk/ IHbn8AlhY5LfhnBTrtXa3l4G0oxtHTFrfsNvdngTRzJbbCDfTaUP3dlo12HAgRWxRONIHBLra43 pMcJu0f6k8prjloxJHFXpzUx7od0hdl3/xAd0TWgmbNc8/tdYmW5jO/GeOWT8RjuQhvBUk4PWk7 9P33BgGXoeuiL95yM+YrxPir09b0awBCymQZvMDwFvu52mhJNhXOk5uLi3qnr5FcUi2NT/6tndM oeY92DxOL2D9wbw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Starting with commit 0b2600f81cef ("treewide: change inode->i_ino from
unsigned long to u64") inode numbers were changed from an 'unsigned long'
type to a 'u64' but somehow selinuxfs was lost in the conversion.  This
patch corrects this oversight and converts selinuxfs to 'u64' inode
numbers.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/selinuxfs.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c7d91476971c..292302eb60f3 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -75,8 +75,8 @@ struct selinux_fs_info {
 	char **bool_pending_names;
 	int *bool_pending_values;
 	struct dentry *class_dir;
-	unsigned long last_class_ino;
-	unsigned long last_ino;
+	u64 last_class_ino;
+	u64 last_ino;
 	struct super_block *sb;
 };
 
@@ -304,15 +304,14 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 			  int **bool_pending_values);
 static int sel_make_classes(struct selinux_policy *newpolicy,
 			    struct dentry *class_dir,
-			    unsigned long *last_class_ino);
+			    u64 *last_class_ino);
 
 /* declaration for sel_make_class_dirs */
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
-			unsigned long *ino);
+				   u64 *ino);
 
 /* declaration for sel_make_policy_nodes */
-static struct dentry *sel_make_swapover_dir(struct super_block *sb,
-						unsigned long *ino);
+static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 *ino);
 
 static ssize_t sel_read_mls(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
@@ -467,7 +466,7 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	unsigned int bool_num = 0;
 	char **bool_names = NULL;
 	int *bool_values = NULL;
-	unsigned long tmp_ino = fsi->last_ino; /* Don't increment last_ino in this function */
+	u64 tmp_ino = fsi->last_ino; /* Don't increment last_ino in this function */
 
 	tmp_parent = sel_make_swapover_dir(fsi->sb, &tmp_ino);
 	if (IS_ERR(tmp_parent))
@@ -1568,22 +1567,22 @@ static int sel_make_initcon_files(struct dentry *dir)
 	return err;
 }
 
-static inline unsigned long sel_class_to_ino(u16 class)
+static inline u64 sel_class_to_ino(u16 class)
 {
 	return (class * (SEL_VEC_MAX + 1)) | SEL_CLASS_INO_OFFSET;
 }
 
-static inline u16 sel_ino_to_class(unsigned long ino)
+static inline u16 sel_ino_to_class(u64 ino)
 {
 	return (ino & SEL_INO_MASK) / (SEL_VEC_MAX + 1);
 }
 
-static inline unsigned long sel_perm_to_ino(u16 class, u32 perm)
+static inline u64 sel_perm_to_ino(u16 class, u32 perm)
 {
 	return (class * (SEL_VEC_MAX + 1) + perm) | SEL_CLASS_INO_OFFSET;
 }
 
-static inline u32 sel_ino_to_perm(unsigned long ino)
+static inline u32 sel_ino_to_perm(u64 ino)
 {
 	return (ino & SEL_INO_MASK) % (SEL_VEC_MAX + 1);
 }
@@ -1591,7 +1590,7 @@ static inline u32 sel_ino_to_perm(unsigned long ino)
 static ssize_t sel_read_class(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	unsigned long ino = file_inode(file)->i_ino;
+	u64 ino = file_inode(file)->i_ino;
 	char res[TMPBUFLEN];
 	ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_class(ino));
 	return simple_read_from_buffer(buf, count, ppos, res, len);
@@ -1605,7 +1604,7 @@ static const struct file_operations sel_class_ops = {
 static ssize_t sel_read_perm(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	unsigned long ino = file_inode(file)->i_ino;
+	u64 ino = file_inode(file)->i_ino;
 	char res[TMPBUFLEN];
 	ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_perm(ino));
 	return simple_read_from_buffer(buf, count, ppos, res, len);
@@ -1622,7 +1621,7 @@ static ssize_t sel_read_policycap(struct file *file, char __user *buf,
 	int value;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
-	unsigned long i_ino = file_inode(file)->i_ino;
+	u64 i_ino = file_inode(file)->i_ino;
 
 	value = security_policycap_supported(i_ino & SEL_INO_MASK);
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
@@ -1698,7 +1697,7 @@ static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
 
 static int sel_make_classes(struct selinux_policy *newpolicy,
 			    struct dentry *class_dir,
-			    unsigned long *last_class_ino)
+			    u64 *last_class_ino)
 {
 	u32 i, nclasses;
 	int rc;
@@ -1763,7 +1762,7 @@ static int sel_make_policycap(struct dentry *dir)
 }
 
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
-			unsigned long *ino)
+				   u64 *ino)
 {
 	struct inode *inode;
 
@@ -1792,8 +1791,7 @@ static const struct inode_operations swapover_dir_inode_operations = {
 	.permission	= reject_all,
 };
 
-static struct dentry *sel_make_swapover_dir(struct super_block *sb,
-						unsigned long *ino)
+static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 *ino)
 {
 	struct dentry *dentry;
 	struct inode *inode;
-- 
2.55.0

