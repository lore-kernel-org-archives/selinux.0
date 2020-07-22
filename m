Return-Path: <SRS0=bGuM=BB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F56C433E0
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 22:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF60B206E3
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URpUIMNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbgGVWPa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:15:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42384 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730802AbgGVWPa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jul 2020 18:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595456128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bp5relU5iUHCYma55pPCNtufGKz5iSLNnZUds6MfFBE=;
        b=URpUIMNI73W4Dh9fyCg/KgVg1echJnv2Iq9Y+JVjcMoa/Bkao6mjLx3Vw3uRhHTmbmV8Yv
        wSabwEFxEYhY0loVrgTQ8QIygjR187giy1CLExEqIignbd49Mm5VgTIurKwYaVoUMVL/5Z
        vGjW4LnwOKHmRji/i5q+hzBokxOgKYg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-ZbbpX_5DN1KZ4quRY1yoEA-1; Wed, 22 Jul 2020 18:15:26 -0400
X-MC-Unique: ZbbpX_5DN1KZ4quRY1yoEA-1
Received: by mail-lf1-f72.google.com with SMTP id p192so1060408lfa.0
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 15:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bp5relU5iUHCYma55pPCNtufGKz5iSLNnZUds6MfFBE=;
        b=rCkaDlm87JhxAsLcWXnW6NTxEF72sdVYSowP+S322cP4XQf8VnRNFMCt0Ll+KSVSCG
         P+llZM+xKpLoVfInsvniomtI09yBfswQKJKTEcPHqCPe9ThPHs2WVV27/6DFlmofpEoD
         Qzjw6d4Ai3aYpo9ZJTgqfKbQCdPFoQTUyiEny33zzViyeFLo/RcrLlNmbyXsDK7ecFi6
         j6qKvP4/zENu7sH9UNxSc9ZKsCRYaJt6ZiD4PhCsNlO1HVcU8i7GVilCZUHhg/cUJuIx
         BX5ELvfigKT6LHjwxOcI4fItXyibv3bTXPn2clryio9b3ttM0hEAElRgvVUkE0qAFGvr
         HjRw==
X-Gm-Message-State: AOAM533HtGSS7XqCYfseYn2A5PP7iQTabmcdzMp2nW9Yw0JLSKBUP0UY
        gXQ551H63GXoI+gut8wFqNkpyFXcEav5N1ROSTCYqb3I6BDP9b0sjHfpLyk5ItqOfBal2B7Res4
        bbblzlNpdrVsJJpJnoJD2i3DFHX7oRMLKNg==
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr687247lfo.125.1595456125343;
        Wed, 22 Jul 2020 15:15:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4wzL1LTpxizzKTbkJ+sMTnRVqTxA9k5wn6q/8LxzpRg5eINPCF3iMKEveYgw1uPaAhogaHSJLgzWEGUbVIUA=
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr687241lfo.125.1595456125105;
 Wed, 22 Jul 2020 15:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200719103506.865962-1-omosnace@redhat.com> <20200719103506.865962-2-omosnace@redhat.com>
 <CAEjxPJ6jiWr5ZHWLqirAmu+9R=_qECyTrXPqtKSqwMeEdHZFQg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6jiWr5ZHWLqirAmu+9R=_qECyTrXPqtKSqwMeEdHZFQg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 23 Jul 2020 00:15:14 +0200
Message-ID: <CAFqZXNs43nOnPJBsi+qp0fsu_ykdmrJwuKbQhMF3wEZGK0KftA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] libsepol,checkpolicy: optimize storage of filename transitions
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 8:23 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Sun, Jul 19, 2020 at 6:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
>
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index c6733fa4..01a90438 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -3388,40 +3387,21 @@ int define_filename_trans(void)
> <snip>
> > +                               dup_name = NULL;
> > +                               rc = policydb_filetrans_insert(
> > +                                       policydbp, s+1, t+1, c+1, name,
> > +                                       &dup_name, otype, NULL
> > +                               );
> > +                               free(dup_name);
>
> The dup_name / name_alloc handling seems rather odd.  In every caller
> except one you follow the pattern above, where we set it to NULL, call
> policydb_filetrans_insert, and then free it immediately.  I'm not sure
> why you are doing it this way.

The original intent was to allow a choice between putting the already
allocated string into the key (when the caller function owns it) vs.
allocating a new string (when the caller gets just a read-only
reference to it), while also leaving the string allocated in case such
key already exists (so that the caller can use it in an error message,
as filename_trans_read_one_compat() used to do). However, after
rebasing on top of d27aa22dbeec ("libsepol: drop broken warning on
duplicate filename transitions") such function interface seems to be
no longer optimal... I'll see if I can simplify it.

Thanks for pointing it out.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

