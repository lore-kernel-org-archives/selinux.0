Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B06C47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15A820836
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 18:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcPRVgrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD3STO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:19:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbgD3STN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588270751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rdd/sbm4WNE5LBCreefmlCZJG5ktW09I/Z4q0s2DUhU=;
        b=UcPRVgrwO9OZantdGk73Po6y/AzVCAIe4ihMTsGIED6nboukV4Em2TDsuMvUUoTS5Xv6Lo
        SmiUmJRllTaOHsoikRUO9TSI4IlnXNE+041ZtoHbMBHPP97TEdtP6Sl2bxEnbn4VUTYN7V
        bdvGq2Pf474R3AB+LW5VxSekah0yYK4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-1wFxUfQzPq-zyaup6xL1uA-1; Thu, 30 Apr 2020 14:19:07 -0400
X-MC-Unique: 1wFxUfQzPq-zyaup6xL1uA-1
Received: by mail-ot1-f72.google.com with SMTP id m15so173757otl.11
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 11:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdd/sbm4WNE5LBCreefmlCZJG5ktW09I/Z4q0s2DUhU=;
        b=o9+jjvGdyzLktJy5CD5lkSu7taGh2UVXmz2dhsyimXCVpjTXscaHjUiViuOshu6PhE
         2rrbBHfYyPFO/F4HSccN8tTKlakZC4WOMGW/Fw6xKmnyiEuCGNTUYsmvaNET3SAPXZWE
         Xr0+pXIK/3wsmRDJGY1iJBC0mtdXyM3KtEfUQcuyGZxsk/srhK0F+ThGFitZkz664T4E
         M7Chj1VSbmMYFWh9HJZFt52K/f0Akre9OFiU9NYI5tw1zJhxOOL2+YsrmR/H+uu/nhpV
         hcSLYrJm6A1RdZA3f1virP9FV+HfOOOCd6AxNF+KzOqGd7XJnkYILH0HK8Bz1GLp6B3P
         qDkQ==
X-Gm-Message-State: AGi0PubfMdDFh0/dxHaFAv+qrHXivX9LUkxstQ9h86sHFQZ3TjeQwCQI
        Inn77vylfONQb/Lj99a3rPkzTKQWTo+59t4TMaN9lv7OemzroOehgLNevuv8brwGF6YoPL5IzjH
        nwUnXopkX0a7eaIJBWLuv9JGSEUDiMBbL0A==
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr361174otq.66.1588270746268;
        Thu, 30 Apr 2020 11:19:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLS8W/+aupzfshEMOl6hsmoPl0JNl1Dqa1SCxr0n1vWMwIviWvXRazEZJfTlyIQObAmOKGLOyavKG1w8lQ749k=
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr361150otq.66.1588270745911;
 Thu, 30 Apr 2020 11:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200328124550.199568-1-omosnace@redhat.com> <20200328124550.199568-2-omosnace@redhat.com>
 <CAP+JOzThTU-EFiwTXdiZt6Va+9vMzH4M3pei+C1nn0UbbUruZA@mail.gmail.com>
