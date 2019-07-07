Return-Path: <SRS0=laxl=VE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C829BC48BDB
	for <selinux@archiver.kernel.org>; Sun,  7 Jul 2019 17:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9CC2082F
	for <selinux@archiver.kernel.org>; Sun,  7 Jul 2019 17:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Icifu70O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfGGRgL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Jul 2019 13:36:11 -0400
Received: from rgout0602.bt.lon5.cpcloud.co.uk ([65.20.0.129]:19848 "EHLO
        rgout06.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbfGGRgL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Jul 2019 13:36:11 -0400
X-OWM-Source-IP: 86.147.205.104 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrfeekgdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddugeejrddvtdehrddutdegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdehrddutdegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrfeekgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddugeejrddvtdehrddutdegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdehrddutdegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
Received: from localhost.localdomain (86.147.205.104) by rgout06.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C3942FB10BE9207 for selinux@vger.kernel.org; Sun, 7 Jul 2019 18:24:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1562520971; 
        bh=14yMJrjSnXwBczy7+7TYf+keRnNMbJ3Vex+ad6rc1q0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=Icifu70ODUnhdmJjZ0gol8eumKEwakhKKecTusJSiMRzI1qJxQFPoVGqSxLRV1ZZ62a6pays1n/yw7wccSaQDiPZ0nGwOKMbIHDdXuD9GYQpCnKUXw8mHIn0KPMo2a7KQzdCxAlA4EF2p6RbqpOqa1sq2egAxW9oRgcTPrd0mRM=
Message-ID: <fca3a25ad9f302d8755b200b530380e598901e87.camel@btinternet.com>
Subject: Re: [PATCH] libselinux: Fix security_get_boolean_names build error
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Date:   Sun, 07 Jul 2019 18:24:11 +0100
In-Reply-To: <20190702182138.7209-1-richard_c_haines@btinternet.com>
References: <20190702182138.7209-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2019-07-02 at 19:21 +0100, Richard Haines wrote:
> When running 'make' from libselinux on Fedora 30 (gcc 9.1.1) the
> following error is reported:
> 
> bute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wstrict-overflow=5
> -I../include -D_GNU_SOURCE  -DNO_ANDROID_BACKEND  -c -o booleans.o
> booleans.c
> booleans.c: In function ‘security_get_boolean_names’:
> booleans.c:39:5: error: assuming signed overflow does not occur when
> changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>   39 | int security_get_boolean_names(char ***names, int *len)
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:171: booleans.o] Error 1
> 
> This is because of 'for (--i; i >= 0; --i)', however the --i is not
> required anyway as proven when simulating oom and running valgrind.

Please ignore this patch. Tried to cancel but delivered to list four
days later. The [1] patch is the correct one to review.

[1] 
https://lore.kernel.org/selinux/20190703141255.6321-1-richard_c_haines@btinternet.com/T/#u

> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/booleans.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index ab1e0754..33bf13c7 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -81,7 +81,7 @@ int security_get_boolean_names(char ***names, int
> *len)
>  	free(namelist);
>  	return rc;
>        bad_freen:
> -	for (--i; i >= 0; --i)
> +	for (; i >= 0; --i)
>  		free(n[i]);
>  	free(n);
>        bad:

