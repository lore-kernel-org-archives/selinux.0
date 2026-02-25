Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89673BFE40
	for <selinux@vger.kernel.org>; Wed, 25 Feb 2026 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047329; cv=none; b=SB1JDHFLwWebFngIfcQb788DUdIeSH5bwdKPcGvB8AqqNjEB2k57H9EZ4MLjbaK+zkixSoILMh+csy8P8CrTghKHHPm7n4FqG7VFJtw14ab4DOEAL+vHmJ5zmnSzNgTSiRmXAjX0FKktjm95mHCFEDPRULRG1M+nqiqBUilHZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047329; c=relaxed/simple;
	bh=Z4Fg7fjgA4jR59lvCAx89NIhEyoK6SenrnlArDkRdXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPyvHMXhJWP1UjtFPgARjeviXD/uvqZI9VvkQwo9zSsShLGhcnaQVzatp10Xaf/7rFayR3wfxJMRV2HZO+RS4veTpM2c5xsGG8jIZVhIHtq49lbeGs9EAoz7x3bih1Bt9Ni7IrBgdlLanFX2ZlsEY/tZ6f0bkEjDmn0+vFfVuWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XwNCzbJB; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XwNCzbJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772047320; bh=Kx3lh50URtTVDmhOk7GDZVYFUsygTADgtUtzLNOgH9I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XwNCzbJBt60W6lzwiqJKfI/qO7ytA8AxF96G1nhXyemU2iQqubCpceAyO/oIDuuMhvuoYFiJmfbOqehuGqcQMtmAY1lk+nrgjiKblqLk7aj8kFfRdH0oMIUDRPivuZ8iTh7Qe4t5lE4Cg/DfvBzXjN7CK81ChOCf/cmtyRXhrZkQgB9xSknZ3tr9wyjR31jK87VoF/4ulClgpTFyXu/DyNsQEPs218EmxBww0ULoDrnIxgzfhBObMQIrRUQBFBTSwAis/lDtNYUfBXWHHsdv4awjVr99JrPhgpsGkcaj2llTkpKe3okZvyhoV5c5hcR7OnD4nTDl4cpp/RwjuwRV9A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772047320; bh=JdkqazoaizM6Vd2IFvPZanpxSEVzkq8VEUpkKhdBh8V=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JlRSU83E9cykGYR370buH6f7iwi/JMyGF1DuVn4CPBG7WuGGYLY3+mGK42WPK48YdJ261kI65hEWHBP3+mapBU96znUDIwtYobeYF9helayf5yHvhetOu2IoeIHdmmeDDtVvuDY+tFKQSlab2mHSevXFTy+kttqVaRFM1mlOobn4sad7XORf8VuJwlbbo3cLNElglSUucjB+fff4AzW7gx4dbzo9KlT6YAy4DSuRT9cdIzwtpFPFqeYDj1JmP6q9JJBeoZ3VD0em193uvthX+6RA7aJVCV/wm9T45EPEWUWTY9X9QvQS903zK9NHV0Y6PGbLRy9qKP4ypdEAcKRRaQ==
X-YMail-OSG: RLgCmfMVM1llhEcOgee41RLvbHrM9Q9tlvaKHFqatZfqmUhgx7F7tFGhY3XBxxK
 bJ9_hMeDO7j4MJRVueZv14EwCOSgEboBUO96UnlraMzZ_hkUdeETh1J4axfoPAc9xe8LoxTNiHDC
 YeZga2wt1ojWLqrnfRXKEIr7qYWqH_7AdvZ5qKZh6oAsHj7woUUAoKiG3M.pQAy51Pge6LyqvGFz
 k8rKl83WcflNNYJyVJ7QRdEB7DONFiWqyOFsFc3Xnm9Z6n38y.8WpaX8CKeKq811vNxUwBk87mCs
 q8jXNrh3QlCYnP1tLmIN92QvAVod2gcjkPuqgo4kKAXMiILmZ2OZuCN1XhQPjTzHY4uuGaokTMhj
 52AWECyCZrSaHUdeHPttmamvxT8szAkxe6rAlR4swA4jtHM4Q5MrsY5gsrv5u25mdTh5syIsd6od
 _UX4u4xl8md5vxKs7cQKpid2qAjxc4_cpMCuL4Sr3.41AOyN4pUkwKJSBg2NhpAOKqgco_36TKLY
 dU0s8Hxb.DyYEIr2yEYeak.Ko3k9RpwUtNjXGHbTO1UxbRRnCr533ZSACO9SDBCCAuP55r8MKlCp
 pFSfWCELanT5bxIzuUb2VLka8ALib3q0RaIT6XF8U63lBMnIGuIRBzkYnfAbAknwN9jqQLtGepZc
 E_Bdu0YexOAIqyiR7mrfG49fY9AnYzENxtgmnF3Dv8oQATHWMmb2OXfFrY5vUdHwR410SLo9hAVT
 Bxzv9Z1FLLhxfNkF2O_fBC_aMEiIFIIkejJH..bBD.aPZaAaiQ3DTs.2HKR6uiHg5BCDpx4lcVSn
 trD6e.HuP4K6e0Ovrcwv7aqMW9oY5QxgbCJLsn4_Oi2M6zT5vCElUOBdba9W0hB7fXzDjLgUf1Tu
 TMcEzEzfu2ae5nBash4pqNW5snEnxkNlQct.qrUyXxPI0xtqKYSKKu2hSCjSviKDpWf_ulgWDHvY
 HN4aQFw.jG9VRmF8KFeOcdrzH3MSHacenYyZdT5WLKcg88XVbmHKq.2JfvQJtGYzk1iGmGfHurof
 ooJLn3hn9kZseYgFXynrgAAQLM9Hdhp9S1ff.wMQ8d_3kaPbayfZzswBWLeIfoMhhkxgciQkWMB8
 gWR7F5GHkKp1Y5DDkhwvI7w6RpN2yvzVwVSTqpXRbZ7enYD9kAbgaaXHv.yhmk9VLN6Vv9VvfYYt
 1BZG4H6vYE2icGRqHolpqhVmQop5_i1YXSoOxpBL7v2ytMuWa9u6z3b6fgzF08MO1nelYAcTZAnI
 s0AUeNlwEkc.LB4OhTeOmePWWOhwyqaBzEuoyOFOfbjc_STjc3FexHcuF1lqfScWOLVNi5C.cbHM
 iegtR6RViRlbbO8NTvwiLB5bwr0IdZIO1XvDV_b8_7opjAeCdaYJ68.OQoNry4Zs3oI6B3rzR9lu
 .s6vrS3anONpobc47hc8rxewwFmj5VysSoltgQ3nVa9GF7McHmip1OJRt4YK17Buf93DVZa_Gj3o
 QEWK3BGf5Ws3FIFsxy_1jLav3C9q46DjiMnhADLf4fMB7syKp60b0.oowLN9yvVGhzjWtbxc8pSG
 rlFw0HwBBsap9fIrqSjLoaYuf7b_EIIhYyJk9819J5Ct6KlgufMKahYayKsnlqglrQzlCYvyXT_T
 ij0TwPjDZo97GpIG9HGYZ1Mto3SI82HNREcLeSDqU8esAIslPMAlkL7ozu5RQmtHFJw5C65H7m_l
 hNOs5Ipt2rocCrmH8B6kZFeP5DzvddAUoo.ZCAQDcvoUK63C67Z9W83G5ea2bEzMT4CreNJOBh78
 Uh4YKWXYzN1fsF1MhjTsgKTY_MCRTGzDuPRH2y_F2Q7d0LZUvRiz4tlr87jYUfeCBE0Z41jW3uRi
 VSBlIBAp.0TaPs1ptcv35.96U0KXv4BrCRa7moEZiAzTb_UlBe_zeJfgCw9qfsUwTeH1hzzc0plw
 rL09PLROddRKIfCL_msI77rhScXz9.9CXZxAUvZUR673OFa9Ocy0C1YmIKFCo__bSJkzlMawmdCz
 __OD94J50MOCMRY_CUKFKrQh.u9asjWWmHM1WA8W4Ae9RMv.OeGoj9svOSsWsnXSHtzR5OZuJGCK
 lQaKxhVnDmbS2Mtkq5sfZR_Ira0WCBqYTxNRO5nKT.DbJkvlk.CjqTjHq11LVd5Y6cHhz8kj7Xwb
 885v8Q4yHjzVU4rbU6DT8Nr3I6N1EcKPU0BD1YX9Lj9sBSp6UcrW0GRjp33AtkKPXkVRgUBWyndc
 CqfJxI7l05FSnSEV4x466O224TWrEKPiyeAwoy3.zU6u.Ww_KPp4Q5Rz8dGb8sv6p0eeYlaBki41
 zfXBagfsoZVtmPlzIgSzmiw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f020e702-9882-4f19-893c-4f81fd581431
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Feb 2026 19:22:00 +0000
Received: by hermes--production-gq1-6dfcf9f8b-5skm9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 34de27226d18fbed2fa1781e81910440;
          Wed, 25 Feb 2026 19:21:57 +0000 (UTC)
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
	selinux@vger.kernel.org
