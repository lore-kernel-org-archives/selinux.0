Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A6AC33CAF
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A24F2080D
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="R19BTW2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgAMNiw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:38:52 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:33104 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgAMNiw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 08:38:52 -0500
X-EEMSG-check-017: 65293052|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="65293052"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 13:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578922729; x=1610458729;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=AtXAFW4FpycVvgqJpjDQe+3TXBz6KYcatRpFoMP6Jpw=;
  b=R19BTW2L+598GbbcKkdI2TvI0XM3JkwEKtI9SdapaK93pZIeHkpqU+jr
   nBI4FjvFul0xZHf9Ac8kcIFvkyVqCGJMBKWTKja8t+smI7Phn2cf6gxYI
   u7FtTyRdaTjbG8PxgiVH0fLDIsD+iyZQo4fJmPwDj2Owj4CN6dUqlxyyk
   fLi3uOzrsYSfT+4Vio8ahzK+8biQ1j0Clf1FP2G9PQMz1LBToZDupVZ1Z
   Ne1Rw+pT+nejPE23Y3qvIOTVZhZ8V8SdlEMGB1IR7gzbXgDIKlp68qzmt
   vhjxUQT4IMfdVtVtKolJkqh+YpoABzBrgBnHqZHRYZ3jzfiaDCX4wil3j
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="37676965"
IronPort-PHdr: =?us-ascii?q?9a23=3A4brhxRbo0dfqFiAI3L/IPKn/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsy6bnLW6fgltlLVR4KTs6sC17ON9fq/ASddu96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdu8sKjYdtKqs91A?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4xkJ?=
 =?us-ascii?q?oTv0PDHjTol0rqlqOWakUl9fSo6+TgeLnmoIOTN5RohQ3kN6Qum8i/Dfw5Mg?=
 =?us-ascii?q?gIQWeb5fyx2KDs8ED2WrlHjuA6nrPHvJ3VO8gXvLO1DxdQ0ok56ha/Czmm0M?=
 =?us-ascii?q?4fnXkCNF9FYw+Ij5PyNlHSIPH3Efe/g1O2nDdt3PDJJKftAprKLnjdiLvhZ6?=
 =?us-ascii?q?py61ZAyAovytBS/4pUBascIPL3QULxrMbXDgI9MwCtxubnD9J91pkAVm6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvg++fHuiX45mVkAfaimxpYXdn+4Eep8I0?=
 =?us-ascii?q?mDYnrjnM0BEWEUsQo6VuDqj0eCUTEAL0q1Cpo1+zVzLYWhF4qLEpiknbipxC?=
 =?us-ascii?q?6mGthTYWdcBxaHFnK+M82fVvMNbj+CCtFunyZCVrW7TYIlkxa0u1zU0b1ie9?=
 =?us-ascii?q?HI9zUYuJSr79184+nehFlm7jBvJ9iM2GGKCWdvlyUHQCFgj/M3mlB01lrWif?=
 =?us-ascii?q?swuPdfD9EGoqoSAwo=3D?=
X-IPAS-Result: =?us-ascii?q?A2AhBAA7chxe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQMiQOGawaBEiWJbpFICQEBAQEBAQEBATcBAYRAAoIcOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgnoBBSMEEVELGAICJgICVwYBDAYCAQGCYz+CV?=
 =?us-ascii?q?yWpCH8zhUmDT4E9gQ4ojDN5gQeBEScMA4JdPodZgl4EjVSJUUaXUYJBgkiTX?=
 =?us-ascii?q?wYbmmyOW50HIoFYKwgCGAghDzuCbFAYDYgNF45BIwMwjR4BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Jan 2020 13:38:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DDcCFH229600;
        Mon, 13 Jan 2020 08:38:12 -0500
