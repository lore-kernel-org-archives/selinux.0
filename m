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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24963C433F5
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A89061212
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 14:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhIOPBD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 11:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbhIOPBC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Sep 2021 11:01:02 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E6CC061575
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 07:59:43 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s20so4586304oiw.3
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U1HiEcYcLDZjSPgra5ta5bWVX6oxvUwN6TkrUsyiC7k=;
        b=JfUhUknehJVhmLm4Q+9aW+VZuR5oN7/ReXSKSxctxJlOHKz3tkJHQDR9EUBtDV+9LE
         VZAZcBC6ark7B89uHI+LilpvvrscJos9onpuNWy8d0M6E+pq6nNfhrli0dZQcUR6zGZg
         IJp3XhtR6Cu5F12dDFyKalJmCtx+mbHodN3K6V6bbwH7+Pq0JEiyvCtCI8ALufQ9oCf+
         w0Hn9vLWNjolXhje0anHZR5SNxuNn8bKaxPJTPSqhFJ7uWeY97blxoL9gSKFpuyJt3Is
         YLeBUvzn0HADErMoxPnBwI+lB+oroKrRwXQSmWrcLrGhKDGeXHCWpKQhYc/z/DY+2vLM
         lUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U1HiEcYcLDZjSPgra5ta5bWVX6oxvUwN6TkrUsyiC7k=;
        b=FvglK+CMnGs+bY+jsefmsvr31Ntoj4WNRVjHH55eM8r8TJDP7Fors18VFNIuGKyttB
         1DqHXc53oy2tBiwAeDo3297909AYNpe3gbUILLALIZ0XEH7728JD1BPmY1nJauw+2DDS
         IzXgshX02VqSUiTZgsbP4Z5cpwPShCVKyiM13zigxa/7OeI5+ASb4ghVzf8m1bPyeQ8M
         MZ6iiAEuVh+jlHgxf1r0MrxEo+xIoarMEEbHu11fiMvGPcp9XcsQ0O1PW22xpT+O/lzw
         aavI+wagFCm0EnZxH4BrYTuoXyfs8ZlPFy2A7iF3GOXW5Frt0cW9BzXBrc6TTxKHATgc
         Scyw==
X-Gm-Message-State: AOAM533PDMUept8MPxX/7WMexeRymQCIq2z3cQ8iJrwArGsqOwsDU1bZ
        IzE1ay4YL79hPThczCw6tNbHDBd3O/NBb84U7U1ukU2zVlc=
X-Google-Smtp-Source: ABdhPJxdndhd5/QyZ956SfPkb2oapO5SdG6DYalS3NXIQI1fh3DMFcPiwrYi1kv2Hjk0HiVg5ar7zETmwG3TcAxk9tw=
X-Received: by 2002:aca:f189:: with SMTP id p131mr5663871oih.128.1631717982511;
 Wed, 15 Sep 2021 07:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210914124828.19488-1-cgzones@googlemail.com>
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Sep 2021 10:59:31 -0400
Message-ID: <CAP+JOzRB4kENk2HGCQ2it-mPbY90oYaDn9w+RFmMt80v=-CcKw@mail.gmail.com>
Subject: Re: [PATCH 00/13] checkpolicy improvements
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 14, 2021 at 8:51 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Miscellaneous improvements to the checkpolicy subproject, affecting the
> traditional language compilers checkmodule(8) and checkpolicy(8).
>
> Avoid implicit conversions, free leaked memory, resolve several compiler
> warnings, use strict integer parsing.
>
> The last patch is an adoption of a patch proposed by liwugang [1], with
> the requested changes integrated.
>
>
> [1]: https://patchwork.kernel.org/project/selinux/patch/20210601151704.26=
88389-1-liwugang@163.com/
>
> Christian G=C3=B6ttsche (13):
>   libsepol: avoid implicit conversions
>   libsepol: free memory after policy validation
>   checkpolicy: enclose macro argument in parentheses
>   checkpolicy: misc checkmodule tweaks
>   checkpolicy: misc checkpolicy tweaks
>   checkpolicy: mark read-only parameters in module compiler const
>   checkpolicy: mark file local functions in policy_define static
>   checkpolicy: add missing function declarations
>   checkpolicy: resolve dismod memory leaks
>   checkpolicy: avoid implicit conversion
>   checkpolicy: error out on parsing too big integers
>   checkpolicy: print warning on source line overflow
>   checkpolicy: free extended permission memory
>
>  checkpolicy/checkmodule.c        | 18 +++----
>  checkpolicy/checkpolicy.c        | 26 +++++-----
>  checkpolicy/module_compiler.c    | 26 +++++-----
>  checkpolicy/module_compiler.h    |  4 +-
>  checkpolicy/policy_define.c      | 87 ++++++++++++++++----------------
>  checkpolicy/policy_parse.y       | 16 +++++-
>  checkpolicy/policy_scan.l        | 25 ++++++---
>  checkpolicy/test/dismod.c        |  7 ++-
>  libsepol/src/policydb_validate.c | 14 ++++-
>  libsepol/src/util.c              |  2 +-
>  10 files changed, 131 insertions(+), 94 deletions(-)
>
> --
> 2.33.0
>

For the whole series with the v2 and v3 patches:

Acked-by: James Carter <jwcart2@gmail.com>
