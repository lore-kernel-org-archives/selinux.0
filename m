Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B848C4321E
	for <selinux@archiver.kernel.org>; Thu, 17 Nov 2022 21:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiKQV0V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbiKQVZ2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Nov 2022 16:25:28 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D5490B7
        for <selinux@vger.kernel.org>; Thu, 17 Nov 2022 13:25:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a29so4932573lfj.9
        for <selinux@vger.kernel.org>; Thu, 17 Nov 2022 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH4/UKY/9bqVwL35AhPcR3scssiVpuKh4ttOrLtKiwg=;
        b=MZ/pNMLJN/BqwTFuC+7/u45zuoK11GiOVqcTqPl+JvN10y7gE2RY1YRDWglMSqodmt
         /yNYdxiLfNO+QdQt5vPOrgf0R9ahcRLh9hVCeA6ABdxuGuu9+mU0QMSbtmsb3CteG2kQ
         S8fM3lUdRPQ4q0GGkyxqa9AEd2pdSv06UEEQxk6EddHcENH+KnC3A3LkRMnPI18mlXIc
         cxSvM+bq6HOl+pgYriZxfIsc0hWwttCTdvDrW2gF55+iYHtMdts1xIALmnCizWn358C7
         iCQov5X2EZDkqlQnKqSDulLSkkmGvrmozhGcuWsqn0okz/VjBvQU+N1oIJlpue/Za/sb
         SdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HH4/UKY/9bqVwL35AhPcR3scssiVpuKh4ttOrLtKiwg=;
        b=0wH3kmuVy0NDmgyQHDLZhToXTpVPoS7WdarZibuQJ/ltD/DZ4gXg9UXWuQyhbkH1IJ
         PXo5s1AT3LdLgInX4MUt2hzMkiXlqCk6xuKRMvnSK357/3XQaP3ueMg/iCWrqfsu8nPO
         Vo9YYUDHR5BynaV7VweaKE4mWRSuASzL8TZPgtgqs0rr5r6rf2tk+galgJ9H92+nXobi
         /UNEc83XQCEXgBKjweeJNYxFYDLb+8CD+ksRRIBrZpxU0CmYK91Fv2cv/3hWmHeNRXW5
         dfXFXiH2Pza+jpVTefJfZS8SPyeHmPvJCGO3c1GmaA1Dr/v93I7FQ9CPrpfKMZNa/Pjz
         99PA==
X-Gm-Message-State: ANoB5pmYW0dXAfSWkr+vpJUdGY0NP+ho6kbfx52vCA0/QjpWC0mTnYxJ
        97IDmLxIK/2vdq/7qsRGq00kbP0I/ExSDUR6cIrU8uq1xrk=
X-Google-Smtp-Source: AA0mqf4dOqxq5ZJpKNC8zRQ+SYwI67+mdcZgHLCr7p4xlCTgpfFcZiic7EWr3kPgsxkCAb6wZriVbaBPHsSq5cg5PeE=
X-Received: by 2002:a05:6512:3603:b0:4b4:b5d8:880d with SMTP id
 f3-20020a056512360300b004b4b5d8880dmr1403891lfs.121.1668720320532; Thu, 17
 Nov 2022 13:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20221114194031.12245-1-cgzones@googlemail.com>
In-Reply-To: <20221114194031.12245-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 17 Nov 2022 16:25:08 -0500
Message-ID: <CAP+JOzTTB1vSnjza25P0HkCVXQKe+YaaNERGQav9LU6Pkv1O_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/tests: use more strict compiler options
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 14, 2022 at 2:42 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use the more strict C compiler warnings from the root Makefile.
>
> Also fail on warnings from the m4 macro processor.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/tests/Makefile            | 19 +++++++++++++++++--
>  libsepol/tests/test-linker-roles.c |  2 +-
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
> index a72c327d..273373b0 100644
> --- a/libsepol/tests/Makefile
> +++ b/libsepol/tests/Makefile
> @@ -1,9 +1,24 @@
>  ENV ?=3D env
> -M4 ?=3D m4
> +M4 ?=3D m4 -E -E
>  MKDIR ?=3D mkdir
>  EXE ?=3D libsepol-tests
>
> -CFLAGS +=3D -g3 -gdwarf-2 -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmiss=
ing-format-attribute -Wno-unused-parameter -Werror
> +CFLAGS +=3D -g3 -gdwarf-2 -O0 \
> +       -Werror -Wall -Wextra \
> +       -Wfloat-equal \
> +       -Wformat=3D2 \
> +       -Winit-self \
> +       -Wmissing-format-attribute \
> +       -Wmissing-noreturn \
> +       -Wmissing-prototypes \
> +       -Wnull-dereference \
> +       -Wpointer-arith \
> +       -Wshadow \
> +       -Wstrict-prototypes \
> +       -Wundef \
> +       -Wunused \
> +       -Wwrite-strings \
> +       -fno-common
>
>  # Statically link libsepol on the assumption that we are going to
>  # be testing internal functions.
> diff --git a/libsepol/tests/test-linker-roles.c b/libsepol/tests/test-lin=
ker-roles.c
> index 2b17dffd..b35bdbe6 100644
> --- a/libsepol/tests/test-linker-roles.c
> +++ b/libsepol/tests/test-linker-roles.c
> @@ -53,7 +53,7 @@
>
>  /* this simply tests whether the passed in role only has its own
>   * value in its dominates ebitmap */
> -static void only_dominates_self(policydb_t * p, role_datum_t * role)
> +static void only_dominates_self(policydb_t * p __attribute__ ((unused)),=
 role_datum_t * role)
>  {
>         ebitmap_node_t *tnode;
>         unsigned int i;
> --
> 2.38.1
>
