Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA271E5210;
	Tue, 18 Mar 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286917; cv=none; b=jfBlNVzAJ1kSJxUt2v6XmnN5KvZFohpm+uhVMF4VlSdgGqDkVSnPnu8VK68qBX/ViAHdiA4mq7l3nPrelwUSTk9dYPLTpLFYOhNpWQgglpVPgOfjJ9II9cVc6pxGDgqosK9pSXe/hk4uRcMArZEWZqcEKuzxjiDCeyrg8JnZeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286917; c=relaxed/simple;
	bh=x3MFLKxajThmrsuQ3jKAODZyN1gCOqA9za4QRnq5HhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZduvimvrAKxtP0zqHxz3k3az5u8OCCu1jLK7Qt70E6VP03rggZb74XRfNVPUVqBbdffS+Ihnj9/ODr5Hlxi+tBAFo3g0OHNT0oEymerhU/gK2BojbjFjnxpCsoJ5dKKGq+PtyOEbAtOsnFY3ezCgrQqBK1tKiX/wpwm/imt6gY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=HJEwj33N; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="HJEwj33N"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1742286913;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KgljvI9zTG/ra/bOFf1+lbMP9VvMSOzOYz/eiv2gK5g=;
	b=HJEwj33NMcIFsh8WLbVYS/9Xsj5ogy0U+LAi66Tz1cQdmvtbvbGZufG79pdtmwU91AcPld
	WgO61zHMlfmpuY1OYaOxM0/ObygVrKA2qGac5+raFIENv795eHVMV3qT7qJKF1N9kjVpS1
	rE0D4P3ySLhI7jneriykyv0ykQQknGJ7fRHoIa0plyT1vw+vFPilIl5n/by2G0VxvGBdF8
	aHBcFgVZTGYhIFd6voa9NSofzNMtVk1vdv9Y08q7WhHBeEsRSuCoK4LG5emr1k6TEZX1UI
	xSDHu08TkA6cbtb1Tc2QlhY5SUHXwCT6rCF/lamSa7eemuPZyfY4n1XAoThr9Q==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/6] selinux: add cache stats for network tables
Date: Tue, 18 Mar 2025 09:33:33 +0100
Message-ID: <20250318083422.21489-5-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-1-cgoettsche@seltendoof.de>
References: <20250318083422.21489-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Export utilization statistics for network object labeling related hash
tables, similar to AVC and SID hash tables, to userspace via new
selinuxfs files under /stats/.

Guard this functionality with a new compile time option
SECURITY_SELINUX_NETTABLE_STATS.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/Kconfig           |   8 ++
 security/selinux/ibpkey.c          |  33 +++++++
 security/selinux/include/ibpkey.h  |   5 +
 security/selinux/include/netif.h   |   4 +
 security/selinux/include/netnode.h |   4 +
 security/selinux/include/netport.h |   4 +
 security/selinux/netif.c           |  39 ++++++++
 security/selinux/netnode.c         |  33 +++++++
 security/selinux/netport.c         |  33 +++++++
 security/selinux/selinuxfs.c       | 152 ++++++++++++++++++++++++++++-
 10 files changed, 313 insertions(+), 2 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 61abc1e094a8..cae0c7b2c994 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -46,6 +46,14 @@ config SECURITY_SELINUX_AVC_STATS
 	  /sys/fs/selinux/avc/cache_stats, which may be monitored via
 	  tools such as avcstat.
 