In-Reply-To: <CAP+JOzThTU-EFiwTXdiZt6Va+9vMzH4M3pei+C1nn0UbbUruZA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 Apr 2020 20:18:54 +0200
Message-ID: <CAFqZXNs0rT825Q2pdVc+PT1SVevxBSBvaZbyVZa=6ztDaScdrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsepol,checkpolicy: optimize storage of filename transitions
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 7:35 PM James Carter <jwcart2@gmail.com> wrote:
> On Sat, Mar 28, 2020 at 8:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > In preparation to support a new policy format with a more optimal
> > representation of filename transition rules, this patch applies an
> > equivalent change from kernel commit c3a276111ea2 ("selinux: optimize
> > storage of filename transitions").
> >
> > See the kernel commit's description [1] for the rationale behind this
> > representation. This change doesn't bring any measurable difference of
> > policy build performance (semodule -B) on Fedora.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  checkpolicy/policy_define.c                |  52 +++------
> >  checkpolicy/test/dispol.c                  |  27 +++--
> >  libsepol/cil/src/cil_binary.c              |  29 ++---
> >  libsepol/include/sepol/policydb/policydb.h |  15 ++-
> >  libsepol/src/expand.c                      |  60 +++-------
> >  libsepol/src/kernel_to_cil.c               |  24 +++-
> >  libsepol/src/kernel_to_conf.c              |  24 +++-
> >  libsepol/src/policydb.c                    | 126 ++++++++++++++-------
> >  libsepol/src/write.c                       |  46 ++++----
> >  9 files changed, 223 insertions(+), 180 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index c6733fa4..01a90438 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -3303,10 +3303,9 @@ int define_filename_trans(void)
> >         ebitmap_t e_stypes, e_ttypes;
> >         ebitmap_t e_tclasses;
> >         ebitmap_node_t *snode, *tnode, *cnode;
> > -       filename_trans_t *ft;
> > -       filename_trans_datum_t *ftdatum;
> >         filename_trans_rule_t *ftr;
> >         type_datum_t *typdatum;
> > +       char *dup_name;
> >         uint32_t otype;
> >         unsigned int c, s, t;
> >         int add, rc;
> > @@ -3388,40 +3387,21 @@ int define_filename_trans(void)
> >         ebitmap_for_each_positive_bit(&e_tclasses, cnode, c) {
> >                 ebitmap_for_each_positive_bit(&e_stypes, snode, s) {
> >                         ebitmap_for_each_positive_bit(&e_ttypes, tnode, t) {
> > -                               ft = calloc(1, sizeof(*ft));
> > -                               if (!ft) {
> > -                                       yyerror("out of memory");
> > -                                       goto bad;
> > -                               }
> > -                               ft->stype = s+1;
> > -                               ft->ttype = t+1;
> > -                               ft->tclass = c+1;
> > -                               ft->name = strdup(name);
> > -                               if (!ft->name) {
> > -                                       yyerror("out of memory");
> > -                                       goto bad;
> > -                               }
> > -
> > -                               ftdatum = hashtab_search(policydbp->filename_trans,
> > -                                                        (hashtab_key_t)ft);
> > -                               if (ftdatum) {
> > -                                       yyerror2("duplicate filename transition for: filename_trans %s %s %s:%s",
> > -                                                name,
> > -                                                policydbp->p_type_val_to_name[s],
> > -                                                policydbp->p_type_val_to_name[t],
> > -                                                policydbp->p_class_val_to_name[c]);
> > -                                       goto bad;
> > -                               }
> > -
> > -                               ftdatum = calloc(1, sizeof(*ftdatum));
> > -                               if (!ftdatum) {
> > -                                       yyerror("out of memory");
> > -                                       goto bad;
> > -                               }
> > -                               rc = hashtab_insert(policydbp->filename_trans,
> > -                                                   (hashtab_key_t)ft,
> > -                                                   ftdatum);
> > -                               if (rc) {
> > +                               dup_name = NULL;
> > +                               rc = policydb_filetrans_insert(
> > +                                       policydbp, s+1, t+1, c+1, name,
> > +                                       &dup_name, otype, NULL
> > +                               );
> > +                               free(dup_name);
> > +                               if (rc != SEPOL_OK) {
> > +                                       if (rc == SEPOL_EEXIST) {
> > +                                               yyerror2("duplicate filename transition for: filename_trans %s %s %s:%s",
> > +                                                       name,
> > +                                                       policydbp->p_type_val_to_name[s],
> > +                                                       policydbp->p_type_val_to_name[t],
> > +                                                       policydbp->p_class_val_to_name[c]);
> > +                                               goto bad;
> > +                                       }
> >                                         yyerror("out of memory");
> >                                         goto bad;
> >                                 }
> > diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> > index d72d9fb3..7c74e9cf 100644
> > --- a/checkpolicy/test/dispol.c
> > +++ b/checkpolicy/test/dispol.c
> > @@ -329,26 +329,39 @@ static void display_role_trans(policydb_t *p, FILE *fp)
> >  struct filenametr_display_args {
> >         policydb_t *p;
> >         FILE *fp;
> > +       filename_trans_key_t *ft;
> >  };
> >
> > -static int filenametr_display(hashtab_key_t key,
> > -                             hashtab_datum_t datum,
> > -                             void *ptr)
> > +static int filenametr_display_sub(hashtab_key_t key,
> > +                                 hashtab_datum_t datum,
> > +                                 void *ptr)
> >  {
> > -       struct filename_trans *ft = (struct filename_trans *)key;
> > -       struct filename_trans_datum *ftdatum = datum;
> >         struct filenametr_display_args *args = ptr;
> > +       filename_trans_key_t *ft = args->ft;
> >         policydb_t *p = args->p;
> >         FILE *fp = args->fp;
> > +       uint32_t stype = (uintptr_t)key;
> > +       uint32_t otype = (uintptr_t)datum;
> >
> > -       display_id(p, fp, SYM_TYPES, ft->stype - 1, "");
> > +       display_id(p, fp, SYM_TYPES, stype - 1, "");
> >         display_id(p, fp, SYM_TYPES, ft->ttype - 1, "");
> >         display_id(p, fp, SYM_CLASSES, ft->tclass - 1, ":");
> > -       display_id(p, fp, SYM_TYPES, ftdatum->otype - 1, "");
> > +       display_id(p, fp, SYM_TYPES, otype - 1, "");
> >         fprintf(fp, " %s\n", ft->name);
> >         return 0;
> >  }
> >
> > +static int filenametr_display(hashtab_key_t key,
> > +                             hashtab_datum_t datum,
> > +                             void *ptr)
> > +{
> > +       struct filenametr_display_args *args = ptr;
> > +       hashtab_t subhash = datum;
> > +
> > +       args->ft = (filename_trans_key_t *)key;
> > +       return hashtab_map(subhash, filenametr_display_sub, args);
> > +}
> > +
> >
>
> Because of the discussion about setools, I've been playing some with
> dispol and I am getting segfaults with your patch when trying to print
> out the filename transitions.
>
> Looking closer at dispol, this doesn't make sense. The function
> display_filename_trans(), which hasn't changed, passes the function
> filenametr_display() to hashtab_map(), but then filenametr_display()
> takes the datum passed to it to call hashtab_map() again (this time
> with filenametr_display_sub()). The datum is a filename_trans_datum_t
> which doesn't have a hashtab in it.

Ouch, you're right! This must be a leftover of an earlier
implementation of ftrans rules compression I was trying out before...
I must've forgotten to update the dispol code and didn't realize it,
because the damn thing still compiled... I'll have a closer look
tomorrow and get it fixed. Thanks for spotting it, it would've been
much more embarrassing if this was found after merging...

