Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58005C43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C2F206B7
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 14:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DKHqbIKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfAIOg2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:36:28 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:3774 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfAIOg2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 09:36:28 -0500
X-EEMSG-check-017: 632260570|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,457,1539648000"; 
   d="scan'208";a="632260570"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2019 14:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547044414; x=1578580414;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=D13ZL2WmNePjvRusnWZ0rQF5cwusA9KAGwk6w1Lx8jc=;
  b=DKHqbIKp0wktzUSzt0xFdEqpFLWkRK2ZvYT3Uha8kPMY4leUZssw6vNY
   /q7TSBcVPfEeCta1ExItKZ0hPWZhsv7i0mai8dDivl7DXA8l2vi8oqS89
   Hi2It15aP8UrxnHObfhUAxfixjpbr/2rHvq5V7AW+AhaoBB8tdFKI6ep/
   EU+4KmQBE0P1uwX4pWQi+cV1shvowF/Ga9XK+5M6SvAs4/EVBeToEAfO6
   /iA6u24leasTynums2jBmrz7jjyNOKjigYogybwOWw/YDP/505lk0Bk7n
   +rLRu7lakIfhQrVhryaLvEU3LMuv0/unecxF7x3aUdR+Vp4dI/6UX3smH
   w==;
X-IronPort-AV: E=Sophos;i="5.56,457,1539648000"; 
   d="scan'208";a="19357281"
IronPort-PHdr: =?us-ascii?q?9a23=3A54bqKhabHcxV7TWVGeX4EJb/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps+6ZR7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI/pUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBetDmaOpNrTs4tTGxkoiY3xqActZ?=
 =?us-ascii?q?KlcyUG1o4rywPZZveaaYaH+AjjW/yUITpggXJlf6+wiAiq/Ei7z+38StG00F?=
 =?us-ascii?q?FXripZitXMtm4C1xjU6sWfVvty5F2h2TeS1wDI8O1EPUA1mrbbK54m2LIwkI?=
 =?us-ascii?q?YcsV/fESPsnUX2jauWel0l+uiu9evnfq3rqoKTOoJ7kA3zMrkiltahDek3LA?=
 =?us-ascii?q?QCRXWX9fy51LL5/E35RLtKjucxkqncqJ3aPtkUprWiDg9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QehnkINkhJeB2Aj4j3I13OOuz3De+jg1Swlzdm3/fGPrjmApXWKHjMiqvucq?=
 =?us-ascii?q?hm5k5G1gU80NBf6IhICr0bPP3zXUrxvsTCDhAlKwy03/rnCNJl24MFR22PBq?=
 =?us-ascii?q?6ZMKXPsV6H/e8vPeaMa5EPuDrnKPgq+eTujXknll8ZZ6Wp2oEXaH+gFPR8P0?=
 =?us-ascii?q?qZeWbsgssGEWoSpgoxVvHqiFmZXD5LfXmyQqY86ig+CIKhCofDXJ6ijKad0y?=
 =?us-ascii?q?e8G51cfnpGBUyUEXf0a4WEXO8BaCaTIs9njzwFWqGtS5Q/2h6yqQ/60btnLv?=
 =?us-ascii?q?bU+yEBsJLj08V65/DXlR4s7jF0Ecud3H+XT21unWMHWSU23KZhrkx50FuD1r?=
 =?us-ascii?q?J4g/NAH9xJ+/xJShs6NYLbz+FiBNDyQBzOftiKSFamWdimBTAxTtQsw94BbU?=
 =?us-ascii?q?Z9HMiijhbe0CWwH78VlruLBJou/qLbxXjxKN53y2za26k5k1kmXsxPOHW6hq?=
 =?us-ascii?q?597AXTBJDGk1+fl6m0caQQxinN9H2MzWCWpkFXTBZwUbnZXXAYfkbWqdX55k?=
 =?us-ascii?q?XfT76hELgnPBBBxtOcJatUdNLpiU5LROnsONvAeWK9gWSwCgiSxrOKcoXqf3?=
 =?us-ascii?q?8R3CLHCEgLiwoT52qJNRAiBie9pGLTFCBhFV31Y0Pr7Ol+sGi7Q1QqzwGFcU?=
 =?us-ascii?q?JhzaC5+h0LivyGTfMcwLYEtD0mqzVuE1bul+7RXv2GqxBsfu15Zsg76VxK1i?=
 =?us-ascii?q?qNsAl6JZqpJK1KnFMScw1r+Ujp0kMzQp5NlckssWMC0gV/M+Sb3UlHejfe2o?=
 =?us-ascii?q?r/fvXvI3T2tDWobLTbkgXG2cuS0r8G9fB9rlLkpgzvHU0npSZJyd5QhkCA64?=
 =?us-ascii?q?3KAQxaapf4VkI65lAuvL3BSjUs7IPTk3t3OO+7tSGUiIFhP/cs1hv1J4QXC6?=
 =?us-ascii?q?iDDgKnVpRAX8U=3D?=
