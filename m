Return-Path: <SRS0=61sA=XS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299FEC04EBF
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 15:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01A720673
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 15:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DY1Ywkpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfIWPIk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:08:40 -0400
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:42185 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfIWPIk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Sep 2019 11:08:40 -0400
X-EEMSG-check-017: 26115796|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,540,1559520000"; 
   d="scan'208";a="26115796"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Sep 2019 15:08:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569251318; x=1600787318;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=l4HcIZXWMrFMvAPGSHAlTRmqLrQCPyU+mOKKSrfRBkw=;
  b=DY1YwkpqjQgMyqf3RmM5RI3y8jUCLS/16Cg2e8qgUoaLIEWYcQltOaJt
   1OFi1WHi0JtdKJqyMLYX5vrrsIVS3grrDvmVWVCI+8jsYzxH0MzO86Wyp
   C5qwCunszUPPFUhmdYNxbJ+bai0GVbaA3Y3Sasaf9tr6dIlV2frSL0Tpb
   zSFXFiIVBFTHUQnWg4/DI37dB44wxgoq6nq7s91Q+D/K2w3yrWYCZiStb
   QLYTE1oJumDN/VvG4pufs13bOjrFZts4IA65n+BFoxWueXVLad7KGv1xg
   xMN6a/0f7CEdDdqhpzi4BHVG+1GgsR4VmNTyBlgmaxGq9Su9Du07FGUn4
   g==;
X-IronPort-AV: E=Sophos;i="5.64,540,1559520000"; 
   d="scan'208";a="33211778"
IronPort-PHdr: =?us-ascii?q?9a23=3AS/Z7LRWvvjdvXMettkKthEEVcW3V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBOPt8tkgFKBZ4jH8fUM07OQ7/m7HzZQqsbZ+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUbgoRuJ6Utxh?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBuzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzzjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXmJmuD4ix7Ebtp?=
 =?us-ascii?q?O2czIGxZQ6yxLFdfCKfJaE7gj+WOuXPDx2nmhqeKiliBa36UWgz+r8WdSq31?=
 =?us-ascii?q?tStSpFl8XMtmgK1xzO9siLUvt98Vml2TaIzw3T9vtLIVo1larGMJ4t2KIwl5?=
 =?us-ascii?q?oPvkTDGS/6gkP2g7ONdko44OSo7uXnYrH+qp+dMY97lB3+P7wzlsGwDuk0KA?=
 =?us-ascii?q?gDU3WB9eii27Dv41f1TKhSgv0ziKbZsZTaJcoBpq6+Bg9Yyp0j5AukDzq9zN?=
 =?us-ascii?q?QZnWUILFJCeB6diYjpIEvBLOr3Dfe4nVSgiC1ryOzePr39HpXNKWDOkKnkfb?=
 =?us-ascii?q?Z66U5dyQszzctE6pJOFL4OPfLzVVXttNDCEhA5NAm0yf79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPaPJr1CI4uMvI++RZI4aozv9Nfcl6OD0jXMjml8SY7Op3Z0JZ3C8BPhmJF?=
 =?us-ascii?q?+ZYXW/yusGRFkLokIbS+74iUbKBSBWYHSgXrkU/Dw3CIu6S4zEQ9bpyKeM2C?=
 =?us-ascii?q?a9A41+eG9LEBaPHG3ueoHCXO0DOwyIJco0qSAJTbisTcca0BiqsALrg+58Iv?=
 =?us-ascii?q?H85jwTtZWl0sN8oeLUi0dhpnRPE82B3jTVHClPlWQSSmpzhf0urA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CXAABs3ohd/wHyM5BlHAEBAQQBAQwEAQGBUwcBAQsBg?=
 =?us-ascii?q?XMqgUAyhEyIHIZwTQEBAQEBAQaBNol1jy2BewkBAQEBAQEBAQE0AQIBAYQ/A?=
 =?us-ascii?q?oMWIzQJDgIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCZwEFIxVRCw4KAgImAgJXB?=
 =?us-ascii?q?gEMCAEBgl8/gXcUrGqBMoVMgy6BSIEMKAGMCBh4gQeBOIJrPoQNg0KCNiIEl?=
 =?us-ascii?q?gKXCoIsgi6SVgYbgjaHSwWPH44amw84gVgrCAIYCCEPgyhPEBSQLyQDgTYBA?=
 =?us-ascii?q?YlMglQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Sep 2019 15:08:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8NF8cqg014139;
        Mon, 23 Sep 2019 11:08:38 -0400
Subject: Re: [PATCH] policycoreutils/fixfiles: Fix "verify" option
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <20190923144340.3197-1-vmojzis@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f9727681-817e-ba7a-7ba7-7837bf7f0212@tycho.nsa.gov>
Date:   Mon, 23 Sep 2019 11:08:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190923144340.3197-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/23/19 10:43 AM, Vit Mojzis wrote:
> "restorecon -n" (used in the "restore" function) has to be used with
> "-v" to display the files whose labels would be changed.
> 
> Fixes:
>     Fixfiles verify does not report misslabelled files unless "-v" option is
>     used.

Please add a Signed-off-by line.  With this change, aside from display 
"Verifying" vs. "Checking" there seems to be no difference between 
fixfiles verify and fixfiles check?  Wondering if there was some 
difference originally?

> ---
>   policycoreutils/scripts/fixfiles | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 5be9ba6e..1a31e061 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -302,7 +302,7 @@ process() {
>   case "$1" in
>       restore) restore Relabel;;
>       check) VERBOSE="-v"; restore Check -n;;
> -    verify) restore Verify -n;;
> +    verify) VERBOSE="-v"; restore Verify -n;;
>       relabel) relabel;;
>       onboot)
>   	if [ "$RESTORE_MODE" != DEFAULT ]; then
> 

