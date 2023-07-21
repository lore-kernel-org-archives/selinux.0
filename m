Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D6EB64DD
	for <selinux@archiver.kernel.org>; Fri, 21 Jul 2023 16:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjGUQSL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGUQRq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jul 2023 12:17:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0BE30FF
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 09:16:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b89d47ffb6so12706525ad.2
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689956197; x=1690560997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOfcF6KC97lXasyQVeAOft04SGnnQ/5b4hYknAwKrjA=;
        b=I7MkF4r57mMZK0tMPo4rDKdSKlHUiiDZWesKn6ZA3q3nKQEI/brg0chEYE8T5YZcGy
         7btgrhms6d5BkFaIombCIOVrPfYyLRY5HhsluGfRWtvBMRJi2Jr4LgTBQ5ve+4X5w2Zi
         EoQp1aDZlbruvA7V4jENiuM2xSjKJtWwhIaY36z7JXW0LAB+S3YgioyfeyTrON5VhhBr
         ljjALHcyVPM69JRgYqx07Si/EORzpMEH0063W0oemWwaMnQRFFlbqvFzycCLNpfStLKJ
         chhWIiQNsWhy3KfCL6Z2yYPxA3So4Hz0kNQAB3fLKKFluN/VPnNv3u9BVnHdxhTBV0Xy
         0kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956197; x=1690560997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOfcF6KC97lXasyQVeAOft04SGnnQ/5b4hYknAwKrjA=;
        b=H88xiIWUMnnSc7210OZ2BVcopw3Rb9V5yRLFOKI8oyhHjhyDQ2r2sv3cpzuW2hI2DE
         DijJ8matbI1m4J5taZEYeQ5swu+mWwWmX6ESLfztbmmON44qjIaTnOendMQco0o7L+yi
         FfeaVCl30oHwWSsbE6bLwzVRB5Z1L8eoZoY+uOLeIV8LkOYGg59p5VTkZkn/sibPI9AZ
         ewxXyGNsoVNFzQaG6xyOrZVXs7cNKLB8hho/eJxW+kRu8Wb+oF4pekrmMYKLR5P2X+wZ
         0oqfsHrh1rUHZzxcDAe3bWqPw3daEKst4t34sa2BS/qp0jQrwIDpS76mu7jSHA+miNNQ
         P50w==
X-Gm-Message-State: ABy/qLZEPyi2CitS6fu8g7uDz+BTyudl14GBxbS5Gs49NQyJv/kuZZbg
        maSFCucSIe/n1C9uhi5fPp9Itvf8J3ZalfSRZyY=
X-Google-Smtp-Source: APBJJlELCBo3IY9Z9ETMuwz2fmtDHKhh/K6QHRRucSaHGuPMo9d2j8BpYJQy1TdSxQEjHBe95PAmXmeetIwk/6URBDQ=
X-Received: by 2002:a17:90a:9311:b0:262:ece1:5fd0 with SMTP id
 p17-20020a17090a931100b00262ece15fd0mr1730505pjo.12.1689956197204; Fri, 21
 Jul 2023 09:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230121180318.11853-1-carenas@gmail.com> <20230123014047.84911-1-carenas@gmail.com>
In-Reply-To: <20230123014047.84911-1-carenas@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 21 Jul 2023 12:16:25 -0400
Message-ID: <CAEjxPJ4qzgLWJ8neZBd9TLP-rzE0JrXYCKx0+NCQiFbErWcmpA@mail.gmail.com>
Subject: Re: [PATCH 0/3] improve performance of pcre matches
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     selinux@vger.kernel.org, "inseob@google.com" <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 22, 2023 at 8:46=E2=80=AFPM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> The following series optimizes the way PCRE2 matches are done by using
> more efficiently the match_data resources and shows over 30% reduction
> in cpu utilization while only using 1/5 of the memory as shown in the
> bug report[1] that started it all.
>
> The first patch is just an administrative change that I found useful
> while building and testing the code with a development version of PCRE2.
>
> The second patch reverts the workaround merged in 30b3e9d2 (libselinux:
> Workaround for heap overhead of pcre, 2023-01-12) while addressing the
> increased memory utilization that it was trying to prevent by changing
> the way the match_data required for each match was being handled.
>
> The last patch changes the single threaded codepath to allow for a simila=
r
> performance improvement done to the multithreaded codepath by intentional=
ly
> leaking one match_data that could be reused for all matches.
>
> Carlo Marcelo Arenas Bel=C3=B3n (3):
>   scripts: respect an initial LD_LIBRARY_PATH with env_use_destdir
>   libselinux: improve performance with pcre matches
>   libselinux: use a static match_data if single threaded
>
>  libselinux/src/regex.c            | 111 +++++++++++++++++-------------
>  libselinux/src/selinux_internal.h |   4 ++
>  scripts/env_use_destdir           |   8 ++-
>  3 files changed, 73 insertions(+), 50 deletions(-)
>
> [1] https://github.com/PCRE2Project/pcre2/issues/194

Sorry for the delay in responding. Looking at AOSP, I only see the 2nd
patch in this series applied, not the third one. Checking to see
whether the 3rd patch is still desired/needed.
