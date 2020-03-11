Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A3BC10F27
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 11:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552DD21655
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 11:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fi7LvJl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgCKLn4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:43:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20489 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgCKLnz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 07:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583927034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NMvewW5K9+L3s/kJoBTyOhWWtEyX1KeIZxV0lNWnnE8=;
        b=fi7LvJl+BTop70Io6J2f3b3gZqG9Q37d5+xBs/8mS404ge9fr/mwH5bfAyZs+fs+aWhXsj
        WtAhzKGW3FDaMarFNoQzKY1DO6CCDYW0lu4qotdxfXo6waHrwuV24xbkdG0jnoZVM5spQ2
        tZnQ6z9rbV8hBGfEfANOvuL3cG5iCzU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-myHsEyqXMSiibkvfgAoZjQ-1; Wed, 11 Mar 2020 07:43:52 -0400
X-MC-Unique: myHsEyqXMSiibkvfgAoZjQ-1
Received: by mail-oi1-f200.google.com with SMTP id s126so890249oih.6
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 04:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMvewW5K9+L3s/kJoBTyOhWWtEyX1KeIZxV0lNWnnE8=;
        b=tYstvSgaFOUis/ninNUeV7fCHSDZTmQew96gTj/ErEGChJEEtpgm9k7eFa7/7U9baO
         S/eLRebQRwwgQKenFR1ZFcJFCQ/hDWHORQGNoMBPY1C+EZmf17l27KufXj1dvwkLZFe5
         6O1wcgfYN+/qfKMKqAsQPdGvF9UcqKEvn0G08DKjc1Ab9/C55sIXL/I+AmDydweKAfw8
         XsCZ3RPLHRv+Ae8Fl7aYdUfXDZmUYVn5UaFfFqbgwuZZLCfeAUXFj0zqqyQHuR619mBL
         XnKjfXfKLYXqEPgyOgH3Ia9QxVlhwoChWiiysnCsGxZ4qxcxHQvm4Yl94/b+GPII0VQ4
         D2MQ==
X-Gm-Message-State: ANhLgQ0pZmPoi5Qpcw+rQn0zU68ZHbUCk3PBywjw/p/rmd1vGFJp7cO1
        egtC5tC6PiWJWLoVmirUopHhT8ztJIUgkD05Ndt97qz0NMpjXNsIOR4M9TGy9Z3JIeos8ej/ZR6
        YYfcg7oCwN7ACAFXx4FFiQRBBTact6oGBJA==
X-Received: by 2002:a9d:7458:: with SMTP id p24mr2048407otk.197.1583927031567;
        Wed, 11 Mar 2020 04:43:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsi4KyqsEzocIAfU+Y0IK0eqfPF/J1D8coQscP84CKQFYvWSv89pQp+BXu3h6FApt43eIyy6Eif5tXzdyeOXbs=
X-Received: by 2002:a9d:7458:: with SMTP id p24mr2048394otk.197.1583927031349;
 Wed, 11 Mar 2020 04:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200304212831.18292-1-jwcart2@gmail.com> <CAFqZXNsv_rn0XY_0fUu3nh6XUHoW2G4htBVyLTGDtvEDjabqVA@mail.gmail.com>
In-Reply-To: <CAFqZXNsv_rn0XY_0fUu3nh6XUHoW2G4htBVyLTGDtvEDjabqVA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 11 Mar 2020 12:43:40 +0100
Message-ID: <CAFqZXNusmHHN49J7tEuYxVAdK5z1yt3pR4setS_8mL_38wA6JQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Do not check flavor when checking for
 duplicate parameters
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 9, 2020 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Mar 4, 2020 at 10:28 PM James Carter <jwcart2@gmail.com> wrote:
> > A parameter of a macro was only considered to be a duplicate if it
> > matched both the name and flavor of another parameter. While it is
> > true that CIL is able to differentiate between those two parameters,
> > there is no reason to use the same name for two macro parameters and
> > it is better to return an error for what is probably an error.
> >
> > Remove the check of the flavors when checking for duplicate parameters.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_build_ast.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 307b1ee3..fcecdc4f 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -5304,11 +5304,9 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
> >                 struct cil_list_item *curr_param;
> >                 cil_list_for_each(curr_param, macro->params) {
> >                         if (param->str == ((struct cil_param*)curr_param->data)->str) {
> > -                               if (param->flavor == ((struct cil_param*)curr_param->data)->flavor) {
> > -                                       cil_log(CIL_ERR, "Duplicate parameter\n");
> > -                                       cil_destroy_param(param);
> > -                                       goto exit;
> > -                               }
> > +                               cil_log(CIL_ERR, "Duplicate parameter\n");
> > +                               cil_destroy_param(param);
> > +                               goto exit;
> >                         }
> >                 }
> >
> > --
> > 2.17.1
> >
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Applied, thanks.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

