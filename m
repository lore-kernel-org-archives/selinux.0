Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6104AC433DF
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 02:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B8420823
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 02:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Wxf82dhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHFChs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgHFChr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 22:37:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B6FC061574
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 19:37:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g19so34790549ejc.9
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJiyOatu2BrhSaaNI3CEOgqyKkXrPoiolBEFQyTeOqc=;
        b=Wxf82dhOxY0sN6GhRRXjQlAPQX6xTnqydghQKLHDdhKQTuT7pgrhD/70lji4Mq7UNH
         u82EQ9yHGo0stC7Wi3XU30vrHPOTUwSURD5mJbvpQEo6FIzICYW3eF657qTaaDI0UeLF
         Mr0uFhp8I8O2QBfaR56M4NQ4w5/DK+LH1/FubbPuPuSTqEDmWZ7s0m09Jz1xY99mfTvI
         l7i70MwbogkR4iGUBYAGcNj4MZPGC4e7cs7+Uj5LrT/6sq22n7ewLoruE6naYz0P7FCC
         OKw4HRzgWH/JOtGgPXHVPi2OBhdjGlNkhyXevuOAS0kNWaFufnz+WAAMFoiLDNVdiYfe
         A8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJiyOatu2BrhSaaNI3CEOgqyKkXrPoiolBEFQyTeOqc=;
        b=c3jiLkDwEwg6JswctikZPyyk8VYgLYQPWVw16wz6r04FoqVCNzszB3JfeXPMEZW2tT
         bfmVmuBco1it6tLkvqlY4a2YcOWVQDEO1ZUXqrfiI0kYQlhqaz964yPMRkD0u8FQFst5
         7nZrtOcrngA1QpsB+f6uv7np8rlCSa0Sobemqn9sAeVdTePorognJNtC4TomZKttkpT7
         8wN4qD/3dwLpLjOYTwNYk9yPm/wQUPUm3Ac+b4ptFppLczAICN1/Ejhsf7y9QptM07EJ
         x+NNw8dnfwpVV4M54TkI+omeMb/8WuIqyr/uwLKGEQrnDp89/3VwlnJiBuEYCKc+3wTK
         7DQg==
X-Gm-Message-State: AOAM531zdEvnKSlMWgk3eRhYqhO2pb9x2bfOnTKibLHOvVgtYFyunvsC
        m8xpUnhBAOfZG5RZy5TaqlUZoY0DO2zK6hJ2eH6hO8tzxQ==
X-Google-Smtp-Source: ABdhPJxxStaJxz94y+/UB8Z7yXR+RrN9aooVs1vvyzmRzOqt4BuUJBr36PNNtK+g/UDDK9qkivZhF5K2NJ9VozzsBJc=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr2058628eje.431.1596681464787;
 Wed, 05 Aug 2020 19:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200804073310.195204-1-dominick.grift@defensec.nl> <20200805194048.490708-1-dominick.grift@defensec.nl>
In-Reply-To: <20200805194048.490708-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Aug 2020 22:37:33 -0400
Message-ID: <CAHC9VhTKrhidm5+m17Pa20=YC=3un6sdBVQUgqDCVmpWMomYTQ@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v6] type_statements: document expandattribute
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 5, 2020 at 3:50 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This functionality was added for Androids Treble in 2017.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> v2: change expandtypeattribute to expandattribute
> v3: overriden is overridden
> v4: convert to markdown
> v5: copied and pasted description from James Carter and changed default_value to expand_value
> v6: can be used in if conditionals and update description from James Carter
>
>  src/type_statements.md | 693 ++++++++++++++++++-----------------------
>  1 file changed, 302 insertions(+), 391 deletions(-)

Merged into the main branch, thank you!  A word of caution, I did have
to merge this by hand so I may have made a mistake; please take a look
at what is in the repo and let me know if anything looks wrong.

-- 
paul moore
www.paul-moore.com
