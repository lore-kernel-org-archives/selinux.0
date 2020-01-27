Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8743C32771
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 08:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F61214AF
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 08:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8juSNPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgA0Icx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:32:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39568 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726260AbgA0Icx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 03:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580113971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CwXUB4tcc2u3Coa0YrhYVO8NQzpKHpWEQqa+lBL078s=;
        b=P8juSNPYkh5rqsy5ldepSdynwviwyZW5iwwWPT7SZRpfei76DlUYCH0+LNo0G8ZwCpTde7
        jh9fC0xJ9WfI/jiFH7bc8+5ZvtS4sfDBNT//gu6TmKv7S4h4MMgHv0dg9p/OlgZAiWKPtP
        K835NTp72qiLjqHKNPaX00Y2b2HN5G8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-eVdfZWuPO-e0hYliqcmCMg-1; Mon, 27 Jan 2020 03:32:49 -0500
X-MC-Unique: eVdfZWuPO-e0hYliqcmCMg-1
Received: by mail-oi1-f198.google.com with SMTP id 199so1482735oie.10
        for <selinux@vger.kernel.org>; Mon, 27 Jan 2020 00:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwXUB4tcc2u3Coa0YrhYVO8NQzpKHpWEQqa+lBL078s=;
        b=R7Xb0ewFVDUJwcXoOSZOWLP8JlQBBlmFMcnHceCGVwsDxrsaN283rAXHQ51PVBrgMp
         vS0da0SJn9WELtL0iP/Ft4Fr78jEQKE0lUMVAIku6Zop8P7/e68nmPOdYjaNyqppQjBQ
         UC19JpSt31pI6dssQsLFcE8tZkif6y+4aJKixAN/z6IW0D6aLJ2ZPKNmxpdjI6VUiodt
         mvUjEbN0ZrwLHK12EGtMkoNE5ajUH0wyfOzEI4gG8yoDXWlWKt97VR4FzJ8i8aVYQ8Xs
         sFPVqiEyNw9Jz26RfD/INUkKPn60g6EDUBXyBw829sBrSeIp1Z9BqQ7gjSWLRYWAAg3H
         1U8Q==
X-Gm-Message-State: APjAAAUUUOBfqgEyVkU0VvSw6Y0j5EXPUvpKnW/i7HNO9ql1w6BKqaxE
        EtE8ktcgJ14jHqavIVcv1/h/wqRxXDV+GstjVOI/W4oO/2240VrocssGgcjuEWJv8LjA8rOy5VK
        QjUCg/xfwev2cLFXv/4rIdF+m3ZZKrcoglg==
X-Received: by 2002:a9d:65da:: with SMTP id z26mr11620484oth.197.1580113968813;
        Mon, 27 Jan 2020 00:32:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyW/TfOd/p7mNMWaradaHcM7p0DWtIbKHdmXS1wMxXs6NLXFWiEIjw+nTrJ1+9yGq6h5gWOIGaaK6lSjItsuro=
X-Received: by 2002:a9d:65da:: with SMTP id z26mr11620467oth.197.1580113968530;
 Mon, 27 Jan 2020 00:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20200123204004.25600-1-jwcart2@tycho.nsa.gov> <CAFqZXNtkpV+E-Vpkeq2_2FitKQFFfu1bjDdaZFD5SA3gm9FfSg@mail.gmail.com>
In-Reply-To: <CAFqZXNtkpV+E-Vpkeq2_2FitKQFFfu1bjDdaZFD5SA3gm9FfSg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 27 Jan 2020 09:32:37 +0100
Message-ID: <CAFqZXNvorPP0esNoKZ_5jrVOrqibc4h1=HXc704b_rD2DbP6NQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix bug in cil_copy_avrule() in extended
 permission handling
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 24, 2020 at 2:12 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jan 23, 2020 at 9:39 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
> > When copying an avrule with extended permissions (permx) in
> > cil_copy_avrule(), the check for a named permx checks the new permx
> > instead of the old one, so the check will always fail. This leads to a
> > segfault when trying to copy a named permx because there will be an
> > attempt to copy the nonexistent permx struct instead of the name of
> > the named permx.
> >
> > Check whether the original is a named permx instead of the new one.
> >
> > Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>
> (OK, this looks simple enough to try out my new maintainer "powers" :)
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Now applied, thanks.

>
> > ---
> >  libsepol/cil/src/cil_copy_ast.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> > index 7af00aaf..67dd8528 100644
> > --- a/libsepol/cil/src/cil_copy_ast.c
> > +++ b/libsepol/cil/src/cil_copy_ast.c
> > @@ -827,7 +827,7 @@ int cil_copy_avrule(struct cil_db *db, void *data, void **copy, __attribute__((u
> >         if (!new->is_extended) {
> >                 cil_copy_classperms_list(orig->perms.classperms, &new->perms.classperms);
> >         } else {
> > -               if (new->perms.x.permx_str != NULL) {
> > +               if (orig->perms.x.permx_str != NULL) {
> >                         new->perms.x.permx_str = orig->perms.x.permx_str;
> >                 } else {
> >                         cil_permissionx_init(&new->perms.x.permx);
> > --
> > 2.21.1
> >
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.



--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

