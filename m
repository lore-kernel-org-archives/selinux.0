Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE44C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 16:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15F3206C3
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 16:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFx05Dwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgFHQVc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHQVc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 12:21:32 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2D9C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 09:21:31 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a3so3851135oid.4
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ur1x0nIQx0zI/j+gJYx1XzaICvgT5GPeMpKZnjuP9Yc=;
        b=KFx05Dwd2mi/6h6okBHNEKk/f591Y2/rhWqmylQsJ921iookUymHjiSYQmOezGfdvv
         0rlm4UrWcBd2p+oLk/n6V5xnqo93QGdzKKjx3nwTgmWT6nsLyQnr05WSkHR3ApfxqlQ1
         XX8qZ/9p8a/RPeeLrXh4Iv20W42m13k9f4KxGkQNHmsO7joQh9MDBE0abNv6DZY/lX8I
         xxxqCSUmHRU+X+zlgSaUjV37FNltYSWI5EG2sTYdVfNg3qGJeYNOG1wE0a/qKg75V3Gs
         EGufiKZv5aMcIzne2BN4Rt89CjOwVkFjzO0ZdnruiOcQ7r3b72jPaNYc9RqLODYZleir
         Uf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ur1x0nIQx0zI/j+gJYx1XzaICvgT5GPeMpKZnjuP9Yc=;
        b=HWFdJVLrJLpI0JkX+sbwJ2nf2ShLkMNk/jJUxDYZm6c/CY1BzHf29dRF2tORePPQ5U
         IqsbBnyRhevyV0wd4Jna6jIfE+C/7RDjulJL4XWZ2kHLUavOLgvDqtMCK0J5c5P698Bi
         IrMUheelmbJyZvi4CeX+lK1nmOiIYvNbECzApSY+PqsfWZKq0qBT1JM3xA7lecCinE85
         GdcUqCyvJ9iQbEYoXrODlLAyzXzpDdnwIk6UpjFi4cAcwG6YYUWyZtJdKsiycod6QkUG
         cgD7NBj7tAUXEv6DADw1X8iThFmrEfuE7cZbdQnn/Q/df3WK3IMUqlmwSyavvTYcGC+8
         0G+w==
X-Gm-Message-State: AOAM530/yZvWHiOzW+wkL+cAml0iiPgCP4I1dz7vluvUGQj30nyVyPZJ
        OcvzxlXgStSo3Eb88GONy8Hh0PcYXAvXfQzVjJw=
X-Google-Smtp-Source: ABdhPJx8e+hMuP9ojSaiju3YHGLS7jn0fAQdhYMC4o5lKo2tyalAz4eeJif3Uy2u9Yiv5MWmoLF0kG104inP22NgdSo=
X-Received: by 2002:aca:3d09:: with SMTP id k9mr115062oia.160.1591633290394;
 Mon, 08 Jun 2020 09:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ4NU0rd0ZgGuNXpWy37St==bfT8_XfR1Z1YQNwdLVR6tw@mail.gmail.com>
 <20200608153722.18622-1-william.c.roberts@intel.com>
In-Reply-To: <20200608153722.18622-1-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 8 Jun 2020 12:21:19 -0400
Message-ID: <CAEjxPJ7AtH67Gdoj6eHGJ22mXWYHWOqaRZP+Gi18aR5iJeJ5Cg@mail.gmail.com>
Subject: Re: [PATCH v2] README: start a section for documenting CFLAGS
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 8, 2020 at 11:37 AM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> Start a section in the README for documenting that custom CFLAGS yields
> CUSTOM results and that your mileage may vary. The first CFLAG to
> document that you likely want to include is -fsemantic-interposition.

CUSTOM is all-caps for some reason, and it should be
-fno-semantic-interposition.

> diff --git a/README.md b/README.md
> index 9d64f0b5cf90..eb8e170ea1f7 100644
> --- a/README.md
> +++ b/README.md
> +
> +- -fsemantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
> +   will support passing this flag, but ignore it. Previous clang versions fail.

-fno-semantic-interposition
