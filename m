Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896FCC43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 17:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500E920685
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 17:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TGomxKOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfAIRIh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:08:37 -0500
Received: from sonic303-28.consmr.mail.gq1.yahoo.com ([98.137.64.209]:43203
        "EHLO sonic303-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbfAIRIh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 12:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547053716; bh=LOTNmiPhAAmKh5qvyF4rWev/s04jDXV80kRE6lJavBs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=TGomxKOvu378BsZahJOmEhRNyq31MqA8/5t55/TXZ3snH+XG1NcSsJyEo9xe2ZdKJPj2idjslz3KUIKdoRjzFLbVQpX/6LrqXrzDCEPbBXYzFdjG/luwujDAsdHlobpG0e2t1RSfs+1wfIjxan0qQ9jBKpaDZjC0UuMuePtQkNSWq6ChdYN0wAK+CfXSPb2ZnolaTjXFU+nK03iQova4CW0bCgNpnf/R0txJ7J8mImdWCKWJyl9xcH0tTYkTbDWDESkGIEF905jUCEeT31GumEfikfvJtp7e8VNRciiNtZmpOx79SEJiU9OTa9YLUj+xf6RrBO5bTqIUtaqWZ1fJbQ==
X-YMail-OSG: bZAY4NMVM1kOS20Fz1H0P.MLT1o7yrmcZvGxRrGxw.ID3EXmW1uJQp3F10Z0vrJ
 qYWCUokDvIyTZIKbSUsXvY9DLAtybPCl0G8hPBU0FRg0ipM8Q5oAYQqd7c3q_O7n7NHsssiDNLx3
 B4mtr5NENv_2lcIufv8716AOWPF9fC3NIA.Nlw4CZ9T9N9W5oVny1sn70hSBKWy2y7CTRp8GQ0pM
 Ab4koipMWf8Gwd.bG3887bPyBAueDPztFARMvDKbrYhidco8rPVV3XePj0YX6Oni3ZanLSCU8bR.
 3frajTgDcWHGTZNTwgIoQ0CxJUiJBUHdeKc_NAjn0xfrpwt5E8GCvvDKwGxc8rXF6uMMu8LNxIhd
 gPyyuhoI01tEPTm_XOvWdd6_KVjC1QzszGG6V8rM4qGpSRDrz7OPlvGVowJ5wcFfKxn0cvCKsPjl
 26le51DfiXTGda81rXcb5_jIII_LGGkpQWPIe95GWHlksz6VGs996Hp1Hx.yXVlwSYQMx9tmaF.w
 2X_DlWB.qlVUIJ0ZGBFfqec0qRYzfzitdOktUuNiOzgWDgPuee_WdH14zrpKeHQcoKbDitLBJoSD
 x9YMcmJ97NKgUny8MqeamgQ8rVowPjDS.fDXU1J0872zRZ1NPm5.fTPCdqVTJz68uN1qwO9zGQeH
 N8V2YdQS7zS2ZvMkirUJpuIcsPbp4HEN0VFWui_OaMvlqlfOhxpLdQzcTuBC8GzTgDbTcfhVIHMJ
 GlSV8StwdT7BeLRVmF6TeHFsMcuKt3SzbcXu_s6mwX.PKxNYlVHC2EbLK_AsWIl3HgqBUFXHcqEN
 9kLkv19wSO4DP2oJEEOE8hgbcg_vTuLfJAzarcIa0_5p86F1OY47fSZyS8m9Lu1iKF87wKl_xK9b
 r.5GoXFDUhv6t3zQSRt_HX3cLBQVPtWGuds.cTZ0qSXHJqvcEOW6lWWnbkG.toiTpobgZUSAdc2v
 yh7XyFQCHFObvjP3QSEGfLLxXVj7Ugyn5.EYFuFqY_vzBDS0ttwpiXy9RWbR_C1nphijf4LNsgEK
 N9zamTgPDuMNS2_mT_MGsZv0IqqAKAg_9pPyhPe_6nqrFkEfmq5rsGqQJRS12qiCdDqV4sFOWvMM
 5gyiMxoqPSXsCQts-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Wed, 9 Jan 2019 17:08:36 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 71518c7b68c0f6917377cd27b719e555;
          Wed, 09 Jan 2019 17:08:34 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] LSM: Add new hook for generic node initialization
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190109162830.8309-1-omosnace@redhat.com>
 <20190109162830.8309-2-omosnace@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cbe734fb-cd91-57a8-0de5-f4f0f8a1a2cd@schaufler-ca.com>
