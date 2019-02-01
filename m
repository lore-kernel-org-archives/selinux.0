Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0882C282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 20:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A731E20863
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 20:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lFKnLZ5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfBAUT3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:19:29 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:10507 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfBAUT2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 15:19:28 -0500
X-Greylist: delayed 694 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 15:19:28 EST
X-EEMSG-check-017: 681819816|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,549,1539648000"; 
   d="scan'208";a="681819816"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Feb 2019 20:07:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549051671; x=1580587671;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=XLnGIgGBzMp/Uzaits5DtjlLwO+ysRMwog4z/qQuhL4=;
  b=lFKnLZ5h9fcOxqYoLO8cTPxDP9OP9W4eoZBOak8S9xXd6H10qleqwMNE
   I/yQbRo6NVfBHTE65x2NEe/69VK/5/XFZgFj9W0byaP0ONzFdADiZvHFW
   KTmKGBOV7o+UjWJ8zKU8feMMkyUev1w5QFPa2hNHBSi47Z1o9ManQXtNM
   Vlhxt2PDzo/bRZBqRX1SjRL7n/fz5+RWPGK8WQsdqe9vwbwdeAtf+Mbok
   DenuLwWLhnSmptQhiSg0fAkcii4fFmO5DXpevoadOesuawJ1tAgOaU1i0
   cpgrPcT47r46DButrXJGvMe4t+PZTMT2jOxCj9t2+4MwhV43UL8UGv290
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,549,1539648000"; 
   d="scan'208";a="20124902"
IronPort-PHdr: =?us-ascii?q?9a23=3AmxPnnRCbWttUbzFOsjOtUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT8pcbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnWttj5KLseXO63waTO0D7Nb+lW2TD46IXQcBAgr+2DUq?=
 =?us-ascii?q?hqccrN10UkCgTIjleeqIP5JTyVzPgNv3aA4up8VeOgl24nqwZrrjip3ccjkJ?=
 =?us-ascii?q?PFho0SylDa7Ch0xps+K96gSENjfNKpH5RduzuaOodrWM8uXW5ltDggxrEbv5?=
 =?us-ascii?q?OwYTIEx449xxHFbvyKa42I4hX+W+mPOTp4n3dleK6nhxa17Eig1vXwVsmq31?=
 =?us-ascii?q?ZOqSpIisXMuWoX1xzS98iHUeFx/luh2DmT1wDT7ftIIUYomqrAN5Et2Lswlp?=
 =?us-ascii?q?sXsUjbHy/2nlv5jLOOe0k59eWl5P7rb7X7qpOGKYN5hR/yPr4zlsCnBOQ3KA?=
 =?us-ascii?q?kOX2yV+eSm073j+FX0QLdEj/IqiKbZqozaKdoAq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiC9rx/TcMb38HpXNNGPMn636cL?=
 =?us-ascii?q?Zn9UFT1QozwspD555OFr4BJ/fzUFfrtNPEFh85LxC0w+H/BdVmyIweXWOPAq?=
 =?us-ascii?q?mEMKLdqlKI+O0vLPeWZIMPuzbyNeIl5/jwgn89g1MderOp3ZREIEy/S8xrP1?=
 =?us-ascii?q?/RRXPxns0LGGwK9l4mSOX3lEeIWBZJanqyVr567TY+XsbuForHR4awkJSf0y?=
 =?us-ascii?q?qhWJ5bfGZLDhaLC3i7WZ+DXqIOdymbONM72mgGSrOoUZN7/Q2/vw/9jbx8J6?=
 =?us-ascii?q?zb/TNO5sGr78R8++CGzUJ6zjdzFcnIljjXF2w=3D?=
X-IPAS-Result: =?us-ascii?q?A2BBAADcpVRc/wHyM5BkHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?VopgTcBMieEA5QOgWAIJZgOFIFnOAGEQAKDESI1CA0BAwEBAQEBAQIBbCiCO?=
 =?us-ascii?q?ikBgmYBAQEBAgEjBBFGCwsJBQoCAiYCAlcGAQwGAgEBgl8/gXoIqRV8M4VDh?=
 =?us-ascii?q?G+BC4s1gVZAgTgMgl+ETgESAYMoglcCgSwBiESGNko6kTwGA5IwBhmSQC2DA?=
 =?us-ascii?q?4ZwkyIBNmVxKwpBgWiBToJSjikhAzCBBQEBiVOCPgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 01 Feb 2019 20:07:50 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions.infosec.tycho.ncsc.mil [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x11K7oQa007991;
        Fri, 1 Feb 2019 15:07:50 -0500
Subject: Re: [Non-DoD Source] [PATCH 1/3] libsepol: Fix RESOURCE_LEAK defects
 reported by coverity scan
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20190131132226.19030-1-plautrba@redhat.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <f7df19cb-9240-afd7-fbe9-814b4e0e5b87@tycho.nsa.gov>
Date:   Fri, 1 Feb 2019 15:07:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131132226.19030-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/31/19 8:22 AM, Petr Lautrbach wrote:
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>   libsepol/cil/src/cil_binary.c      | 12 ++++++++++++
>   libsepol/cil/src/cil_resolve_ast.c | 10 ++++++++++
>   libsepol/cil/src/cil_symtab.c      |  1 +
>   libsepol/src/expand.c              |  3 +++
>   libsepol/src/kernel_to_cil.c       |  2 ++
>   libsepol/src/kernel_to_conf.c      |  2 ++
>   6 files changed, 30 insertions(+)
> 

...

> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 6f1b235e..125a6809 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1451,6 +1451,7 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
>   				new_trans->name = strdup(cur_rule->name);
>   				if (!new_trans->name) {
>   					ERR(state->handle, "Out of memory!");
> +					free(new_trans);
>   					return -1;
>   				}
>   				new_trans->stype = i + 1;
> @@ -1460,6 +1461,8 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
>   				otype = calloc(1, sizeof(*otype));
>   				if (!otype) {
>   					ERR(state->handle, "Out of memory!");
> +					free(new_trans->name);
> +					free(new_trans);
>   					return -1;
>   				}
>   				otype->otype = mapped_otype;

I believe that you need the following in the "if (rc) {" block a few lines down.
free(new_trans->name);
free(new_tran);
free(otype);


Everything else that I didn't comment on in this email or my last looks good.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
