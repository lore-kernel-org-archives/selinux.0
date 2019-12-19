Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB1C43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FEF24650
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 16:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OS1s+m5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLSQAY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:00:24 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:52301 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfLSQAY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 11:00:24 -0500
X-EEMSG-check-017: 39787187|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="39787187"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Dec 2019 16:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576771220; x=1608307220;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HNfDHRhGYVkqnjWB+sU3sQZkwcx6EXjKpmJfsyr+mTw=;
  b=OS1s+m5nsKfiYLKq/4861l9v1uJXGcivSlyGw61LIYDB7yB5jX8ib4W9
   /GPTVuyPs2/OYpDC2Ltf+3/bo8pm5rL0NSDcMotAnFXy/Rxzq5eTSbfe5
   xYF2od50QKp2T6OPLoS6WaJIheM7U6jeOJddK5ros+MvbpfTfOtVozLKo
   oM+Z6LYg5GaFSOmLGIQ1mua+V+6AH3DQ8xnXQBUjHZAlyLDfXlE6kl0/Y
   X4F7YldUdo1CNGku6+g5C9QeZDFIyPfPzTOq1fDXs/JvWD7kWRF+tMXB0
   ZPXLWEAN3aBfZasIrqoS/43gJ3yqaqCotpkUF5ZW0N3MG1uu70FsKlvCO
   w==;
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="31283805"
IronPort-PHdr: =?us-ascii?q?9a23=3AJlRF1xbv8UcawwSiKUpzm/f/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsyyZR7h7PlgxGXEQZ/co6odzbaP6Oa6ADVLsc/JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusULnIduJaU8xg?=
 =?us-ascii?q?bUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwl5?=
 =?us-ascii?q?wTsUrEHi/thkr5kLWadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeAmagIjyIFzOPPD5Auu/g1SrijtrwevGMaf7DpXCKXjDjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opOCrEaIfL8R1L+tNvaDh84KAG73+HnB8hj2YwERGKPGK?=
 =?us-ascii?q?iZMLnIvlOS4eIvOeaMbpcPuDnhM/gl++LujXghlF8FZ6apwJ8XZWugHvt8Pk?=
 =?us-ascii?q?WZZWPggtIGEWcNpAoxUvbmh0GFUT5Wf3yyRb4z5iknCIK6CofOXputj6KF3C?=
 =?us-ascii?q?e6GJ1We29HB0uSEXfnaYqEQe0AaCGMLc97lDwLS7yhR5Um1RG0uw/w06BnIf?=
 =?us-ascii?q?bM+i0EqZLj08B45+nSlRE06Dx1AN2R03qTQG5og2MIXT423Lx/oEBkz1eD1r?=
 =?us-ascii?q?V3g+FcFdNN/P5JTAg6OoDGz+BgCND9RBjBftGXR1aiWNmmBisxTt1ii+MJNn?=
 =?us-ascii?q?x0BdTqrQ3G1jDiOL4Zm7uJBZM96KOUi2LqJspxzHTH/KImg1QvX9FIL2Tggb?=
 =?us-ascii?q?RwoUybTcHxmlid34Otcr4Rk2SFoH+K0G6mpEhFVEt1VqLfUDYUYU6A/vrj4U?=
 =?us-ascii?q?aXdKOjEbQqNEN6zMeGLqZbIonygU5uWOboONOYZXm43Wi3G0Dblfu3cIP2dj?=
 =?us-ascii?q?BFj23mA08enlVWpC3XOA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ARAAAZnvtd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFrAgEBAQELAYF1gWwBIBIqhAaJA4ZbBoE3iWyPXoFnCQEBAQEBA?=
 =?us-ascii?q?QEBATcBAYRAAoJANwYOAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQMjB?=
 =?us-ascii?q?BFBEAsRAwECAQICJgICTwgGAQwGAgEBglMMP4JTJawZdX8zhU+DR4E9gQ4oA?=
 =?us-ascii?q?YwyeYEHgTgPgl0+hBIEARIBgy+CXgSHOo9VRpc2gj6CRJNOBhuCQ5gOLY4kg?=
 =?us-ascii?q?UabGyNncSsIAhgIIQ+DJ1AYDZt2IwMwjlUPF4IbAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Dec 2019 15:59:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBJFxZml178240;
        Thu, 19 Dec 2019 10:59:37 -0500
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>,
        "'Paul Moore'" <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
 <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
 <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
 <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov>
 <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
 <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com>
 <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov>
 <001e01d5b4f0$495efbd0$dc1cf370$@codeaurora.org>
 <21b5511a-fdba-3c2f-e9a6-efdc890b5881@tycho.nsa.gov>
 <CAHC9VhQYA8uTRQ0OajEmsTrDytNVx+BSiL5vEsGefKEhAw+gKA@mail.gmail.com>
 <002701d5b651$8434b2b0$8c9e1810$@codeaurora.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3ad91461-f717-879b-6ace-a8ca31d6e3e1@tycho.nsa.gov>
Date:   Thu, 19 Dec 2019 11:00:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <002701d5b651$8434b2b0$8c9e1810$@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/19 4:48 AM, Ravi Kumar Siddojigari wrote:
> Sorry , Re-adding the patch  below as requested.
> 
> Stephen ,
> Issue is fixed with this  2 changes , Issue as even reproduced on v4.14 and  similar changes work there also .

It would be preferable if you sent the patch directly via git send-email 
or similar.  In any event, for the final version, we should drop the 
Change-Id because it is Android-specific and we should add a Fixes line 
like so:

Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")

Given the behavior you are describing and the fact that you could 
reproduce it on v4.14 as well, I would recommend marking both it and 
Paul's earlier patch for stable (Paul will do this if he agrees; no 
action required by you).

> 
> --
>  From 77c618006397c7a65ead257f3cb4e4fe3da2d4b8 Mon Sep 17 00:00:00 2001
> From: Jaihind Yadav <jaihindyadav@codeaurora.org>
> Date: Tue, 17 Dec 2019 17:25:47 +0530
> Subject: [PATCH] selinux: ensure we cleanup the internal AVC counters on error
>   in avc_update()
> 
> In AVC update we don't call avc_node_kill() when avc_xperms_populate()
> fails, resulting in the avc->avc_cache.active_nodes counter having a
> false value. In last patch this changes was missed , so correcting it.
> 
> Change-Id: Ic0298162cc766c0f21be7ab232e259766654dad3
> Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
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
> 1.9.1
> 
> Br,
> 
