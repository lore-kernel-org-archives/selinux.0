Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98733C433F5
	for <selinux@archiver.kernel.org>; Mon, 13 Dec 2021 23:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244322AbhLMXzP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244323AbhLMXzO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Dec 2021 18:55:14 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE69C06173F
        for <selinux@vger.kernel.org>; Mon, 13 Dec 2021 15:55:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r11so56704596edd.9
        for <selinux@vger.kernel.org>; Mon, 13 Dec 2021 15:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oef3m3+YzJ7E05zS4lp2MGqhBEG0m5iAQzLxBWp+Fk0=;
        b=h1SvjqxbHMNniCZQeME0hyXCzBPE6SlGjWKnwoPsPGHlkq/KHJkwyVce26O09Y1WKJ
         6y4jB7tTOEmO6xnVrUekwajXXmZK1MgK9zpcXSOGX/CgAHSv6dcQ4DbFp/3tiDWJtiC5
         GC2lviGE4ciB/FJt9oTIZsFCshK/fh71zwYvC3/FI7lV0meHH7n2C1xOkG9WZGZjnUNe
         xEm90HrQvhkM6FSZfTeEBzLMEofhpSPFDwDCdTemN6cjc8+P4uFpnWu/afKz6smLSfPd
         2rhFYk9X+H861FIEU75Wf9nyv4Sk/IrSIohSz5cUeujz2myT0qWHdARI4qyQMaTOzg9O
         mXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oef3m3+YzJ7E05zS4lp2MGqhBEG0m5iAQzLxBWp+Fk0=;
        b=RCoacacHlrYIaWUynRUpnsch3FP9BXTBOAT65vJ2sfP7KqLO10Hf/3REPIY22SXn/i
         x+tDY7QHZG4hNSYksnZdFPdc1HNQwD/NFqRsxoWKsodePWFsKaYxGqrm5LCiu5llWAZN
         aLdeShiHamkgr/F9vLAfiFgq8S33vzOvnOwnq6fXUS9kxwvxhDjTLxLscKu7l5MN41ee
         w72xgCF/9mabfrOf/NYZu0YXTutTU7iG3Rof80Kj7MIqee8GVHj4F82lx6b8W8LpOdtD
         b1a8qZq5XSN9xrYVoGISzaOduqT2RUhzdOkJwU7a5KTXykQWPOEQL3rPKyp9Yx1Y11R9
         nd4w==
X-Gm-Message-State: AOAM531oU0ITZczSbTKJro0vsWAtn+HPeArm6Q050xBmzrewtAiuH23F
        jOhts+YKzo3qfrZLlSOY3d28U7vepk8Vnx5L8WgI/fPKyA==
X-Google-Smtp-Source: ABdhPJx3LtHl4WxymdfkAfFdAP4GUHMP7yumphGFax6Fuyg8cNZds2sVQ5fUB9T5hZ6kol0OQqUyUKSpViT0k/jto4M=
X-Received: by 2002:a05:6402:35d2:: with SMTP id z18mr2885515edc.188.1639439713014;
 Mon, 13 Dec 2021 15:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20211213101622.29888-1-richard_c_haines@btinternet.com> <20211213101622.29888-2-richard_c_haines@btinternet.com>
In-Reply-To: <20211213101622.29888-2-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Dec 2021 18:55:02 -0500
Message-ID: <CAHC9VhTjwvcJQjK7veAwKnV__e9ZUvtbbd3e+d6-W8qrPdtYfw@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] selinux-notebook: Make file links consistent
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 13, 2021 at 5:16 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Before building EPUB book the file links to the notebook-examples
> directory area needs to be consistent. This will allow sed to fix the path
> during the build (as pandoc insists on defaulting to file:///EPUB/text).
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/bounds_rules.md     |  2 +-
>  src/cil_overview.md     |  2 +-
>  src/embedded_systems.md | 12 ++++++------
>  src/network_support.md  |  4 ++--
>  src/postgresql.md       |  6 +++---
>  src/seandroid.md        |  4 ++--
>  src/toc.md              |  2 +-
>  7 files changed, 16 insertions(+), 16 deletions(-)

Seems like a reasonable change independent of the ePUB work.  Merged
into main, thanks Richard.

-- 
paul moore
www.paul-moore.com
