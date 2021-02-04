Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1003C433E9
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 20:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AF864F67
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 20:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhBDUOb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbhBDUNz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 15:13:55 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C3C06178A
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 12:12:46 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d7so4689295otf.3
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVLL9ru1qgTC7QpnDcIXm4S3hFMSDGQF71imrVIGRFA=;
        b=Zc3IE57TCETwP4M4VzS3nebefylYgU55LauFrc+vtxsL6NFQPKkAXHkGfn/U6LY9RU
         LrMj/59ARBVGlXz4OrzETiP1w9Wt/jPRYW11RCZ3uBnpVwu9Kwm8hKp0DjA0XcYr1NaL
         C31Z0VdVMbC+lqgzI6Upb1QuMO32gjvIAImECW5C0AssjncG7J81geABzYlMtZwcmWdj
         olgej16BKkuCzkc0OZciHLBdDt25HVXIzIrdWVvX/tXX+YPtOUPre32/GYwuWp0GFI9u
         KvzdMJUdzYe35sLoZTZIsYtOhJt7E01sxcc4AjIw9zxd8raox53WFIfBgIvI8HUS2Zws
         Hymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVLL9ru1qgTC7QpnDcIXm4S3hFMSDGQF71imrVIGRFA=;
        b=An4QzV93ixglbL0d63Z0yHrIhO7nLvtPpZ0aSXoOb1uYeICah3xvowyHOFe80Hgd9u
         NkCtrMADtXQjsiOWSWGicvAz8MoKuSsCTcXHCtpzyFuj5zEXVvDxckXh8Xk7BD07hgit
         5MZUd1JXEqIybdwEkGFomaGV2NT/AOVdeqIbR9mdI2/LyTM1tk3t57wWzVQ2GC5j1jv7
         45+UywuqQji3rsaANb0jg4WJ9lkilSwqlBqukdtInHm8GyMUBYFGpwv4YNFGdd7jfolC
         4uPvE8u5F/+isui3sWpq9++ntxtqsaNu7fz7qh2VeJPMik56jaWpsEVFDLRcR/y5tmyu
         gyNQ==
X-Gm-Message-State: AOAM532k+XCTKwL7HAO0vBu+Udr3wxyt6y6c4TNr3QEsYYLFRcvpLGfK
        gdtNbO/3LYNvy5mMyDV02IYphrloPNytQZIXwEEUvrgozmA=
X-Google-Smtp-Source: ABdhPJxQdhA35A0g04tt0dH9QYjkx7vorWwNMo8/ae3pzhTkgc8MLIaoe/b19tKcDG+cRyj4PfbJ++daHWcqIxHEcOI=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr842285otu.59.1612469566220;
 Thu, 04 Feb 2021 12:12:46 -0800 (PST)
MIME-Version: 1.0
References: <e8b641c5-4e60-a264-1a4e-0c0b2dd98981@gmail.com>
In-Reply-To: <e8b641c5-4e60-a264-1a4e-0c0b2dd98981@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 4 Feb 2021 15:17:48 -0500
Message-ID: <CAP+JOzQ6Vv7dFJfqBUe5SO596UVQ3-SzJ_Vi50nLf7fv6ofTVQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] secilc/docs: add syntax highlighting for cil examples
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 4, 2021 at 12:10 PM bauen1 <j2468h@googlemail.com> wrote:
>
> Hi,
>
> To make editing the secilc docs easier, I've modified it to use fenced code blocks around all cil examples.
> This way editor syntax highlighting can do a better job and as a result I've found 3 minor bracket issues that are also fixed in patch 1.
>
> To allow pandoc to also do syntax highlighting I've written a rudimentary syntax definition in the format consumed by pandoc (https://docs.kde.org/trunk5/en/applications/katepart/highlight.html#katehighlight-xml-format) and enabled it.
> However pandocs default themes aren't the best, some of them don't highlight every keyword I've added, color scheme doesn't fit, etc ...
> On the other side It's very hard to just find 6 colors that work well together.
>
> I've uploaded an example using the default pandoc theme:
> https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide.html
> https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide.pdf
>

I notice on page 10:
(block unconfined
    (user user)
   ...

That the second user (which is the name of the user) is highlighted as
well as the user keyword.

Similar thing happens further done on page 10 with the rule:
(portcon udp 12345 (unconfined.user object_r unconfined.object ((s0) (s0(c0)))))

The "user" part of "unconfined.user" is highlighted.

"unconfined.user" is used in other examples as well.

Changing the first statement to be (user user1) would be fine, but I
would like "unconfined.user" to remain as is.
I am not sure how hard it would be to fix that.

I am not sure if this matters to anyone, but if the document is
printed, the syntax highlighting (particularly for the comments) might
make it a little bit hard to read.

Thanks,
Jim

> bauen1 (2):
>   secilc/docs: use fenced code blocks for cil examples
>   secilc/docs: add syntax highlighting for secil
>
>  secilc/docs/Makefile                          |  12 +-
>  secilc/docs/cil_access_vector_rules.md        |  33 ++-
>  secilc/docs/cil_call_macro_statements.md      |  10 +
>  .../cil_class_and_permission_statements.md    |  42 ++++
>  secilc/docs/cil_conditional_statements.md     |  16 +-
>  secilc/docs/cil_constraint_statements.md      |  16 ++
>  secilc/docs/cil_container_statements.md       |  16 ++
>  secilc/docs/cil_context_statement.md          |  10 +
>  secilc/docs/cil_file_labeling_statements.md   |  14 ++
>  secilc/docs/cil_infiniband_statements.md      |   9 +-
>  secilc/docs/cil_mls_labeling_statements.md    |  50 +++-
>  .../docs/cil_network_labeling_statements.md   |  16 ++
>  secilc/docs/cil_policy_config_statements.md   |  12 +
>  secilc/docs/cil_reference_guide.md            |  27 +++
>  secilc/docs/cil_role_statements.md            |  26 ++
>  secilc/docs/cil_sid_statements.md             |  12 +
>  secilc/docs/cil_type_statements.md            |  50 ++++
>  secilc/docs/cil_user_statements.md            |  42 +++-
>  secilc/docs/cil_xen_statements.md             |  20 ++
>  secilc/docs/secil.xml                         | 224 ++++++++++++++++++
>  20 files changed, 644 insertions(+), 13 deletions(-)
>  create mode 100644 secilc/docs/secil.xml
>
> --
> 2.30.0
>
