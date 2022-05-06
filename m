Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386FC433F5
	for <selinux@archiver.kernel.org>; Fri,  6 May 2022 13:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiEFNxX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 May 2022 09:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiEFNxW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 May 2022 09:53:22 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE8F95DA34
        for <selinux@vger.kernel.org>; Fri,  6 May 2022 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651844978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jkWuunTubxHfs7GNOEIDmyRqsmd41KRhGYLaGrQqxjU=;
        b=d17mhCjswNMXP9MEk3HbL5Mi2veXRb12eFPQdQpyXHXU2iud7m0eVsvV2hP75iRi4AhEKH
        RO0Snl65M7hClKl5lIUWgWbfAechg6gtpGGhrvnA5rLOHLuRxI4WS9hmOPfdPZIPzrphE/
        GhbbKXaDx/q3bTob5jbAP5dNP55ThSo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-DqHYCmddNmaSIglFwwevYg-1; Fri, 06 May 2022 09:49:38 -0400
X-MC-Unique: DqHYCmddNmaSIglFwwevYg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-2eb7d137101so65388427b3.12
        for <selinux@vger.kernel.org>; Fri, 06 May 2022 06:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkWuunTubxHfs7GNOEIDmyRqsmd41KRhGYLaGrQqxjU=;
        b=O4lyKw8ljTyomAdESmbTCG2qUL4nBziB/IhDty2wNAixkTR5x9Ngk50fsZ6/nJHYlp
         E21GCqpdJ6QIRdS8e8FxTh3Fq/NeUryexB+5NODL3O/S0kq8gpmnolcpGiqGkjY+xdRL
         DsYdzBxM1EpGsHPD5PsPSBkbEzBLJ/gxWJA4UnD5OccZmXRUvH8sMYr+f9E279QckwAU
         2NbLHGuola8ZaQW0D3dVMGCkGJBbzb9BLjA2HECt0ViXXkp1xFMgqB0MW+142JAm9Uk+
         uPL2IhGwaHAravhMcOy7oZMnNTunc3Vmx0yLV95hBIHxknKmBN5NwNtIMILcR5dK2gYg
         b60g==
X-Gm-Message-State: AOAM531sfL8PA2ZVa60XGuqXJF0Lg7ONRskPzMQrs4c/1H1FYvGKM/Li
        WspyUV/6SLM3S2YOyhWKfAf1bc6zDlJSzoYuXSnqhLU8XXrnB5P5uC8jW5pdBO9epOCT3RIinO0
        bOF3bDR7vPAPY8i8ZCEb+/GnVq/2xFsNTKg==
X-Received: by 2002:a25:938d:0:b0:648:c0cd:3339 with SMTP id a13-20020a25938d000000b00648c0cd3339mr2316621ybm.336.1651844977019;
        Fri, 06 May 2022 06:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYZEVWrFw4QwsfgjWHTlDk0o6wPAz0TMx9H9gl6UFoZ+WC5AR7rW4pl2y9YM7MTMhkKzbiQenakpNAl32qj38=
X-Received: by 2002:a25:938d:0:b0:648:c0cd:3339 with SMTP id
 a13-20020a25938d000000b00648c0cd3339mr2316608ybm.336.1651844976848; Fri, 06
 May 2022 06:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220426105118.506847-1-omosnace@redhat.com> <20220426105118.506847-3-omosnace@redhat.com>
 <CAP+JOzTpJ4XROVjo9-rOmh97rwiEOp2YPxXSuUOQtLbRWX0kGg@mail.gmail.com>
In-Reply-To: <CAP+JOzTpJ4XROVjo9-rOmh97rwiEOp2YPxXSuUOQtLbRWX0kGg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 6 May 2022 15:49:25 +0200
Message-ID: <CAFqZXNtiHRZPsGD62y78ek7KwvdhuOqT_CizsaBcNV7ci9ng0A@mail.gmail.com>
Subject: Re: [PATCH userspace v2 2/2] libsepol,checkpolicy: add support for
 self keyword in type transitions
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 28, 2022 at 9:23 PM James Carter <jwcart2@gmail.com> wrote:
> On Wed, Apr 27, 2022 at 6:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > With the addition of the anon_inode class in the kernel, 'self'
> > transition rules became useful, but haven't been implemented.
> >
> > This patch implements the self keyword in all 'typetransition'
> > statements at the TE language level and adds the support to the module
> > policydb format. Note that changing the kernel policydb format is not
> > necessary at all, as type transitions are always expanded in the kernel
> > policydb.
> >
>
> These patches also cause "self" to be allowed in type change and type
> member rules as well. That is fine, but it should be stated.

Good point, I'll update the commit messages.

[...]
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index d7ac2b25..5f593c1d 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -1929,11 +1929,12 @@ static int role_allow_rule_write(role_allow_rule_t * r, struct policy_file *fp)
> >         return POLICYDB_SUCCESS;
> >  }
> >
> > -static int filename_trans_rule_write(filename_trans_rule_t * t, struct policy_file *fp)
> > +static int filename_trans_rule_write(policydb_t *p, filename_trans_rule_t *t,
> > +                                    struct policy_file *fp)
> >  {
> >         int nel = 0;
> > -       size_t items;
> > -       uint32_t buf[2], len;
> > +       size_t items, entries;
> > +       uint32_t buf[3], len;
> >         filename_trans_rule_t *ftr;
> >
> >         for (ftr = t; ftr; ftr = ftr->next)
>
>
> The flags field needs to be cleared if the policy version being
> written is < MOD_POLICYDB_VERSION_SELF_TYPETRANS.
>
> Something like:
> +        if ((p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS) &&
> +            (ftr->flags & RULE_SELF)) {
> +            WARN(fp->handle, "Module policy version %u does not support using "
> +                 "\"self\" in a filename type transition rule", p->policyvers);
> +            ftr->flags &= ~RULE_SELF;
> +        }
>
> A similar check is needed in avrule_write(), but there needs to be a
> check that the rule is an AVRULE_TYPE as well.

I agree we need to handle this case, but should we really just discard
the flag? It seems that currently avrule->ttypes is empty if
(avrule->flags & RULE_SELF) is set, so we would create an empty (or
maybe even invalid?) rule in the policy module. Setting ttypes =
stypes would not be equivalent and expanding the rule also doesn't
seem like a great idea. IMHO we should just return an error on any
attempt to downgrade a module containing self AVRULE_TYPE rules below
MOD_POLICYDB_VERSION_SELF_TYPETRANS.

What do you think?

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

