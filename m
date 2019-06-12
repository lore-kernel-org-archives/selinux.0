Return-Path: <SRS0=2Cbv=UL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAED8C31E46
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B40421019
	for <selinux@archiver.kernel.org>; Wed, 12 Jun 2019 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rzXwsVF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406775AbfFLQcl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:32:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45024 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406352AbfFLQcl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jun 2019 12:32:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so15647610ljc.11
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2019 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWP1fkQ9Ns6VzfWktVBVy9TgakCkH1naQ2y1IBf58Iw=;
        b=rzXwsVF16ApRUd8hxVf3oRHA4QJYhXcZiGEeFysBCVkxg6EYX3McZUlANHjfvv+wIS
         XzqmehE2jCH2oFpBrY+6Ti4r/m5qfW7j4ivmHsGzjaofiod8aWS/RkORkGinvYwt4J7I
         gGyizrsH55LS31ORwzgjwSMSLUvTfr28OlEML9P2+hnjFM1OQeW5hwqfD8XOCEXY1b0M
         hUGpWOrTdeGdQO1XBT8MyqL9QXfhEnIiQYEFC32BXEfAe1jPn/piRezDMWTL78OK1hRg
         xxaXumOZszt4z283Tu6ReB+o8pzYMrHc79g/NoX/EdLVNkTIwqX18vmbuP/5EncUSaNo
         l/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWP1fkQ9Ns6VzfWktVBVy9TgakCkH1naQ2y1IBf58Iw=;
        b=dmKokqg+QhEmg6iKqvHYaohl3Z78F8k0jxU3kj1xiy9j7Fm3u/KdpbYOogi3zmrjSl
         OXSlMgsz48rx79LNl1is4pV6T5HQGCYcHD2fCJufgsOD4jiGjR4ZoBmWrKUAuVGXvQMc
         pk1kOQH/5gDw4mfqLATmWBJOPK6SF7ud9b9502sxwmyY9nVO6a67QbgJrnIZzyH1kMJ8
         WmLInITX64IJl2YuWPjHrj7WF4wHb1QoiT7Z5IQO4RlrIWg0BMsxIpaSw1WlKhuKO2eK
         2o4k0YLLZhBKD9QRQjEs0Cm5j0kUk+JHj4z3/DjPPVr49PSK8qXK2NkF1buqDsP4sur7
         Pk3w==
X-Gm-Message-State: APjAAAWNoENS1SnPlmR5n8xtbsunWeOcHgcwuBfYd9ACk/MYDti5jPvA
        xTvcHK70+UZ+n/l9i0N5it0xBbHUJkQQ6OjUQ29n
X-Google-Smtp-Source: APXvYqxLeno2B0Q0a24EmY32s4Dqmbvz0+ATXQY/dN5ZIgimSUwuga2KnJhxVwVU65BGK+V6ld9Ag9Gj4/AhoNzCckg=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr34347162ljw.76.1560357158786;
 Wed, 12 Jun 2019 09:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190612135114.GB4015@zhanggen-UX430UQ> <20190612135538.GA4257@zhanggen-UX430UQ>
In-Reply-To: <20190612135538.GA4257@zhanggen-UX430UQ>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Jun 2019 12:32:27 -0400
Message-ID: <CAHC9VhR2Hyr+SXnO2ss4L-jcOJUVmYPPQ20N8-CQFPbsK5T6eQ@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 12, 2019 at 9:55 AM Gen Zhang <blackgod016574@gmail.com> wrote:
>
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> should be freed when error.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")

Merged into selinux/stable-5.2, thanks.

-- 
paul moore
www.paul-moore.com
