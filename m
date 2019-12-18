Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFAFC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 16:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B371218AC
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 16:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Yd0dquPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLRQQL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:16:11 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:38598 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfLRQQK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 11:16:10 -0500
X-EEMSG-check-017: 36877376|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="36877376"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 16:16:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576685768; x=1608221768;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zhgDTItEPLhISa9xnVxp4pQMpoOx5rTf3omdTaN5bro=;
  b=Yd0dquPuKiFWb+KfEns/H1VfTpBQcOHWiuatmfCKXcKvYK2zVvO5hQyC
   aJ1f4aWfUc3uWkm0vpSJvB3xwZm7LUBv0CRCAP72WMgKURTtpPV+Szt5z
   QyR1phbVmmsUYw4CcCbtRrMBN27RspsE/6VFu/yvR4F/zlL6SeV0FSkQM
   Yk4RGT4NApirq8kkdE8vMibxzEmH9QcDShZBOc2LFHH6V4ta3QiW5qzln
   Rk8ao63/a2dmyOcBcGoFplkhKcSJRjp6cbdCTmwVVAPoK+C8dkYx5xrzE
   GSjaKxDWGZEobXIWfwrqU3JiMoi67FHytZcjIJEnlMP55dBydxOeJoxgK
   w==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="36911956"
IronPort-PHdr: =?us-ascii?q?9a23=3AjU92nxREg0oZNSvXsG6TIaHYHdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YBOGt8tkgFKBZ4jH8fUM07OQ7/m7HzZYsN3R6TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajZdmJ6o+yR?=
 =?us-ascii?q?bFv2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQWyAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZEq0OL+joWkDvtN3VFQQ5PBC0w+n9FdV92IceVnyVAq?=
 =?us-ascii?q?OALKzdq0WE6f4oI+mJfIUVoiryK+A55/7yin80gUMScrOy3ZQJaHG0BO9mLF?=
 =?us-ascii?q?mZYXX2n9cBH2MKsRQkTOHxiV2CVyJTaGi2X64m+j47D4emB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa2BED1CMFm3od5+FW/cXcy+SJNVukjkaWrigUYMh0guutADiwbp9Mu?=
 =?us-ascii?q?XU4jEYtY7k1NVt4+3TlBcy9SF7DsiEyGGCUX17nn4SRz83wKB+oVVxylKE0a?=
 =?us-ascii?q?dlnvxYEcJc6uhXUgc1K5Hc1fZ2C9PsVQLbeNeGVlKmTs+hATErQdI728UObF?=
 =?us-ascii?q?plG9W+khDD2DKnA6QLmLyPBZw09L/c3nfqKsZjxHbJyrMhg0MlQsRRL22mgL?=
 =?us-ascii?q?Bw9wzJC47OiUWZmL6gdb4A0y7V6GeD0W2OsVlbUAFuT6rFRmwQZkzRrdT6/U?=
 =?us-ascii?q?7NU7+uCa4gMgtEyM6CN65KZsfujVVcS/fpIM7ebH6pm2esGRaIwauBbIjte2?=
 =?us-ascii?q?Ud2iXREkoEkwcT/XmcMwg+HTmuo2TFATNyD13vZUTs8e9/qHynVEA0yxuGYF?=
 =?us-ascii?q?Fm17qw4hQVn+CTS+sP3rIYvycssy10E0i739LZFtqApgxhcLxfYdwj+ldH03?=
 =?us-ascii?q?zWtwhmM5yhNqxiglkecxppsE/0zBV4EIZAkdUwrHww1gZyL7yX3ElDdzOAxZ?=
 =?us-ascii?q?rwIKHYKnHu/BCzbK7bwkne38yL+qcL8/k4s0/svBytFkY79nVn1N5V02GC6Z?=
 =?us-ascii?q?nQEAUSVpfxAQ4L8E1RrqrXc2EG7IPdyHNoPLP85jTLwN84LPAuyh+9cdNSKu?=
 =?us-ascii?q?aPHUn5FMhMQ4ClIfcnih6yZRINIe5W+bQcPsW6ev/A06mueK5imTW8l2VcyI?=
 =?us-ascii?q?Z010+NsS1mRaqA25cD3uHdxQaMSi39kEbkt8f7hIRJTS8dE3D5yiX+AoNVIK?=
 =?us-ascii?q?pocsJDEmqqIsuq1v1giJP3HX1V7liuAxUBwsD6VwCVagnGwQBI1UkR6UeikC?=
 =?us-ascii?q?+8wi08xyoltYKDzSfOxKLkbxNBNWlVEjoxxWzwKJS52ohJFHOjaBIkwV78vx?=
 =?us-ascii?q?f3?=