+config SECURITY_SELINUX_NETTABLE_STATS
+	bool "SELinux Network Hashtable Statistics"
+	depends on SECURITY_SELINUX
+	default y
+	help
+	  This option collects network hash table statistics to
+	  /sys/fs/selinux/stats/.
+
 config SECURITY_SELINUX_SIDTAB_HASH_BITS
 	int "SELinux sidtab hashtable size"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 470481cfe0e8..c1ad58297ac4 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -218,6 +218,39 @@ void sel_ib_pkey_flush(void)
 	spin_unlock_irqrestore(&sel_ib_pkey_lock, flags);
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+/**
+ * sel_ib_pkey_get_hash_stats - Dump pkey table statistics
+ * @page: the page sized buffer to write to
+ *
+ * Description:
+ * Make the utilization of the hash table available for userspace for
+ * introspection.
+ *
+ */
+int sel_ib_pkey_get_hash_stats(char *page)
+{
+	unsigned int idx, chain_len, max_chain_len = 0, slots_used = 0, total = 0;
+	unsigned long long chain2_len_sum = 0;
+
+	for (idx = 0; idx < SEL_PKEY_HASH_SIZE; idx++) {
+		chain_len = sel_ib_pkey_hash[idx].size;
+
+		if (chain_len > 0)
+			slots_used++;
+		if (chain_len > max_chain_len)
+			max_chain_len = chain_len;
+		total += chain_len;
+		chain2_len_sum += (unsigned long long)chain_len * chain_len;
+	}
+
+	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
+			 "longest chain: %d\nsum of chain length^2: %llu\n",
+			 total, slots_used, SEL_PKEY_HASH_SIZE, max_chain_len,
+			 chain2_len_sum);
+}
+#endif /* CONFIG_SECURITY_SELINUX_NETTABLE_STATS */
+
 static __init int sel_ib_pkey_init(void)
 {
 	int iter;
diff --git a/security/selinux/include/ibpkey.h b/security/selinux/include/ibpkey.h
index 875b055849e1..2d84877fc8c5 100644
--- a/security/selinux/include/ibpkey.h
+++ b/security/selinux/include/ibpkey.h
@@ -20,6 +20,11 @@
 #ifdef CONFIG_SECURITY_INFINIBAND
 void sel_ib_pkey_flush(void);
 int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid);
