Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FD4C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF39206D8
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UdnX9fe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLQRg4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:36:56 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:47086 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfLQRg4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 12:36:56 -0500
X-EEMSG-check-017: 61573599|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="61573599"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 17:36:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576604214; x=1608140214;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=P6o0ucg7c+mkA1PEwdV4Vqi3C8wSmkNeeM2Bjfovxjs=;
  b=UdnX9fe5ciW0VkQif3E/e0qZbE4u3VAUzYwVu7dZuUNzcDe7EadAAcpU
   uEx1Xqun1PPhy5ifG79eaDahL1Dian1zPGDLc5ovaTDVbQTjqQCb5ELz3
   6cZYo2k/GRLsKjBR4RA6PPeVwgHNyIHb1DBski1+IXun+77hufMdo9zl2
   FhLs48fmV1CrjegRMTaSZkYOXStkAp1VBiWRMMGlm1hEFdX4k/SPiw5+x
   nYIH6b7Zbl7ct8t1uzIhBCwg8hwUBcBCdeop0+Qx6pUGBUSQZCt2LPvDN
   AQDHZGgfiFznnTOL//EkxCKk8vyexD+BsqD9qjzbwaTJHe89QIWPOAMs2
   A==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31196569"
IronPort-PHdr: =?us-ascii?q?9a23=3ATg00uBWdkHPI+McvsQSFq6213wfV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRCAvKdThVPEFb/W9+hDw7KP9fy5AipaucnK4SBKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMIjYd+KKs9xR?=
 =?us-ascii?q?/Er3hVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWgGufixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00yaUGtI?=
 =?us-ascii?q?amcCUFx5kr3R7SZ+Gdf4SW7R/vSvydLSp+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcPUA7j7DbK588wr4rjJ?=
 =?us-ascii?q?YTsELDHiHxmEXtkqCZal8o+vSo6uv7YrXmoYWQN4lohQHlLqsigMm/AeU8Mg?=
 =?us-ascii?q?QWXmib//qz1KH78EHkT7hHgec6n6nEvJzAO8gWqbC1DxVI3oo77hawFTam0N?=
 =?us-ascii?q?AWnXkdK1JFfQqKj5P0NFHVO/34Efe+jEiskDds3fzGOKbhDY/XInjMl7fhY6?=
 =?us-ascii?q?5x61RAxwor0dBf+5VUB6kdL/3pQU/+qtzZAwQiMwOow+boEsh91o0aWW2RGK?=
 =?us-ascii?q?+VKb/dvkWS6u0zJOmMYZcfuCzhJPg9+/7ukXg5lEcBcqazxpsYdnC5Eu59I0?=
 =?us-ascii?q?qFYXrjmMoBEWkOvgUgVuznk1yCUThPZ3msW6Iw/C00CIWjDY3bXICinKSB3D?=
 =?us-ascii?q?unHp1Rfm1GCFWMEXDyd4WeWvcMczmfIsl7nTwBS7ehSpUt1Ra0tA/107BnNP?=
 =?us-ascii?q?bb+jUEtZL/09h4/+nTlRA09TxpAMWRynqNQH9okWMVXT823bx/oExkxleG1q?=
 =?us-ascii?q?h3nuFYFdhN6P5STAc6OoDTz/ZgB9DxRA3BZNGJR0iiQtm8BjExVN0xyccUY0?=
 =?us-ascii?q?lhA9WikgzD3y2yDr8OibOLAJ008qTB33n+PMt91XnG27c7j1U8QctAK3emhq?=
 =?us-ascii?q?hh+AjXHYLJlF+Zl6myf6QGwCHN7HuDzXaJvExAUw5/T7vKXWsDaUvRqtT55V?=
 =?us-ascii?q?jPQKOuCbQ9NQtBzM+CKrZPatHzilVGXvjjMszEY22tg2ewGQqIxrSUYYrofG?=
 =?us-ascii?q?Ud3CPdBFIGkwAU/XaJLw4+Bjy/rGLYFzFhCUjgY0Xr8el4qXO0UlU7zwWQY0?=
 =?us-ascii?q?J90Lq1/wYfheaARPMLwrIEpCAhpi1sHFmj2dLWBMeApwtnfKlFYtMy/k1H1W?=
 =?us-ascii?q?THuAx5JZGgLrluhloZcwRpoUzizQ53BZ9Dkcg3tnMl1hB+KaSG319bdTOYxY?=
 =?us-ascii?q?j6OqfLJWnq4BCvd6nW10nG0NmM56cP7O81q035swG0Ekou6nBn095S03uG+J?=
 =?us-ascii?q?rGFhYdUZX0UhV/yx8vjLjBbzh13IjU3GBiNaSu+mvJ0skkFcM+wRapYtlbPb?=
 =?us-ascii?q?nBHwa0GMofUYzmI+UxlknvdRkENf1c8KMuF8Kga/aCnqWsOaIonjehl35G+6?=
 =?us-ascii?q?h720eB9mx7UOGMl5IExeyImxCKXCrmjUuw98XwlZ1AaBkMEWeljyvpHohcYu?=
 =?us-ascii?q?t1Z4lPQXyjJ8yx28VWmZHgQThb+USlCldA39WmKjSIaFmo5hFdzUQapzScnC?=
 =?us-ascii?q?K8yzFl22UyorG3wD3Fw+OkcgEOfGFMWj8x3h/XPYGogoVCDwCTZA8zmU7gvB?=
 =?us-ascii?q?yryg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BNAAAoEfld/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQEiQOGdAQGgTeJaooihyMJAQEBAQEBAQEBNwEBh?=
 =?us-ascii?q?EACgjw4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQRALGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+CUyWuN38zhU+DPoFIgQ4ojDJ5gQeBOA+CXT6HWYJeBJcMR?=
 =?us-ascii?q?pczgj6CQpNIBhuaSS2OIJxeIoFYKwgCGAghDzuCbFARFI0eF45BIwMwkgABA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 17:36:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHHaYNZ142362;
        Tue, 17 Dec 2019 12:36:34 -0500
