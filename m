Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19ABC0015E
	for <selinux@archiver.kernel.org>; Mon, 24 Jul 2023 12:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjGXMgU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGXMgS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jul 2023 08:36:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969BE67
        for <selinux@vger.kernel.org>; Mon, 24 Jul 2023 05:36:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26598fc0825so3556768a91.0
        for <selinux@vger.kernel.org>; Mon, 24 Jul 2023 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690202176; x=1690806976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEJcA68pHiFLxvE5B/6XQKuch5fnseXX0vqFnwPuS0Q=;
        b=b8LyDTGBGIPgTfq4Ex8Gj79lHF/S9x1Nk4kuiVGspywjc+ziuxOGnIOgMJdSOTXio7
         fjiaLq+s/l5J0Wm7oBdj/jRfB3jaBYBedGxEqwxcYb6w4Y7Cke5AaXRGitL4zP8qEWfl
         EooEqEbb9kkaPHZ/oX907GZtQLPc5cLu+o02MFT/iOVpDQ3LVjtWl2DXInY8IZGhbVZ+
         oUkhSxR4FuYEz9LwzXvs84TaOvh/D6a+hJ2n8oJLQxa8yJLz1PR1lwVPnocMT9BDm4hn
         YTh6PYNCKHC+1IaWLosAHQIxjzinChE9Hu+wSgs8sHNxCusESgtImY/mtkOQClBnLYw0
         jaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690202176; x=1690806976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEJcA68pHiFLxvE5B/6XQKuch5fnseXX0vqFnwPuS0Q=;
        b=WUNWzVd5pXU+lRxvK4TxvjnSX2Z/5gaHLBYc4A7CsUZJPwaOJw8uTbL3Z4RliNeS/C
         MEH7bwoQYBKFSeRTjOCT5wThtlvMsBz5mF5ugBaVwjbL2M4IDRiiuBia+rTREFW+eDvG
         Dq4XfhBRqySA1xFbxfgjlB9gvWbjfKkB6l/Q7zpL4HMK1EaAeQB9qny1Mo1jbjMdit2u
         GjmxOnmbpvNg5vNTt228yFIsdKgJt3ZmnQ6KKQZKhTgWqpCU2AeyVRO5jXPdr2hwzl96
         qnFqWaJxfbCI2iuTL+BW171MDNPf+8A8b9D2XkZKRs5uEcGtLU5AHJ/36PWvxupCK+hz
         0yOg==
X-Gm-Message-State: ABy/qLZWAF/unZwRbyS3/OfKKq/LSzWR56yDP+kBEjN3WwjcclMZ4J2E
        RHaay45JdbIR0eATEDPvsFDiW6/OSFbTKF/jb4Q=
X-Google-Smtp-Source: APBJJlFqkoWSZpChQevSoNQiMFF6Yzo7wipwA9NVri4OuugehZ/TnxyMfLRU1j2K8ak5JsejL5I+bFj4UrWHN40dW2c=
X-Received: by 2002:a17:90a:e7ce:b0:262:d8e7:abfc with SMTP id
 kb14-20020a17090ae7ce00b00262d8e7abfcmr13804276pjb.17.1690202176217; Mon, 24
 Jul 2023 05:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230719165716.18285-1-stephen.smalley.work@gmail.com> <874jltzlvd.fsf@redhat.com>
In-Reply-To: <874jltzlvd.fsf@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Jul 2023 08:36:04 -0400
Message-ID: <CAEjxPJ4rN1VXZO9VwPLij2=GcOFefpH0gWxyDDe5LWQBaA3YCw@mail.gmail.com>
Subject: Re: RFC: remove /ru/ man pages from the repo
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 24, 2023 at 5:42=E2=80=AFAM Petr Lautrbach <plautrba@redhat.com=
> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > Change "NSA SELinux" to just "SELinux" and remove NSA from the
> > SELinux manual pages.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> FTR
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>
> My proposal to drop "ru" is bellow.

Thanks, makes sense to me.

> > --- a/libselinux/man/ru/man8/selinux.8
> > +++ b/libselinux/man/ru/man8/selinux.8
> > @@ -1,9 +1,9 @@
> >  .TH  "selinux"  "8"  "29 =D0=B0=D0=BF=D1=80=D0=B5=D0=BB=D1=8F 2005" "d=
walsh@redhat.com" "=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=
=D1=86=D0=B8=D1=8F =D0=BF=D0=BE =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=BD=
=D0=BE=D0=B9 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B5 SELinux"
> >  .SH "=D0=98=D0=9C=D0=AF"
> > -SELinux \- Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=
=BD=D0=BE=D0=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=
=81=D1=82=D1=8C=D1=8E =D0=BE=D1=82 NSA (SELinux)
> > +SELinux \- Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=
=BD=D0=BE=D0=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=
=81=D1=82=D1=8C=D1=8E =D0=BE=D1=82 (SELinux)
> >  .
>
>
> This translates to "Linux with improved security from (SELinux)".
>
> Since 2019, the majority of modifications made to the man pages have not
> been implemented to "ru" part. I guess that these pages will become
> obsolete with time.
>
> I think we should drop the ru translation from this repository and  if
> there's a demand, start a new project that would be connected to a
> translation platform like https://translate.fedoraproject.org/. This woul=
d
> make it possible to translate into other languages too.

SGTM.
