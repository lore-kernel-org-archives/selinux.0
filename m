Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89EDC433ED
	for <selinux@archiver.kernel.org>; Tue,  4 May 2021 20:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A96461166
	for <selinux@archiver.kernel.org>; Tue,  4 May 2021 20:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhEDUI7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 May 2021 16:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhEDUI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 May 2021 16:08:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EECEC061574
        for <selinux@vger.kernel.org>; Tue,  4 May 2021 13:08:03 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso9387385otv.6
        for <selinux@vger.kernel.org>; Tue, 04 May 2021 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yh97mdG71ZLqxTa6ibSTgAqOdCBp5KnVDXChSyc7c4Y=;
        b=VK8dGfQQSkYfq7jP7vG63BILX+6uvEAPO4q8BIGLvQaauAU6cKVdhoHTzAArY/9r5o
         1sWxDjnuMktJgR05vouxJTfa0I1mERlmXwgj/g+LwjI1DmMD8CXxdzNerqO+EQXzPivb
         FM93GEnDNPZThm0XinuyQ/H42bKjELMd6+22URIW58c7wtQroV/tp8DBtRMs5pZPxCY/
         yDrSGUQnTaqdHcVuu3SMU3W9Myg4gnfwKITgwcsH7+k1swWCOhM9Wffr41IgdjeOa6ui
         DqX6MM509D+F0LYoCwhAq/KFH3SDSCE90fupBNDlYr8YJW5yQpvZZ2KaDtL/UH2Bl7uu
         /QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yh97mdG71ZLqxTa6ibSTgAqOdCBp5KnVDXChSyc7c4Y=;
        b=N8CFWw+8cxrnEYpn6XQ52UdRYK5C5gB1XCaPnjLuCukXjti1jWNaO05R4e7YmPN53d
         iFdYvMS6uGr4cFtj3SvpYb3PbosE/tusU02lKwqfyqjQcF0OvAs1QZ6vwjPr8ydmmGBb
         0HzR4lNZt2fbAwv2swREBgIG3SqY8cGI6MFO7tfqsaNE4t3bR4Z2yjFb8IW72vfy01bR
         nK/yI1PFR0xeHoqqAfnZ8TVDHKAqbptJIlqB2I/0NlpAyHPjaXnmCy9sE9OtqjU0abq/
         NvKKkxwqLEG5SWre8lJ0ec0IYt743ObgwPWTY5H9/hCCTMW9r4kywIsPrSaI8q1naej7
         sSIA==
X-Gm-Message-State: AOAM530vk7dWBGRantzEmSCH4uz8a0/Umb84z7AoK8j563CIHh+K8rKM
        KGQr+1DsrhMDuGc8ZWgfuBSLWrxNNYdA22OQeYQm/uVsa+U=
X-Google-Smtp-Source: ABdhPJxAJVBEJ+adrft6Uc2ng45HDWPoOzzCrAkTvEJ3uNaEG9Z/FInkHlOOIA+zz52ATJ3Y0tJuL1fn0MUtOqoPZ5Y=
X-Received: by 2002:a9d:614b:: with SMTP id c11mr9826271otk.59.1620158882976;
 Tue, 04 May 2021 13:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210428201753.282831-1-jwcart2@gmail.com>
In-Reply-To: <20210428201753.282831-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 4 May 2021 16:07:52 -0400
Message-ID: <CAP+JOzSONdWXYcWepkUHYL8siUGH0-ozyrMEGpHPbrxpS-UNCg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix bugs identified by the secilc-fuzzer
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 28, 2021 at 4:17 PM James Carter <jwcart2@gmail.com> wrote:
>
> These patches are all related by the fact that the secilc-fuzzer
> identified the bugs that led to them. Wherever possible I have
> tried to fix all of the issues related to the specific one found.
>
> James Carter (5):
>   libsepol/cil: Fix instances where an error returns SEPOL_OK
>   libsepol/cil: Detect degenerate inheritance and exit with an error
>   libsepol/cil: Check datum in ordered list for expected flavor
>   libsepol/cil: Check for self-referential loops in sets
>   libsepol/cil: Return an error if a call argument fails to resolve
>
>  libsepol/cil/src/cil_build_ast.c   |   3 +
>  libsepol/cil/src/cil_internal.h    |   2 +
>  libsepol/cil/src/cil_resolve_ast.c | 107 ++++++++++++++++++++---------
>  libsepol/cil/src/cil_verify.c      |  97 ++++++++++++++++++--------
>  libsepol/cil/src/cil_verify.h      |   1 -
>  5 files changed, 151 insertions(+), 59 deletions(-)
>
> --
> 2.26.3
>

All but patch 4 has been applied. I will send a v2 for patch 4 based
on the suggested by Nicolas.
Jim
