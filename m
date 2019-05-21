Return-Path: <SRS0=L5Vm=TV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9F8C04AAF
	for <selinux@archiver.kernel.org>; Tue, 21 May 2019 17:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0876D217D7
	for <selinux@archiver.kernel.org>; Tue, 21 May 2019 17:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EniXckc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfEUR7P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 May 2019 13:59:15 -0400
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:31223 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfEUR7P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 May 2019 13:59:15 -0400
X-EEMSG-check-017: 413873261|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 May 2019 17:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558461554; x=1589997554;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZiBa0ejpzQfwfodLoPeAsddMADD84N6PBdiF2hY3OoU=;
  b=EniXckc2nCPNXFx4s9JW3G02ehy+xjDQiejXJvV2k0jC8L5AL6id4/A9
   V32ZL4I1UCW6qMhomiYkQazNn0xe2G0jrq1epacq3+zLxSAhar6Idy54c
   qvCQGxGvdVEUMi1HKbVV/MGeKMvogtdFYW8rFAU7iENY1HHT2Oi2IfMXa
   /wlaWRG4ndqQMzKOYIewXSm7N8XXVor3jhiF1pxXmMFqFI54FZG9ShMFa
   UbtiOKF9nunZEuMJKFJ1toonHIf7LN54fZiaXTBeQRQh7LJNdtF1poCWu
   aXAGDqrX921IyiOMb5H4a18hG0SlZwpngSVIjbeULJsqccO8dWIGdtvrx
   w==;
X-IronPort-AV: E=Sophos;i="5.60,496,1549929600"; 
   d="scan'208";a="27997632"
IronPort-PHdr: =?us-ascii?q?9a23=3AyUZ2WhSombTFVqK8g82caL5qq9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zZheN2/xhgRfzUJnB7Loc0qyK6vmmADVYqs/Y7zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrsAndrNQajZZ+Jqo+1x?=
 =?us-ascii?q?fFv3lFcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Cu7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9U1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1WSp43qIyma1v4Rs2SF8uFtUuCvimA7pA5ruDiv2tkgh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMYIhw74smZ?=
 =?us-ascii?q?oTtkTPBCn2l1ntjKCKbEkk/+mo6+D/brXnoJ+TKZN0hxnjPqkhlcGzG+Q1Ph?=
 =?us-ascii?q?UUU2SF9umwyqfv8VDhTLVPlPI2k63ZsJ7AJcQco660Gw1V04g/5BmlFTemzM?=
 =?us-ascii?q?oUkGIbLFNFZB2Hj4/pN0vIIPDjF/izmVuskDB1x/zeJL3uHo3NLmTfkLfmZb?=
 =?us-ascii?q?t98U9cxxYzzd9F/ZJbF6kOL+7rVU/xrtPYDxk5PBKvw+v8E9p9yoIeWWSTAq?=
 =?us-ascii?q?CHKqPSt0GH5v41L+aQY48VvS73K+I56P72kX85hVgdcLGy3ZQJbHC4H/JmI1?=
 =?us-ascii?q?iWYHf3nNcBHnkFvhAkQOzpllKCSzhTaGi2X64m4TE7Eo2mXs//QdWXgbeB1T?=
 =?us-ascii?q?23Vr1fZ2ZLERjYC3bjd4yeV8AHXyKbI8lsiRQOSbmnV4I70xyy8gT9zuwjZv?=
 =?us-ascii?q?HZ/iweqILLytd4/avQmAs0+DgyCN6SgE+XSGQhnHwDTiUqhugro1N2w02fi4?=
 =?us-ascii?q?BkkvdYEppV/PoPXQAkY82Ph9dmAsz/D1qSNuyCT0yrF5D/WmA8?=
X-IPAS-Result: =?us-ascii?q?A2A+DQAYPORc/wHyM5BlHQEBBQEHBQGBZYFnKoE7MiiEE?=
 =?us-ascii?q?4h7i3AtmlAJAQEBAQEBAQEBNAECAQGCEoIuAoImIzgTAQMBAQEEAQEBAQMBA?=
 =?us-ascii?q?WwogjopAYJnAQUjFUEQCwkPAgImAgJXBgEMBgIBAYJfP4FrAx2nNIEvhUiDK?=
 =?us-ascii?q?IFGgQwoi1GBVkCBOIJrPoIahTSCWASBLQGSGJRdBgOCD4VajSAGG5YsjFaXV?=
 =?us-ascii?q?iGBVysKQUqBHoFOgkaOJyMDMIEGAQGLWSuCJQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 May 2019 17:59:04 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4LHx4ng025251;
        Tue, 21 May 2019 13:59:04 -0400
Subject: Re: [Non-DoD Source] [PATCH] libsepol/cil: Allow validatetrans rules
 to be resolved
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov
References: <20190521112206.5403-1-richard_c_haines@btinternet.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <82e7d8a1-d962-2a0b-fbdc-07143a8061c3@tycho.nsa.gov>
Date:   Tue, 21 May 2019 13:59:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521112206.5403-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/21/19 7:22 AM, Richard Haines wrote:
> When validatetrans rule is in CIL policy it errors with:
> u3, r3, and t3 can only be used with mlsvalidatetrans rules
> 
> Will now resolve these examples:
> (validatetrans binder (and (and (eq t1 t1_t) (eq t2 t2_t)) (eq t3 t3_t)))
> (mlsvalidatetrans file (and (and (eq t1 t1_t) (eq t2 t2_t))
>      (and (eq t3 t3_t) (domby h1 h2))))
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Acked-by: James Carter <jwcart2@tycho.nsa.gov>

> ---
>   libsepol/cil/src/cil_verify.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 1036d73..1a21cf4 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -221,8 +221,8 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
>   			cil_log(CIL_ERR, "l1, l2, h1, and h2 cannot be used on the left side with a string or list on the right side\n");
>   			goto exit;
>   		} else if (l_flavor == CIL_CONS_U3 || l_flavor == CIL_CONS_R3 || l_flavor == CIL_CONS_T3) {
> -			if (expr_flavor != CIL_MLSVALIDATETRANS) {
> -				cil_log(CIL_ERR, "u3, r3, and t3 can only be used with mlsvalidatetrans rules\n");
> +			if (expr_flavor != CIL_VALIDATETRANS && expr_flavor != CIL_MLSVALIDATETRANS) {
> +				cil_log(CIL_ERR, "u3, r3, and t3 can only be used with (mls)validatetrans rules\n");
>   				goto exit;
>   			}
>   		}
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