Subject: Re: [PATCH v12 04/25] LSM: Use lsmblob in security_kernel_act_as
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-5-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b1cfbe56-b752-99d4-55d6-8a1c5b642d65@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 12:37:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change the security_kernel_act_as interface to use a lsmblob
> structure in place of the single u32 secid in support of
> module stacking. Change its only caller, set_security_override,
> to do the same. Change that one's only caller,
> set_security_override_from_ctx, to call it with the new
> parameter type.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Same question re the WARN_ON, but otherwise:

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   include/linux/cred.h     |  3 ++-
>   include/linux/security.h |  5 +++--
>   kernel/cred.c            | 10 ++++++----
>   security/security.c      | 14 ++++++++++++--
>   4 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 18639c069263..03ae0182cba6 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -18,6 +18,7 @@
>   
>   struct cred;
>   struct inode;
> +struct lsmblob;
>   
>   /*
>    * COW Supplementary groups list
> @@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
>   extern void revert_creds(const struct cred *);
>   extern struct cred *prepare_kernel_cred(struct task_struct *);
>   extern int change_create_files_as(struct cred *, struct inode *);
> -extern int set_security_override(struct cred *, u32);
> +extern int set_security_override(struct cred *, struct lsmblob *);
>   extern int set_security_override_from_ctx(struct cred *, const char *);
>   extern int set_create_files_as(struct cred *, struct inode *);
>   extern int cred_fscmp(const struct cred *, const struct cred *);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 9c6dbe248eaf..322ed9622819 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -437,7 +437,7 @@ void security_cred_free(struct cred *cred);
>   int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
>   void security_transfer_creds(struct cred *new, const struct cred *old);
>   void security_cred_getsecid(const struct cred *c, u32 *secid);
> -int security_kernel_act_as(struct cred *new, u32 secid);
> +int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
>   int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>   int security_kernel_module_request(char *kmod_name);
>   int security_kernel_load_data(enum kernel_load_data_id id);
> @@ -1043,7 +1043,8 @@ static inline void security_transfer_creds(struct cred *new,
>   {
>   }
>   
> -static inline int security_kernel_act_as(struct cred *cred, u32 secid)
> +static inline int security_kernel_act_as(struct cred *cred,
> +					 struct lsmblob *blob)
>   {
>   	return 0;
>   }
> diff --git a/kernel/cred.c b/kernel/cred.c
> index c0a4c12d38b2..846ac4b23c16 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -732,14 +732,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
>   /**
>    * set_security_override - Set the security ID in a set of credentials
>    * @new: The credentials to alter
> - * @secid: The LSM security ID to set
> + * @blob: The LSM security information to set
>    *
>    * Set the LSM security ID in a set of credentials so that the subjective
>    * security is overridden when an alternative set of credentials is used.
>    */
> -int set_security_override(struct cred *new, u32 secid)
> +int set_security_override(struct cred *new, struct lsmblob *blob)
>   {
> -	return security_kernel_act_as(new, secid);
> +	return security_kernel_act_as(new, blob);
>   }
>   EXPORT_SYMBOL(set_security_override);
>   
> @@ -755,6 +755,7 @@ EXPORT_SYMBOL(set_security_override);
>    */
>   int set_security_override_from_ctx(struct cred *new, const char *secctx)
>   {
> +	struct lsmblob blob;
>   	u32 secid;
>   	int ret;
>   
> @@ -762,7 +763,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
>   	if (ret < 0)
>   		return ret;
>   
> -	return set_security_override(new, secid);
> +	lsmblob_init(&blob, secid);
> +	return set_security_override(new, &blob);
>   }
>   EXPORT_SYMBOL(set_security_override_from_ctx);
>   
> diff --git a/security/security.c b/security/security.c
> index bfea9739c084..cee032b5ce29 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1615,9 +1615,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
>   }
>   EXPORT_SYMBOL(security_cred_getsecid);
>   
> -int security_kernel_act_as(struct cred *new, u32 secid)
> +int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
>   {
> -	return call_int_hook(kernel_act_as, 0, new, secid);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>   }
>   
>   int security_kernel_create_files_as(struct cred *new, struct inode *inode)
> 