Date:   Wed, 9 Jan 2019 09:08:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190109162830.8309-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
> This patch introduces a new security hook that is intended for
> initializing the security data for newly created pseudo filesystem
> objects (such as kernfs nodes) that provide a way of storing a
> non-default security context, but need to operate independently from
> mounts.
>
> The main motivation is to allow kernfs nodes to inherit the context of
> the parent under SELinux, similar to the behavior of
> security_inode_init_security(). Other LSMs may implement their own logic
> for handling the creation of new nodes.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++++
>  include/linux/security.h  | 14 ++++++++++++++
>  security/security.c       | 10 ++++++++++
>  3 files changed, 54 insertions(+)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index aaeb7fa24dc4..3a2399d7721f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -429,6 +429,31 @@
>   *	to abort the copy up. Note that the caller is responsible for reading
>   *	and writing the xattrs as this hook is merely a filter.
>   *
> + * Security hooks for special file-like objects
> + *
> + * @object_init_security:

I don't like the name. There are too many things that are "objects"
for this to be meaningful. I also dislike seeing names like
security_object_init_security. How about init_from_parent? If there's
never a chance that it will be used anywhere but with kernfs, it could
be kernfs_node_init. The existing set of hook names are sufficiently
confusing without adding to the mystery.

> + *	Obtain the security context for a newly created filesystem object
> + *	based on the security context of the parent node.  The purpose is
> + *	similar to @inode_init_security, but this hook is intended for
> + *	non-inode objects that need to behave like a directory tree (e.g.
> + *	kernfs nodes).  In this case it is assumed that the LSM assigns some
> + *	default context to the node by default and the object internally stores
> + *	a copy of the security context if (and only if) it has been set to a
> + *	non-default value explicitly (e.g. via *setxattr(2)).
> + *
> + *	@parent_ctx contains the security context of the parent directory
> + *	(must not be NULL -- if the parent has no explicit context set,
> + *	the child should also keep the default context and the hook should
> + *	not be called).
> + *	@parent_ctxlen contains the length of @parent_ctx data.
> + *	@qstr contains the last path component of the new object.
> + *	@mode contanis the file mode of the object.

s/contanis/contains/

> + *	@ctx is a pointer in which to place the allocated security context.
> + *	@ctxlen points to the place to put the length of @ctx.
> + *
> + *	Returns 0 if @ctx and @ctxlen have been successfully set or
> + *	-ENOMEM on memory allocation failure.
> + *
>   * Security hooks for file operations
>   *
>   * @file_permission:
> @@ -1556,6 +1581,10 @@ union security_list_options {
>  	int (*inode_copy_up)(struct dentry *src, struct cred **new);
>  	int (*inode_copy_up_xattr)(const char *name);
>  
> +	int (*object_init_security)(void *parent_ctx, u32 parent_ctxlen,
> +				    const struct qstr *qstr, u16 mode,
> +				    void **ctx, u32 *ctxlen);
> +
>  	int (*file_permission)(struct file *file, int mask);
>  	int (*file_alloc_security)(struct file *file);
>  	void (*file_free_security)(struct file *file);
> @@ -1855,6 +1884,7 @@ struct security_hook_heads {
>  	struct hlist_head inode_getsecid;
>  	struct hlist_head inode_copy_up;
>  	struct hlist_head inode_copy_up_xattr;
> +	struct hlist_head object_init_security;
>  	struct hlist_head file_permission;
>  	struct hlist_head file_alloc_security;
>  	struct hlist_head file_free_security;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d170a5b031f3..1e7971d10fe6 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -315,6 +315,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
>  void security_inode_getsecid(struct inode *inode, u32 *secid);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(const char *name);
> +int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
> +				  const struct qstr *qstr, u16 mode,
> +				  void **ctx, u32 *ctxlen);
>  int security_file_permission(struct file *file, int mask);
>  int security_file_alloc(struct file *file);
>  void security_file_free(struct file *file);
> @@ -815,6 +818,17 @@ static inline int security_inode_copy_up_xattr(const char *name)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int security_object_init_security(void *parent_ctx,
> +						u32 parent_ctxlen,
> +						const struct qstr *qstr,
> +						u16 mode, void **ctx,
> +						u32 *ctxlen)
> +{
> +	*ctx = NULL;
> +	*ctxlen = 0;
> +	return 0;
> +}
> +
>  static inline int security_file_permission(struct file *file, int mask)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 04d173eb93f6..a010bfbe3fc6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -879,6 +879,16 @@ int security_inode_copy_up_xattr(const char *name)
>  }
>  EXPORT_SYMBOL(security_inode_copy_up_xattr);
>  
> +int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
> +				  const struct qstr *qstr, u16 mode,
> +				  void **ctx, u32 *ctxlen)
> +{
> +	*ctx = NULL;
> +	*ctxlen = 0;
> +	return call_int_hook(object_init_security, 0, parent_ctx, parent_ctxlen,
> +			     qstr, mode, ctx, ctxlen);
> +}
> +
>  int security_file_permission(struct file *file, int mask)
>  {
>  	int ret;

