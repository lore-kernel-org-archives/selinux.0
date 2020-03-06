Return-Path: <SRS0=Zw2N=4X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C569C10DCE
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 16:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6652072D
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 16:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6wVzbgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCFQYh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:24:37 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45854 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgCFQYh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 11:24:37 -0500
Received: by mail-oi1-f177.google.com with SMTP id v19so3056637oic.12
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUFjPHuq7tPVHcYkslrw17ScygoTuV/Jm+UixVtvVTU=;
        b=M6wVzbgYHa47bVW9NgLE+aDESc4svr4fxXZc4mOhVegQ0faelPv8tfckFwd/chTrR2
         U4IkmkipYSGKTEgfYvOjtccT2tbqc3HdeM8Z56lEKxDWS2XQRi2CyD+2cfry5Iw8CRsx
         p2VCPBmL7/FXqAE0DkqFF5jXRU+XXOE+2zTAvzYoxIYB76+hbeOIAxYcW4fwNKCm0Tah
         qz3nVy7gzvKLb5xuBUMzcZZWXAxQkB+Pek39Z2McaU+zM3LE5+xAgpvFvX3HpHQmfzgR
         FRIkpzpHIwLgK5boFFjYYY95k6a5vR/2vz5xsgIgUYygXniEeBohXdy69CyhrnUCszno
         L2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUFjPHuq7tPVHcYkslrw17ScygoTuV/Jm+UixVtvVTU=;
        b=Bx0fwNEROMFk56Kk1kTwpLqb9DShr53bz577Q1vNYDnWoelXxdTv7VfYDYrBHgFFqB
         HWgnD1yHupgGwBF8bFyxtzewxnWKVPW6PvkeAQqBTJu3gx3Pk3EyeXjrGgT4LHO5cbxN
         4axQfshZvPPgSvl+xsST6HzdGhiUxo0Sb4GVQjr8mA2IzV5hz7YQzL8XZifmZHOsWOeh
         yN5rnUTW1pOkP0Y4ZJEPDcEimP5mzm43ToF6/mam+eqCbjSQs3J3dSlSVuHFCh+Cd8OG
         ZNXbS7AHN9KjI7yroQqHdIrU7ZyBMlW5DJ7H4HHhM3t24nDj/8mJjZ5pYuqO6Sd+J++z
         fkQQ==
X-Gm-Message-State: ANhLgQ0sNx7LkCucoFFyFXv+4ryi7dY9/aYMciiojHQATM+Q9TLpMZR+
        IlciNxspktJJs+Dluv9Y+jMxfvPuC4ieHhvJ9+0=
X-Google-Smtp-Source: ADFU+vsYX3Nts8rQUOhFNjMTMbxMwk0cLNOrRZd4GQN/ZNwnntcEH8lGSYyURJJGWg1arDW62ksw12shuE7OKC58HE0=
X-Received: by 2002:aca:ad54:: with SMTP id w81mr3285723oie.172.1583511876523;
 Fri, 06 Mar 2020 08:24:36 -0800 (PST)
MIME-Version: 1.0
References: <CAFftDdp8TtcWRSA2PPWGaq1SPB81y7cF+w3ThbKr-BniEx9Gmw@mail.gmail.com>
In-Reply-To: <CAFftDdp8TtcWRSA2PPWGaq1SPB81y7cF+w3ThbKr-BniEx9Gmw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 6 Mar 2020 11:25:50 -0500
Message-ID: <CAEjxPJ7AMmRH-5y_WLx_b9rKdvq823FnJJ2HBBWAdDSQL3rnpg@mail.gmail.com>
Subject: Re: libsepol: drop dso question on CFLAGS (package maintainers weigh
 in please)
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 6, 2020 at 9:52 AM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> The libsepol/src/Makefile has the below lines for CFLAGS:
>
> CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2
>
> override CFLAGS += -I. -I../include -D_GNU_SOURCE
>
> Does anyone have a preference where I add the -fno-semantic-interposition?
>
> I was thinking the conditional assignment because of the comment made
> about packagers overriding things on the selinux drop dso patch
> series.

I am not a package maintainer but regardless of how this gets added
(and I think in the libselinux case
it ends up being part of the conditional assignment), we need to make
sure that maintainers are strongly
encouraged to add it to their builds to preserve existing behavior.
