Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0EEC77B72
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjDTPLt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjDTPLs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:11:48 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64E85B93
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:11:45 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id q10so2404229uas.2
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682003505; x=1684595505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mye6GepEqqNMiSm6lQCpnBS1iaC+thlW149tusbF94U=;
        b=F2f7MO66u+FZufdjAxqKvuVA/v47css9CMxSeifVaB93bkoygjqZvrN/MFAPn5t65i
         tcbUtqKfghwD7hPDiehKj8lSi2vkxRuqJE1w33VC70Ft7GvFvnq9oM/qVTLVdGwW8clS
         kBCGn55vKTIvChJ1VkIbAKCoKxPcy1FVpVVtpVh4iM4Ts5veccoJPWNLNicxXfUbWRUl
         oA/1/vDsoXhfRlVCv9XTfpIIihAm+umY1Q1xEch06NSgha459267tjuOu9f/AWIfCoIs
         b2xh2vcS6xI5WfayhDpMXO1iZ+qeAN7ukXLS4Aa6NAw+OBYTLH0qRDUe+ILKUxLzt5kH
         4myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682003505; x=1684595505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mye6GepEqqNMiSm6lQCpnBS1iaC+thlW149tusbF94U=;
        b=la2ckTflnfMNXB+wm1wz9nWyfpZDhJNFFeQre2XTBsA062N3uf33+7YVyKFh3ytAGf
         1NgkSAXsfD0VPh/4FE640mj1lyA18ySRTDFQXW/oUYgGypSOEK7OsQHN11uXyQiTaPL1
         2I0yDDQrhWMnzZJELi1EkCbi6/0qrRYg88yc8BFtuUDqm4nuq2ue6vx/Ni8jMwmmBfcy
         UNLBh78EMm0y9oLinclNP2XYrg1qd3jIxDmwf8fepmR0ghv8lgFc07YSHSl2nmmp8IvP
         o6HnDPuw3h1gC6ih7RGMJgzsb+T4H/7wIsgV1h6APP0dRw/xFrBUulDK59Jok0csrnTs
         2RnA==
X-Gm-Message-State: AAQBX9di//hBq0Fz++g35SxaEOne9+Bftnan2BVmfgtOTw7PzV9y+U7S
        SRA4hCre83l1YTE3bP8kTbER/JPhpEZ/X0ddu8O2ZbyU
X-Google-Smtp-Source: AKy350bW20HsyfodtMWlNsuf4amIZSertqDVLKFaqS71bfBhorY5/G4FU8KvK9/RxsJaARu7Mn89P8ais/88MPew3uw=
X-Received: by 2002:a1f:a994:0:b0:446:c76f:a7e5 with SMTP id
 s142-20020a1fa994000000b00446c76fa7e5mr1200272vke.0.1682003504645; Thu, 20
 Apr 2023 08:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230420135803.4692-1-cgzones@googlemail.com> <CAFqZXNtQ+zxTGBJbxXySaLVZHf7O3nXa9K84kV7GNtLJKZASAw@mail.gmail.com>
In-Reply-To: <CAFqZXNtQ+zxTGBJbxXySaLVZHf7O3nXa9K84kV7GNtLJKZASAw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 20 Apr 2023 17:11:33 +0200
Message-ID: <CAJ2a_De91qKV4Cz-VSuJqQn+xXaeHLhXwF4LvA+qRtHfezLhwQ@mail.gmail.com>
Subject: Re: [TESTSUITE PATCH] README.md: update dependencies
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 20 Apr 2023 at 16:28, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Apr 20, 2023 at 3:59=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > Add libibverbs-dev, required since 4b4922e1 ("tests/infiniband*:
> > simplify test activation"):
> >
> >     create_modify_qp.c:10:10: fatal error: infiniband/verbs.h: No such =
file or directory
> >        10 | #include <infiniband/verbs.h>
> >           |          ^~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  README.md | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/README.md b/README.md
> > index 7bd1dbc..5256cda 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -82,6 +82,7 @@ following command (NOTE: On Fedora 32 and below you n=
eed to remove
> >                 lksctp-tools-devel \
> >                 attr \
> >                 libbpf-devel \
> > +               libibverbs-devel \
> >                 keyutils-libs-devel \
> >                 quota \
> >                 xfsprogs-devel \
> > @@ -124,6 +125,7 @@ command:
> >                 libselinux1-dev \
> >                 net-tools \
> >                 iptables \
> > +               libibverbs-dev \
> >                 libsctp-dev \
> >                 attr \
> >                 libbpf-dev \
> > --
> > 2.40.0
> >
>
> These have already been added in
> https://github.com/SELinuxProject/selinux-testsuite/commit/65cbbb8c4a4caf=
d1b307bfbd954acd7c5a653bb8

Whoops, must have looked on an outdated fork.
Please disregard my fault.

>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
