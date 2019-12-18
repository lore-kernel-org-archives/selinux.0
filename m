Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67137C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345B32082E
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Zwg2hwrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfLRRlK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:41:10 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:11910 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRlK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 12:41:10 -0500
X-EEMSG-check-017: 37223547|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="37223547"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 17:41:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576690869; x=1608226869;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kYMnqSfxG44+/+4WCAGdGpL68SHnHE2CxWqVLRVzl/A=;
  b=Zwg2hwrfI1oO0nw6jjImvYk8gRbGqvDlBnxEZRckNMJoIiNPSq+A2px9
   2OJDA3EFEK8B6bfa6AQnNwl0oqNjLw31Cf9CYeFbfF6imiQP0bIBNoFWB
   NWvHlXeGF1VV/8w9RvEnoe0kqauYwWajeZ8Yk6zmh5crOv5Lh6AsIhY9d
   mDJifH7heJUFJlHVfbP7qKAQ3s7DMxtiakiI/ZL0FWZorntvWmlmMB4t0
   9Gra1flH5u0u85t3YSiNPKlqDVoxhVMLyh/XgJJQKkbUHBqQwyf+1AI0B
   NEgBhn+RPjVsqEnjgMpv+05ESR+ut15+sLuexfX+NcnvQ4C2RhCPaCSWM
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31244705"
IronPort-PHdr: =?us-ascii?q?9a23=3A0Q3QbRMvZKC42uwoJssl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/n7pMbcNUDSrc9gkEXOFd2Cra4d0KyM6/GrCD1IyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQnNssQajo9vJ6IswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcCsx+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsTWZouCMgxb0Hv5?=
 =?us-ascii?q?62ZDMKyJAgxx7DcfCHaI+I7xT+X+iSOTd1nG9pdb2wihqo8UWs1/fwWte73V?=
 =?us-ascii?q?pUtCZJj9/BvW0X2RPJ8MiIUP5981+k2TaIyg/c9PlJIVsxlarHM54hxaMwlo?=
 =?us-ascii?q?YLvUTDACD2nEL2gbeKdko+4Oio6vnnYq78qp+dMY90hAb+Mr8wlcOjG+g4Lg?=
 =?us-ascii?q?gPUHSb+eS7zrHj+1H2QK5WgfEsl6nZsZTaKdwapq6/HQBVzp4u5wuwAjqpyt?=
 =?us-ascii?q?gVnWQLIEhbdB+IkYTlIUzCLOj9DfilglSslDlrx+rBPr3kGpjNNWXMkKz6cL?=
 =?us-ascii?q?Zh609T1AozzddF65JSEbEOOuj/WkD2tNzGFhM5KRC7w/77CNVh0YMTQX6ADb?=
 =?us-ascii?q?WCMKzMsV6F/fkvLPWMZIAPpTb9Jfwl6OD0jXMghVASZ7Ol0ocQaHC9Bv5mOV?=
 =?us-ascii?q?mWYWLwgtcdFmcHphYxQ/bxiFKcUT9ffW2yUL485j4hFYKmA4PDSZ63gLGa3S?=
 =?us-ascii?q?e7GIFWaX5CClyWDXjocICEUe8WaC2OOs9hjiAEVb+5Ro8j0BGusxX6y6BmLu?=
 =?us-ascii?q?rP4SAYs4js1N1r6O3Sjx0y8iZ0D8uF2WGXU250hn8IRyMx3K1npUx9y1GD0b?=
 =?us-ascii?q?V3gvBBDtxc+e9GUhogNZ7d0+x7C8n+WgfGftiUVVamRsupDCovTtI+3dAOeV?=
 =?us-ascii?q?xxG9a8gRDZ2SqlHbsVm6aMBJwu/aLWx2LxKNply3bayKkhiEErQtBROm2ih6?=
 =?us-ascii?q?5/8RXTBoHSnkWHmKala74c0DTO9Gid12qOul9XUApqXaXCR3AfaVPcrc7l6U?=
 =?us-ascii?q?PaU7+uFbMnPxNCycGcNKRKccHmjVJBRPfgI9nRf2Kxm323BRaNx7OMcY/qd3?=
 =?us-ascii?q?8a3CXHB0gOixoT8mqeNQgiGiehpHrTDD5pFVLvZUPg6+t+qHS7TkAuyQGKdF?=
 =?us-ascii?q?Nu17yu9xEJn/OcTfQT3rQFuCg9sTp0GEyx0M7RC9qFvwBhZrlTYcsh4Fdb0m?=
 =?us-ascii?q?LUrxR9MYKmL6Btm14ecgJ3s1rt1xppEIVAl9YlrHcxwQpzMK6Y1FRBdy2G0p?=
 =?us-ascii?q?zqIb3YMGry/A21a6HMwF3e1siZ9r0N6PQgs1/jph2mFlI+83V71NlYy2Oc6Y?=
 =?us-ascii?q?/XDAoWSp/xSlw49wV+p73DZyk94ITU1WdyPqWurjDC3NcpV6MZzUOLdsxSIe?=
 =?us-ascii?q?u/Hw/7DsMeCtLmfOcjgFW4RgkPPOlP+qo5JYatfr2N36v9eK5rlSmrnCJc64?=
 =?us-ascii?q?B0z0yI+jBUS+jU0pJDyPadmkOFUjDmlla6msb+nI1FIzYIES73zSniGZ4Ufa?=
 =?us-ascii?q?B5YJwKFXbrJsq729Fzr4DiVmQe91O5AV4Cnsizdl7adFH53AtNxWwJrnG93y?=
 =?us-ascii?q?i11Tp5l3cutKXM8jbJxrHZaBcfOmNNDFJnhFPoLJn828sWR2C0fgMpk12j/k?=
 =?us-ascii?q?+8yK9F8vcsZ1LPSFtFKnClZ1ppVbG94//bOZ9C?=
