Return-Path: <SRS0=i/ur=NR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343F1C32789
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FDC2081D
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 16:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FDC2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbeKGBpw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:45:52 -0500
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:64314 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbeKGBpw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 20:45:52 -0500
X-EEMSG-check-008: 178858975|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Nov 2018 16:19:52 +0000
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="17594646"
IronPort-PHdr: =?us-ascii?q?9a23=3A4Fco7hPcvciQlzVq68Yl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/3yrarrMEGX3/hxlliBBdydt6obzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlKiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cRE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXbOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0ljdrxuzJPrrlAprXNXjPirbhfb?=
 =?us-ascii?q?F6605H0wo+1tVf6p1bC70bJ/LzQEDxvsTCDhAlKwy03/rnCNJl24MFR22PBq?=
 =?us-ascii?q?6ZMKXPsV6H/e8vPeaMa5EPuDrnKPgq+eTujXknll8ZZ6Wp2oEXaH/rVshhdm?=
 =?us-ascii?q?OYan3oi8xJMGANpRF2GOrrg1qGWCUVZnG1RLkU420rToW8AtGHDpughL2HwT?=
 =?us-ascii?q?eTAJJbfCZFB0qKHHOucJ+LH78uYSefOYdKmyYYWKLpH40+3hi0qFXS16tsLu?=
 =?us-ascii?q?2S/DYR853kyo4myffUkEQJ6TFsD8mbm1qIRmVwk3JAEyQ6x4hjsEd9zRGFyq?=
 =?us-ascii?q?E+jPtGQ48Ar8hVWxs3YMaPh9dxDMr/D0eYJI+E?=
X-IPAS-Result: =?us-ascii?q?A2DVBwBnvuFb/wHyM5BkHAEBAQQBAQcEAQGBZYFbKYE1M?=
 =?us-ascii?q?yeDdpQwTAEBAQEBAQaBNYkRkBk4AYRAAoNYIjgWAQMBAQEBAQECAWwogjYkA?=
 =?us-ascii?q?YJgAQUjBBFRCxgCAiYCAlcGAQwGAgEBgl4/gXUNqDJ7M4U8hHaBC4ptF3mBB?=
 =?us-ascii?q?4E4gmuIAoJXAo87M49JCYoThnkGGIFWiCKGbJklIYFVKwgCGAghD4MnkHghA?=
 =?us-ascii?q?zCBBQEBjGwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Nov 2018 16:19:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA6GJp0q009549;
        Tue, 6 Nov 2018 11:19:51 -0500
Subject: Re: [PATCH 1/1] libsepol: mark permissive types when loading a binary
 policy
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org,
        James Carter <jwcart2@tycho.nsa.gov>
References: <20181105210001.31499-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e5aece95-c1b5-073c-8add-510ee908df57@tycho.nsa.gov>
Date:   Tue, 6 Nov 2018 11:22:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105210001.31499-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/5/18 4:00 PM, Nicolas Iooss wrote:
> When using checkpolicy to read a binary policy, permissive types are not
> written in the output file. In order to reproduce this issue, a test
> policy can be written from minimal.cil with the following commands:
> 
>      $ cd secilc/test/
>      $ cp minimum.cil my_policy.cil
>      $ echo '(typepermissive TYPE)' >> my_policy.cil
>      $ secilc my_policy.cil
>      $ checkpolicy -bC -o /dev/stdout policy.31
> 
>      # There is no "(typepermissive TYPE)" in checkpolicy output.
> 
> This is because TYPE_FLAGS_PERMISSIVE is added to typdatum->flags only
> when loading a module, which uses the permissive flag in the type
> properties. A kernel policy defines permissive types in a dedicated
> bitmap, which gets loaded as p->permissive_map before the types are
> loaded. Use this bitmap to mark permissive types in the loaded policy.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Or we could directly use the permissive_map in 
kernel_to_cil/kernel_to_conf?  Regardless,

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libsepol/src/policydb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 96176d805d59..f2beaf041fc7 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2469,6 +2469,9 @@ static int type_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
>   		if (properties & TYPEDATUM_PROPERTY_PERMISSIVE
>   		    && p->policy_type != POLICY_KERN)
>   			typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
> +		if (p->policy_type == POLICY_KERN
> +		    && ebitmap_get_bit(&p->permissive_map, typdatum->s.value))
> +			typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
>   
>   		typdatum->bounds = le32_to_cpu(buf[++pos]);
>   	} else {
> 

