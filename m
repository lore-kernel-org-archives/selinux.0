Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EFDC433F5
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 21:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiBRVRt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:17:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiBRVRt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 16:17:49 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1F8F47
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 13:17:31 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id j24so2270350oii.11
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 13:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YajnuaGAVy0Khd03VwCrvDNIIoJ8qVRuXS9vJYtqGA=;
        b=F1ubPgx5yQZzF/7E/t0fBKhuVYUiXPK8IoJF7ke+HS3YDcnaENr4PxHxwy9ENUGbCi
         T0klEhxEhvQ2njCPBbgX8qu6IWpx4qj0zndTHja2fU+N1/8Pw2rMBu9lWnmzB/sumoKU
         fK2U6mIuuKktHoVjQAaL8hK+EFABwvxHH3QrDkCXBmzJWZ7v5mSDy0iBppP4BgCsQHfL
         tK2F0SRlyNlqDff4OymS+7bwuoRlYu3WDMYTQRGkQ6w8vLUi73BQFfI0o1pggCIctFuA
         mMgL5wmyB2h4GxfewKEHvB3LgKjm9lKVwUxbV8+KR3tHbXudVPWzyvNe2TRu4YqFm20N
         0DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YajnuaGAVy0Khd03VwCrvDNIIoJ8qVRuXS9vJYtqGA=;
        b=3pU5cwCKvd5SBLSuPftnP20eWTSeA1MljudlSXC1dcA4njpI7sfWgrLpcrfizI91Ab
         Hgg0ZHLhLyhTWfpSS+lfyyp1cwela8k0D35GwVxE+nNsFzoOyuzcTuSVR5HSGj8pv6MA
         a07VTh8rLJYYbKDNKW8MpeBvc3nUG/aDMjkgkspSBllmXiKa+Pe3Uf1yeAMx+18XnR1e
         k4GosBsqUyK/rM13MK016fYyK56lL6kYvesVcKZ5zssqyUi88o6javZsW5A6HrrHXQil
         JGXLNfG3n2V4Xp/lxydAqE/FtATxYT4TMI8US9ui5HvzriptewmOnnsrPzOqepUHroil
         i/xQ==
X-Gm-Message-State: AOAM533EjHuGnYbJfcJrQtyWafneNUYFw7NL3KENcN/R748sNEJFmxm5
        DrcTM+oITyQCS03xKYcR9thQidT8EYp5XggeQET6U08d
X-Google-Smtp-Source: ABdhPJwRuU4c3tkVVRGY6Pjy6RrZg9ppOPkLJA9LT/wTHYYfxpjjmNhu0yWhyvtdZbzKYBZwHQuZyGl6mBv1mA7dppw=
X-Received: by 2002:a05:6808:1642:b0:2d4:5a9a:c58b with SMTP id
 az2-20020a056808164200b002d45a9ac58bmr4298451oib.200.1645219050358; Fri, 18
 Feb 2022 13:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20220119163518.93780-1-jwcart2@gmail.com>
In-Reply-To: <20220119163518.93780-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 18 Feb 2022 16:17:19 -0500
Message-ID: <CAP+JOzSKEY0YgEwHRedmRa4VyKUsLxLqFX44PEQVnn-QkCMhxQ@mail.gmail.com>
Subject: Re: [PATCH 0/4 v2] libsepol/cil: Limit certain error and warning reports
To:     SElinux list <selinux@vger.kernel.org>
Cc:     bauen1 <j2468h@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I plan on merging this series next week.
Jim

On Wed, Jan 19, 2022 at 11:35 AM James Carter <jwcart2@gmail.com> wrote:
>
> When reporting some errors or warnings, a search is made to find the
> original or matching rule. Both neverallow and type bounds violations will
> use cil_find_matching_avrule_in_ast() to find the rules in violation. For
> context rules, the AST is walked to find the conflicting rule. If there are
> a lot of errors or warnings, then this can take a lot of time. oss-fuzz has
> generated policies that can abuse this reporting, so the desire is to limit
> the reporting by default.
>
> By using the new function, cil_get_log_level(), the error reporting for
> neverallow and type bounds violations and the warnings for context rule
> conflicts can be less by default while still allowing for everything to
> be reported at higher log verbosity levels.
>
>
> James Carter (4):
>   libsepol/cil: Add cil_get_log_level() function
>   libsepol/cil: Provide more control over reporting bounds failures
>   libsepol/cil: Limit the neverallow violations reported
>   libsepol/cil: Limit the amount of reporting for context rule conflicts
>
>  libsepol/cil/src/cil_binary.c | 20 +++++++++---
>  libsepol/cil/src/cil_log.c    |  5 +++
>  libsepol/cil/src/cil_log.h    |  2 ++
>  libsepol/cil/src/cil_post.c   | 57 ++++++++++++++++++++---------------
>  4 files changed, 56 insertions(+), 28 deletions(-)
>
> --
> 2.31.1
>
