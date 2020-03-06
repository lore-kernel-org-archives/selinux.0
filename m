Return-Path: <SRS0=Zw2N=4X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82860C10DCE
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 17:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C68120656
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 17:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuH/5daW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFRqT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:46:19 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46143 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCFRqT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 12:46:19 -0500
Received: by mail-il1-f195.google.com with SMTP id e8so2758579ilc.13
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 09:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TgbRYFH2eIS4vxEY89TUtKPBhUcJ8rZDPnpSLk9e0Mc=;
        b=DuH/5daWJFt4ymut0ygnxoa3tBASv7Hp6iMIHQv/CaNDCyK5UaPZJZuaXOeg2fiKB/
         Fn39BSB6w88CnC5JbEtCaT9kG+bzu3eU3wMtErR0mDBoW77TXqF8KTVGxUYATQUbXE9W
         Cl5p+zpY5a8haLLLHYb6oYA2+1+m6J2sN6EqeeJ+/J2fF+FzcqzXUj9a2putrOqKG41Z
         bvHoT2g1PdsmIQv54wfqeqnyf0F0Wlf/qeiE0MaSN+F0J+9VaWzT/a0np6lDCcsQx5Ji
         ZinS6QGCMPqODwJgvtvI1SeYwGTeBqZt2b9cIDtYFvaK59Z91Tf07N6c1v/Wc+0RUdN1
         +9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgbRYFH2eIS4vxEY89TUtKPBhUcJ8rZDPnpSLk9e0Mc=;
        b=oeVIw/hBBCfJO0knNG9hb1ve2TA6uHovg3uIaXRDqQUstYv+rUziNNZac6vYkroDHy
         Ove/nsCNb5dwgxogQNk/zptOVXTjotG8HRWdhszZhcCFKvR0DZdCFrPw0hp/TjZdqa3u
         qRepQyRzjJmao7E920zbcz/gQYCfyJ7BHnePtKQSeINNn5DU7p/M14cHnJ5NF9+Zi/14
         5RW9tipJT4iOiyA85OaFrf+u9PsaIfwWbIxxrLjzCYUPBhCKaHRKDhs6Aex0XOV0XkQn
         334o8iilbladHR2H/RYwSh9V5F05jhzX/sT/1FivPK6xrvrzCyzJBSOx6VfCkk2zc5v4
         +Omg==
X-Gm-Message-State: ANhLgQ0knd5tnRh2EydRGUiRy2dJMDfPDfpddu7K8gCrNA9APG/7lyp0
        wcP4Zw7oaRHfRZ0fVfIH62tPSVxQgGwqJ7Hc5EZPVVYB
X-Google-Smtp-Source: ADFU+vsuzsZk3mYFGc7SHJedwuKceieNrXPU33dtfZeiOU7cjqNOO5imKUk+28kLBMfIVsrQwxXM2T09K2Pw0y5cdjg=
X-Received: by 2002:a92:5cc7:: with SMTP id d68mr4284842ilg.163.1583516778910;
 Fri, 06 Mar 2020 09:46:18 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdp8TtcWRSA2PPWGaq1SPB81y7cF+w3ThbKr-BniEx9Gmw@mail.gmail.com>
 <CAEjxPJ7AMmRH-5y_WLx_b9rKdvq823FnJJ2HBBWAdDSQL3rnpg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7AMmRH-5y_WLx_b9rKdvq823FnJJ2HBBWAdDSQL3rnpg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 6 Mar 2020 11:46:07 -0600
Message-ID: <CAFftDdqbkFfd_ZyY54dGXjm6wOD2Ji_MWArmtupYV7p5w=3AkQ@mail.gmail.com>
Subject: Re: libsepol: drop dso question on CFLAGS (package maintainers weigh
 in please)
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 6, 2020 at 10:24 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Mar 6, 2020 at 9:52 AM William Roberts <bill.c.roberts@gmail.com> wrote:
> >
> > The libsepol/src/Makefile has the below lines for CFLAGS:
> >
> > CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2
> >
> > override CFLAGS += -I. -I../include -D_GNU_SOURCE
> >
> > Does anyone have a preference where I add the -fno-semantic-interposition?
> >
> > I was thinking the conditional assignment because of the comment made
> > about packagers overriding things on the selinux drop dso patch
> > series.
>
> I am not a package maintainer but regardless of how this gets added
> (and I think in the libselinux case
> it ends up being part of the conditional assignment), we need to make
> sure that maintainers are strongly
> encouraged to add it to their builds to preserve existing behavior.

Definitely.

The same would go for libselinux, its on EXTRA_CFLAGS which eventually
gets conditionally assigned to CFLAGS.

I would imagine if you set custom CFLAGS when building a package, you better
make sure it's perfect. You won't necessarily get a wrong lib, but you could get
something undesirable for a host of reasons (hardening flags omitted, etc).

I could definitely see an argument to add this no matter what for gcc builds
(omit for clang) and make it non-override-able. But the package folks seemed
to frown on that.
