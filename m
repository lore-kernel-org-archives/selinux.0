Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6437C47071
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 04:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbjKPEeN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Nov 2023 23:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjKPEd4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Nov 2023 23:33:56 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F08C1AC
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 20:33:52 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41c157bbd30so2656241cf.0
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 20:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109231; x=1700714031; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRCIUlxMviG/akojIoiuUtAzlfA4z+ppx5JWcANslrQ=;
        b=SwYS/wyuZgZb9WJ0PIvbdBV7/u/Z74cHs86kLwpyUjEaxAXQtDq6If6SI7YvAdGeTm
         6CCGvzBiXTzyxPeSUfFgQNUfwXcV8V6Ol45lE8wSbPTJkP5Yh2x+QdBsmHJs9uBoL3oJ
         eGSmR68w0bH5KDsM4hsNba/8NMA/Dl9jaNVn85591Ud0BL+hq9WIzhpnHo13OE4hgLt2
         JmqI4uCRpXAqIc0dTXWhjm/I3Pxv3lu83q7bOIndslt95HTIOsiQ1Xi73YnnBvxqTy2N
         TcmKB0D9Z7rNvSj00Z8ubcL6V54Qfcuv/lxJwqOi5ttkVZ1DdMhAr9Q1PyDEV3fHaCAh
         hhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109231; x=1700714031;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRCIUlxMviG/akojIoiuUtAzlfA4z+ppx5JWcANslrQ=;
        b=t38jbxW8wyVPdFGhMdfY2v9LydFqiG1/FIeIds9oa828vKSgx8HFNHhsR1iBqOoUAp
         U8blOM7E9Y+DsYwrrZwW0DcDQjhv6YvThUmINPXYrEk1o2Cgxg4nzmc4kXBCaLQ9z/R2
         FsqoyARMSuvyY7LOPOSfZ69xwmTIVA0/r8+E5bOsmYD+NbMa9MWiOQZztbKKcW/UFfY/
         B/G5gJ9KmmESIk/0oyiGT0nureIaahnus4GgkpVnDXFovVX756i8t11yNrtif+k3Pm/j
         61DG2sxzC0CfDeHwYxgHKoc5pSPHox68aibh2AhpnOT6AvqqOwNI+rUtPIrTL11esdu+
         ozQw==
X-Gm-Message-State: AOJu0YwPbEL0zSLYmea/Oeg6Ai7udMK+udmEUU6e1/jyIINVXGJ0JZop
        mo1jEx2VH+wlIgwnfCHx9e0D
X-Google-Smtp-Source: AGHT+IHphFpDzgVFwOfukFTgf3tIsG9A83ycMGfQY4UVTT6EROx8wCbgF2iRta1hsOxzIr0MuKuWvQ==
X-Received: by 2002:a05:622a:1a9c:b0:412:24e6:a485 with SMTP id s28-20020a05622a1a9c00b0041224e6a485mr8399280qtc.2.1700109231366;
        Wed, 15 Nov 2023 20:33:51 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id e7-20020ac84907000000b004195faf1e2csm4050405qtq.97.2023.11.15.20.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:50 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:33:50 -0500
Message-ID: <f79bb72356ca062d3f3b6b00c3694d8f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 17/23] security: Introduce inode_post_remove_acl hook
References: <20231107134012.682009-18-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-18-roberto.sassu@huaweicloud.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_remove_acl hook.
> 
> At inode_remove_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_remove_acl, EVM re-calculates the file's HMAC with the passed
> POSIX ACL removed and other file metadata.
> 
> Other LSMs could similarly take some action after successful POSIX ACL
> removal.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  8 ++++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 28 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index d2dbea54a63a..6eb7c9cff1e5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2413,6 +2413,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>  	return evm_inode_remove_acl(idmap, dentry, acl_name);
>  }
>  
> +/**
> + * security_inode_post_remove_acl() - Update inode security after rm posix acls
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @acl_name: acl name
> + *
> + * Update inode security data after successfully removing posix acls on
> + * @dentry in @idmap. The posix acls are identified by @acl_name.
> + */
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +				    struct dentry *dentry, const char *acl_name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;

See previous comments regaring S_PRIVATE checks.

> +	call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
> +}
> +
>  /**
>   * security_inode_post_setxattr() - Update the inode after a setxattr operation
>   * @dentry: file
> -- 
> 2.34.1

--
paul-moore.com