+
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+int sel_ib_pkey_get_hash_stats(char *page);
+#endif
+
 #else
 static inline void sel_ib_pkey_flush(void)
 {
diff --git a/security/selinux/include/netif.h b/security/selinux/include/netif.h
index 2838bdc170dd..7246eb3ebc71 100644
--- a/security/selinux/include/netif.h
+++ b/security/selinux/include/netif.h
@@ -21,4 +21,8 @@ void sel_netif_flush(void);
 
 int sel_netif_sid(struct net *ns, int ifindex, u32 *sid);
 
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+int sel_netif_get_hash_stats(char *page);
+#endif
+
 #endif /* _SELINUX_NETIF_H_ */
diff --git a/security/selinux/include/netnode.h b/security/selinux/include/netnode.h
index e4dc904c3585..897c72b4b664 100644
--- a/security/selinux/include/netnode.h
+++ b/security/selinux/include/netnode.h
@@ -23,4 +23,8 @@ void sel_netnode_flush(void);
 
 int sel_netnode_sid(const void *addr, u16 family, u32 *sid);
 
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+int sel_netnode_get_hash_stats(char *page);
+#endif
+
 #endif
diff --git a/security/selinux/include/netport.h b/security/selinux/include/netport.h
index 9096a8289948..1b9744656616 100644
--- a/security/selinux/include/netport.h
+++ b/security/selinux/include/netport.h
@@ -22,4 +22,8 @@ void sel_netport_flush(void);
 
 int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);
 
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+int sel_netport_get_hash_stats(char *page);
+#endif
+
 #endif
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 2ab7fe9e1ea2..f7bdf75f871e 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -250,6 +250,45 @@ void sel_netif_flush(void)
 	spin_unlock_bh(&sel_netif_lock);
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+/**
+ * sel_netif_get_hash_stats - Dump network interface table statistics
+ * @page: the page sized buffer to write to
+ *
+ * Description:
+ * Make the utilization of the hash table available for userspace for
+ * introspection.
+ *
+ */
+int sel_netif_get_hash_stats(char *page)
+{
+	unsigned int idx, chain_len, max_chain_len = 0, slots_used = 0, total = 0;
+	unsigned long long chain2_len_sum = 0;
+	const struct sel_netif *netif;
+
+	rcu_read_lock();
+	for (idx = 0; idx < SEL_NETIF_HASH_SIZE; idx++) {
+		chain_len = 0;
+
+		list_for_each_entry_rcu(netif, &sel_netif_hash[idx], list)
+			chain_len++;
+
+		if (chain_len > 0)
+			slots_used++;
+		if (chain_len > max_chain_len)
+			max_chain_len = chain_len;
+		total += chain_len;
+		chain2_len_sum += (unsigned long long)chain_len * chain_len;
+	}
+	rcu_read_unlock();
+
+	return scnprintf(page, PAGE_SIZE, "entries: %d/%d\nbuckets used: %d/%d\n"
+			 "longest chain: %d\nsum of chain length^2: %llu\n",
+			 total, SEL_NETIF_HASH_MAX, slots_used, SEL_NETIF_HASH_SIZE,
+			 max_chain_len, chain2_len_sum);
+}
+#endif /* CONFIG_SECURITY_SELINUX_NETTABLE_STATS */
+
 static int sel_netif_netdev_notifier_handler(struct notifier_block *this,
 					     unsigned long event, void *ptr)
 {
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 15fdf385062e..0e380ee82eb2 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -290,6 +290,39 @@ void sel_netnode_flush(void)
 	spin_unlock_bh(&sel_netnode_lock);
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+/**
+ * sel_netnode_get_hash_stats - Dump network address table statistics
+ * @page: the page sized buffer to write to
+ *
+ * Description:
+ * Make the utilization of the hash table available for userspace for
+ * introspection.
+ *
+ */
+int sel_netnode_get_hash_stats(char *page)
+{
+	unsigned int idx, chain_len, max_chain_len = 0, slots_used = 0, total = 0;
+	unsigned long long chain2_len_sum = 0;
+
+	for (idx = 0; idx < SEL_NETNODE_HASH_SIZE; idx++) {
+		chain_len = sel_netnode_hash[idx].size;
+
+		if (chain_len > 0)
+			slots_used++;
+		if (chain_len > max_chain_len)
+			max_chain_len = chain_len;
+		total += chain_len;
+		chain2_len_sum += (unsigned long long)chain_len * chain_len;
+	}
+
+	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
+			 "longest chain: %d\nsum of chain length^2: %llu\n",
+			 total, slots_used, SEL_NETNODE_HASH_SIZE, max_chain_len,
+			 chain2_len_sum);
+}
+#endif /* CONFIG_SECURITY_SELINUX_NETTABLE_STATS */
+
 static __init int sel_netnode_init(void)
 {
 	int iter;
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 648c2bce83a7..2a315dcc4344 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -224,6 +224,39 @@ void sel_netport_flush(void)
 	spin_unlock_bh(&sel_netport_lock);
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+/**
+ * sel_netport_get_hash_stats - Dump network port table statistics
+ * @page: the page sized buffer to write to
+ *
+ * Description:
+ * Make the utilization of the hash table available for userspace for
+ * introspection.
+ *
+ */
+int sel_netport_get_hash_stats(char *page)
+{
+	unsigned int idx, chain_len, max_chain_len = 0, slots_used = 0, total = 0;
+	unsigned long long chain2_len_sum = 0;
+
+	for (idx = 0; idx < SEL_NETPORT_HASH_SIZE; idx++) {
+		chain_len = sel_netport_hash[idx].size;
+
+		if (chain_len > 0)
+			slots_used++;
+		if (chain_len > max_chain_len)
+			max_chain_len = chain_len;
+		total += chain_len;
+		chain2_len_sum += (unsigned long long)chain_len * chain_len;
+	}
+
+	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
+			 "longest chain: %d\nsum of chain length^2: %llu\n",
+			 total, slots_used, SEL_NETPORT_HASH_SIZE, max_chain_len,
+			 chain2_len_sum);
+}
+#endif /* CONFIG_SECURITY_SELINUX_NETTABLE_STATS */
+
 static __init int sel_netport_init(void)
 {
 	int iter;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 47480eb2189b..815c509a633b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -42,6 +42,10 @@
 #include "objsec.h"
 #include "conditional.h"
 #include "ima.h"
+#include "ibpkey.h"
+#include "netif.h"
+#include "netnode.h"
+#include "netport.h"
 
 enum sel_inos {
 	SEL_ROOT_INO = 2,
@@ -1619,6 +1623,138 @@ static int sel_make_avc_files(struct dentry *dir)
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+static ssize_t sel_read_netif_stats(struct file *filp, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t length;
+
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	length = sel_netif_get_hash_stats(page);
+	if (length >= 0)
+		length = simple_read_from_buffer(buf, count, ppos, page, length);
+	free_page((unsigned long)page);
+
+	return length;
+}
+
+static const struct file_operations sel_netif_stats_ops = {
+	.read		= sel_read_netif_stats,
+	.llseek		= generic_file_llseek,
+};
+
+static ssize_t sel_read_netnode_stats(struct file *filp, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t length;
+
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	length = sel_netnode_get_hash_stats(page);
+	if (length >= 0)
+		length = simple_read_from_buffer(buf, count, ppos, page, length);
+	free_page((unsigned long)page);
+
+	return length;
+}
+
+static const struct file_operations sel_netnode_stats_ops = {
+	.read		= sel_read_netnode_stats,
+	.llseek		= generic_file_llseek,
+};
+
+static ssize_t sel_read_netport_stats(struct file *filp, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t length;
+
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	length = sel_netport_get_hash_stats(page);
+	if (length >= 0)
+		length = simple_read_from_buffer(buf, count, ppos, page, length);
+	free_page((unsigned long)page);
+
+	return length;
+}
+
+static const struct file_operations sel_netport_stats_ops = {
+	.read		= sel_read_netport_stats,
+	.llseek		= generic_file_llseek,
+};
+
+#ifdef CONFIG_SECURITY_INFINIBAND
+static ssize_t sel_read_ib_pkey_stats(struct file *filp, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	char *page;
+	ssize_t length;
+
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	length = sel_ib_pkey_get_hash_stats(page);
+	if (length >= 0)
+		length = simple_read_from_buffer(buf, count, ppos, page, length);
+	free_page((unsigned long)page);
+
+	return length;
+}
+
+static const struct file_operations sel_ib_pkey_stats_ops = {
+	.read		= sel_read_ib_pkey_stats,
+	.llseek		= generic_file_llseek,
+};
+#endif /* CONFIG_SECURITY_INFINIBAND */
+
+static int sel_make_stats_files(struct dentry *dir)
+{
+	struct super_block *sb = dir->d_sb;
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+	unsigned int i;
+	static const struct tree_descr files[] = {
+		{ "netif_hash_stats", &sel_netif_stats_ops, 0444 },
+		{ "netnode_hash_stats", &sel_netnode_stats_ops, 0444 },
+		{ "netport_hash_stats", &sel_netport_stats_ops, 0444 },
+#ifdef CONFIG_SECURITY_INFINIBAND
+		{ "ibpkey_hash_stats", &sel_ib_pkey_stats_ops, 0444 },
+#endif
+	};
+
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		struct inode *inode;
+		struct dentry *dentry;
+
+		dentry = d_alloc_name(dir, files[i].name);
+		if (!dentry)
+			return -ENOMEM;
+
+		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
+		if (!inode) {
+			dput(dentry);
+			return -ENOMEM;
+		}
+
+		inode->i_fop = files[i].ops;
+		inode->i_ino = ++fsi->last_ino;
+		d_add(dentry, inode);
+	}
+
+	return 0;
+}
+#endif /* CONFIG_SECURITY_SELINUX_NETTABLE_STATS */
+
 static int sel_make_ss_files(struct dentry *dir)
 {
 	struct super_block *sb = dir->d_sb;
@@ -2051,6 +2187,18 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
+#ifdef CONFIG_SECURITY_SELINUX_NETTABLE_STATS
+	dentry = sel_make_dir(sb->s_root, "stats", &fsi->last_ino);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto err;
+	}
+
+	ret = sel_make_stats_files(dentry);
+	if (ret)
+		goto err;
+#endif /* CONFIG_SECURITY_SELINUX_NETTABLE_STATS */
+
 	dentry = sel_make_dir(sb->s_root, "ss", &fsi->last_ino);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
@@ -2094,8 +2242,8 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	return 0;
 err:
-	pr_err("SELinux: %s:  failed while creating inodes\n",
-		__func__);
+	pr_err("SELinux: %s:  failed while creating inodes:  %d\n",
+		__func__, ret);
 
 	selinux_fs_info_free(sb);
 
-- 
2.49.0

