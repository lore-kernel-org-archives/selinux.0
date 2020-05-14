Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16F4C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89775206A5
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 12:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJ0N1a59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgENMTZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 08:19:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727122AbgENMTY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 08:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589458762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yyWDkLkzj9Qitsh7/Nt/MlUn9xqJNgorFc6ME3U2t7Q=;
        b=YJ0N1a59QruAogtl/AHCYhnMcBIy1HpaNW0r31hzbokoXKCH7fp/GWlfzIijwwdGkaBDgh
        XwmIn569JYG3QPGhK9OoKYi8vp1tzUCI/FnnQi14/1SBn21ThIpyxFfHIgl93bN50QJjik
        TFgZiO0/fCQ80obSYa6HbUDYSNgiCko=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-WmrrzRCoNA2hsSFKM7QjzA-1; Thu, 14 May 2020 08:19:18 -0400
X-MC-Unique: WmrrzRCoNA2hsSFKM7QjzA-1
Received: by mail-oo1-f71.google.com with SMTP id y22so1527027oos.12
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 05:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyWDkLkzj9Qitsh7/Nt/MlUn9xqJNgorFc6ME3U2t7Q=;
        b=ZTkG/R19t9WlPf4ny/BqD0+hti+muH0C6+PgQaKuTxxiaCf9Fyw+zqB5q4w48saMIS
         dWKCgyFDNzuZiO01vsCiZWdQv8ZylZABtnN7jae4h45uC7t/nRNmpeIjlxw/pr2XvqGW
         dt4lEfE8hE9vGKx226jGMm4QtltgUKYJm8yXJCgPUCjnc7B8Wos0qzVT3lxFUf/t1dWT
         RLhE4MnfG9m2tei7TqGpDD8Iqp0ZBpv1zsQs9+4yFu+m0l4O1BIuXLm4nQ6igw8QEESV
         f35Gvlf6GH4wkggJgp0G6WZQU9//2t0IvHha7VEI1KBFe1PaVgBeXAUr59nCT+DwIaah
         z17A==
X-Gm-Message-State: AOAM531XWzBy+uHE/F1LuiP965yNgffd7sCnn4NR6RPaapH6BJNGOPaD
        Ye5uPzhzkh3TQLgXwkrpvp7N5Oi2+FJ1nrUjx6L/KMRjj1SyS2DpT8ZQMUJyI4FXQAEd6LMZJml
        IYzG0r7/5UEmtxjDiOktZQjEnROm+7lKw5Q==
X-Received: by 2002:a05:6830:138b:: with SMTP id d11mr686950otq.367.1589458757655;
        Thu, 14 May 2020 05:19:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY96+B7Pz+GxrgYd7TUtSY/fPmKfYzgCA0ccm1wCj1Eba6gOczy7uu7DycSZE4eFZVqbNBIoXXptCpZUHKmq8=
X-Received: by 2002:a05:6830:138b:: with SMTP id d11mr686900otq.367.1589458756536;
 Thu, 14 May 2020 05:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200513211508.4477-1-stephen.smalley.work@gmail.com>
 <CAFqZXNtNSH8_8ow-ZkAMK=UXvs_rCieUr3xgn6pqrpb-Xvnbtw@mail.gmail.com> <CAEjxPJ4g5+erpnA-ikj6RjZ0KL2v5jd6mENcX1Ahtk2-7=s0bw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4g5+erpnA-ikj6RjZ0KL2v5jd6mENcX1Ahtk2-7=s0bw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 14 May 2020 14:19:05 +0200
Message-ID: <CAFqZXNuj__kQrnUBDgtjv=z2Bu-+WpuQPKkhnHi6zKYK-vFmXA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: drop broken warning on duplicate filename transitions
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 2:03 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, May 14, 2020 at 4:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, May 13, 2020 at 11:16 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > As per the issue below, libsepol segfaults on loading old kernel policies
> > > that contain duplicate filename transition rules.  The segfault is due to
> > > the fact that the val_to_name arrays have not yet been populated at this
> > > point in the policydb_read() processing.  Since this warning apparently
> > > never worked since it was first introduced, drop it and just silently
> > > discard the duplicate like the kernel does.  I was not able to produce a
> > > policy with such duplicates using the current policy toolchain, either
> > > via CIL or via binary modules with manual semodule_link/expand.
> > >
> > > Fixes: https://github.com/SELinuxProject/selinux/issues/239
> > > Fixes: 8fdb2255215a1f14 ("libsepol,checkpolicy: convert rangetrans and filenametrans to hashtabs")
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  libsepol/src/policydb.c | 9 +--------
> > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > >
> > > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > > index 5b289a52..3992ea56 100644
> > > --- a/libsepol/src/policydb.c
> > > +++ b/libsepol/src/policydb.c
> > > @@ -2655,15 +2655,8 @@ int filename_trans_read(policydb_t *p, struct policy_file *fp)
> > >                          * Some old policies were wrongly generated with
> > >                          * duplicate filename transition rules.  For backward
> > >                          * compatibility, do not reject such policies, just
> > > -                        * issue a warning and ignore the duplicate.
> > > +                        * ignore the duplicate.
> > >                          */
> > > -                       WARN(fp->handle,
> > > -                            "Duplicate name-based type_transition %s %s:%s \"%s\":  %s, ignoring",
> > > -                            p->p_type_val_to_name[ft->stype - 1],
> > > -                            p->p_type_val_to_name[ft->ttype - 1],
> > > -                            p->p_class_val_to_name[ft->tclass - 1],
> > > -                            ft->name,
> > > -                            p->p_type_val_to_name[otype->otype - 1]);
> >
> > Not sure if it's the same situation, but should we also do something
> > about a similar pattern in checkpolicy/policy_define.c?
> >
> > https://github.com/SELinuxProject/selinux/blob/63bf6afe5ed20e1d62f966de65882dc327fb2915/checkpolicy/policy_define.c#L3408
>
> No, in that case we are compiling source policy and we want to warn on
> it to encourage removal of duplicates (and we have populated the
> val_to_name arrays there so the warning works).

Ok, makes sense. In that case:

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

