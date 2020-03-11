Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0476EC10F27
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 11:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB63721D7E
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 11:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmCjbvP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgCKLne (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:43:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38335 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729130AbgCKLne (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 07:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583927013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMtp2QAQ4TdZ6hLuqTZg4WwBcJ/lXcZ2UiciorMSk8M=;
        b=AmCjbvP5H1QIXm/8S2b4pQyx1ey0MNVnVML2fNoWEFk78NoRBUmevckox97T/dYblIzlWh
        HWcivXiYlv1fGHhtx+lZ24SqYtFRhKcvHADqlTaL8h1dM7uhi14MtRgfx7TttuoGRDA60O
        YfUZWxyYqW0i0P5QcrO14JXdqOe6IqY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-8GbnbxW3OAWotfjsg-Q0Sg-1; Wed, 11 Mar 2020 07:43:29 -0400
X-MC-Unique: 8GbnbxW3OAWotfjsg-Q0Sg-1
Received: by mail-oi1-f200.google.com with SMTP id q130so875860oia.12
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 04:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMtp2QAQ4TdZ6hLuqTZg4WwBcJ/lXcZ2UiciorMSk8M=;
        b=LDRCjt5zGhvBlRoZw3+T/YI6OOyKAhqOzooiPa0/AcxtTEJTDN7l1sEkvVIHzmLQpd
         oLUVJbD25TVmRABkR+VGT3ARDx1rIatSg1Ws4uax/JNoir2RQxF7rJaFHQTCzFTeipei
         x1tLahzPUxhx8WfZwUE/i0mAkNqDdq99eNqrz0y3r6/0KoB6a1wvtpgBbTWIpbA3yKpS
         LrMDzluMw5Gzh7KNeSkAoebzQMHsIHZVzk1BWcWcK7oc7pBNFwyUxsV8C9kqeinybJGT
         mAv+nQtjzF2JDP9HsHdVTWz2GpUF24D52DSt/LYKKIM+lJmoSVDUCdmCHW9Jzk/1E6+F
         fkog==
X-Gm-Message-State: ANhLgQ1zYyKicHkJjZoWk2R7n1cgrTaFsrnq+jg3tujqcgcwR5doF5GB
        hpAP+40JamJe10t2PbBjSLS9zbarlU0SLQmPWkk7P7RwRREKbENk8FS/Xk2gnE5OylMP6cTxUEg
        SJqgXQh032OGly8KdepuSEScdmAX/p+usIA==
X-Received: by 2002:a9d:7458:: with SMTP id p24mr2047407otk.197.1583927008209;
        Wed, 11 Mar 2020 04:43:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtWQaxo3/mBLiIo/eZNZUllPv20VZ2+3QMdmsb8wxxlWJ+i/61+4+e0ahO0Ed8g5jzONFNwF3rkaaHzsdAuwtE=
X-Received: by 2002:a9d:7458:: with SMTP id p24mr2047392otk.197.1583927007888;
 Wed, 11 Mar 2020 04:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200304212811.18242-1-jwcart2@gmail.com> <CAFqZXNu-oovsELRzzDU9nb4r50azdztOVetW7ohFY1kK2Xr8+g@mail.gmail.com>
In-Reply-To: <CAFqZXNu-oovsELRzzDU9nb4r50azdztOVetW7ohFY1kK2Xr8+g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 11 Mar 2020 12:43:16 +0100
Message-ID: <CAFqZXNt3w9bUJyKcdpGk8Y8UoHH4FYBU+swDoh4UmTh1t-4r1A@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Check if name is a macro parameter first
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 9, 2020 at 1:03 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Mar 4, 2020 at 10:28 PM James Carter <jwcart2@gmail.com> wrote:
> > Type transition file names are stored in a symbol table. Before the
> > name is added, the symbol table is searched to see if the name had
> > already been inserted. If it has, then the already existing datum is
> > returned. If it has not, then the name is added if either the
> > typetransition rule does not occur in a macro or the name is not one
> > of the macro parameters.
> >
> > Checking for a previous insertion before checking if the name is a
> > macro parameter can cause a macro parameter to be treated as the
> > actual name if a previous type transition file name is the same as
> > the parameter.
> >
> > Now check the name to see if it a macro paramter before checking for
> > its existence in the symbol table.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index 87575860..daf873be 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -76,14 +76,6 @@ static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key,
> >         enum cil_sym_index sym_index;
> >         struct cil_symtab_datum *datum = NULL;
> >
> > -       cil_flavor_to_symtab_index(CIL_NAME, &sym_index);
> > -       symtab = &((struct cil_root *)db->ast->root->data)->symtab[sym_index];
> > -
> > -       cil_symtab_get_datum(symtab, key, &datum);
> > -       if (datum != NULL) {
> > -               return (struct cil_name *)datum;
> > -       }
> > -
> >         if (parent->flavor == CIL_CALL) {
> >                 struct cil_call *call = parent->data;
> >                 macro = call->macro;
> > @@ -99,6 +91,14 @@ static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key,
> >                 }
> >         }
> >
> > +       cil_flavor_to_symtab_index(CIL_NAME, &sym_index);
> > +       symtab = &((struct cil_root *)db->ast->root->data)->symtab[sym_index];
> > +
> > +       cil_symtab_get_datum(symtab, key, &datum);
> > +       if (datum != NULL) {
> > +               return (struct cil_name *)datum;
> > +       }
> > +
> >         cil_name_init(&name);
> >         cil_symtab_insert(symtab, key, (struct cil_symtab_datum *)name, ast_node);
> >         cil_list_append(db->names, CIL_NAME, name);
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

