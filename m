Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A78C00140
	for <selinux@archiver.kernel.org>; Mon, 15 Aug 2022 15:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiHOPy2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHOPy1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Aug 2022 11:54:27 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F017077
        for <selinux@vger.kernel.org>; Mon, 15 Aug 2022 08:54:27 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so5706261otq.11
        for <selinux@vger.kernel.org>; Mon, 15 Aug 2022 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=vi7gDxzGCi53o7T+YllLVS7knXAZ4oMCvgjoC9fPzsg=;
        b=fWDiqEG7humjQBW02NB//95zV1CT76QxcPHXRDoc5MHdUNNjAtSCXmssc6MAcc5DwA
         SuRSdfccyorMZd8rOdhP3I9b+cH6TmyC4lVrJC/0vjBU9TRunDLUsk5m8olRk0feGBdG
         d58hPMwE9hbIa63CggJofHehu4MSsC3npfEUbqBnoy4Kw2xbcHKTXxTultqM/1s8bU6w
         TDKgSBmpyZE3QU34oN3dmWnFqy8W7LfdwOrKmGsSRjUAaP6//zqYL5nUCNvsKyyz8p+a
         6GfRDYFO2z8fdrNKwibYgHhbUJkIYBvSwWFpEUn/9JRwu/2WGW8hCgHjGp4CYNVv/EVP
         dB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=vi7gDxzGCi53o7T+YllLVS7knXAZ4oMCvgjoC9fPzsg=;
        b=yxS3kYhlMcUC16uAZA7nj6sHpg3DXqivsVm/pOAT5YVLKzCDOPMwENWpB/xJCA/Suf
         gYEObnXGV9njDOO+CCJTJRDp1tBqUepOwovDPlk7TqjibcsUxmJvsOS+ppPE17uSHuHk
         MoJx1O2Sg+NhJQyhxEVj6cXdXm4vHuqgQTdzi6PmqcwlszjKkhj/XKAmwX0TuFJ5iV/N
         8Oh7b5PBqwHZvG9Y6UnxfTT37kQCQsCppoWj31h4Is+OmoRO5zHoZaSwn7btVAqmEyNF
         fg9RIoV33Q7qJtlZEYw9PaEDNdb0Edx91QaYKSRI5VZTnZjhu3qTsslqnacL4ISDH9Jp
         YCXg==
X-Gm-Message-State: ACgBeo2h7osc31cxaGQPXjSjbQB28ZCrQjElIxvsZxKpnb4IeGQXWimC
        6mTwIbZE6ZSId0qchc48pIjSC4ZCTmnhCcu3Rj9BNUB/
X-Google-Smtp-Source: AA6agR5WTUj7KcQRm0Lg1L3YKOy133Ndku+jnawS6uc0a407ITnyqJJAyIhAtnIqN+Rcuyb2NbUDM7sR4cp55IyqMFI=
X-Received: by 2002:a05:6830:61cd:b0:618:d560:b787 with SMTP id
 cc13-20020a05683061cd00b00618d560b787mr6495604otb.154.1660578866439; Mon, 15
 Aug 2022 08:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220808173620.16760-1-cgzones@googlemail.com>
 <d395fef5-379b-faa1-d974-2e58ee8381cd@linux.microsoft.com> <CAP+JOzQmkZOtk_c_aB8JMZT9gSkfy8GC1qJyYcqdLqnOZXSNNA@mail.gmail.com>
In-Reply-To: <CAP+JOzQmkZOtk_c_aB8JMZT9gSkfy8GC1qJyYcqdLqnOZXSNNA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 15 Aug 2022 11:54:15 -0400
Message-ID: <CAP+JOzQRx9F5wrA37ZL6gqBbDX+ws3dNih+S8ofjhJNED75-AA@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: use strict function prototype for definitions
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 10, 2022 at 11:34 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Aug 9, 2022 at 10:06 AM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
> >
> > On 8/8/2022 1:36 PM, Christian G=C3=B6ttsche wrote:
> > > Clang 15 starts to complain about non strict function definitions:
> > >
> > >      policy_define.c:4907:30: error: a function declaration without a=
 prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> > >      int define_devicetree_context()
> > >                                   ^
> > >                                    void
> > >      policy_define.c:5298:29: error: a function declaration without a=
 prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> > >      int define_ipv4_node_context()
> > >                                  ^
> > >                                   void
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For this series:
> Acked-by: James Carter <jwcart2@gmail.com>
>
This series has been merged.
Thanks,
Jim

> > > ---
> > >   checkpolicy/policy_define.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.=
c
> > > index 8bf36859..f3b48870 100644
> > > --- a/checkpolicy/policy_define.c
> > > +++ b/checkpolicy/policy_define.c
> > > @@ -4904,7 +4904,7 @@ bad:
> > >       return -1;
> > >   }
> > >
> > > -int define_devicetree_context()
> > > +int define_devicetree_context(void)
> > >   {
> > >       ocontext_t *newc, *c, *l, *head;
> > >
> > > @@ -5295,7 +5295,7 @@ int define_netif_context(void)
> > >       return 0;
> > >   }
> > >
> > > -int define_ipv4_node_context()
> > > +int define_ipv4_node_context(void)
> > >   {
> > >       char *id;
> > >       int rc =3D 0;
> >
> > Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
