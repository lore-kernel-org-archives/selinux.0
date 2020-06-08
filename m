Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D48C433DF
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 22:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618012068D
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 22:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBpHIZC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgFHWed (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgFHWec (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 18:34:32 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E435C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 15:34:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k8so8281127iol.13
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdxSzyTEu9CSSWy5EmTjpfV+NcdjqV/plLQYptQec8Y=;
        b=lBpHIZC4K1CpYWRPZo9Ph+HNIAYl7OcYBQz30xOJMPjqc5A4qmT7ATT9vjZeBjGcjr
         Fp5sYDEtOaGtkm/7yuezQYO2Mp7OZlLV6PxYKSHSNiBQacW6/dYkFR5GXVhy70B71KLJ
         c9YFrO/8jWbj1B9OeYtq3cQQJx8Jahu9xvuFvyqZCxx6DCGz7VCsO3Any75JAsLAlFI6
         +pjyZkKYQM8sr588A2rm2uiOwUBKrhWD88CBfsDTzsiDbvYT6+wmugscazAC+nWSNobX
         q2fGUwGRiGXlqwkLkUWlbxUs9PX3saA2T5FkWgEZtrOxPKGpdMiyYFq695JP+xp4ilVe
         5p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdxSzyTEu9CSSWy5EmTjpfV+NcdjqV/plLQYptQec8Y=;
        b=lS76t5teTFkayqVdKLcOEvc6aWJYwSwONXFDJEJ0dY0NMUUx1zGVdHfgQiiIXxZcws
         OC+apoHfFYvXFVqksg8OTooBqce7bkk2WwlSvwbIcnK+/V7W3aWDXv+rgDrAx+dTpjab
         wsjbd9bqjvSHySKl/bHt4A0GT0E38glYzWpCBhyMWxweeoArtH0Nq8Gi6u3B7AAzFtC5
         ojI0zbaLManE/pmHu585FfkSoF+zVu9JU4xoMMLFFNWgo3db66A0UzcyOMr6oDwVpOQZ
         qUkmPr81Fn2gsEGWAHnRf8XwNjJbKvlevkUgnYmX8hLPaMYuZobPoLdArCm8Boy/1Iwi
         3vOQ==
X-Gm-Message-State: AOAM530YiLtD98iRLFMhGxL5oJ2aSw75dVqaf/Lj6EoN2Pf10J0KDDyR
        XjVeroqp0TTl+GjYzlAdYccnR95xtZNfmBagCrY=
X-Google-Smtp-Source: ABdhPJy2mVJbI+Mt0W4pnbzg5fG7c8sDM+Q2/a1o8WJYTiuApx850TYzT9z4Kq47hvZA+eisYCIVEECXRy1t5gWQDfY=
X-Received: by 2002:a6b:e60e:: with SMTP id g14mr24060524ioh.141.1591655671818;
 Mon, 08 Jun 2020 15:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ4NU0rd0ZgGuNXpWy37St==bfT8_XfR1Z1YQNwdLVR6tw@mail.gmail.com>
 <20200608153722.18622-1-william.c.roberts@intel.com> <CAEjxPJ7AtH67Gdoj6eHGJ22mXWYHWOqaRZP+Gi18aR5iJeJ5Cg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7AtH67Gdoj6eHGJ22mXWYHWOqaRZP+Gi18aR5iJeJ5Cg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 8 Jun 2020 17:34:20 -0500
Message-ID: <CAFftDdpSDpCNNhgaCK63KUcuFys-qXzWVZCQcqnCBHEm1BHORA@mail.gmail.com>
Subject: Re: [PATCH v2] README: start a section for documenting CFLAGS
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Laurent Bigonville <bigon@debian.org>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 8, 2020 at 11:21 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 8, 2020 at 11:37 AM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Start a section in the README for documenting that custom CFLAGS yields
> > CUSTOM results and that your mileage may vary. The first CFLAG to
> > document that you likely want to include is -fsemantic-interposition.
>
> CUSTOM is all-caps for some reason, and it should be

Meant to emphasize CUSTOM RESULTS, but it only really emphasizes
it correctly if RESULTS is also capitalized (which it wasn't).

> -fno-semantic-interposition.

Argh, I forgot to change that, sorry.

>
> > diff --git a/README.md b/README.md
> > index 9d64f0b5cf90..eb8e170ea1f7 100644
> > --- a/README.md
> > +++ b/README.md
> > +
> > +- -fsemantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
> > +   will support passing this flag, but ignore it. Previous clang versions fail.
>
> -fno-semantic-interposition