X-IPAS-Result: =?us-ascii?q?A2BXAABfT/pd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF8gXaBbSASKoQEiQOGVQEBAQEBBoESJYEBiGmKIocjCQEBAQEBA?=
 =?us-ascii?q?QEBATcBAYRAAoI9OBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMEEUEQC?=
 =?us-ascii?q?xgCAiYCAlcGAQwGAgEBgl8/glMlrXZ/M4VPg0eBQYEOKIwyeYEHgREnDAOCK?=
 =?us-ascii?q?DU+hDODJoJeBI0eJIhrYUaXNYI/gkOTSgYCGZpOLY4hnF8igVgrCAIYCCEPO?=
 =?us-ascii?q?4JsUBgNjR4XjkEjAzCPIAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Dec 2019 16:16:06 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIGFd6V018583;
        Wed, 18 Dec 2019 11:15:40 -0500
Subject: Re: [PATCH v12 16/25] LSM: Use lsmcontext in
 security_dentry_init_security
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-17-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <88931455-3fb0-66d4-aaa2-507fda1d81b0@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 11:16:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-17-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change the security_dentry_init_security() interface to
> fill an lsmcontext structure instead of a void * data area
> and a length. The lone caller of this interface is NFS4,
> which may make copies of the data using its own mechanisms.
> A rework of the nfs4 code to use the lsmcontext properly
> is a significant project, so the coward's way out is taken,
> and the lsmcontext data from security_dentry_init_security()
> is copied, then released directly.
> 
> This interface does not use the "display". There is currently
> not case where that is useful or reasonable.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
>   include/linux/security.h |  7 +++----
>   security/security.c      | 29 +++++++++++++++++++++++++----
>   3 files changed, 44 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index a30e36654c57..78d63f7f0088 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -112,6 +112,7 @@ static inline struct nfs4_label *
>   nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>   	struct iattr *sattr, struct nfs4_label *label)
>   {
> +	struct lsmcontext context;
>   	int err;
>   
>   	if (label == NULL)
> @@ -121,21 +122,26 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>   		return NULL;
>   
>   	err = security_dentry_init_security(dentry, sattr->ia_mode,
> -				&dentry->d_name, (void **)&label->label, &label->len);
> -	if (err == 0)
> -		return label;
> +					    &dentry->d_name, &context);
> +
> +	if (err)
> +		return NULL;
> +
> +	label->label = kmemdup(context.context, context.len, GFP_KERNEL);

This seems unfortunate; it introduces an extra allocation/copy of the 
context.  I'd prefer to avoid it.  Also wondering if GFP_KERNEL is 
always safe here.

> +	if (label->label == NULL)
> +		label = NULL;
> +	else
> +		label->len = context.len;
> +
> +	security_release_secctx(&context);
> +
> +	return label;
>   
> -	return NULL;
>   }
>   static inline void
>   nfs4_label_release_security(struct nfs4_label *label)
>   {
> -	struct lsmcontext scaff; /* scaffolding */
> -
> -	if (label) {
> -		lsmcontext_init(&scaff, label->label, label->len, 0);
> -		security_release_secctx(&scaff);
> -	}
> +	kfree(label->label);
>   }
>   static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
>   {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 00421941f683..a5eba06a9382 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -398,8 +398,8 @@ int security_add_mnt_opt(const char *option, const char *val,
>   				int len, void **mnt_opts);
>   int security_move_mount(const struct path *from_path, const struct path *to_path);
>   int security_dentry_init_security(struct dentry *dentry, int mode,
> -					const struct qstr *name, void **ctx,
> -					u32 *ctxlen);
> +					const struct qstr *name,
> +					struct lsmcontext *ctx);
>   int security_dentry_create_files_as(struct dentry *dentry, int mode,
>   					struct qstr *name,
>   					const struct cred *old,
> @@ -790,8 +790,7 @@ static inline void security_inode_free(struct inode *inode)
>   static inline int security_dentry_init_security(struct dentry *dentry,
>   						 int mode,
>   						 const struct qstr *name,
> -						 void **ctx,
> -						 u32 *ctxlen)
> +						 struct lsmcontext *ctx)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/security/security.c b/security/security.c
> index 4ba1a6ed36e0..8aa107b57af9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1011,12 +1011,33 @@ void security_inode_free(struct inode *inode)
>   				inode_free_by_rcu);
>   }
>   
> +/*
> + * security_dentry_init_security - initial context for a dentry
> + * @dentry: directory entry
> + * @mode: access mode
> + * @name: path name
> + * @context: resulting security context
> + *
> + * Use at most one security module to get the initial
> + * security context. Do not use the "display".
> + *
> + * Returns -EOPNOTSUPP if not supplied by any module or the module result.
> + */
>   int security_dentry_init_security(struct dentry *dentry, int mode,
> -					const struct qstr *name, void **ctx,
> -					u32 *ctxlen)
> +				  const struct qstr *name,
> +				  struct lsmcontext *cp)
>   {
> -	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
> -				name, ctx, ctxlen);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
> +			     list) {
> +		cp->slot = hp->lsmid->slot;
> +		return hp->hook.dentry_init_security(dentry, mode, name,
> +						     (void **)&cp->context,
> +						     &cp->len);
> +	}
> +
> +	return -EOPNOTSUPP;
>   }
>   EXPORT_SYMBOL(security_dentry_init_security);
>   
> 

