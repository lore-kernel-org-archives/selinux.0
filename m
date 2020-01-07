Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EC4C282DD
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 19:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BA820656
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 19:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="VmbDYFGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAGTXT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:23:19 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:49905 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGTXT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 14:23:19 -0500
X-EEMSG-check-017: 66879548|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="66879548"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2020 19:23:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578424997; x=1609960997;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/SOBgDLNUjpW8LvGtHHN70P8s0MEyboT6rR1qxVnFm4=;
  b=VmbDYFGT8p92lzJIlx9dYWqJjE5hjZ+GZHoOdBI4ezd3Mg/9ARyX3Lfj
   rr0ICIqa8qqq8FFCJKKEi8q6eTTRH9+890FHVNXfmuVG0Sh/W+cGVzryo
   ts0ozu6WpMjaA4cVRMzJuIndQ3eH5hF2rdv09kK3ge9qGuvqJosjhxS+w
   Oik8yVdt1+wK/A5JdfllvnrEIbbeaxVTabCmz4MZrv+rB1fQ15EeFIMcQ
   d0ftLXQHvc95+ZEf1+mNEeeDOgPy3/tcLJKaQ0XlIFs4rUTegi60l6h9a
   XOwWBV5/ZtlounnJC/+UPT/CbhVa15WvMftMurmDV9ZZTLwOugOg87EkI
   w==;
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="31690530"
IronPort-PHdr: =?us-ascii?q?9a23=3AaP/5jByI6nmkOfXXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u4RK/ad9pjvdHbS+e9qxAeQG9mCsLQe1rSd6/6ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBi2rAjdudUajIp/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwqV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbKpghwrA3lp?=
 =?us-ascii?q?oIr0vMAjX6mFn2jaCKdkUk/fKk6+L7bbX9upCQLYp0igD6Mqg2m8y/B/o3Mh?=
 =?us-ascii?q?QWUmSG9umx26fv8E3kTLlQkPE7nbfVvIrHKcgDo662GQ5V0oIt6xalCDem1c?=
 =?us-ascii?q?wVnWIaI1JeYx+Hk4joNE3OIPD/F/u/hU+sny1xy/DJOb3hHI3BLmLfn7f5Yb?=
 =?us-ascii?q?Z990lcxRIvwt9F/JJbFLEALenoWkDttNzXFAI5MwKww+n5EtVxz58RVniVDq?=
 =?us-ascii?q?CFN6PStEeC5vgzLOmUeI8VpDH9JuA56PH0ln82h18ccbOy3ZQLaHC3BOlmI0?=
 =?us-ascii?q?udYXXymNcMCmYKvgwiTOP0jF2OSyJcZ3G3X6gk/DE0FJqmDZvfRoCqmLGB3i?=
 =?us-ascii?q?K7HppMZmBcC1CMCmzld4OeVPcJdi2SI9VtkjseVbiuU4Uhzw2htBfmy7p7Ke?=
 =?us-ascii?q?rZ4ikYtZPl1Nho6OzfjAoy+iJoAMSAyWGNTn10n2MRSz8z26BwvFF9ylOd3q?=
 =?us-ascii?q?VjnfxYGsJc5+lTXgc5K5Hc1ep6BM72Wg7bedeJUlmmSM28AT4tVtIx38MOY0?=
 =?us-ascii?q?FlFtW5kB/D2yuqA7kIl72EH5E07K3c0GbrJ8pnyHbJyrMhj184TctLL2Gmgb?=
 =?us-ascii?q?R/9wfLDY7Tj0qZj7qqdbgb3CPV92eM03SBvFpEXw53VqXFXmsSaVfWrdTj4U?=
 =?us-ascii?q?PCSr6uCakiMgdbzs6CMKRKYMXzjVpaXPfjJMjeY2WplmeyAhaIxrWMYJDoe2?=
 =?us-ascii?q?Ua3CXSEk4EkxsN8naALgUxGj2uo2TZDDxoFFLgf1nj8e1kpHynSU80yhmAb1?=
 =?us-ascii?q?d92Lqt5h4VmfucRusL3r0avichpCh0HFe7397PCNqPuRBhfKNCbtM5+1pH1H?=
 =?us-ascii?q?vVtwh6Ppy+Ma9unEUefB50v0PzzRV4EJ9Mkc40o38wzgpyMbqS0EldeDOAwZ?=
 =?us-ascii?q?DwJrrXJ3Hq/B+1dq7W3krT0M6M9acS7PQ0slDjvAauFko47XprycVa03yZ5s?=
 =?us-ascii?q?aCMA1HepvqX1d/zBN6rqzUZiQnr9ff3GZhIIGvuT/LxtwtCfFgwR/mdNBaZu?=
 =?us-ascii?q?fMHwbpHtxcHMOuIfEkn1WzRhMCIO1WsqUzOofudf6BwrSqJ85mlTerjCJA+o?=
 =?us-ascii?q?85mkaN8TdsD/XF1Isfwu2Jmw6AWyr4gX+/vc3t34NJfzcfGiy40yegTJVcYq?=
 =?us-ascii?q?x0YJYjF2ijOYu0y894ipqrXGRXp3C5AFZT49OkYRqfaRTG2ARU0UkG6Si8lT?=
 =?us-ascii?q?CQ0y1/kzZvqLGWmiPJ3bKxJ1I8JmdXSTw63h/XKo+ugoVfBRP5Yg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CcAwCu2RRe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXyBf?=
 =?us-ascii?q?YFtIBIqhAmJA4ZtBoESJYluiiSHJAkBAQEBAQEBAQE3AQGEQAKCDTgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIwQRQQULCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/glMFIKwldX8zhU+DLYE9gQ4ojDN5gQeBEScMA4JdPoQzgyaCXgSNS?=
 =?us-ascii?q?YlQRogajyaCQIJFk1EGG5pfLY4mnHIigVgrCAIYCCEPgydQGA2NHheOQSMDM?=
 =?us-ascii?q?I5dAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Jan 2020 19:23:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 007JMYvQ227728;
        Tue, 7 Jan 2020 14:22:36 -0500
Subject: Re: [PATCH v13 16/25] LSM: Use lsmcontext in
 security_dentry_init_security
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-17-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2fd11d2b-b676-8111-6b9f-bd86ed4d651a@tycho.nsa.gov>
Date:   Tue, 7 Jan 2020 14:23:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191224235939.7483-17-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/24/19 6:59 PM, Casey Schaufler wrote:
> Change the security_dentry_init_security() interface to
> fill an lsmcontext structure instead of a void * data area
> and a length. The lone caller of this interface is NFS4,
> which may make copies of the data using its own mechanisms.
> A rework of the nfs4 code to use the lsmcontext properly
> is a significant project. SELinux is handled correctly, and
> is the only current user.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   fs/nfs/nfs4proc.c        | 15 ++++++++-------
>   include/linux/security.h |  7 +++----
>   security/security.c      | 29 +++++++++++++++++++++++++----
>   3 files changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index a30e36654c57..6cd2463f890b 100644
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
> @@ -121,21 +122,21 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>   		return NULL;
>   
>   	err = security_dentry_init_security(dentry, sattr->ia_mode,
> -				&dentry->d_name, (void **)&label->label, &label->len);
> +					    &dentry->d_name, &context);
> +
> +	label->label = context.context;
> +	label->len = context.len;

No point in setting label->label/len if err != 0.

> +
>   	if (err == 0)
>   		return label;
>   
>   	return NULL;
> +
>   }

Leftover empty line.

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

Not sure why you don't just leave the scaffolding here?
