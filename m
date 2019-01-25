Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216D6C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 13:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28A920881
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 13:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="l6sYJQ37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAYNtK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:49:10 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:14923 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfAYNtK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 08:49:10 -0500
X-EEMSG-check-017: 679531848|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,521,1539648000"; 
   d="scan'208";a="679531848"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Jan 2019 13:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548424148; x=1579960148;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Gpq+Y+SMJvarovUDipm7LUYacyaVH+AO57K6Te43E8w=;
  b=l6sYJQ37aUgMTEjBBBl3kuOBq+lbgX4enAWSbMJ1flMiPaC85w4wQAz1
   lXqItBdOzhHpio7JTlNn69oxNH728ceWyJdcTXHJc7RLjvXw6WQ0a/j1O
   AtHMxtxalkgBGhINPAuxvpkcsAVpTv80CI6cmLu740RYb/D16mpKnzBjf
   jgG65FRIxDrYmFriT1o4WeCnqhB+cH8wILyo2AurfKD/uBphT7srKlooJ
   ObKPHiG1btsc4mff5Ne3xex/1WFJ25Xjzin235Y2BgJxYrTJ7HQq1k8Y8
   0lZ2JSdGkQZOCvPwogV6aD+5FBYKlPU+z6kknQPbQQZAawY7Ip+is6vmV
   w==;
X-IronPort-AV: E=Sophos;i="5.56,521,1539648000"; 
   d="scan'208";a="19855651"
IronPort-PHdr: =?us-ascii?q?9a23=3Aj47KfxOUMROYAaD83Q4l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z5osbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnWttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZq43VJd8Aq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiDBrx/XBPr36BJXCNGTMn6n6cL?=
 =?us-ascii?q?Zn9UFT1QozwspD555OFr4BJ/fzUFfrtNPEFh85LxC0w+H/BdVmyIweXWOPAq?=
 =?us-ascii?q?mEMKLdqlKI+O0vLPeWZIMPuzbyNeIl5/jwgn89g1MderOp3ZQPYnCiAvtmO1?=
 =?us-ascii?q?mZYWbrgtoZCWcFpBc+TOjxhV2aSzFTenKyU7s55jE8D4KmF5nMSpqxj7yG2S?=
 =?us-ascii?q?exBodWaXxeClCQDXfocJ2JW/MNaCKUP89gnSUIWqK8S4A81BGuqBT3y6B5Ie?=
 =?us-ascii?q?XJ+i0Xr47j2MJp6O3UkBFhvQBzWuOb33uATSlRmXgOTjQ73+grpkl60VGK2q?=
 =?us-ascii?q?VQmfFUFdVPofhOV1F+fYXRy+18FsDaRA3MZJGKRUygT9HgBis+CpoJysIKK2?=
 =?us-ascii?q?N6HM+vxkTb1jeuK6ccirjOAZsz6K+a1H/0cZVT0XHDgZI9gkEmT80HDmivgq?=
 =?us-ascii?q?py5kCHHILSu1mInKatM6IH1WjC83nVnjnGh11RTAMlCfaNZnsYfEaD6I2jvk?=
 =?us-ascii?q?4=3D?=
X-IPAS-Result: =?us-ascii?q?A2AkAQD/Ektc/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?YE3ATInhAGUEUwBAQEBAQEGgQgIJYk0kE44AYRAAoMIIjgSAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjopAYJmAQEBAQIBIwQRQRALDgoCAiYCAlcGAQwGAgEBgl8/gXUFCKslf?=
 =?us-ascii?q?DOFQ4RtgQuLNhd4gQeBOAyCX4gKglcCiVcLhno5VpBNCY4zg3EGGIIQkBcti?=
 =?us-ascii?q?WaTDyGBVisIAhgIIQ+DJ4InF448IQMwgQUBAYonAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 25 Jan 2019 13:49:08 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0PDn7Mc024603;
        Fri, 25 Jan 2019 08:49:07 -0500
Subject: Re: [PATCH v3 3/4] selinux: remove some useless BUG_ONs
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com
References: <20190125100651.21753-1-omosnace@redhat.com>
 <20190125100651.21753-4-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0e0ce852-12ab-4855-7794-c1744160e78e@tycho.nsa.gov>
Date:   Fri, 25 Jan 2019 08:52:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125100651.21753-4-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/25/19 5:06 AM, Ondrej Mosnacek wrote:
> These BUG_ONs do not really protect from any catastrophic situation so
> there is no need to have them there.

They are to catch bugs in callers that pass requested==0.  That is 
always indicative of a bug in the caller (e.g. failed to correctly 
compute the permissions).  Otherwise, we will silently allow such calls 
and not notice them.

At the least, they should be WARN_ONs.

> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/avc.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 5ebad47391c9..478fa4213c25 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1044,7 +1044,6 @@ int avc_has_extended_perms(struct selinux_state *state,
>   	int rc = 0, rc2;
>   
>   	xp_node = &local_xp_node;
> -	BUG_ON(!requested);
>   
>   	rcu_read_lock();
>   
> @@ -1134,8 +1133,6 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
>   	int rc = 0;
>   	u32 denied;
>   
> -	BUG_ON(!requested);
> -
>   	rcu_read_lock();
>   
>   	node = avc_lookup(state->avc, ssid, tsid, tclass);
> 

