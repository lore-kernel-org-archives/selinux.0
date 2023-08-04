Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E886C41513
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 02:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjHDCUo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjHDCU0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 22:20:26 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D253B44A1
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 19:20:23 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63cf28db24cso9613066d6.2
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115623; x=1691720423;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WCtKRV7b+epJAAEXM2TZFXGiCSj243meGoK8CGC4Js4=;
        b=DlPXRmHvBtbIVEg/TQL4KDpt1sq7TYTm38bx3KiI6PY+OzFa7r2re2OmLFeR+rFEJG
         oHopXyMDnpSNps8cMOD64hN2pOb6JYsVtVslAyFQokUsjrKkF+tGk/TJON8GObDRyP9i
         M3KTKFLDpvKNnyWqez4x3OhjWN3R5+OK6C3j0N2TjS4tbKBfTiZuVAufTPleupn6FURD
         tCNrSMzpSlMhzXvGodq6FBnJmTj8lTixDhrmRjRUHmYDsKHLIcxT37r0KiZnaT8setNC
         TaQNfcMbpGgjhaSfFtPrZ/lUE00NoNAUe2X7aZwnrgYfJXYCeknVdTRb8xI6dgvWJRkJ
         /K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115623; x=1691720423;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCtKRV7b+epJAAEXM2TZFXGiCSj243meGoK8CGC4Js4=;
        b=PvhGd6PL8EJqYHxYTaQkIAh/0SXKxSdgwTy5/kMjzq5pdwc11Xymh30PGkR/O8b7PQ
         kNROwqlTA0s222yZ2BGKUcDBgsXeyKgWqswXXkEGbM0kagENBVl2TbuYdpkTuBuoenjJ
         jo534pPwy2hhwb34USpI3sgOfySwHt+nHZjxx1pAaDm/2fCzoO0/kCjJR/N8S3ln+xYN
         SmMTkrCbowZao6W93MvajrncXZrjjSuUkXF7YST/TovAZ+TZvozm0f0nqQ5/8YYtW6mw
         Dvaf9fCp7ZxeVTzRzr9HW8bUxhJG/o3hKu7WlKm0kAMfiGneTDNiCDfwlYhYBDIEWrvy
         z4OQ==
X-Gm-Message-State: AOJu0YweFSauqyNutV01mKeAZVVAcd+hqlqVLFytEU+WvNVtBGXEuxhr
        6WQ91VSRxvN3jKMJGqtYfXqi
X-Google-Smtp-Source: AGHT+IH+7NG8bzD2w66luBoKir2wyDLXvKAHHE9GAHJjXSenmZo2cvAXXITlkdxkqabvs9MWAZ7QHw==
X-Received: by 2002:a0c:e38f:0:b0:63d:2fa3:441f with SMTP id a15-20020a0ce38f000000b0063d2fa3441fmr421199qvl.11.1691115622724;
        Thu, 03 Aug 2023 19:20:22 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l9-20020a0ce089000000b0063d5a7871d4sm325603qvk.78.2023.08.03.19.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:22 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:22 -0400
Message-ID: <f37d02a675208bebc7025443e6cd74da.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] selinux: avoid implicit conversions in selinuxfs  code
References: <20230728155501.39632-6-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-6-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use umode_t as parameter type for sel_make_inode(), which assigns the
> value to the member i_mode of struct inode.
> 
> Use identical type for loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/selinuxfs.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index b969e87fd870..7d7931d1758e 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c

...

> @@ -1623,7 +1622,7 @@ static int sel_make_avc_files(struct dentry *dir)
>  #endif
>  	};
>  
> -	for (i = 0; i < ARRAY_SIZE(files); i++) {
> +	for (u32 i = 0; i < ARRAY_SIZE(files); i++) {

No initializers in the for-loop ;)

Also, how did you decide 'i' should be a u32?

>  		struct inode *inode;
>  		struct dentry *dentry;
>  
> @@ -1649,7 +1648,7 @@ static int sel_make_ss_files(struct dentry *dir)
>  {
>  	struct super_block *sb = dir->d_sb;
>  	struct selinux_fs_info *fsi = sb->s_fs_info;
> -	int i;
> +	u32 i;

Same as above, why u32?

>  	static const struct tree_descr files[] = {
>  		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
>  	};
> @@ -1700,7 +1699,7 @@ static const struct file_operations sel_initcon_ops = {
>  
>  static int sel_make_initcon_files(struct dentry *dir)
>  {
> -	int i;
> +	u32 i;

Again, why u32?

>  	for (i = 1; i <= SECINITSID_NUM; i++) {
>  		struct inode *inode;
> -- 
> 2.40.1

--
paul-moore.com
