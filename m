Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5361FC433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301132073A
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="b/hyw6Ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgGIOO0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:14:26 -0400
Received: from mailomta14-sa.btinternet.com ([213.120.69.20]:19167 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbgGIOO0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 10:14:26 -0400
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200709141424.UAOD3440.sa-prd-fep-044.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Thu, 9 Jul 2020 15:14:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1594304064; 
        bh=fJcUz63NcS70F+cJFnf0vDHX0hFdIC4J4rTzM+XWtwk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=b/hyw6GaryGkV5f9ud8rDBTBxsBbDiINNdLZ/DVZWkf3JX4ZUb7EPJ+IeFWh168XW/VTiEYdm5HAoNZFUIzdAvRfcsylQ4al/ufolgQvpe5d0mC6dEI6tnobeqPDYln4RIdD2tCnT72Pw9mPnx3zEaDbaYYZARXH4J0w6CZMHoEFbc3BAJvzQJTS4Sysw4h7A1zPcGrD6g6Sm043S0xE+b4xUsAg7UpyBregLztmywEP/TqjgoBz/SfpLMG4bvYdlMSr4+u1VJ0614hplwsbjF5Lp0n1IMAF8VPx/mltwPuiegC6mY/sV8s4GQKdwF8JcfrNApPPDnChNKcilT708w==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.158.127.33]
X-OWM-Source-IP: 109.158.127.33 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudelgdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeekhedvfeeugffhffduveeiffffkeekveefteehveffvdeuhfeiveefjeffiefhnecuffhomhgrihhnpehosghjvggtthdrthgunecukfhppedutdelrdduheekrdduvdejrdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehnfhhsqdgtlhhivghnthdpihhnvghtpedutdelrdduheekrdduvdejrdeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoeguohhmihhnihgtkhdrghhrihhfthesuggvfhgvnhhsvggtrdhnlheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from nfs-client (109.158.127.33) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B66105EF3EC5; Thu, 9 Jul 2020 15:14:24 +0100
Message-ID: <47c6b95c59fd088bed61761c78e38bc04b9506d2.camel@btinternet.com>
Subject: Re: [SELinux-notebook PATCH] auditing.md: describe avc record
 permissive keyword
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Date:   Thu, 09 Jul 2020 15:14:15 +0100
In-Reply-To: <20200709075056.1670642-1-dominick.grift@defensec.nl>
References: <20200709075056.1670642-1-dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-07-09 at 09:50 +0200, Dominick Grift wrote:
> This was added to Linux 4.17 via "selinux: Report permissive mode in
> avc: denied messages."
> 
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  src/auditing.md | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Richard Haines <richard_c_haines@btinternet.com>

> diff --git a/src/auditing.md b/src/auditing.md
> index 19f8be6..295373a 100644
> --- a/src/auditing.md
> +++ b/src/auditing.md
> @@ -161,6 +161,12 @@ section that follows.
>  <td>tclass</td>
>  <td>The object class of the target or object.</td>
>  </tr>
> +<tr>
> +<td>permissive</td>
> +<td>Keyword introduced in Linux 4.17 to indicate whether the event
> +was denied or granted due to global or per-domain permissive
> +mode.</td>
> +</tr>
>  </tbody>
>  </table>
>  

