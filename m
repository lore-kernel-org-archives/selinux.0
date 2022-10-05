Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32064C433F5
	for <selinux@archiver.kernel.org>; Wed,  5 Oct 2022 14:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJEOj0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJEOjZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Oct 2022 10:39:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC2F46855
        for <selinux@vger.kernel.org>; Wed,  5 Oct 2022 07:39:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so3337363pjb.0
        for <selinux@vger.kernel.org>; Wed, 05 Oct 2022 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SkwLEV2ENCQ3CELbKI01Xq0SxqrW4m5z0dbOYX9PQtU=;
        b=d8wUGEhQQszp+Ewc0pIOUjOBz9MSCA6o6kEpHDQsa9ovR4WoGSq13776SUB77eZzMu
         QjquKLyUvUhS7xHIameQK5L33MDLyDKYjfF8t28gp0QjBrfQ0LkzluBuC9Tadwf0nhAy
         CNAoKXhZ03EP9xWYNMI882ijIJKY2aHOMfvZnUbmeKkCVuz7qBOnsVpAULo/+pmBF1f6
         6pufoCdwPblIsYa0sRfNc47N2+hce1NsQVt3fDTdKzXfLIF1yRJYYQ1CaJDP7cpX2zT3
         HXyEYSvRcwmeMY/h8/lr7E+W8AieycDPaLGsE0A4eeid19Qbhcg3OvGuI0fQNORP4o2l
         kjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SkwLEV2ENCQ3CELbKI01Xq0SxqrW4m5z0dbOYX9PQtU=;
        b=46TMwRoH98FakYQaTxGoQUt+kV5BLl/12KYcSARF5xjFFOQOtGuROQEncTf/1bMjyH
         rFJHLgA03AksJpocM+RpwaLcVupiTz8l3H2RZrgmXapZkjQrWFSfZ/sZI5u0myAmORCI
         U7gJGk5A/n/bOlZpjLhCl1vqzfh9dGEzH2tMwCA3TeijT0gDHZeyy8UUkWAEwNFGDrtP
         bD1lPId+aBuK+RwywGf8kp47MtpdNI3RN8QKbRT0wmMyeT67hk4LkP2R0ggUpHU6ssIS
         C1Msrw5bIvWb2ghun9ccEEig+Ff5onk7ghf4TxgGBTnTNeOOkv23+uHSprscvFLuiixd
         /F8Q==
X-Gm-Message-State: ACrzQf2qP397IOKk1Ah3sbbMm8bbXyS2KFGZuBAQpe0ZxBNQQPFRwxt/
        /VBG5wiE3QUygWPYwvuXJSf83z6WrbSxO5XLmgVzGlYP
X-Google-Smtp-Source: AMsMyM4dtjHkqx5Oe+iUgTZ/aUYD7g5Z8js9xSoMZ2Px877T+xg1oi9GZwTF49gUWwWfR0aaUsIseIj9WwRwxxKcscU=
X-Received: by 2002:a17:90b:3b8e:b0:209:1e71:147e with SMTP id
 pc14-20020a17090b3b8e00b002091e71147emr95168pjb.92.1664980762223; Wed, 05 Oct
 2022 07:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <166387874213.1884920.6973035378183003234.stgit@olly> <CAP+JOzSaVG4asajffr2XbGND7sPRv1uQk=szegVPNV+GMfhboQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSaVG4asajffr2XbGND7sPRv1uQk=szegVPNV+GMfhboQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 5 Oct 2022 10:39:11 -0400
Message-ID: <CAP+JOzSeFMvgdF_V5JbRrUX5t6aSR0pUQGzvApH0HsSNm1-joA@mail.gmail.com>
Subject: Re: [PATCH] docs: add Paul Moore's GPG fingerprint
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 27, 2022 at 3:45 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Sep 22, 2022 at 4:45 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  SECURITY.md |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/SECURITY.md b/SECURITY.md
> > index 37630585..c817eac9 100644
> > --- a/SECURITY.md
> > +++ b/SECURITY.md
> > @@ -30,6 +30,7 @@ the issue as quickly as possible and shorten the disclosure window.
> >  * Joshua Brindle, brindle@gmail.com
> >  * James Carter, jwcart2@gmail.com
> >  * Paul Moore, paul@paul-moore.com
> > +  *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
> >  * Jason Zaman, perfinion@gentoo.org
> >  * Steve Lawrence, slawrence@tresys.com
> >  * William Roberts, bill.c.roberts@gmail.com
> >