X-IPAS-Result: =?us-ascii?q?A2AoAwA1BTZc/wHyM5BjHAEBAQQBAQcEAQGBZYFbKYFoJ?=
 =?us-ascii?q?4QAlARMAQEBAQEBBoEICCWJLJBBOAGEQAKCHyI4EgEDAQEBAQEBAgFsKII6K?=
 =?us-ascii?q?QGCZwEFIxVBEAsOCgICJgICVwYBDAYCAQGCXz+BdQ2qeYEvhUGEd4ELizQXe?=
 =?us-ascii?q?IEHgTgMgjEuiAqCVwKPcEk3kHwJkXcGAhaRd4lskkQhgVYrCAIYCCEPgyeCJ?=
 =?us-ascii?q?xeOPCEDMIEFAQGKLQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jan 2019 14:33:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x09EXU3c003673;
        Wed, 9 Jan 2019 09:33:32 -0500
Subject: Re: [PATCH 1/3] LSM: Add new hook for generic node initialization
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190109091028.24485-1-omosnace@redhat.com>
 <20190109091028.24485-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <34700932-359e-5b01-565c-0816dd4a1940@tycho.nsa.gov>
Date:   Wed, 9 Jan 2019 09:35:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109091028.24485-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/19 4:10 AM, Ondrej Mosnacek wrote:
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
>   include/linux/lsm_hooks.h |  5 +++++
>   include/linux/security.h  | 12 ++++++++++++
>   security/security.c       |  8 ++++++++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index aaeb7fa24dc4..f2b4c0bf4a7b 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1556,6 +1556,10 @@ union security_list_options {
>   	int (*inode_copy_up)(struct dentry *src, struct cred **new);
>   	int (*inode_copy_up_xattr)(const char *name);
>   
> +	int (*object_init_security)(void *parent_ctx, u32 parent_ctxlen,
> +				    const struct qstr *qstr, u16 mode,
> +				    void **ctx, u32 *ctxlen);

You'll want to add a kerneldoc comment for the new hook; see the 
existing ones for the other hooks at the top of lsm_hooks.h.

> +
>   	int (*file_permission)(struct file *file, int mask);
>   	int (*file_alloc_security)(struct file *file);
>   	void (*file_free_security)(struct file *file);
> @@ -1855,6 +1859,7 @@ struct security_hook_heads {
>   	struct hlist_head inode_getsecid;
>   	struct hlist_head inode_copy_up;
>   	struct hlist_head inode_copy_up_xattr;
> +	struct hlist_head object_init_security;
>   	struct hlist_head file_permission;
>   	struct hlist_head file_alloc_security;
>   	struct hlist_head file_free_security;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d170a5b031f3..e20d1f378ea4 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -315,6 +315,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
>   void security_inode_getsecid(struct inode *inode, u32 *secid);
>   int security_inode_copy_up(struct dentry *src, struct cred **new);
>   int security_inode_copy_up_xattr(const char *name);
> +int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
> +				  const struct qstr *qstr, u16 mode,
> +				  void **ctx, u32 *ctxlen);
>   int security_file_permission(struct file *file, int mask);
>   int security_file_alloc(struct file *file);
>   void security_file_free(struct file *file);
> @@ -815,6 +818,15 @@ static inline int security_inode_copy_up_xattr(const char *name)
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline int security_object_init_security(void *parent_ctx,
> +						u32 parent_ctxlen,
> +						const struct qstr *qstr,
> +						u16 mode, void **ctx,
> +						u32 *ctxlen)
> +{
> +	return 0;
> +}
> +
>   static inline int security_file_permission(struct file *file, int mask)
>   {
>   	return 0;
> diff --git a/security/security.c b/security/security.c
> index 04d173eb93f6..56e77368b87f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -879,6 +879,14 @@ int security_inode_copy_up_xattr(const char *name)
>   }
>   EXPORT_SYMBOL(security_inode_copy_up_xattr);
>   
> +int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
> +				  const struct qstr *qstr, u16 mode,
> +				  void **ctx, u32 *ctxlen)
> +{
> +	return call_int_hook(object_init_security, 0, parent_ctx, parent_ctxlen,
> +			     qstr, mode, ctx, ctxlen);
> +}
> +
>   int security_file_permission(struct file *file, int mask)
>   {
>   	int ret;
> 

