Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79FFC433EF
	for <selinux@archiver.kernel.org>; Mon, 21 Mar 2022 20:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiCUUvM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCUUvM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Mar 2022 16:51:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C586210A
        for <selinux@vger.kernel.org>; Mon, 21 Mar 2022 13:49:45 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v75so17584283oie.1
        for <selinux@vger.kernel.org>; Mon, 21 Mar 2022 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBqrsdrh8kcTd9sKrQqvaKAkj84mF4uQSxbHVr8yxlQ=;
        b=jqQGwb9ERar0MxrTrAOOvDjGt3D/rPIRUkKhVm7PoEURQbdNSHIznjkt0aQcPyfi+3
         i/DDgeforJcrikjr7pC4g6G0twSXzXYWF4aMxBuDkMELjYosHDWi7nbH+AH22vL6RHqb
         tcx5OOoJsotmG9aQQSLAT+qzapuFv6ZqHFw7Wl5eNws9NaOvMcKjdo/M9qyaiwfVzKKi
         7e1SQy+gzJbUMdohId5lbtG4dVaPvckvZPEwpBEgLjgMACZOQpmxQKsmg5lrl9CZdPZg
         kTib0nwsLNAf7f2s+6iib2gKjMmn9HHE+ymO4cm+oCmHFjsg/k8ZSpDFALjSnsxH6hqx
         G5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBqrsdrh8kcTd9sKrQqvaKAkj84mF4uQSxbHVr8yxlQ=;
        b=eT/HkW2RE0bxWGEE2fTLfEGRo2bBnOXzKDmIK2Qs15M9+89cghickqPpkVK814JxSA
         OUrsXIDJfTv4vTyMQApAfLVaqWCIS3FPIfP7MJB5/39WgHhTw6u89IjxA240XH6pFeAk
         inOadlzOMe9+pY+dB8q2s8jSjK/M0dLkO2ZI9fu0HksHchVqeDRVM5z1nP0RCqSU4X2j
         xTPcrCRKk1pFDW3G0i2bG0MSKU1BXJdxaoE3n44BYT64H0mapB4+Tn26yLItBJrGtOHJ
         k7wQREhn8oKcLv8ir0kiB98Y7PPYsh8uQeB+NlbiW6rFUj44ReK+yDN7dB9D7z3ypp7f
         AOmA==
X-Gm-Message-State: AOAM5309l0Jj2UYeu67qHHvXqVhAIo36yUIPfyjDUrB8T6mUPm/Lvbef
        t/JtK0MgVex7cnwjdPqu4wbpAqNogGh7UgMB0Gd17sQl3x4=
X-Google-Smtp-Source: ABdhPJyQuRHofBdhvaN56vuEqJ7Ay1iXsZT+z9wugpUUSulwfsAFXODLeRchowu0TFKwVviHU5pM0eJKyXy4KIsKtTI=
X-Received: by 2002:aca:c184:0:b0:2ef:6652:5584 with SMTP id
 r126-20020acac184000000b002ef66525584mr502203oif.156.1647895784743; Mon, 21
 Mar 2022 13:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220321105250.148231-1-dominick.grift@defensec.nl> <20220321115054.150336-1-dominick.grift@defensec.nl>
In-Reply-To: <20220321115054.150336-1-dominick.grift@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Mar 2022 16:49:33 -0400
Message-ID: <CAP+JOzRU-N-tP50iTB=EoV=tLU=KphRiZvUgLe+-HqwiDaJDAQ@mail.gmail.com>
Subject: Re: [PATCH v2] optional statement is not valid in if and require statement
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 21, 2022 at 10:30 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> the conditional-policy-statements chapter describes which statements
> are allowed in if statements and optional is not one of them
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: adjusts kernel_policy_language.md as well
>
>  src/kernel_policy_language.md    | 2 +-
>  src/modular_policy_statements.md | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/kernel_policy_language.md b/src/kernel_policy_language.md
> index b7b72ce..4f01609 100644
> --- a/src/kernel_policy_language.md
> +++ b/src/kernel_policy_language.md
> @@ -262,7 +262,7 @@ within an *if/else* construct, *optional {rule_list}*, or
>  | *neverallow*     |        Yes        |      Yes    |Yes [^fn_kpl_3]|          No            |         Yes        |        No         |
>  | *neverallowxperm*|        Yes        |      Yes    |      Yes      |          No            |         No         |        No         |
>  | *nodecon*        |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
> -| *optional*       |        No         |      Yes    |      Yes      |          Yes           |         Yes        |        Yes        |
> +| *optional*       |        No         |      Yes    |      Yes      |          No            |         Yes        |        No         |
>  | *permissive*     |        Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
>  | *policycap*      |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
>  | *portcon*        |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
> diff --git a/src/modular_policy_statements.md b/src/modular_policy_statements.md
> index e62e6ac..508d531 100644
> --- a/src/modular_policy_statements.md
> +++ b/src/modular_policy_statements.md
> @@ -190,7 +190,7 @@ Conditional Policy Statements
>
>  | *if* Statement          | *optional* Statement    | *require* Statement     |
>  | ----------------------- | ----------------------- | ----------------------- |
> -| Yes                     | Yes                     | Yes                     |
> +| No                      | Yes                     | No                      |
>
>  **Examples:**
>
> --
> 2.35.1
>