X-IPAS-Result: =?us-ascii?q?A2DJAAC5Y/pd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF2gW0gEiqEBIkDhlkGgTeJapFFCQEBAQEBAQEBATcBAYRAAoI9OBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAgEjBBFBBQsLGAICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCXz+CUwUgrRd1fzOFT4M8gUGBDiiMMnmBB4ERJw+CLy4+hDWDJIJeB?=
 =?us-ascii?q?I1CiUxGlzWCP4JDk0oGG4JDmAuOToFGmxkigVgrCAIYCCEPgydQGA2NHheOQ?=
 =?us-ascii?q?SMDMIxtgkABAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 17:41:07 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIHedvl056741;
        Wed, 18 Dec 2019 12:40:39 -0500
Subject: Re: [PATCH v12 19/25] NET: Store LSM netlabel data in a lsmblob
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-20-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8c1d38e1-f589-4abf-f9f1-8c8f433e4ea6@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 12:41:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-20-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Netlabel uses LSM interfaces requiring an lsmblob and
> the internal storage is used to pass information between
> these interfaces, so change the internal data from a secid
> to a lsmblob. Update the netlabel interfaces and their
> callers to accommodate the change. This requires that the
> modules using netlabel use the lsm_id.slot to access the
> correct secid when using netlabel.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/net/netlabel.h              |  8 ++--
>   net/ipv4/cipso_ipv4.c               |  6 ++-
>   net/netlabel/netlabel_kapi.c        |  6 +--
>   net/netlabel/netlabel_unlabeled.c   | 57 +++++++++++------------------
>   net/netlabel/netlabel_unlabeled.h   |  2 +-
>   security/selinux/hooks.c            |  2 +-
>   security/selinux/include/security.h |  1 +
>   security/selinux/netlabel.c         |  2 +-
>   security/selinux/ss/services.c      |  4 +-
>   security/smack/smack.h              |  1 +
>   security/smack/smack_lsm.c          |  5 ++-
>   security/smack/smackfs.c            | 10 +++--
>   12 files changed, 50 insertions(+), 54 deletions(-)
> 

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 376882215919..8ee7a804423e 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1467,7 +1467,8 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
>   
>   	buffer[0] = CIPSO_V4_TAG_LOCAL;
>   	buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
> -	*(u32 *)&buffer[2] = secattr->attr.secid;
> +	/* only one netlabel user - the first */
> +	*(u32 *)&buffer[2] = secattr->attr.lsmblob.secid[0];
>   
>   	return CIPSO_V4_TAG_LOC_BLEN;
>   }
> @@ -1487,7 +1488,8 @@ static int cipso_v4_parsetag_loc(const struct cipso_v4_doi *doi_def,
>   				 const unsigned char *tag,
>   				 struct netlbl_lsm_secattr *secattr)
>   {
> -	secattr->attr.secid = *(u32 *)&tag[2];
> +	/* only one netlabel user - the first */
> +	secattr->attr.lsmblob.secid[0] = *(u32 *)&tag[2];
>   	secattr->flags |= NETLBL_SECATTR_SECID;
>   
>   	return 0;

Here we always use secid[0].

> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 6a94b31b5472..d8d7603ab14e 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -108,7 +108,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
>   		return NULL;
>   
>   	if ((secattr->flags & NETLBL_SECATTR_SECID) &&
> -	    (secattr->attr.secid == sid))
> +	    (secattr->attr.lsmblob.secid[selinux_lsmid.slot] == sid))
>   		return secattr;
>   
>   	return NULL;

And here we use secid[selinux_lsmid.slot].  So things will break in 
interesting ways if selinux_lsmid.slot is anything other than zero? 
What's the point of using this indirection in the security modules 
until/unless NetLabel truly supports something other than slot 0?

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index a5813c7629c1..2b7680903b6b 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3599,7 +3599,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>   	if (secattr->flags & NETLBL_SECATTR_CACHE)
>   		*sid = *(u32 *)secattr->cache->data;
>   	else if (secattr->flags & NETLBL_SECATTR_SECID)
> -		*sid = secattr->attr.secid;
> +		*sid = secattr->attr.lsmblob.secid[selinux_lsmid.slot];
>   	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
>   		rc = -EIDRM;
>   		ctx = sidtab_search(sidtab, SECINITSID_NETMSG);
> @@ -3672,7 +3672,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>   	if (secattr->domain == NULL)
>   		goto out;
>   
> -	secattr->attr.secid = sid;
> +	secattr->attr.lsmblob.secid[selinux_lsmid.slot] = sid;
>   	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
>   	mls_export_netlbl_lvl(policydb, ctx, secattr);
>   	rc = mls_export_netlbl_cat(policydb, ctx, secattr);

Ditto