Subject: Re: [RFC PATCH] selinux: remove redundant allocation and helper
 functions
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <157869192997.484726.14884768578207909170.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fee766f2-e19d-5af4-1635-5c4240c3b495@tycho.nsa.gov>
Date:   Mon, 13 Jan 2020 08:39:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <157869192997.484726.14884768578207909170.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 4:32 PM, Paul Moore wrote:
> This patch removes the inode, file, and superblock security blob
> allocation functions and moves the associated code into the
> respective LSM hooks.  This patch also removes the inode_doinit()
> function as it was a trivial wrapper around
> inode_doinit_with_dentry() and called from one location in the code.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c |   94 ++++++++++++++++++----------------------------
>   1 file changed, 36 insertions(+), 58 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2c84b12d50bc..1305fc51bfae 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -238,24 +238,6 @@ static inline u32 task_sid(const struct task_struct *task)
>   	return sid;
>   }
>   
> -/* Allocate and free functions for each kind of security blob. */
> -
> -static int inode_alloc_security(struct inode *inode)
> -{
> -	struct inode_security_struct *isec = selinux_inode(inode);
> -	u32 sid = current_sid();
> -
> -	spin_lock_init(&isec->lock);
> -	INIT_LIST_HEAD(&isec->list);
> -	isec->inode = inode;
> -	isec->sid = SECINITSID_UNLABELED;
> -	isec->sclass = SECCLASS_FILE;
> -	isec->task_sid = sid;
> -	isec->initialized = LABEL_INVALID;
> -
> -	return 0;
> -}
> -
>   static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
>   
>   /*
> @@ -354,37 +336,6 @@ static void inode_free_security(struct inode *inode)
>   	}
>   }
>   
> -static int file_alloc_security(struct file *file)
> -{
> -	struct file_security_struct *fsec = selinux_file(file);
> -	u32 sid = current_sid();
> -
> -	fsec->sid = sid;
> -	fsec->fown_sid = sid;
> -
> -	return 0;
> -}
> -
> -static int superblock_alloc_security(struct super_block *sb)
> -{
> -	struct superblock_security_struct *sbsec;
> -
> -	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
> -	if (!sbsec)
> -		return -ENOMEM;
> -
> -	mutex_init(&sbsec->lock);
> -	INIT_LIST_HEAD(&sbsec->isec_head);
> -	spin_lock_init(&sbsec->isec_lock);
> -	sbsec->sb = sb;
> -	sbsec->sid = SECINITSID_UNLABELED;
> -	sbsec->def_sid = SECINITSID_FILE;
> -	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
> -	sb->s_security = sbsec;
> -
> -	return 0;
> -}
> -
>   static void superblock_free_security(struct super_block *sb)
>   {
>   	struct superblock_security_struct *sbsec = sb->s_security;
> @@ -406,11 +357,6 @@ static void selinux_free_mnt_opts(void *mnt_opts)
>   	kfree(opts);
>   }
>   
> -static inline int inode_doinit(struct inode *inode)
> -{
> -	return inode_doinit_with_dentry(inode, NULL);
> -}
> -
>   enum {
>   	Opt_error = -1,
>   	Opt_context = 0,
> @@ -598,7 +544,7 @@ static int sb_finish_set_opts(struct super_block *sb)
>   		inode = igrab(inode);
>   		if (inode) {
>   			if (!IS_PRIVATE(inode))
> -				inode_doinit(inode);
> +				inode_doinit_with_dentry(inode, NULL);
>   			iput(inode);
>   		}
>   		spin_lock(&sbsec->isec_lock);
> @@ -2593,7 +2539,22 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>   
>   static int selinux_sb_alloc_security(struct super_block *sb)
>   {
> -	return superblock_alloc_security(sb);
> +	struct superblock_security_struct *sbsec;
> +
> +	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
> +	if (!sbsec)
> +		return -ENOMEM;
> +
> +	mutex_init(&sbsec->lock);
> +	INIT_LIST_HEAD(&sbsec->isec_head);
> +	spin_lock_init(&sbsec->isec_lock);
> +	sbsec->sb = sb;
> +	sbsec->sid = SECINITSID_UNLABELED;
> +	sbsec->def_sid = SECINITSID_FILE;
> +	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
> +	sb->s_security = sbsec;
> +
> +	return 0;
>   }
>   
>   static void selinux_sb_free_security(struct super_block *sb)
> @@ -2845,7 +2806,18 @@ static int selinux_fs_context_parse_param(struct fs_context *fc,
>   
>   static int selinux_inode_alloc_security(struct inode *inode)
>   {
> -	return inode_alloc_security(inode);
> +	struct inode_security_struct *isec = selinux_inode(inode);
> +	u32 sid = current_sid();
> +
> +	spin_lock_init(&isec->lock);
> +	INIT_LIST_HEAD(&isec->list);
> +	isec->inode = inode;
> +	isec->sid = SECINITSID_UNLABELED;
> +	isec->sclass = SECCLASS_FILE;
> +	isec->task_sid = sid;
> +	isec->initialized = LABEL_INVALID;
> +
> +	return 0;
>   }
>   
>   static void selinux_inode_free_security(struct inode *inode)
> @@ -3555,7 +3527,13 @@ static int selinux_file_permission(struct file *file, int mask)
>   
>   static int selinux_file_alloc_security(struct file *file)
>   {
> -	return file_alloc_security(file);
> +	struct file_security_struct *fsec = selinux_file(file);
> +	u32 sid = current_sid();
> +
> +	fsec->sid = sid;
> +	fsec->fown_sid = sid;
> +
> +	return 0;
>   }
>   
>   /*
> 

