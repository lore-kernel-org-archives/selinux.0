Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CC6C001B0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 14:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjHIOzM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjHIOzM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 10:55:12 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C572107
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 07:55:11 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583e91891aeso78988217b3.1
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691592911; x=1692197711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+wLjBF8495BuooPgtDeCiwhsfrdlFdvOlT1EXkbhj0=;
        b=etE1yrg9bVHbHdWcX9Hlj1z+jhL2q2Blf41BdR56+X45Gs6ckLzND8OAz6A0HOF0Pa
         JJfS/XcAeoWAYcsNDmaau9Og/2D00s0kP1grYjAn9LwjwWYyUZm24478ZHpkwiNA/0pq
         y9Apc69gSK6Qfl2ridFL/IjHGDEuchmuGOktzdtcWeQYa8WaLjSmNkW9xg6YF4npWbqg
         5jdggg6XvcBEplD6X1Y7MxnOPKri+pDkufgm9kLV86c3O+waMjhQhVOc+t5DlhFDHuZG
         VfM9p7SqafbrqhvAcGzJ82JMoqyr/0L0SJ9NSWw3qWPtQHdN5JQu5m6IlcqxA+vLfVLo
         8AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691592911; x=1692197711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+wLjBF8495BuooPgtDeCiwhsfrdlFdvOlT1EXkbhj0=;
        b=g+nEhTVMmQkhIcNRMhwOOtVLGBJDMb0jBxcOOieVuC+J0yfDRbRQmafFT7N2SSkPXz
         0xhGIFbHc1DPZBk9JcSzu612ffcA1nLJyxDI1bZ6nYHlJHyfoNa3BN1uChasc6f1qLNS
         POCZq0IdyUCtx8zm+JHX2tk1UTt3FyMRvUvClF+ijEGRQMN2nyKnpbo1GLFvejafwlw+
         rA8gENtW25V8aG8AIfeXE///R517KBtCKi12Aeco8eGAPDwy3wgoaVtI502g2SnSuA+k
         X8xMNMhmlZnQ8zRIZed7S3gTaszqfbxam0Qyjua8l4f9C6i05n2moe54s2uv4jEtTYCM
         /j9A==
X-Gm-Message-State: AOJu0YyioDg0XHAPch8Ebq2tzio0Tdf0aawuddmsaHcaoYS6GS60+EMA
        6lGv0lGxh90GFt63dTYhKHRk16YsHxwp8LwtQfUV
X-Google-Smtp-Source: AGHT+IF8SK8JQRbqkg9z8kNwMD7Svb2X3+Fb1BH+oPnuvUQY0A3+kmnifzdyCaNulMmpTa67spwwSMeAyED0btwx6/s=
X-Received: by 2002:a0d:ca96:0:b0:586:9c7a:d9ec with SMTP id
 m144-20020a0dca96000000b005869c7ad9ecmr3190844ywd.9.1691592910737; Wed, 09
 Aug 2023 07:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230808155010.76584-2-paul@paul-moore.com> <CAFqZXNvMLBrkTy1PAUGGATq+AO_wo3tr6-7ysjLzqK1qgJ2Vfw@mail.gmail.com>
In-Reply-To: <CAFqZXNvMLBrkTy1PAUGGATq+AO_wo3tr6-7ysjLzqK1qgJ2Vfw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Aug 2023 10:55:00 -0400
Message-ID: <CAHC9VhQvSD4OOGpJc4ozn9rmQfb-JV_SxjeL9UdZ=UaYWiVcvQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: revert SECINITSID_INIT support
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 9, 2023 at 4:57=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
> On Tue, Aug 8, 2023 at 6:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > This commit reverts 5b0eea835d4e ("selinux: introduce an initial SID
> > for early boot processes") as it was found to cause problems on
> > distros with old SELinux userspace tools/libraries, specifically
> > Ubuntu 16.04.
> >
> > Hopefully we will be able to re-add this functionality at a later
> > date, but let's revert this for now to help ensure a stable and
> > backwards compatible SELinux tree.
> >
> > Link: https://lore.kernel.org/selinux/87edkseqf8.fsf@mail.lhotse
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c                      | 28 -------------------
> >  .../selinux/include/initial_sid_to_string.h   |  2 +-
> >  security/selinux/include/policycap.h          |  1 -
> >  security/selinux/include/policycap_names.h    |  1 -
> >  security/selinux/include/security.h           |  6 ----
> >  security/selinux/ss/policydb.c                | 27 ------------------
> >  6 files changed, 1 insertion(+), 64 deletions(-)
>
> I don't think I'm able to post a fix for this quickly enough, so:
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Merged into selinux/next.

FWIW, I really do like the idea behind this, and I'm looking forward
to a proper fix so that we can bring it back.  Unfortunately the
revert is necessary so we have can have a week or two of good code in
selinux/next before the merge window.

* https://github.com/SELinuxProject/selinux-kernel/blob/main/README.md#kern=
el-tree-process

--=20
paul-moore.com
