Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599FAC77B75
	for <selinux@archiver.kernel.org>; Mon,  8 May 2023 20:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjEHU2t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 May 2023 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjEHU2S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 May 2023 16:28:18 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833D46B9
        for <selinux@vger.kernel.org>; Mon,  8 May 2023 13:28:15 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9d881ad689so6627868276.2
        for <selinux@vger.kernel.org>; Mon, 08 May 2023 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683577694; x=1686169694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/+q6UfsXm7046dAW02Z5BiOYkJE9V/u6XNxFRxQF88=;
        b=CDu65jWR/bCa6UVmaVg7L3csbtQ0bHBsSrgGkFqfkFMSnniPEIStKNcXCSOIYkcZ0I
         8r+SFAoCQbtuMVtYVaIlWaYM3eW/mXIIN7HkGwERBxK/0pQuj08l0iOlbuiDhY1fjSgb
         Y7WupDAjb3k9284J70P3Yviw4kb2TsMokwUeao2iGR9lA79aa0373avDMYA5HSQM9Htr
         0w1X9a0zPV5cIWEr/Klx5WW8MFiZuDZLS+m9XvJuCFFgitcyqxlZqqLQluXQ4/4JIk1B
         4yaMHJsN28atzXDzNaEmrsNS5T2cKZzg9n0cM+6yZiuIW6thBMKs11kBeyBI115jq+jd
         LmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683577694; x=1686169694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/+q6UfsXm7046dAW02Z5BiOYkJE9V/u6XNxFRxQF88=;
        b=JCmwDgEzqUQRAOtTgyztlIMmjhZ92Ap1aBsJuQJAV4M4OzQIV7dxZWfTCEhDGbNLWm
         G1xdzoRok71Hxm15skdIlM9SdWUF9M5UVByLV2GD8eY3VjCZZHLY1n5oxbcsmVsLVuGf
         uuAkGJTdZqbnlgCR+DPbnyVvA5wc6VPMGjVrB0irbBJb4T2gygZR1Tpt/VTk97ASHC+m
         XvXEFcExcX/UisOXnlREZpAPte9JVYfYQBmP4+dPl9BP2FMraAkA3z1w5PYTN3PkES0T
         7cFozkROXtGb5c3A5NUY8G/HV+/wDBHb3NYZ7ASgSFvPZXc1lu093qu/yEPwSDPzuaEP
         Ywdg==
X-Gm-Message-State: AC+VfDxE1wuONCVLjZ4DTDPGwXGONVi+KMNz4fQHcci5jnYFIA8G+ApB
        iVW3+wSs3AgJy/iKSbSC14kyRYARHT6l0t0j7ju2VyGuLBu45HM=
X-Google-Smtp-Source: ACHHUZ6XMcjiCZfUnSlZX/JjTepNZ0JYYuajCspyPtKMbs+LWSlA3Xl4FaZvgtm9ISnphbVDd8p5jDFoyNNxxNjXZnA=
X-Received: by 2002:a05:6902:1204:b0:b9d:da66:e689 with SMTP id
 s4-20020a056902120400b00b9dda66e689mr16115000ybu.39.1683577694589; Mon, 08
 May 2023 13:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230505224835.644278-1-paul@paul-moore.com> <CAFqZXNunnV45QWBe2rWdRRUZGvV9brmSOkQ-JyycAN17jRU5Cw@mail.gmail.com>
In-Reply-To: <CAFqZXNunnV45QWBe2rWdRRUZGvV9brmSOkQ-JyycAN17jRU5Cw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 May 2023 16:28:03 -0400
Message-ID: <CAHC9VhS_C5J=13=1r45Ka0Gquvsgd9htkDqiHQqP4dGNb8R0kg@mail.gmail.com>
Subject: Re: [PATCH] selinux: more Makefile tweaks
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 6, 2023 at 5:23=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
> On Sat, May 6, 2023 at 12:50=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > A few small tweaks to improve the SELinux Makefile:
> >
> > - Define a new variable, 'genhdrs', to represent both flask.h and
> >   av_permissions.h; this should help ensure consistent processing for
> >   both generated headers.
> >
> > - Move the 'ccflags-y' variable closer to the top, just after the
> >   main 'obj-$(CONFIG_SECURITY_SELINUX)' definition to make it more
> >   visible and improve the grouping in the Makefile.
> >
> > - Rework some of the vertical whitespace to improve some of the
> >   grouping in the Makefile.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/Makefile | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
>
> LGTM,
>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks for taking a look.  Merged into selinux/next.

--=20
paul-moore.com
