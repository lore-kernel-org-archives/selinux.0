Return-Path: <SRS0=FN9z=54=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A2AC2BA2B
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86525206E9
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 16:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNaFDLKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86525206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgDLQzG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Apr 2020 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDLQzG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Apr 2020 12:55:06 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 12:55:05 EDT
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44693C0A3BF0
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 09:45:33 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w20so7118664iob.2
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+N1hEd87wSXQAR/3bQidivaf+VQCZbA8ncjVDYvF04=;
        b=uNaFDLKRKWav7p641DLiqwN+y6KG2LxBoXyq8oWzZwb3fqb9Hk6vXoR1VOnHvZIldO
         HKcHvEx8+DyYcNG9CfhGEvfqXhv5nEpYfyyEMw3iCcjrK1HZvu+h9Ylt1INrli34J/5A
         NClmTJ08bKsXkCSGU60GTgg7VB0CUhOe53Wy47DLIvMy5zKtE/ymgLoh7gdrZiHbaTlM
         dag72lCoVEvUSZtHHdRjqHdvMqUjyAIwkBLpBp5ZshnXwVS96XZZSWlA6quyFM2/ERaD
         sxtlGmZOE/TDLmN5daIkhnabkSYPmBnV0ZzKXvpFRD8e3lK3SmRRh9PqvTVfBIsnxB3I
         sgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+N1hEd87wSXQAR/3bQidivaf+VQCZbA8ncjVDYvF04=;
        b=HNlvWXHkbNAUgGoEJ7FDrxuUFvbXgGdt+PuuRGU9XswGpcXDh4Yt+WO1He9x0UR7R7
         Yw2beG3qphsMvKguESG8Lv6FsCbDuszbxnXWj5ijxCL2Z3cChoOViVvYC5Xwf1M0e1+/
         lWxjvwFbaCAFm5M2mgCbC1YogVLIG3AZz3T3nVu99RL1d9DTH905VP0fQjY8+8CQgwWd
         G5544AVllxF/Zs/Z+Lw68nddAZIYb0++QsLwKu47LrP+IVQn0EqxDqgc1dPoyWTiHnHt
         ALYXnXt5dKWEwgyPYBqGEKWy6cxIsMvFe5n6lj5PfzNOr3h5VlY8NFgL8hukfYporZdT
         3DGQ==
X-Gm-Message-State: AGi0PuaDUTaGr8fHWrrgLzfU6Qve0bEZNzI/n4VupGrxkYu9+Mgbbzc+
        ehEykrLTik0cqOgfSDQqiMo5uVJcLJjpjqstj8C+dCTr
X-Google-Smtp-Source: APiQypL69ps7zkOptnSd8xCWnODw7xdT4inoyOVXUeXA6Zw+FCGSbzwLwJJ7RP82X5yqsTw4rquyBW5auPWiyubOd5c=
X-Received: by 2002:a02:cd03:: with SMTP id g3mr12187176jaq.61.1586709932455;
 Sun, 12 Apr 2020 09:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=k9UsVjai1ZaBQUquQv6X3B-RkPGL4PikhtLyNGiGOnJQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=k9UsVjai1ZaBQUquQv6X3B-RkPGL4PikhtLyNGiGOnJQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 12 Apr 2020 11:45:21 -0500
Message-ID: <CAFftDdohqX3vdg=VCSEu_1BQhOUv0ry0vRYtchAFecYZOPK-qQ@mail.gmail.com>
Subject: Re: Duplicate versions of libsemanage symbols
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 12, 2020 at 11:27 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Hello,
> Since recent changes in libsemanage.so's linker script, I have been
> experiencing issues. As I encountered these issues only when I was
> using a build configuration which is slightly different from what is
> in the repository, I wanted to spend time to investigate what was
> going on before eventually submitting a proper bug report.
> The issue I see is the following: when I compile with the gold linker
> and a custom set of build options, linking libsemanage.so fails with
> [1]:
>
> /usr/bin/ld.gold: warning: using 'LIBSEMANAGE_1.0' as version for
> 'semanage_get_hll_compiler_path' which is also named in version
> 'LIBSEMANAGE_1.1' in script
> /usr/bin/ld.gold: warning: using 'LIBSEMANAGE_1.0' as version for
> 'semanage_get_ignore_module_cache' which is also named in version
> 'LIBSEMANAGE_1.1' in script
> /usr/bin/ld.gold: warning: using 'LIBSEMANAGE_1.0' as version for
> 'semanage_set_ignore_module_cache' which is also named in version
> 'LIBSEMANAGE_1.1' in script
> ...

Does it actually fail or just print these warnings? IIRC, @sds replied with some
superfluous linking warnings, but we ignored them. I tried looking
through my mail
and the archive but I couldn't find it.

>
> Looking back at a normal build of current git master (that succeeded),
> I indeed have:
>
> $ objdump -T libsemanage/src/libsemanage.so | grep
> semanage_get_hll_compiler_path
> 000000000001b9b0 g    DF .text 000000000000021c  LIBSEMANAGE_1.0
> semanage_get_hll_compiler_path
>
> The same command on libsemanage 3.0 (last release) gives:
>
> $ objdump -T /usr/lib/libsemanage.so | grep semanage_get_hll_compiler_path
> 000000000001a3c0 g    DF .text 0000000000000224  LIBSEMANAGE_1.1
> semanage_get_hll_compiler_path
>
> In short, semanage_get_hll_compiler_path is defined twice in
> libsemanage/src/libsemanage.map [2] and the linker only provides the
> first one. In fact, libsemanage.so built from git master has currently
> only 2 functions in LIBSEMANAGE_1.1:
>
> $ objdump -T libsemanage/src/libsemanage.so | grep LIBSEMANAGE_1.1
> 000000000001e1f0 g    DF .text 000000000000010d  LIBSEMANAGE_1.1
> semanage_module_install
> 000000000001eea0 g    DF .text 000000000000011f  LIBSEMANAGE_1.1
> semanage_module_get_enabled
>
> These functions changed their API between versions 1.0 and 1.1, so
> this is normal (there are .symver macros in the code and they work
> properly). The issue is that all the other symbols went into
> LIBSEMANAGE_1.0 instead of LIBSEMANAGE_1.1. Is this a bug or did I
> misunderstand something? Should the duplicated functions be removed
> from LIBSEMANAGE_1.0 in libsemanage.map?

objdump -T is probably a better way to do this than what I had with
readelf, as it shows the version.

Let me roll a patch, I probably have to go through the others as well.

>
> Thanks,
> Nicolas
>
> [1] https://travis-ci.org/github/fishilico/selinux/jobs/674002033#L2471
> [2] https://github.com/SELinuxProject/selinux/blob/aa40067b7b86d5e4c951fccae1aa98baff148613/libsemanage/src/libsemanage.map
>
