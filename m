Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB7C433EF
	for <selinux@archiver.kernel.org>; Fri, 27 May 2022 19:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiE0THM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 May 2022 15:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiE0THL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 May 2022 15:07:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEC540915
        for <selinux@vger.kernel.org>; Fri, 27 May 2022 12:07:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso3219647wmn.4
        for <selinux@vger.kernel.org>; Fri, 27 May 2022 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxrhhDl9w30FjB1sy6mVDeRzEYCZbrQz6zirMvkOb98=;
        b=Ih9JBNGYT4sMij0muncbHTs9xdTBfXgGZTidaLktBAci+jBj8UvNreuO5+LyrOAb24
         iwQ9qZSpYF5GoZqMxWHhXsstL+vfo2U8bbcJieJtsq6bHNwV8it80AgwrSVndNhcWZAk
         mOKq6wZIrvEQYhHLVuQZXv49VQKARvYaQHzIyHs8bo4Wd7v0uYdA72vm7KC1UDPVOiVC
         84bwAsNoK3lvpK+5bKdK+nY0Bzfw4JKnHnRRtVZe+A+MYwm7cJvT/2JtYshN+rVLmggE
         dbTIMb8SJB5g0P+IEJ3xoat9oq4NDS0mKmvKejwQRRcdwAFHcXn4NwGYTfSc2Dl3Pn4X
         BcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxrhhDl9w30FjB1sy6mVDeRzEYCZbrQz6zirMvkOb98=;
        b=SemL6MnVMbJoy4SHEgT8ueX1RTs1JXUSeLqKt7CLbT/y2YM6QMSbqwufp7V6RL/yjW
         FU4xl2+//AxA5C4lidh85SU8Rgo6aApUY2WNLyD37sQ7qm9+jr7eexFuR19HS732pctE
         TboaIVevVscfGGjE9hAaG/wtIcJlUzDRpdII7douuZMA+lw/ayLyz+RqBYFgJuJXcKsM
         9ihJIpfQcVBrXKDEBt7bp8x8uV0hsUWPf6EDBh+2u0owjLEJ2ejvUxwbNY/qUBaDRM5x
         k6x+SlWH3F+xg3odQOjACYRX7NAoFZtdJOnpHFG/FdwCRucC1ncXqfYft7Et5ybYOA4J
         GbkA==
X-Gm-Message-State: AOAM531F41hMZp8kcVDu4RfjT6W26h1PZAkSJJXWO73m53/HmoYgh42i
        IdL0NT6TFG6TF6UmU+KnNoER1SXn0+so8xzThCEQbrRlKw==
X-Google-Smtp-Source: ABdhPJxvKZTm+xwT1koh4d7oY9GRZHHC+pEi4zVfA/zthieZY79f5VgdIMIFYl2aJeOqzujmebLEc/h/e3/LImQcD14=
X-Received: by 2002:a05:600c:414e:b0:397:55aa:ccc0 with SMTP id
 h14-20020a05600c414e00b0039755aaccc0mr8611840wmm.51.1653678427780; Fri, 27
 May 2022 12:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSJUmLmeNQBc5-ornFqtB1v1ogjmwfVBN+VKg4qK7PSuA@mail.gmail.com>
 <20220527180451.302448-1-dominick.grift@defensec.nl>
In-Reply-To: <20220527180451.302448-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 May 2022 15:06:56 -0400
Message-ID: <CAHC9VhQo5eSCQmXkkhQVW8o6ysahbUnZXMqkc3GZVALTD-hz+g@mail.gmail.com>
Subject: Re: [PATCH v2] network_support.md: clarify local port range and name_bind
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 27, 2022 at 2:05 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> v2: rephrases the whole things
>
>  src/network_support.md | 8 ++++++++
>  1 file changed, 8 insertions(+)

Tomorrow came very quickly :)  Merged, thanks Dominick.

-- 
paul-moore.com
