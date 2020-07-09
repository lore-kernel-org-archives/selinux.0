Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1412C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 18:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B0B2078B
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 18:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VmEG+VpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGIStL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGIStL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 14:49:11 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92BAC08C5CE
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 11:49:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg28so2657876edb.3
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9jrKdB1uD47S7y9RXxxETYM9KPAYskYrA0djubSHm+I=;
        b=VmEG+VpXPvc0lOjsb/vjYk+4qVcV0wNkRDvTL1QPpeOF8RhVLUmBizvHKDjyrBBEU/
         zAjExW80lfdHOUIqK67aTufGwdj5VTl/J7EPJo7ncOMNZKfEaRnSMbAOnP+v9wssJSd/
         Kt8y7asFGE6Em+p5rVU+KuKjDTB27pMHAeTlALP4GmLb6+/krP6VqcIgrb+XpQ1MClzW
         3Hu/Yg7uWEFFoF+zBuemTRSsP+vNPDiIXsb913CPgbbl27LW1Gi20KEev9zJ5rYi7AVx
         /wJIru8pG0FL0LvOxIQlUbeUVkv2KWGXMxEX1KxoSM0cdsgGoQJEVp19rVNRSz3vaj40
         gFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9jrKdB1uD47S7y9RXxxETYM9KPAYskYrA0djubSHm+I=;
        b=OZJrOERMw4YEtoGUOst3UUrkVqUMC7TGnJaIj99BXN6LFbZzq8JxkiGYzlfxgJvkRQ
         0vXqLBNCSwFh8S0eoFtSNYx+YduydZaczgy9PvW3bC50HSQCt+MR7kAx/hzxIq2XedTt
         ihNwZ/2bGulMzGfuAbdIHXmD2IOfaKv2GS+00/oESbZxCJkm+RpuqhhQywUqt+difPl4
         LbFfF9LaVd9nv78nKi1F4QTPdcAFl1RpDyK8m8AY4tl90mRSBSML/ICgV5U9LJ5mN3wV
         sk1qmQzIpOIq7ONPi+zD+AsQ2d+RNbfTAtfUCtVCNi+ICohDqr1VMuhw0CyzQy+7FoEP
         yb5A==
X-Gm-Message-State: AOAM5333lU/qaWzFIYMNCay9UXZXfBO7SofXQtp41+gI4RFkbibD2urL
        dZNOUxDOSGrjGzSzJxyJNFgaSLMHvNnU48b8Na6niuc=
X-Google-Smtp-Source: ABdhPJwx3oivhxkR0vgo0rtdGb1WqbIXmrIeRLU+1oSNfD7YPD/TAS6M9F352Ieb4/JKBfWD6s6gBQK1kv6SAA45W1M=
X-Received: by 2002:aa7:d6cf:: with SMTP id x15mr71698707edr.164.1594320549307;
 Thu, 09 Jul 2020 11:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <ecf085b6139f40fa9b8dfa3277f8c598d697387d.camel@btinternet.com> <20200709181015.3687-1-dominick.grift@defensec.nl>
In-Reply-To: <20200709181015.3687-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Jul 2020 14:48:58 -0400
Message-ID: <CAHC9VhTZaXcduhT5Fx9BW0ng9FWOVvmqXfAaWSLcB4Vaa0wJXw@mail.gmail.com>
Subject: Re: [PATCH] avc_rules.md: mention secilc with the neverallow statement
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 2:10 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> I was unable to determine whether checkpolicy can be told to disable
> neverallow checking.
>
> v2: As the footnote is HTML, to render the man page entry it needs to be:
> <em><strong>secilc</strong>(8)</em>
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  src/avc_rules.md | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Merged, thanks for the quick revision.

> diff --git a/src/avc_rules.md b/src/avc_rules.md
> index a9dead5..5c2a491 100644
> --- a/src/avc_rules.md
> +++ b/src/avc_rules.md
> @@ -182,8 +182,9 @@ auditallow ada_t self:process execstack;
>
>  This rule specifies that an `allow` rule must not be generated for the
>  operation, even if it has been previously allowed. The `neverallow`
> -statement is a compiler enforced action, where the ***checkpolicy**(8)* =
or
> +statement is a compiler enforced action, where the ***checkpolicy**(8)*,
>  ***checkmodule**(8)* <a href=3D"#fna1" class=3D"footnote-ref" id=3D"fnav=
c1"><sup>1</sup></a>
> +or ***secilc**(8)* <a href=3D"#fna2" class=3D"footnote-ref" id=3D"fnavc2=
"><sup>2</sup></a>
>  compiler checks if any allow rules have been generated in the policy sou=
rce,
>  if so it will issue a warning and stop.
>
> @@ -211,6 +212,7 @@ neverallow { domain -mmap_low_domain_type } self:memp=
rotect mmap_zero;
>  <section class=3D"footnotes">
>  <ol>
>  <li id=3D"fna1"><p><code>neverallow</code> statements are allowed in mod=
ules, however to detect these the <em>semanage.conf</em> file must have the=
 'expand-check=3D1' entry present.<a href=3D"#fnavc1" class=3D"footnote-bac=
k">=E2=86=A9</a></p></li>
> +<li id=3D"fna2"><p>The `--disable-neverallow` option can be used with <e=
m></strong>secilc</strong>(8)</em> to disable <code>neverallow</code> rule =
checking.<a href=3D"#fnavc2" class=3D"footnote-back">=E2=86=A9</a></p></li>
>  </ol>
>  </section>
>

--=20
paul moore
www.paul-moore.com
