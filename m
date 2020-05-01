Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA7AC47253
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 13:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFFD2051A
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 13:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY2XxhmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgEAN60 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 09:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729985AbgEAN6Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 09:58:24 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40199C061A0C
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 06:58:24 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i27so2593447ota.7
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irCF2wSPCrUydU2nTQEmqkFnwVvD6A3WcUOuWXrT1Wg=;
        b=ZY2XxhmOQN0up1ZwTtQmu041L7FeVwrqZKV9b5pYdcAj1IbFPNSn6lwPQILJDyTnbN
         hBfyjqDwxpJiJAtr89QEUigw5p6GNSsxvjfG5DAtdcdHRN0iWLb744raRPsOWloD766z
         IbDCP/f2K8pJFnnbhOXDFYc32laOdccQDTZIsmanlzCeExahaFFEWW2xn3aVYsdPjCAa
         HqmX7dOGEj7YlOM5OS9HUa8CnDhWhxbmjQPgya03RCzUiuJroddr3ASNG1GVMzms01Eg
         HH8w8pstkG8/ltKRpX5S/YGFOR6ycqhM7ZPwodC5zGSHWq2SN0eOrZ0mafOP2b50wySV
         EC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irCF2wSPCrUydU2nTQEmqkFnwVvD6A3WcUOuWXrT1Wg=;
        b=JAndXTjTrLvfbefVr9c/eKkdonnaGSJyfue3YDqTDQMcg35fa/wU2JmMRSYl7oRYtt
         +7C75xDCe5Xo+xiSC00M3SzktGJTGdP51cGvI/oDES6Lv9r4aWzqw+U1QIQNbVo+9VLV
         zTPrE2+Oz9tbEiYZp85ts4aFw53ZL1L0qvmZ41V/XLpiiLoXcTTkI8lVzXuY+3g+zYAR
         n980xfRWxodIdbH0Er0tgtt819qBbX9K4bFhVbTC2gdiA35m+LSoxUjToEq14WVhxkyr
         F3i1xxwM31KQeq2vTbOQnGjFW8DtuqMpdcq//26DV+B5gsFEvXfa/tchFO7gEZBNMglk
         PCIA==
X-Gm-Message-State: AGi0PuY6Oh9FVdT4TfDUZx39JTFcCyC2ZCaoAD2y/76L9dNMaoNJM9Vj
        s8YclAAIGdVOrQY3w7FgUdo0BcDFPduAYzB6IMUHGO05
X-Google-Smtp-Source: APiQypIM10Qf57uahQdGDsfiFDPR0sOq7A+dcrlnLr1RAKil8ZEtIjGNDufC3BqueY+GUPgKEqpY+/2pIBLx7GYw5q0=
X-Received: by 2002:a9d:569:: with SMTP id 96mr3524683otw.59.1588341503657;
 Fri, 01 May 2020 06:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200501092330.1129016-1-nicolas.iooss@m4x.org>
In-Reply-To: <20200501092330.1129016-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 1 May 2020 09:58:12 -0400
Message-ID: <CAP+JOzS7cBr2ANcKoYa-x_C-LHMWoXB2oLbdtfAyYPr4vWT-Tg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/tests: drop ncurses dependency
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 1, 2020 at 5:25 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> ncurses library is not used anywhere.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  .travis.yml             | 1 -
>  libsepol/tests/Makefile | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 918958acfc80..4361d26cbb83 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -53,7 +53,6 @@ addons:
>      - libcap-ng-dev # This package is not whitelisted for the container infrastructure (https://github.com/travis-ci/apt-package-whitelist/issues/1096)
>      - libcunit1-dev
>      - libdbus-glib-1-dev
> -    - libncurses5-dev
>      - libpcre3-dev
>      - patch
>      - python3-dev
> diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
> index e7e305e8150b..fc9bd1a303be 100644
> --- a/libsepol/tests/Makefile
> +++ b/libsepol/tests/Makefile
> @@ -32,7 +32,7 @@ all: $(EXE) $(policies)
>  policies: $(policies)
>
>  $(EXE): $(objs) $(parserobjs) $(LIBSEPOL)
> -       $(CC) $(LDFLAGS) $(objs) $(parserobjs) -lcunit -lcurses $(LIBSEPOL) -o $@
> +       $(CC) $(LDFLAGS) $(objs) $(parserobjs) -lcunit $(LIBSEPOL) -o $@
>
>  %.conf.std: $(m4support) %.conf
>         $(M4) $(M4PARAMS) $^ > $@
> --
> 2.26.2
>
