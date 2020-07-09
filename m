Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3704C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1692074B
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="CV6QBVBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGIOQX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:16:23 -0400
Received: from mailomta1-re.btinternet.com ([213.120.69.94]:52024 "EHLO
        re-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgGIOQX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 10:16:23 -0400
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-041.btinternet.com with ESMTP
          id <20200709141620.ITFB30588.re-prd-fep-041.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Thu, 9 Jul 2020 15:16:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1594304180; 
        bh=exLK7xst1KmhH3wZM0eCBzNSHKWTYYMLAaHAArlSFAY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=CV6QBVBAnnmsnDQu+rKjnd4+JrJ53M6Py9h9umv3gf5jQ/8S+YR0+ZIVC/uQQPDOLTsr7X1+WLwdGdM/y8Gwh6vurmyvDWUpnLwtSHYVAJh6HD8iM0Oe/7S0o9Kov/fSClVl/S9jIpyUvMxqInp5MGenOuFECH+RM+arvGmE1viToDmXMoEh7vOJNaH9pRv/EqqOL5SehbBipMjHz0fcvp8bzeM1wWilw8xungoGZ4/OkpEHY49ypKG1Le5c1h1RZaRLsZA2IbyGrifpz2t9UTSKFnviArBa3RHo39vRhbq2na1G4XqigbBwGFmZB3Vnv+ETRS1werZjBlQbjk+04g==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.158.127.33]
X-OWM-Source-IP: 109.158.127.33 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudelgdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhephfekgeehuddugefgffekheehteetgfejudeghffhveeuvdevudehtdeljeekudevnecukfhppedutdelrdduheekrdduvdejrdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehnfhhsqdgtlhhivghnthdpihhnvghtpedutdelrdduheekrdduvdejrdeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoeguohhmihhnihgtkhdrghhrihhfthesuggvfhgvnhhsvggtrdhnlheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from nfs-client (109.158.127.33) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C50605FF7901; Thu, 9 Jul 2020 15:16:20 +0100
Message-ID: <ecf085b6139f40fa9b8dfa3277f8c598d697387d.camel@btinternet.com>
Subject: Re: [SELinux-notebook PATCH] avc_rules.md: mention secilc with the
 neverallow statement
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Date:   Thu, 09 Jul 2020 15:16:19 +0100
In-Reply-To: <20200709090352.1681563-1-dominick.grift@defensec.nl>
References: <20200709090352.1681563-1-dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-07-09 at 11:03 +0200, Dominick Grift wrote:
> I was unable to determine whether checkpolicy can be told to disable
> neverallow checking.
> 
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  src/avc_rules.md | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/avc_rules.md b/src/avc_rules.md
> index a9dead5..7e62d04 100644
> --- a/src/avc_rules.md
> +++ b/src/avc_rules.md
> @@ -182,8 +182,9 @@ auditallow ada_t self:process execstack;
>  
>  This rule specifies that an `allow` rule must not be generated for
> the
>  operation, even if it has been previously allowed. The `neverallow`
> -statement is a compiler enforced action, where the
> ***checkpolicy**(8)* or
> +statement is a compiler enforced action, where the
> ***checkpolicy**(8)*,
>  ***checkmodule**(8)* <a href="#fna1" class="footnote-ref"
> id="fnavc1"><sup>1</sup></a>
> +or ***secilc**(8)* <a href="#fna2" class="footnote-ref"
> id="fnavc2"><sup>2</sup></a>
>  compiler checks if any allow rules have been generated in the policy
> source,
>  if so it will issue a warning and stop.
>  
> @@ -211,6 +212,7 @@ neverallow { domain -mmap_low_domain_type }
> self:memprotect mmap_zero;
>  <section class="footnotes">
>  <ol>
>  <li id="fna1"><p><code>neverallow</code> statements are allowed in
> modules, however to detect these the <em>semanage.conf</em> file must
> have the 'expand-check=1' entry present.<a href="#fnavc1"
> class="footnote-back">↩</a></p></li>
> +<li id="fna2"><p>The `--disable-neverallow` option can be used with
> ***secilc**(8)* to disable <code>neverallow</code> rule checking.<a
> href="#fnavc2" class="footnote-back">↩</a></p></li>
>  </ol>
>  </section>

As the footnote is HTML, to render the man page entry it needs to be:
<em><strong>secilc</strong>(8)</em>


>  

