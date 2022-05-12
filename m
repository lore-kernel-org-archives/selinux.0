Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C5BC433F5
	for <selinux@archiver.kernel.org>; Thu, 12 May 2022 15:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356103AbiELPrw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 May 2022 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356116AbiELPru (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 May 2022 11:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED11E58385
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652370467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tyE8eZudu12IfUiUh4pRETfrx8ez7E9qV6SaM7h1zkQ=;
        b=TvZb2xXcB/MyTouUY3q6mB/VIwArx/QP+okw/d1EZRaDsIJGmuQpdrAuV7Z4hFtNKkuUUN
        7l9LnPCl1PcekT1l+OW2/r3TCHd9/1GmGKD7k6hDGkzTMKF0bsXoR971cR80fuVnq379Uq
        kA123o01g7tRYnRgsxm7Ld5/CtpSaYE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-9MLCv4KpMVuSiX_nbCyOOw-1; Thu, 12 May 2022 11:47:43 -0400
X-MC-Unique: 9MLCv4KpMVuSiX_nbCyOOw-1
Received: by mail-yb1-f198.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so4915329ybp.19
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 08:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyE8eZudu12IfUiUh4pRETfrx8ez7E9qV6SaM7h1zkQ=;
        b=XU0iLw/w/+C4sZBhAqhcmecPuFWUB4uAAmfmne3CUP2W6AWtc5v8vq3jD+BzyhMEqz
         yfjbBQMxZRvl24L6jxh+6/i7l1vwDrwwHRgfpQ1pGT3JxfjFRX77xgqdFU5bee+dkr1v
         Jp1Sh9Bvsz3/weS6y7pp+E9+73+wTEKYykKDvN1nbd6XIbLB82qhxa6J/1VLPNN4kZVU
         nIeGmAj9d0+bAr6jiwsKQ3Btkrg2f1vHHNCioDQG4HZEOQuJaqtU1i79WyFWPZunmbFi
         B87garTCiKtqROAQDzT5w6HVvWrywlz2Ghxyl8B6yQnYx3gOqCnGPmNRTtOewzC1UJc/
         gmyg==
X-Gm-Message-State: AOAM532tLHXZtnQHvym8xsFcPkd4c5K2FvY8wz41c8d09kDHkNY/TZpB
        THAlU84s5Dq/O5tIBKchqdMHSVg57f0HH+521V1wbifwlhdlJk+F2dlaV7gK0ulkL59DO6JoEQh
        cXK+ozUeqTv8B0vkGG3PquM4OmMUVdSr6Ww==
X-Received: by 2002:a0d:cbd6:0:b0:2f8:d055:c429 with SMTP id n205-20020a0dcbd6000000b002f8d055c429mr703772ywd.247.1652370462632;
        Thu, 12 May 2022 08:47:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIyVXubYSxUomvC1MloDwAdttpGR7Yz/VVYA36TNEu8tW8SpAUEYwX9bS+ndd719pfCdRrmBlpkvw2KK2Yp2o=
X-Received: by 2002:a0d:cbd6:0:b0:2f8:d055:c429 with SMTP id
 n205-20020a0dcbd6000000b002f8d055c429mr703735ywd.247.1652370462256; Thu, 12
 May 2022 08:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220510113929.2780308-1-omosnace@redhat.com> <20220510113929.2780308-3-omosnace@redhat.com>
 <CAP+JOzQCE41Wfb1VF29X=T1jzEbXB9p5RB+3ZyA89sYy01BqHA@mail.gmail.com>
In-Reply-To: <CAP+JOzQCE41Wfb1VF29X=T1jzEbXB9p5RB+3ZyA89sYy01BqHA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 May 2022 17:47:30 +0200
Message-ID: <CAFqZXNt4BWb0y2U98M-XLg_xW58i2iAQNncahQNxWzPLcpaTdg@mail.gmail.com>
Subject: Re: [PATCH userspace v3 2/2] libsepol,checkpolicy: add support for
 self keyword in type transitions
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 11, 2022 at 4:39 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, May 10, 2022 at 7:39 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > With the addition of the anon_inode class in the kernel, 'self'
> > transition rules became useful, but haven't been implemented.
> >
> > The typetransition, typemember, and typechange statements share the
> > relevant code, so this patch implements the self keyword in all of them
> > at the TE language level and adds the support to the module policydb
> > format. Note that changing the kernel policydb format is not necessary
> > at all, as type transitions are always expanded in the kernel policydb.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  checkpolicy/policy_define.c                | 42 ++++++++++++-
> >  libsepol/include/sepol/policydb/policydb.h |  4 +-
> >  libsepol/src/expand.c                      | 69 ++++++++++++++--------
> >  libsepol/src/link.c                        |  1 +
> >  libsepol/src/module_to_cil.c               | 30 ++++++----
> >  libsepol/src/policydb.c                    | 33 +++++++++--
> >  libsepol/src/policydb_validate.c           |  4 ++
> >  libsepol/src/write.c                       | 32 ++++++++--
> >  8 files changed, 166 insertions(+), 49 deletions(-)
> >
[...]
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> > index 156a74a2..0e211c93 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1608,20 +1608,30 @@ static int filename_trans_to_cil(int indent, struct policydb *pdb, struct filena
> >                         goto exit;
> >                 }
> >
> > -               ts = &rule->ttypes;
> > -               rc = process_typeset(pdb, ts, attr_list, &ttypes, &num_ttypes);
> > -               if (rc != 0) {
> > -                       goto exit;
> > -               }
> > -
> > -               for (stype = 0; stype < num_stypes; stype++) {
> > -                       for (ttype = 0; ttype < num_ttypes; ttype++) {
> > -                               cil_println(indent, "(typetransition %s %s %s \"%s\" %s)",
> > -                                           stypes[stype], ttypes[ttype],
> > +               if (rule->flags & RULE_SELF) {
> > +                       for (stype = 0; stype < num_stypes; stype++) {
> > +                               cil_println(indent, "(typetransition %s self %s \"%s\" %s)",
> > +                                           stypes[stype],
> >                                             pdb->p_class_val_to_name[rule->tclass - 1],
> >                                             rule->name,
> >                                             pdb->p_type_val_to_name[rule->otype - 1]);
> >                         }
> > +               } else {
> > +                       ts = &rule->ttypes;
> > +                       rc = process_typeset(pdb, ts, attr_list, &ttypes, &num_ttypes);
> > +                       if (rc != 0) {
> > +                               goto exit;
> > +                       }
> > +
> > +                       for (stype = 0; stype < num_stypes; stype++) {
> > +                               for (ttype = 0; ttype < num_ttypes; ttype++) {
> > +                                       cil_println(indent, "(typetransition %s %s %s \"%s\" %s)",
> > +                                                   stypes[stype], ttypes[ttype],
> > +                                                   pdb->p_class_val_to_name[rule->tclass - 1],
> > +                                                   rule->name,
> > +                                                   pdb->p_type_val_to_name[rule->otype - 1]);
> > +                               }
> > +                       }
>
> Sorry, I missed this in the last version. This shouldn't be in an
> else, it needs to always be done to handle rules like "type_transition
> t1 { t2 attr1 self }:file t3 "file1";". No one really writes rules
> like that, but they are valid.

Indeed... I'll fix that and also add this form of rules into the test.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

