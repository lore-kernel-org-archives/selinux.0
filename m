Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF2DC433EF
	for <selinux@archiver.kernel.org>; Mon, 13 Dec 2021 23:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243068AbhLMXrF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbhLMXrD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Dec 2021 18:47:03 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AABC061574
        for <selinux@vger.kernel.org>; Mon, 13 Dec 2021 15:47:03 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so56916024edq.7
        for <selinux@vger.kernel.org>; Mon, 13 Dec 2021 15:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUeE7msKHv/DMMj3J4utEZf04rsWizgw5ADZnYeBKqo=;
        b=LXqDEGvQvEvjk7cH0kuUqQxdif38XX2JoC4GMRtG44rIsTkC+QOStQNU1YG+5RZO65
         jJ9pvbjH+S5P/sTxboCU+EaDAtDj/+er4XoRRWKv2M3eW1hL39s8mJWFGEaBFxMLyNef
         QXmhsk6iYoC90x+HP44uGZUxNZIIgtU5YQdLu8jNUFNYJzUCaL/bakEC5Ff6QRYRv8kq
         DY0gWYaeEKV6KgE+x8908nTY/5G1LLt1/1bEluNPwNCpdy73k2vpjgm6Nd8MLr4yblM9
         CMjsSOoxRAE8BYuiC1WMytQYCM2ayStenn83TxLa8ojZRUZ4jFtZnqPtEojYX76W+JKc
         NXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUeE7msKHv/DMMj3J4utEZf04rsWizgw5ADZnYeBKqo=;
        b=vWS5oxW9eP3+7oPDs1SmE7JxfqtUve2p3TefXfOnEKZWh6wWA7wzy/P8bZcEpzSB6N
         gX7Bx1+pdtoYBc1yfuqsfuCkAiO5bHJu8+T/cZTGUS28YcDUhnbsyF7yts4QFyUQTtfs
         cjSi2DHCAq7tYWDkc8GK5XaCEWh4Ptl0wofdd2g5qOSisNWUI7T10L+n2txb4sZQ4m+8
         T10ttPMXh7sYlHCKco85Fv9w6JQ2hx2vwesXzwlHdmRtDbZPfiqWS7sT5k/yNOvbMMBq
         G8zMrxH8jSjqZMz8orVfMNdjmTslupM61uxoJYft1Ui8fZBM64NbdhHdEux6EbmV7Wn/
         bRJA==
X-Gm-Message-State: AOAM531EZjkRAJiVmVEmX5b8GemKcnEKoA5WpaqMcT4vnQI96fEeK1TC
        0FhvHllZW8lzanFLMsezbG11uJYKgP04pBZpeDoaQ5GM3A==
X-Google-Smtp-Source: ABdhPJwkoXk3lRQKHEAAHvzwmhciYyxhvO6nGIMpvRwaPU7i6+AZ1iTIv7Keq+85IRli+KxxkNPBoZWek1RfQvns68w=
X-Received: by 2002:a17:906:3a8c:: with SMTP id y12mr1573443ejd.517.1639439221557;
 Mon, 13 Dec 2021 15:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20211212184142.7896-1-toiwoton@gmail.com>
In-Reply-To: <20211212184142.7896-1-toiwoton@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Dec 2021 18:46:50 -0500
Message-ID: <CAHC9VhRToysshDO8u5A2-wPwS9fv8zB5BhgfjQQCg454WiRxzQ@mail.gmail.com>
Subject: Re: [PATCH v4] selinux-notebook: New chapter: Hardening SELinux
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org,
        Daniel Burgener <dburgener@linux.microsoft.com>,
        Dominick Grift <dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Dec 12, 2021 at 1:42 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Describe some easy and more difficult methods to harden SELinux
> policies.
>
> Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
> Reviewed-by: Dominick Grift <dominick.grift@defensec.nl>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
> v4:
>  - Fixed typo
>  - Added Reviewed-Bys
>
> v3: https://lore.kernel.org/selinux/20211116105335.21864-1-toiwoton@gmail.com/
>  - Updated with comments from Daniel Burgener and Dominick Grift
>
> v2: https://lore.kernel.org/selinux/20211113095547.19406-1-toiwoton@gmail.com/
>  - Updated with comments from Daniel Burgener
>  - Fixed issues with PDF generation
>
> v1: https://lore.kernel.org/selinux/20211112125605.28915-1-toiwoton@gmail.com/
> ---
>  src/hardening.md                 | 205 +++++++++++++++++++++++++++++++
>  src/implementing_seaware_apps.md |   2 +-
>  src/reference_policy.md          |   2 +-
>  src/section_list.txt             |   1 +
>  src/toc.md                       |   1 +
>  5 files changed, 209 insertions(+), 2 deletions(-)
>  create mode 100644 src/hardening.md

Merged into the main branch, thanks everyone!

-- 
paul moore
www.paul-moore.com
