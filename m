Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB82C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B4724672
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 15:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="iv+5NxPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfLQPwC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:52:02 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:38963 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfLQPwB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 10:52:01 -0500
X-EEMSG-check-017: 38997785|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="38997785"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 15:51:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576597917; x=1608133917;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FZ9CJNCPffc3dUlPkp4uywiya8xibHLqTGvvrNXjRkA=;
  b=iv+5NxPh8pW1p0fMtIX+e7h6Y+ATsk6LUK+uyfpn3xgwX8AXUTBYImKX
   v8XosLwUnPpJdtlxVr0GEfnlJMtEvxEWZrp/HAqmiWtiTLgjYol/8xCa+
   LU0YZqvnSHh+ZwxRXhhG5Ms24dqZBXwY9rBDEVrzljeSRIvk+Y7Sj8JVo
   8jc1m689DCu6IMqectvBNsxeILXbwXUdMZUgUixPwvjoyjpSfXQTr6/tI
   c3n/HANPdVozG4BMEYCnsBXRiVXSKhZ0AqlJpMrEQKvw6xeORfBN5Kxiz
   x5fmBP02+bTfkS2hM2hz2e1OYZ2INMETJKvm947semxx9d5u0/P3JWxs8
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31187580"
IronPort-PHdr: =?us-ascii?q?9a23=3AQfee/R8OCt4TNf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+weIJqq85mqBkHD//Il1AaPAdyAragc1KGJ4ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe61+IAm0oAnetMQbhZZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumaraLZ4hzLkwlo?=
 =?us-ascii?q?ENvkvfBCP2hEX3g7OWdkUj4OSo7fjoYq76qZOGMo90iwX+Prwvmsy5H+s4Lh?=
 =?us-ascii?q?ADU3WU9OmzzrHu/VD1TK9UgvA5jKXVqo3WKdwepqGjAg9V1ogj6wy4DzejyN?=
 =?us-ascii?q?kYhmQILEledRKbj4nmJ1HOIPfiAfe5mFSjii1nx//BPr3/GpnNNGTMkK/9fb?=
 =?us-ascii?q?Zh7E5R0BAzzcte551JF74BJ/DzWk7qudPECR82LhK7zPz6CNVn0YMeQ3iADr?=
 =?us-ascii?q?WeMKPIvl+C/vgvLPWUZI8JpDb9LOAo5+Xwgn89mF8de7Sp3JQMZXCmEfRpPV?=
 =?us-ascii?q?+ZbWDvgtgfC2cKuBQxTOjwhF2FSz5TaG64X7gg6TEjFIKmEYDDS5i1gLObwS?=
 =?us-ascii?q?e7GoZbZnhcBVCRFXfkboCEW/ALaCKIPMBtiCALVb+kS4U5zxGhqBf6y6Z7Lu?=
 =?us-ascii?q?rT4iAYsZPj1N5o5+zcjB0y7iJ7ANiA02GXTmF0gmMJSyYz3KB4vEN911OD3r?=
 =?us-ascii?q?ZjjvxGGtxc+elJXh05NZHC1ex6Dc79WgbbcteOUlamTYbuPTZkdNsvwpctfk?=
 =?us-ascii?q?N0AZ2ZjxzP2CirDLYPlvTfHoc1/q7b3XnZLMFxxn/bzq47hh8hWMQZcSW9i6?=
 =?us-ascii?q?p+8RXDL5DGnl/flKuwc6kYminX+zSt122L6XpEXRZwXKONZnUWYk/bvJyt/U?=
 =?us-ascii?q?/ZZ6O/ArQgdA1awIiNLbUcOY6htklPWPq2YIeWWGm2gWrlQE/Tl74=3D?=
X-IPAS-Result: =?us-ascii?q?A2B+AgCA+Phd/wHyM5BdCBwBAQEBAQcBAREBBAQBAYF+g?=
 =?us-ascii?q?XSBGFUgEiqEBIkDhnMEBoE3iWqPXoFnCQEBAQEBAQEBASMUAQGEQAKCPDgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIU3DII7KQGCegEFIwQRQRALGAICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz8BglIlrhF/M4VPg0KBSIEOKIwyeYEHgREnD4JdPoQSEg6DJ4JeBJcMR?=
 =?us-ascii?q?pczgj6CQoRtjlsGG4JDdIcCkBAtjiCBRpsYIoFYKwgCGAghD4MnCUcRFJNbi?=
 =?us-ascii?q?BsjAzCPP4JBAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 15:51:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHFpXaT093896;
        Tue, 17 Dec 2019 10:51:35 -0500
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
 <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
 <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
 <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov>
 <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
 <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com>
 <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov>
 <001e01d5b4f0$495efbd0$dc1cf370$@codeaurora.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <21b5511a-fdba-3c2f-e9a6-efdc890b5881@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 10:52:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <001e01d5b4f0$495efbd0$dc1cf370$@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/17/19 10:40 AM, Ravi Kumar Siddojigari wrote:
> Yes  indeed this is a stress test on ARM64 device with multicore  where most of the cores /tasks are stuck  in avc_reclaim_node .
> We still see this issue even after picking the earlier patch " selinux: ensure we cleanup the internal AVC counters on error in avc_insert() commit: d8db60cb23e4"
> Where selinux_state  during issue was as below where all the slots are  NULL and the count was more than threshold.
> Which seem to be calling avc_reclaim_node always and as the all the slots are empty its going for full for- loop with locks and unlock and taking too long .
> Not sure what could make the  slots null , for sure its not due to flush() /Reset(). We think that still we need to call  avc_kill_node  in update_node function .
> Adding the patch below can you please review or correct the following patch .
> 
> 
>    selinux_state = (
>      disabled = FALSE,
>      enforcing = TRUE,
>      checkreqprot = FALSE,
>      initialized = TRUE,
>      policycap = (TRUE, TRUE, TRUE, FALSE, FALSE, TRUE),
>      avc = 0xFFFFFF9BEFF1E890 -> (
>        avc_cache_threshold = 512,  /* <<<<<not configured and its with default*/
>        avc_cache = (
>          slots = ((first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first   /*<<<< all are NULL */
>          slots_lock = ((rlock = (raw_lock = (val = (counter = 0), locked = 0, pending = 0, locked_pending = 0, tail = 0), magic = 3735899821, owner_cpu = 4294967295, owner = 0xFFFFFFFFFFFFFFFF, dep_map = (key = 0xFFFFFF9BEFF298A8, cla
>          lru_hint = (counter = 616831529),
>          active_nodes = (counter = 547),   /*<<<<< increased more than 512*/
>          latest_notif = 1)),
>      ss = 0xFFFFFF9BEFF2E578)
> 
> 
> --
> In AVC update we don't call avc_node_kill() when avc_xperms_populate()
> fails, resulting in the avc->avc_cache.active_nodes counter having a
> false value.In last patch this changes was missed , so correcting it.
> 
> Change-Id: Ic0298162cc766c0f21be7ab232e259766654dad3
> Signed-off-by: Jaihind Yadav<jaihindyadav@codeaurora.org>
> ---
>   security/selinux/avc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 91d24c2..3d1cff2 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -913,7 +913,7 @@ static int avc_update_node(struct selinux_avc *avc,
>          if (orig->ae.xp_node) {
>                  rc = avc_xperms_populate(node, orig->ae.xp_node);
>                  if (rc) {
> -                       kmem_cache_free(avc_node_cachep, node);
> +                       avc_node_kill(avc, node);
>                          goto out_unlock;
>                  }
>          }
> --

That looks correct to me; I guess that one got missed by the prior fix.
Still not sure how your AVC got into that state though...

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

