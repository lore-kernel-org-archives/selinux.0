Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F778C07E9B
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6148961922
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbhGLHfe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 03:35:34 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:35280 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbhGLHeM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 03:34:12 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5381C56486C
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 09:31:21 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id u14so17349992pga.11
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 00:31:21 -0700 (PDT)
X-Gm-Message-State: AOAM532Gi3p6gkKaexS8l99RCY5YZbntmHdSzYY8wsI4cDeHwXdZjVZw
        mg7+loeRuADvBwH9L1nZEUC2AjIwk6SrhY5bl64=
X-Google-Smtp-Source: ABdhPJyKNqSn5ZloqLKXRtjrqHSFxsGjRZ9UzlNH8iO8jpkHTqjvWGjcJRCt78E3ehMOPRMJOhjZ/Aqb9GHr9sjLDK8=
X-Received: by 2002:aa7:8439:0:b029:313:1d31:1318 with SMTP id
 q25-20020aa784390000b02903131d311318mr50563936pfn.24.1626075080180; Mon, 12
 Jul 2021 00:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210710120302.74862-1-evvers@ya.ru>
In-Reply-To: <20210710120302.74862-1-evvers@ya.ru>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 12 Jul 2021 09:31:09 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=m=8t9MQ1gSHE9_9D8aki-mUrWtnYTBVreeuGDwaRK_hA@mail.gmail.com>
Message-ID: <CAJfZ7=m=8t9MQ1gSHE9_9D8aki-mUrWtnYTBVreeuGDwaRK_hA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ci: turn on CIFuzz
To:     Evgeny Vereshchagin <evvers@ya.ru>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 12 09:31:22 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jul 10, 2021 at 2:11 PM Evgeny Vereshchagin <evvers@ya.ru> wrote:
>
> Now that almost all the bugs reported by OSS-Fuzz have been
> fixed libsepol/cil should be stable enough to get CIFuzz working
> more or less reliably. It should help to catch regressions/new bugs
> faster.
>
> https://google.github.io/oss-fuzz/getting-started/continuous-integration/
>
> The patch was tested on GitHub in https://github.com/SELinuxProject/selinux/pull/285
> The CIFuzz job can be found at https://github.com/SELinuxProject/selinux/actions/runs/1017865690
>
> Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>

For both patches:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

If nobody else has comments, I will apply them tomorrow.
Thanks!
Nicolas

> ---
>  .github/workflows/cifuzz.yml | 39 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 .github/workflows/cifuzz.yml
>
> diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
> new file mode 100644
> index 00000000..5c2233a2
> --- /dev/null
> +++ b/.github/workflows/cifuzz.yml
> @@ -0,0 +1,39 @@
> +---
> +name: CIFuzz
> +on:
> +  push:
> +    branches:
> +      - master
> +  pull_request:
> +    branches:
> +      - master
> +jobs:
> +  Fuzzing:
> +    runs-on: ubuntu-latest
> +    if: github.repository == 'SELinuxProject/selinux'
> +    strategy:
> +      fail-fast: false
> +      matrix:
> +        sanitizer: [address, undefined, memory]
> +    steps:
> +      - name: Build Fuzzers (${{ matrix.sanitizer }})
> +        id: build
> +        uses: google/oss-fuzz/infra/cifuzz/actions/build_fuzzers@master
> +        with:
> +          oss-fuzz-project-name: 'selinux'
> +          dry-run: false
> +          allowed-broken-targets-percentage: 0
> +          sanitizer: ${{ matrix.sanitizer }}
> +      - name: Run Fuzzers (${{ matrix.sanitizer }})
> +        uses: google/oss-fuzz/infra/cifuzz/actions/run_fuzzers@master
> +        with:
> +          oss-fuzz-project-name: 'selinux'
> +          fuzz-seconds: 180
> +          dry-run: false
> +          sanitizer: ${{ matrix.sanitizer }}
> +      - name: Upload Crash
> +        uses: actions/upload-artifact@v1
> +        if: failure() && steps.build.outcome == 'success'
> +        with:
> +          name: ${{ matrix.sanitizer }}-artifacts
> +          path: ./out/artifacts
> --
> 2.31.1
>

