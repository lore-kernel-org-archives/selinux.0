Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25CAC433FE
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FE923787
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 16:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgLGQoQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGQoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 11:44:15 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C771C061794
        for <selinux@vger.kernel.org>; Mon,  7 Dec 2020 08:43:35 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id z136so13978230iof.3
        for <selinux@vger.kernel.org>; Mon, 07 Dec 2020 08:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvZi4djUq3gIBNHzIyagGWsCehGDveZG9isnrR2pxfo=;
        b=G36oh1K4dEXJamIPUMKkvslZCCgl2tdUrrCAFFAKFK9mE1Id+sNkQ9L2wW/2QS2hj/
         2XtlbDmZRdTUM5zg6yM8cZ74hOSbbpQL/uGrKTYB4+c5/QW9SiSbVFCDaJu5YbtW0klk
         tive1G4XLYchox/hqTXmKaz3MLUtbOpuRHx+QgFVzm87X9N0ZjE11yCCYleq9i1UovHC
         ZVXAD/cMftCYgSRQ2hgrab0q66V5V5u1ggyV+AkqHcl0a2LoKGOR6SouNz8w7g8B4Mjr
         vx9i90OTvVhtcvA0SxCblPsNMtoZsZPwFMe8en03ZNLHeMu0RAULQYAiDS93B9ehKENj
         I3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvZi4djUq3gIBNHzIyagGWsCehGDveZG9isnrR2pxfo=;
        b=kMhnmRekXMgiXEt2DHuptrFpqa55K1/H/bItgHEJXCUCp/nHhtHRzyV4/96llzBu60
         PVPikhl5litFjYikmdTD49jhNf3W2/GQEqwE55vqacE34BHC/Nl/n4a4H8Wg2XC42sic
         N4qU8130zPbeYT+z4f2fPMwyv+mnnNRObEueJ8p++RCTygasmVMQU2+mii512LK1A9me
         AhvPqWYloXLRwhZhvtf7FheWrJ37QOG6b5YlyTF21JvUv2YY/LBkIWoAfixmXMXHNknn
         KsZZe7enBmS8cZGWfpeBs6B4B6Cx9Jad7xjLufqHl9i1IAi9qwaHHhnGrwz07WJ0IOCf
         6cGQ==
X-Gm-Message-State: AOAM531gJne1D6yff9JCwVULaBlt+J1AAJmZrf/F4fDy+1tttRUM5hg9
        XJ/lRo25eSZbZe5JU4gaBHQgSjzFmKBsUxNO9yo=
X-Google-Smtp-Source: ABdhPJwJ3ypv3sIebPy7ilvya7RQQZBoDeE5yAXbpcaA0H96Omw9RgZqzaWu2aUgX5C/IHnP5D3st+Lw5CghpPjsk98=
X-Received: by 2002:a5e:da46:: with SMTP id o6mr20914091iop.139.1607359414840;
 Mon, 07 Dec 2020 08:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20201206225625.3077530-1-nicolas.iooss@m4x.org>
In-Reply-To: <20201206225625.3077530-1-nicolas.iooss@m4x.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 7 Dec 2020 10:43:23 -0600
Message-ID: <CAFftDdpY9BCrr2DQEOS7yQQJ8SuN158ZkYCz_jDCLpw5=1nNzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] GitHub Actions: upgrade to Python 3.9
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Dec 6, 2020 at 4:58 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  .github/workflows/run_tests.yml | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
> index 6f280de8ff4d..d889b5d55604 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -10,25 +10,26 @@ jobs:
>        matrix:
>          compiler: [gcc, clang]
>          python-ruby-version:
> -          - {python: 3.8, ruby: 2.7}
> -          - {python: 3.8, ruby: 2.7, other: test-flags-override}
> -          - {python: 3.8, ruby: 2.7, other: test-debug}
> -          - {python: 3.8, ruby: 2.7, other: linker-bfd}
> -          - {python: 3.8, ruby: 2.7, other: linker-gold}
> +          - {python: 3.9, ruby: 2.7}
> +          - {python: 3.9, ruby: 2.7, other: test-flags-override}
> +          - {python: 3.9, ruby: 2.7, other: test-debug}
> +          - {python: 3.9, ruby: 2.7, other: linker-bfd}
> +          - {python: 3.9, ruby: 2.7, other: linker-gold}
>            # Test several Python versions with the latest Ruby version
> +          - {python: 3.8, ruby: 2.7}
>            - {python: 3.7, ruby: 2.7}
>            - {python: 3.6, ruby: 2.7}
>            - {python: 3.5, ruby: 2.7}
>            - {python: pypy3, ruby: 2.7}
>            # Test several Ruby versions with the latest Python version
> -          - {python: 3.8, ruby: 2.6}
> -          - {python: 3.8, ruby: 2.5}
> -          - {python: 3.8, ruby: 2.4}
> +          - {python: 3.9, ruby: 2.6}
> +          - {python: 3.9, ruby: 2.5}
> +          - {python: 3.9, ruby: 2.4}
>          exclude:
>            - compiler: clang
> -            python-ruby-version: {python: 3.8, ruby: 2.7, other: linker-bfd}
> +            python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-bfd}
>            - compiler: clang
> -            python-ruby-version: {python: 3.8, ruby: 2.7, other: linker-gold}
> +            python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-gold}
>
>      steps:
>      - uses: actions/checkout@v2
> --
> 2.29.2
>

ack