Subject: [RFC PATCH 1/3] LSM: add a flags field to the LSM hook definitions
Date: Wed, 25 Feb 2026 11:21:41 -0800
Message-ID: <20260225192143.14448-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225192143.14448-1-casey@schaufler-ca.com>
References: <20260225192143.14448-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a field for flags to the definition of LSM hooks.  This allows
for hooks to be identified at system initialization for special
processing.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/bpf_lsm.h       |   2 +-
 include/linux/lsm_hook_defs.h | 614 ++++++++++++++++++----------------
 include/linux/lsm_hooks.h     |   4 +-
 kernel/bpf/bpf_lsm.c          |  10 +-
 security/bpf/hooks.c          |   2 +-
 security/security.c           |   6 +-
 6 files changed, 331 insertions(+), 307 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 643809cc78c3..d71ba8c87e79 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -14,7 +14,7 @@
 
 #ifdef CONFIG_BPF_LSM
 
-#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..acda3a02da97 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -18,451 +18,475 @@
  * The macro LSM_HOOK is used to define the data structures required by
  * the LSM framework using the pattern:
  *
- *	LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
+ *	LSM_HOOK(<return_type>, <default_value>, <flags>, <single>,
+ *		 <hook_name>, args...)
  *
  * struct security_hook_heads {
- *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
+ *   #define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) struct hlist_head NAME;
  *   #include <linux/lsm_hook_defs.h>
  *   #undef LSM_HOOK
  * };
  */
-LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
-LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
+LSM_HOOK(int, 0, 0, binder_set_context_mgr, const struct cred *mgr)
+LSM_HOOK(int, 0, 0, binder_transaction, const struct cred *from,
 	 const struct cred *to)
-LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
+LSM_HOOK(int, 0, 0, binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
-LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
+LSM_HOOK(int, 0, 0, binder_transfer_file, const struct cred *from,
 	 const struct cred *to, const struct file *file)
-LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
+LSM_HOOK(int, 0, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
-LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
-LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
-	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
-LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
+LSM_HOOK(int, 0, 0, ptrace_traceme, struct task_struct *parent)
+LSM_HOOK(int, 0, 0, capget, const struct task_struct *target,
+	 kernel_cap_t *effective, kernel_cap_t *inheritable,
+	 kernel_cap_t *permitted)
+LSM_HOOK(int, 0, 0, capset, struct cred *new, const struct cred *old,
 	 const kernel_cap_t *effective, const kernel_cap_t *inheritable,
 	 const kernel_cap_t *permitted)
-LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
-	 int cap, unsigned int opts)
-LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
-LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
-LSM_HOOK(int, 0, syslog, int type)
-LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
+LSM_HOOK(int, 0, 0, capable, const struct cred *cred,
+	 struct user_namespace *ns, int cap, unsigned int opts)
+LSM_HOOK(int, 0, 0, quotactl, int cmds, int type, int id,
+	 const struct super_block *sb)
+LSM_HOOK(int, 0, 0, quota_on, struct dentry *dentry)
+LSM_HOOK(int, 0, 0, syslog, int type)
+LSM_HOOK(int, 0, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
-LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
-LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
-LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
-LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
-LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
-LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
-LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
+LSM_HOOK(int, 0, 0, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 0, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
+LSM_HOOK(int, 0, 0, bprm_creds_from_file, struct linux_binprm *bprm,
+	 const struct file *file)
+LSM_HOOK(int, 0, 0, bprm_check_security, struct linux_binprm *bprm)
+LSM_HOOK(void, LSM_RET_VOID, 0, bprm_committing_creds,
+	 const struct linux_binprm *bprm)
+LSM_HOOK(void, LSM_RET_VOID, 0, bprm_committed_creds,
+	 const struct linux_binprm *bprm)
+LSM_HOOK(int, 0, 0, fs_context_submount, struct fs_context *fc,
+	 struct super_block *reference)
+LSM_HOOK(int, 0, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
-LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
+LSM_HOOK(int, -ENOPARAM, 0, fs_context_parse_param, struct fs_context *fc,
 	 struct fs_parameter *param)
-LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
-LSM_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
-LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
-LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
-LSM_HOOK(int, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
-LSM_HOOK(int, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
-LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
-LSM_HOOK(int, 0, sb_kern_mount, const struct super_block *sb)
-LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
-LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
-LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
+LSM_HOOK(int, 0, 0, sb_alloc_security, struct super_block *sb)
+LSM_HOOK(void, LSM_RET_VOID, 0, sb_delete, struct super_block *sb)
+LSM_HOOK(void, LSM_RET_VOID, 0, sb_free_security, struct super_block *sb)
+LSM_HOOK(void, LSM_RET_VOID, 0, sb_free_mnt_opts, void *mnt_opts)
+LSM_HOOK(int, 0, 0, sb_eat_lsm_opts, char *orig, void **mnt_opts)
+LSM_HOOK(int, 0, 0, sb_mnt_opts_compat, struct super_block *sb, void *mnt_opts)
+LSM_HOOK(int, 0, 0, sb_remount, struct super_block *sb, void *mnt_opts)
+LSM_HOOK(int, 0, 0, sb_kern_mount, const struct super_block *sb)
+LSM_HOOK(int, 0, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
+LSM_HOOK(int, 0, 0, sb_statfs, struct dentry *dentry)
+LSM_HOOK(int, 0, 0, sb_mount, const char *dev_name, const struct path *path,
 	 const char *type, unsigned long flags, void *data)
-LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
-LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
+LSM_HOOK(int, 0, 0, sb_umount, struct vfsmount *mnt, int flags)
+LSM_HOOK(int, 0, 0, sb_pivotroot, const struct path *old_path,
 	 const struct path *new_path)
-LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
+LSM_HOOK(int, 0, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
 	 unsigned long kern_flags, unsigned long *set_kern_flags)
-LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
+LSM_HOOK(int, 0, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
 	 struct super_block *newsb, unsigned long kern_flags,
 	 unsigned long *set_kern_flags)
-LSM_HOOK(int, 0, move_mount, const struct path *from_path,
+LSM_HOOK(int, 0, 0, move_mount, const struct path *from_path,
 	 const struct path *to_path)
-LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
+LSM_HOOK(int, -EOPNOTSUPP, 0, dentry_init_security, struct dentry *dentry,
 	 int mode, const struct qstr *name, const char **xattr_name,
 	 struct lsm_context *cp)
-LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
+LSM_HOOK(int, 0, 0, dentry_create_files_as, struct dentry *dentry, int mode,
 	 const struct qstr *name, const struct cred *old, struct cred *new)
 
 #ifdef CONFIG_SECURITY_PATH
-LSM_HOOK(int, 0, path_unlink, const struct path *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
+LSM_HOOK(int, 0, 0, path_unlink, const struct path *dir, struct dentry *dentry)
+LSM_HOOK(int, 0, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
 	 umode_t mode)
-LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
+LSM_HOOK(int, 0, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
+LSM_HOOK(int, 0, 0, path_mknod, const struct path *dir, struct dentry *dentry,
 	 umode_t mode, unsigned int dev)
-LSM_HOOK(void, LSM_RET_VOID, path_post_mknod, struct mnt_idmap *idmap,
+LSM_HOOK(void, LSM_RET_VOID, 0, path_post_mknod, struct mnt_idmap *idmap,
 	 struct dentry *dentry)
-LSM_HOOK(int, 0, path_truncate, const struct path *path)
-LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
-	 const char *old_name)
-LSM_HOOK(int, 0, path_link, struct dentry *old_dentry,
+LSM_HOOK(int, 0, 0, path_truncate, const struct path *path)
+LSM_HOOK(int, 0, 0, path_symlink, const struct path *dir,
+	 struct dentry *dentry, const char *old_name)
+LSM_HOOK(int, 0, 0, path_link, struct dentry *old_dentry,
 	 const struct path *new_dir, struct dentry *new_dentry)
-LSM_HOOK(int, 0, path_rename, const struct path *old_dir,
+LSM_HOOK(int, 0, 0, path_rename, const struct path *old_dir,
 	 struct dentry *old_dentry, const struct path *new_dir,
 	 struct dentry *new_dentry, unsigned int flags)
-LSM_HOOK(int, 0, path_chmod, const struct path *path, umode_t mode)
-LSM_HOOK(int, 0, path_chown, const struct path *path, kuid_t uid, kgid_t gid)
-LSM_HOOK(int, 0, path_chroot, const struct path *path)
+LSM_HOOK(int, 0, 0, path_chmod, const struct path *path, umode_t mode)
+LSM_HOOK(int, 0, 0, path_chown, const struct path *path, kuid_t uid, kgid_t gid)
+LSM_HOOK(int, 0, 0, path_chroot, const struct path *path)
 #endif /* CONFIG_SECURITY_PATH */
 
 /* Needed for inode based security check */
-LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
+LSM_HOOK(int, 0, 0, path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
-LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
-LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
-LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_security)
-LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
+LSM_HOOK(int, 0, 0, inode_alloc_security, struct inode *inode)
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_free_security, struct inode *inode)
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_free_security_rcu, void *inode_security)
+LSM_HOOK(int, -EOPNOTSUPP, 0, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
 	 int *xattr_count)
-LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
+LSM_HOOK(int, 0, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
-LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
+LSM_HOOK(int, 0, 0, inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
-LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
-	 struct inode *inode)
-LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_post_create_tmpfile,
+	 struct mnt_idmap *idmap, struct inode *inode)
+LSM_HOOK(int, 0, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
 	 struct dentry *new_dentry)
-LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_symlink, struct inode *dir, struct dentry *dentry,
+LSM_HOOK(int, 0, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
+LSM_HOOK(int, 0, 0, inode_symlink, struct inode *dir, struct dentry *dentry,
 	 const char *old_name)
-LSM_HOOK(int, 0, inode_mkdir, struct inode *dir, struct dentry *dentry,
+LSM_HOOK(int, 0, 0, inode_mkdir, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
-LSM_HOOK(int, 0, inode_rmdir, struct inode *dir, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_mknod, struct inode *dir, struct dentry *dentry,
+LSM_HOOK(int, 0, 0, inode_rmdir, struct inode *dir, struct dentry *dentry)
+LSM_HOOK(int, 0, 0, inode_mknod, struct inode *dir, struct dentry *dentry,
 	 umode_t mode, dev_t dev)
-LSM_HOOK(int, 0, inode_rename, struct inode *old_dir, struct dentry *old_dentry,
-	 struct inode *new_dir, struct dentry *new_dentry)
-LSM_HOOK(int, 0, inode_readlink, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
-	 bool rcu)
-LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
-LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
-	 struct iattr *attr)
-LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
+LSM_HOOK(int, 0, 0, inode_rename, struct inode *old_dir,
+	 struct dentry *old_dentry, struct inode *new_dir,
+	 struct dentry *new_dentry)
+LSM_HOOK(int, 0, 0, inode_readlink, struct dentry *dentry)
+LSM_HOOK(int, 0, 0, inode_follow_link, struct dentry *dentry,
+	 struct inode *inode, bool rcu)
+LSM_HOOK(int, 0, 0, inode_permission, struct inode *inode, int mask)
+LSM_HOOK(int, 0, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *attr)
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_post_setattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, int ia_valid)
-LSM_HOOK(int, 0, inode_getattr, const struct path *path)
-LSM_HOOK(int, 0, inode_xattr_skipcap, const char *name)
-LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
+LSM_HOOK(int, 0, 0, inode_getattr, const struct path *path)
+LSM_HOOK(int, 0, 0, inode_xattr_skipcap, const char *name)
+LSM_HOOK(int, 0, 0, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
 	 size_t size, int flags)
-LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_post_setxattr, struct dentry *dentry,
 	 const char *name, const void *value, size_t size, int flags)
-LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
-LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
+LSM_HOOK(int, 0, 0, inode_getxattr, struct dentry *dentry, const char *name)
+LSM_HOOK(int, 0, 0, inode_listxattr, struct dentry *dentry)
+LSM_HOOK(int, 0, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
-LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
-LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct file_kattr *fa)
-LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct file_kattr *fa)
-LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
+LSM_HOOK(int, 0, 0, inode_file_setattr, struct dentry *dentry,
+	 struct file_kattr *fa)
+LSM_HOOK(int, 0, 0, inode_file_getattr, struct dentry *dentry,
+	 struct file_kattr *fa)
+LSM_HOOK(int, 0, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
-LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_post_set_acl, struct dentry *dentry,
 	 const char *acl_name, struct posix_acl *kacl)
-LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
+LSM_HOOK(int, 0, 0, inode_get_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
-LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
+LSM_HOOK(int, 0, 0, inode_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
-LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idmap,
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_post_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
-LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
+LSM_HOOK(int, 0, 0, inode_need_killpriv, struct dentry *dentry)
+LSM_HOOK(int, 0, 0, inode_killpriv, struct mnt_idmap *idmap,
 	 struct dentry *dentry)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
+LSM_HOOK(int, -EOPNOTSUPP, 0, inode_getsecurity, struct mnt_idmap *idmap,
 	 struct inode *inode, const char *name, void **buffer, bool alloc)
-LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
+LSM_HOOK(int, -EOPNOTSUPP, 0, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
-LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
+LSM_HOOK(int, 0, 0, inode_listsecurity, struct inode *inode, char *buffer,
 	 size_t buffer_size)
-LSM_HOOK(void, LSM_RET_VOID, inode_getlsmprop, struct inode *inode,
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_getlsmprop, struct inode *inode,
 	 struct lsm_prop *prop)
-LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
-LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, struct dentry *src,
+LSM_HOOK(int, 0, 0, inode_copy_up, struct dentry *src, struct cred **new)
+LSM_HOOK(int, -EOPNOTSUPP, 0, inode_copy_up_xattr, struct dentry *src,
 	 const char *name)
-LSM_HOOK(int, 0, inode_setintegrity, const struct inode *inode,
+LSM_HOOK(int, 0, 0, inode_setintegrity, const struct inode *inode,
 	 enum lsm_integrity_type type, const void *value, size_t size)
-LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
+LSM_HOOK(int, 0, 0, kernfs_init_security, struct kernfs_node *kn_dir,
 	 struct kernfs_node *kn)
-LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
-LSM_HOOK(int, 0, file_alloc_security, struct file *file)
-LSM_HOOK(void, LSM_RET_VOID, file_release, struct file *file)
-LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
-LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
+LSM_HOOK(int, 0, 0, file_permission, struct file *file, int mask)
+LSM_HOOK(int, 0, 0, file_alloc_security, struct file *file)
+LSM_HOOK(void, LSM_RET_VOID, 0, file_release, struct file *file)
+LSM_HOOK(void, LSM_RET_VOID, 0, file_free_security, struct file *file)
+LSM_HOOK(int, 0, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
-LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
+LSM_HOOK(int, 0, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
 	 unsigned long arg)
-LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
-LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
+LSM_HOOK(int, 0, 0, mmap_addr, unsigned long addr)
+LSM_HOOK(int, 0, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
-LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
+LSM_HOOK(int, 0, 0, file_mprotect, struct vm_area_struct *vma,
 	 unsigned long reqprot, unsigned long prot)
-LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
-LSM_HOOK(int, 0, file_fcntl, struct file *file, unsigned int cmd,
+LSM_HOOK(int, 0, 0, file_lock, struct file *file, unsigned int cmd)
+LSM_HOOK(int, 0, 0, file_fcntl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
-LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)
-LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
+LSM_HOOK(void, LSM_RET_VOID, 0, file_set_fowner, struct file *file)
+LSM_HOOK(int, 0, 0, file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
-LSM_HOOK(int, 0, file_receive, struct file *file)
-LSM_HOOK(int, 0, file_open, struct file *file)
-LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
-LSM_HOOK(int, 0, file_truncate, struct file *file)
-LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
-	 u64 clone_flags)
-LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
-LSM_HOOK(int, 0, cred_alloc_blank, struct cred *cred, gfp_t gfp)
-LSM_HOOK(void, LSM_RET_VOID, cred_free, struct cred *cred)
-LSM_HOOK(int, 0, cred_prepare, struct cred *new, const struct cred *old,
+LSM_HOOK(int, 0, 0, file_receive, struct file *file)
+LSM_HOOK(int, 0, 0, file_open, struct file *file)
+LSM_HOOK(int, 0, 0, file_post_open, struct file *file, int mask)
+LSM_HOOK(int, 0, 0, file_truncate, struct file *file)
+LSM_HOOK(int, 0, 0, task_alloc, struct task_struct *task, u64 clone_flags)
+LSM_HOOK(void, LSM_RET_VOID, 0, task_free, struct task_struct *task)
+LSM_HOOK(int, 0, 0, cred_alloc_blank, struct cred *cred, gfp_t gfp)
+LSM_HOOK(void, LSM_RET_VOID, 0, cred_free, struct cred *cred)
+LSM_HOOK(int, 0, 0, cred_prepare, struct cred *new, const struct cred *old,
 	 gfp_t gfp)
-LSM_HOOK(void, LSM_RET_VOID, cred_transfer, struct cred *new,
+LSM_HOOK(void, LSM_RET_VOID, 0, cred_transfer, struct cred *new,
 	 const struct cred *old)
-LSM_HOOK(void, LSM_RET_VOID, cred_getsecid, const struct cred *c, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, cred_getlsmprop, const struct cred *c,
+LSM_HOOK(void, LSM_RET_VOID, 0, cred_getsecid, const struct cred *c, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, 0, cred_getlsmprop, const struct cred *c,
 	 struct lsm_prop *prop)
-LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
-LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
-LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
-LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
-LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
+LSM_HOOK(int, 0, 0, kernel_act_as, struct cred *new, u32 secid)
+LSM_HOOK(int, 0, 0, kernel_create_files_as, struct cred *new,
+	 struct inode *inode)
+LSM_HOOK(int, 0, 0, kernel_module_request, char *kmod_name)
+LSM_HOOK(int, 0, 0, kernel_load_data, enum kernel_load_data_id id,
+	 bool contents)
+LSM_HOOK(int, 0, 0, kernel_post_load_data, char *buf, loff_t size,
 	 enum kernel_load_data_id id, char *description)
-LSM_HOOK(int, 0, kernel_read_file, struct file *file,
+LSM_HOOK(int, 0, 0, kernel_read_file, struct file *file,
 	 enum kernel_read_file_id id, bool contents)
-LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
+LSM_HOOK(int, 0, 0, kernel_post_read_file, struct file *file, char *buf,
 	 loff_t size, enum kernel_read_file_id id)
-LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
+LSM_HOOK(int, 0, 0, task_fix_setuid, struct cred *new, const struct cred *old,
 	 int flags)
-LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
+LSM_HOOK(int, 0, 0, task_fix_setgid, struct cred *new, const struct cred *old,
 	 int flags)
-LSM_HOOK(int, 0, task_fix_setgroups, struct cred *new, const struct cred * old)
-LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
-LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
-LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
-LSM_HOOK(void, LSM_RET_VOID, current_getlsmprop_subj, struct lsm_prop *prop)
-LSM_HOOK(void, LSM_RET_VOID, task_getlsmprop_obj,
-	 struct task_struct *p, struct lsm_prop *prop)
-LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
-LSM_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
-LSM_HOOK(int, 0, task_getioprio, struct task_struct *p)
-LSM_HOOK(int, 0, task_prlimit, const struct cred *cred,
+LSM_HOOK(int, 0, 0, task_fix_setgroups, struct cred *new,
+	 const struct cred *old)
+LSM_HOOK(int, 0, 0, task_setpgid, struct task_struct *p, pid_t pgid)
+LSM_HOOK(int, 0, 0, task_getpgid, struct task_struct *p)
+LSM_HOOK(int, 0, 0, task_getsid, struct task_struct *p)
+LSM_HOOK(void, LSM_RET_VOID, 0, current_getlsmprop_subj, struct lsm_prop *prop)
+LSM_HOOK(void, LSM_RET_VOID, 0, task_getlsmprop_obj, struct task_struct *p,
+	 struct lsm_prop *prop)
+LSM_HOOK(int, 0, 0, task_setnice, struct task_struct *p, int nice)
+LSM_HOOK(int, 0, 0, task_setioprio, struct task_struct *p, int ioprio)
+LSM_HOOK(int, 0, 0, task_getioprio, struct task_struct *p)
+LSM_HOOK(int, 0, 0, task_prlimit, const struct cred *cred,
 	 const struct cred *tcred, unsigned int flags)
-LSM_HOOK(int, 0, task_setrlimit, struct task_struct *p, unsigned int resource,
-	 struct rlimit *new_rlim)
-LSM_HOOK(int, 0, task_setscheduler, struct task_struct *p)
-LSM_HOOK(int, 0, task_getscheduler, struct task_struct *p)
-LSM_HOOK(int, 0, task_movememory, struct task_struct *p)
-LSM_HOOK(int, 0, task_kill, struct task_struct *p, struct kernel_siginfo *info,
-	 int sig, const struct cred *cred)
-LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
+LSM_HOOK(int, 0, 0, task_setrlimit, struct task_struct *p,
+	 unsigned int resource, struct rlimit *new_rlim)
+LSM_HOOK(int, 0, 0, task_setscheduler, struct task_struct *p)
+LSM_HOOK(int, 0, 0, task_getscheduler, struct task_struct *p)
+LSM_HOOK(int, 0, 0, task_movememory, struct task_struct *p)
+LSM_HOOK(int, 0, 0, task_kill, struct task_struct *p,
+	 struct kernel_siginfo *info, int sig, const struct cred *cred)
+LSM_HOOK(int, -ENOSYS, 0, task_prctl, int option, unsigned long arg2,
 	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
-LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
+LSM_HOOK(void, LSM_RET_VOID, 0, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
-LSM_HOOK(int, 0, userns_create, const struct cred *cred)
-LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
-LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmprop, struct kern_ipc_perm *ipcp,
+LSM_HOOK(int, 0, 0, userns_create, const struct cred *cred)
+LSM_HOOK(int, 0, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
+LSM_HOOK(void, LSM_RET_VOID, 0, ipc_getlsmprop, struct kern_ipc_perm *ipcp,
 	 struct lsm_prop *prop)
-LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
-LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
-LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
-LSM_HOOK(void, LSM_RET_VOID, msg_queue_free_security,
+LSM_HOOK(int, 0, 0, msg_msg_alloc_security, struct msg_msg *msg)
+LSM_HOOK(void, LSM_RET_VOID, 0, msg_msg_free_security, struct msg_msg *msg)
+LSM_HOOK(int, 0, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
+LSM_HOOK(void, LSM_RET_VOID, 0, msg_queue_free_security,
 	 struct kern_ipc_perm *perm)
-LSM_HOOK(int, 0, msg_queue_associate, struct kern_ipc_perm *perm, int msqflg)
-LSM_HOOK(int, 0, msg_queue_msgctl, struct kern_ipc_perm *perm, int cmd)
-LSM_HOOK(int, 0, msg_queue_msgsnd, struct kern_ipc_perm *perm,
+LSM_HOOK(int, 0, 0, msg_queue_associate, struct kern_ipc_perm *perm, int msqflg)
+LSM_HOOK(int, 0, 0, msg_queue_msgctl, struct kern_ipc_perm *perm, int cmd)
+LSM_HOOK(int, 0, 0, msg_queue_msgsnd, struct kern_ipc_perm *perm,
 	 struct msg_msg *msg, int msqflg)
-LSM_HOOK(int, 0, msg_queue_msgrcv, struct kern_ipc_perm *perm,
+LSM_HOOK(int, 0, 0, msg_queue_msgrcv, struct kern_ipc_perm *perm,
 	 struct msg_msg *msg, struct task_struct *target, long type, int mode)
-LSM_HOOK(int, 0, shm_alloc_security, struct kern_ipc_perm *perm)
-LSM_HOOK(void, LSM_RET_VOID, shm_free_security, struct kern_ipc_perm *perm)
-LSM_HOOK(int, 0, shm_associate, struct kern_ipc_perm *perm, int shmflg)
-LSM_HOOK(int, 0, shm_shmctl, struct kern_ipc_perm *perm, int cmd)
-LSM_HOOK(int, 0, shm_shmat, struct kern_ipc_perm *perm, char __user *shmaddr,
-	 int shmflg)
-LSM_HOOK(int, 0, sem_alloc_security, struct kern_ipc_perm *perm)
-LSM_HOOK(void, LSM_RET_VOID, sem_free_security, struct kern_ipc_perm *perm)
-LSM_HOOK(int, 0, sem_associate, struct kern_ipc_perm *perm, int semflg)
-LSM_HOOK(int, 0, sem_semctl, struct kern_ipc_perm *perm, int cmd)
-LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
+LSM_HOOK(int, 0, 0, shm_alloc_security, struct kern_ipc_perm *perm)
+LSM_HOOK(void, LSM_RET_VOID, 0, shm_free_security, struct kern_ipc_perm *perm)
+LSM_HOOK(int, 0, 0, shm_associate, struct kern_ipc_perm *perm, int shmflg)
+LSM_HOOK(int, 0, 0, shm_shmctl, struct kern_ipc_perm *perm, int cmd)
+LSM_HOOK(int, 0, 0, shm_shmat, struct kern_ipc_perm *perm,
+	 char __user *shmaddr, int shmflg)
+LSM_HOOK(int, 0, 0, sem_alloc_security, struct kern_ipc_perm *perm)
+LSM_HOOK(void, LSM_RET_VOID, 0, sem_free_security, struct kern_ipc_perm *perm)
+LSM_HOOK(int, 0, 0, sem_associate, struct kern_ipc_perm *perm, int semflg)
+LSM_HOOK(int, 0, 0, sem_semctl, struct kern_ipc_perm *perm, int cmd)
+LSM_HOOK(int, 0, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
 	 unsigned nsops, int alter)
-LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
+LSM_HOOK(int, 0, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
+LSM_HOOK(void, LSM_RET_VOID, 0, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
-LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
+LSM_HOOK(int, -EOPNOTSUPP, 0, getselfattr, unsigned int attr,
 	 struct lsm_ctx __user *ctx, u32 *size, u32 flags)
-LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
+LSM_HOOK(int, -EOPNOTSUPP, 0, setselfattr, unsigned int attr,
 	 struct lsm_ctx *ctx, u32 size, u32 flags)
-LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
+LSM_HOOK(int, -EINVAL, 0, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
-LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
-LSM_HOOK(int, 0, ismaclabel, const char *name)
-LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsm_context *cp)
-LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
+LSM_HOOK(int, -EINVAL, 0, setprocattr, const char *name, void *value,
+	 size_t size)
+LSM_HOOK(int, 0, 0, ismaclabel, const char *name)
+LSM_HOOK(int, -EOPNOTSUPP, 0, secid_to_secctx, u32 secid,
+	 struct lsm_context *cp)
+LSM_HOOK(int, -EOPNOTSUPP, 0, lsmprop_to_secctx, struct lsm_prop *prop,
 	 struct lsm_context *cp)
-LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsm_context *cp)
-LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
-LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
-LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode,
+LSM_HOOK(int, 0, 0, secctx_to_secid, const char *secdata, u32 seclen,
+	 u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, 0, release_secctx, struct lsm_context *cp)
+LSM_HOOK(void, LSM_RET_VOID, 0, inode_invalidate_secctx, struct inode *inode)
+LSM_HOOK(int, 0, 0, inode_notifysecctx, struct inode *inode, void *ctx,
+	 u32 ctxlen)
+LSM_HOOK(int, 0, 0, inode_setsecctx, struct dentry *dentry, void *ctx,
+	 u32 ctxlen)
+LSM_HOOK(int, -EOPNOTSUPP, 0, inode_getsecctx, struct inode *inode,
 	 struct lsm_context *cp)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
-LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
+LSM_HOOK(int, 0, 0, post_notification, const struct cred *w_cred,
 	 const struct cred *cred, struct watch_notification *n)
 #endif /* CONFIG_SECURITY && CONFIG_WATCH_QUEUE */
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_KEY_NOTIFICATIONS)
-LSM_HOOK(int, 0, watch_key, struct key *key)
+LSM_HOOK(int, 0, 0, watch_key, struct key *key)
 #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
 
 #ifdef CONFIG_SECURITY_NETWORK
-LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
+LSM_HOOK(int, 0, 0, unix_stream_connect, struct sock *sock, struct sock *other,
 	 struct sock *newsk)
-LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
-LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)
-LSM_HOOK(int, 0, socket_post_create, struct socket *sock, int family, int type,
-	 int protocol, int kern)
-LSM_HOOK(int, 0, socket_socketpair, struct socket *socka, struct socket *sockb)
-LSM_HOOK(int, 0, socket_bind, struct socket *sock, struct sockaddr *address,
-	 int addrlen)
-LSM_HOOK(int, 0, socket_connect, struct socket *sock, struct sockaddr *address,
+LSM_HOOK(int, 0, 0, unix_may_send, struct socket *sock, struct socket *other)
+LSM_HOOK(int, 0, 0, socket_create, int family, int type, int protocol,
+	 int kern)
+LSM_HOOK(int, 0, 0, socket_post_create, struct socket *sock, int family,
+	 int type, int protocol, int kern)
+LSM_HOOK(int, 0, 0, socket_socketpair, struct socket *socka,
+	 struct socket *sockb)
+LSM_HOOK(int, 0, 0, socket_bind, struct socket *sock, struct sockaddr *address,
 	 int addrlen)
-LSM_HOOK(int, 0, socket_listen, struct socket *sock, int backlog)
-LSM_HOOK(int, 0, socket_accept, struct socket *sock, struct socket *newsock)
-LSM_HOOK(int, 0, socket_sendmsg, struct socket *sock, struct msghdr *msg,
+LSM_HOOK(int, 0, 0, socket_connect, struct socket *sock,
+	 struct sockaddr *address, int addrlen)
+LSM_HOOK(int, 0, 0, socket_listen, struct socket *sock, int backlog)
+LSM_HOOK(int, 0, 0, socket_accept, struct socket *sock, struct socket *newsock)
+LSM_HOOK(int, 0, 0, socket_sendmsg, struct socket *sock, struct msghdr *msg,
 	 int size)
-LSM_HOOK(int, 0, socket_recvmsg, struct socket *sock, struct msghdr *msg,
+LSM_HOOK(int, 0, 0, socket_recvmsg, struct socket *sock, struct msghdr *msg,
 	 int size, int flags)
-LSM_HOOK(int, 0, socket_getsockname, struct socket *sock)
-LSM_HOOK(int, 0, socket_getpeername, struct socket *sock)
-LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
-LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
-LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
-LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *sock,
+LSM_HOOK(int, 0, 0, socket_getsockname, struct socket *sock)
+LSM_HOOK(int, 0, 0, socket_getpeername, struct socket *sock)
+LSM_HOOK(int, 0, 0, socket_getsockopt, struct socket *sock, int level,
+	 int optname)
+LSM_HOOK(int, 0, 0, socket_setsockopt, struct socket *sock, int level,
+	 int optname)
+LSM_HOOK(int, 0, 0, socket_shutdown, struct socket *sock, int how)
+LSM_HOOK(int, 0, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
+LSM_HOOK(int, -ENOPROTOOPT, 0, socket_getpeersec_stream, struct socket *sock,
 	 sockptr_t optval, sockptr_t optlen, unsigned int len)
-LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock,
+LSM_HOOK(int, -ENOPROTOOPT, 0, socket_getpeersec_dgram, struct socket *sock,
 	 struct sk_buff *skb, u32 *secid)
-LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
-LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
-LSM_HOOK(void, LSM_RET_VOID, sk_clone_security, const struct sock *sk,
+LSM_HOOK(int, 0, 0, sk_alloc_security, struct sock *sk, int family,
+	 gfp_t priority)
+LSM_HOOK(void, LSM_RET_VOID, 0, sk_free_security, struct sock *sk)
+LSM_HOOK(void, LSM_RET_VOID, 0, sk_clone_security, const struct sock *sk,
 	 struct sock *newsk)
-LSM_HOOK(void, LSM_RET_VOID, sk_getsecid, const struct sock *sk, u32 *secid)
-LSM_HOOK(void, LSM_RET_VOID, sock_graft, struct sock *sk, struct socket *parent)
-LSM_HOOK(int, 0, inet_conn_request, const struct sock *sk, struct sk_buff *skb,
-	 struct request_sock *req)
-LSM_HOOK(void, LSM_RET_VOID, inet_csk_clone, struct sock *newsk,
+LSM_HOOK(void, LSM_RET_VOID, 0, sk_getsecid, const struct sock *sk, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, 0, sock_graft, struct sock *sk,
+	 struct socket *parent)
+LSM_HOOK(int, 0, 0, inet_conn_request, const struct sock *sk,
+	 struct sk_buff *skb, struct request_sock *req)
+LSM_HOOK(void, LSM_RET_VOID, 0, inet_csk_clone, struct sock *newsk,
 	 const struct request_sock *req)
-LSM_HOOK(void, LSM_RET_VOID, inet_conn_established, struct sock *sk,
+LSM_HOOK(void, LSM_RET_VOID, 0, inet_conn_established, struct sock *sk,
 	 struct sk_buff *skb)
-LSM_HOOK(int, 0, secmark_relabel_packet, u32 secid)
-LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_inc, void)
-LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_dec, void)
-LSM_HOOK(void, LSM_RET_VOID, req_classify_flow, const struct request_sock *req,
-	 struct flowi_common *flic)
-LSM_HOOK(int, 0, tun_dev_alloc_security, void *security)
-LSM_HOOK(int, 0, tun_dev_create, void)
-LSM_HOOK(int, 0, tun_dev_attach_queue, void *security)
-LSM_HOOK(int, 0, tun_dev_attach, struct sock *sk, void *security)
-LSM_HOOK(int, 0, tun_dev_open, void *security)
-LSM_HOOK(int, 0, sctp_assoc_request, struct sctp_association *asoc,
+LSM_HOOK(int, 0, 0, secmark_relabel_packet, u32 secid)
+LSM_HOOK(void, LSM_RET_VOID, 0, secmark_refcount_inc, void)
+LSM_HOOK(void, LSM_RET_VOID, 0, secmark_refcount_dec, void)
+LSM_HOOK(void, LSM_RET_VOID, 0, req_classify_flow,
+	 const struct request_sock *req, struct flowi_common *flic)
+LSM_HOOK(int, 0, 0, tun_dev_alloc_security, void *security)
+LSM_HOOK(int, 0, 0, tun_dev_create, void)
+LSM_HOOK(int, 0, 0, tun_dev_attach_queue, void *security)
+LSM_HOOK(int, 0, 0, tun_dev_attach, struct sock *sk, void *security)
+LSM_HOOK(int, 0, 0, tun_dev_open, void *security)
+LSM_HOOK(int, 0, 0, sctp_assoc_request, struct sctp_association *asoc,
 	 struct sk_buff *skb)
-LSM_HOOK(int, 0, sctp_bind_connect, struct sock *sk, int optname,
+LSM_HOOK(int, 0, 0, sctp_bind_connect, struct sock *sk, int optname,
 	 struct sockaddr *address, int addrlen)
-LSM_HOOK(void, LSM_RET_VOID, sctp_sk_clone, struct sctp_association *asoc,
+LSM_HOOK(void, LSM_RET_VOID, 0, sctp_sk_clone, struct sctp_association *asoc,
 	 struct sock *sk, struct sock *newsk)
-LSM_HOOK(int, 0, sctp_assoc_established, struct sctp_association *asoc,
+LSM_HOOK(int, 0, 0, sctp_assoc_established, struct sctp_association *asoc,
 	 struct sk_buff *skb)
-LSM_HOOK(int, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
+LSM_HOOK(int, 0, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
 #endif /* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
-LSM_HOOK(int, 0, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
-LSM_HOOK(int, 0, ib_endport_manage_subnet, void *sec, const char *dev_name,
+LSM_HOOK(int, 0, 0, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
+LSM_HOOK(int, 0, 0, ib_endport_manage_subnet, void *sec, const char *dev_name,
 	 u8 port_num)
-LSM_HOOK(int, 0, ib_alloc_security, void *sec)
+LSM_HOOK(int, 0, 0, ib_alloc_security, void *sec)
 #endif /* CONFIG_SECURITY_INFINIBAND */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-LSM_HOOK(int, 0, xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctxp,
+LSM_HOOK(int, 0, 0, xfrm_policy_alloc_security, struct xfrm_sec_ctx **ctxp,
 	 struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp)
-LSM_HOOK(int, 0, xfrm_policy_clone_security, struct xfrm_sec_ctx *old_ctx,
+LSM_HOOK(int, 0, 0, xfrm_policy_clone_security, struct xfrm_sec_ctx *old_ctx,
 	 struct xfrm_sec_ctx **new_ctx)
-LSM_HOOK(void, LSM_RET_VOID, xfrm_policy_free_security,
+LSM_HOOK(void, LSM_RET_VOID, 0, xfrm_policy_free_security,
 	 struct xfrm_sec_ctx *ctx)
-LSM_HOOK(int, 0, xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx)
-LSM_HOOK(int, 0, xfrm_state_alloc, struct xfrm_state *x,
+LSM_HOOK(int, 0, 0, xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx)
+LSM_HOOK(int, 0, 0, xfrm_state_alloc, struct xfrm_state *x,
 	 struct xfrm_user_sec_ctx *sec_ctx)
-LSM_HOOK(int, 0, xfrm_state_alloc_acquire, struct xfrm_state *x,
-	 struct xfrm_sec_ctx *polsec, u32 secid)
-LSM_HOOK(void, LSM_RET_VOID, xfrm_state_free_security, struct xfrm_state *x)
-LSM_HOOK(int, 0, xfrm_state_delete_security, struct xfrm_state *x)
-LSM_HOOK(int, 0, xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_secid)
-LSM_HOOK(int, 1, xfrm_state_pol_flow_match, struct xfrm_state *x,
+LSM_HOOK(int, 0, 0, xfrm_state_alloc_acquire,
+	 struct xfrm_state *x, struct xfrm_sec_ctx *polsec, u32 secid)
+LSM_HOOK(void, LSM_RET_VOID, 0, xfrm_state_free_security, struct xfrm_state *x)
+LSM_HOOK(int, 0, 0, xfrm_state_delete_security, struct xfrm_state *x)
+LSM_HOOK(int, 0, 0, xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_secid)
+LSM_HOOK(int, 1, 0, xfrm_state_pol_flow_match, struct xfrm_state *x,
 	 struct xfrm_policy *xp, const struct flowi_common *flic)
-LSM_HOOK(int, 0, xfrm_decode_session, struct sk_buff *skb, u32 *secid,
+LSM_HOOK(int, 0, 0, xfrm_decode_session, struct sk_buff *skb, u32 *secid,
 	 int ckall)
 #endif /* CONFIG_SECURITY_NETWORK_XFRM */
 
 /* key management security hooks */
 #ifdef CONFIG_KEYS
-LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
+LSM_HOOK(int, 0, 0, key_alloc, struct key *key, const struct cred *cred,
 	 unsigned long flags)
-LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
-	 enum key_need_perm need_perm)
-LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
-LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
+LSM_HOOK(int, 0, 0, key_permission, key_ref_t key_ref,
+	 const struct cred *cred, enum key_need_perm need_perm)
+LSM_HOOK(int, 0, 0, key_getsecurity, struct key *key, char **buffer)
+LSM_HOOK(void, LSM_RET_VOID, 0, key_post_create_or_update, struct key *keyring,
 	 struct key *key, const void *payload, size_t payload_len,
 	 unsigned long flags, bool create)
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
+LSM_HOOK(int, 0, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
 	 void **lsmrule, gfp_t gfp)
-LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
-LSM_HOOK(int, 0, audit_rule_match, struct lsm_prop *prop, u32 field, u32 op,
+LSM_HOOK(int, 0, 0, audit_rule_known, struct audit_krule *krule)
+LSM_HOOK(int, 0, 0, audit_rule_match, struct lsm_prop *prop, u32 field, u32 op,
 	 void *lsmrule)
-LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
+LSM_HOOK(void, LSM_RET_VOID, 0, audit_rule_free, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
-LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
-LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
-LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
-LSM_HOOK(int, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *attr,
-	 struct bpf_token *token, bool kernel)
-LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
-LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
+LSM_HOOK(int, 0, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size,
+	 bool kernel)
+LSM_HOOK(int, 0, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
+LSM_HOOK(int, 0, 0, bpf_prog, struct bpf_prog *prog)
+LSM_HOOK(int, 0, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *attr,
 	 struct bpf_token *token, bool kernel)
-LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
-LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr,
-	 const struct path *path)
-LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
-LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
-LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
+LSM_HOOK(void, LSM_RET_VOID, 0, bpf_map_free, struct bpf_map *map)
+LSM_HOOK(int, 0, 0, bpf_prog_load, struct bpf_prog *prog,
+	 union bpf_attr *attr, struct bpf_token *token, bool kernel)
+LSM_HOOK(void, LSM_RET_VOID, 0, bpf_prog_free, struct bpf_prog *prog)
+LSM_HOOK(int, 0, 0, bpf_token_create, struct bpf_token *token,
+	 union bpf_attr *attr, const struct path *path)
+LSM_HOOK(void, LSM_RET_VOID, 0, bpf_token_free, struct bpf_token *token)
+LSM_HOOK(int, 0, 0, bpf_token_cmd, const struct bpf_token *token,
+	 enum bpf_cmd cmd)
+LSM_HOOK(int, 0, 0, bpf_token_capable, const struct bpf_token *token, int cap)
 #endif /* CONFIG_BPF_SYSCALL */
 
-LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
+LSM_HOOK(int, 0, 0, locked_down, enum lockdown_reason what)
 
 #ifdef CONFIG_PERF_EVENTS
-LSM_HOOK(int, 0, perf_event_open, int type)
-LSM_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
-LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
-LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
+LSM_HOOK(int, 0, 0, perf_event_open, int type)
+LSM_HOOK(int, 0, 0, perf_event_alloc, struct perf_event *event)
+LSM_HOOK(int, 0, 0, perf_event_read, struct perf_event *event)
+LSM_HOOK(int, 0, 0, perf_event_write, struct perf_event *event)
 #endif /* CONFIG_PERF_EVENTS */
 
 #ifdef CONFIG_IO_URING
-LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
-LSM_HOOK(int, 0, uring_sqpoll, void)
-LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
-LSM_HOOK(int, 0, uring_allowed, void)
+LSM_HOOK(int, 0, 0, uring_override_creds, const struct cred *new)
+LSM_HOOK(int, 0, 0, uring_sqpoll, void)
+LSM_HOOK(int, 0, 0, uring_cmd, struct io_uring_cmd *ioucmd)
+LSM_HOOK(int, 0, 0, uring_allowed, void)
 #endif /* CONFIG_IO_URING */
 
-LSM_HOOK(void, LSM_RET_VOID, initramfs_populated, void)
+LSM_HOOK(void, LSM_RET_VOID, 0, initramfs_populated, void)
 
-LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
-LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
-LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
+LSM_HOOK(int, 0, 0, bdev_alloc_security, struct block_device *bdev)
+LSM_HOOK(void, LSM_RET_VOID, 0, bdev_free_security, struct block_device *bdev)
+LSM_HOOK(int, 0, 0, bdev_setintegrity, struct block_device *bdev,
 	 enum lsm_integrity_type type, const void *value, size_t size)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b92008641242..4411b47f9a8d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -36,7 +36,7 @@
 #include <linux/lsm_count.h>
 
 union security_list_options {
-	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
+	#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) RET (*NAME)(__VA_ARGS__);
 	#include "lsm_hook_defs.h"
 	#undef LSM_HOOK
 	void *lsm_func_addr;
@@ -65,7 +65,7 @@ struct lsm_static_call {
  * dynamic to adapt the number of static calls to the number of callbacks.
  */
 struct lsm_static_calls_table {
-	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) \
 		struct lsm_static_call NAME[MAX_LSM_COUNT];
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 7cb6e8d4282c..53d5c0b69b2c 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -20,16 +20,16 @@
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
  */
-#define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
-noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
-{						\
-	return DEFAULT;				\
+#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...)	\
+noinline RET bpf_lsm_##NAME(__VA_ARGS__)		\
+{							\
+	return DEFAULT;					\
 }
 
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
-#define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
+#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 40efde233f3a..8c4b0ed2b22e 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -8,7 +8,7 @@
 #include <uapi/linux/lsm.h>
 
 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
-	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
diff --git a/security/security.c b/security/security.c
index 31a688650601..25e7cfc96f20 100644
--- a/security/security.c
+++ b/security/security.c
@@ -117,7 +117,7 @@ do {						\
 				*((RET(*)(__VA_ARGS__))NULL));		\
 	DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
 
-#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...)			\
 	LSM_DEFINE_UNROLL(DEFINE_LSM_STATIC_CALL, NAME, RET, __VA_ARGS__)
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
@@ -142,7 +142,7 @@ struct lsm_static_calls_table
 		.trampoline = LSM_HOOK_TRAMP(NAME, NUM),		\
 		.active = &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),		\
 	},
-#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...)			\
 	.NAME = {							\
 		LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)		\
 	},
@@ -422,7 +422,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 #define DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
 #define DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME) \
 	static const int __maybe_unused LSM_RET_DEFAULT(NAME) = (DEFAULT);
-#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) \
 	DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
 
 #include <linux/lsm_hook_defs.h>
-- 
2.52.0

