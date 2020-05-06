Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FEAC28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A08120747
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 19:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io5qmhK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgEFT5Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 15:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgEFT5Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 15:57:25 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372A3C061A0F
        for <selinux@vger.kernel.org>; Wed,  6 May 2020 12:57:25 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c12so1902015oic.1
        for <selinux@vger.kernel.org>; Wed, 06 May 2020 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aces6GKA+RdJLj9I7kAiSCoKakemsM7TY263z8tKNWE=;
        b=io5qmhK+sI2+FCkdmVN+f6vQo+mtUEHVoyH4QBksMwlSVlMZwzQxOE5zxu0BSnPCm6
         m+GL1beQ0+ROkADhmhfZQ7yCJfNX581GnQaTEzNUZsQfTZ2bzsWJjht4iF013ZQZJaqm
         asUZqrI794UEBuv7oqcr3Q/q8IGO01C8aMawO32+DNEZQlzbHLRtJIOC5ITf8j/0OHUd
         vVkX1jqo6RlMms9wAOHczIlwIGWJ+aY2njgcLeqoRQy8JAnvi/iiWf2EVbFsI/a3hc/0
         HOCMsMdjkxuACLuEXj9hgttzDQA9GRRx9Is7XJOufI5+Tzue9krGl3oHpNYVIVfGTi20
         WZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aces6GKA+RdJLj9I7kAiSCoKakemsM7TY263z8tKNWE=;
        b=kxpupZ8bWsjESf2HR/JenXtBT1iu645ppPBN3r1lQmER8dHX85E8RW+JBI3QptGwa1
         dGT+RQPtj9hQC7oydmZfAGf/xAaYSysJaQuMot9ZbGEl+LvOfmjO5jFDaZnjlOPBA4d6
         dyawZH8dQqLK4AwtfIZ9iph8CRfyuqOgsiwU7W7dJxI7VqhtopWuNYL7VDQhS9KB9ZA0
         0Yyd5j8/2tUwxbiQzbG4YLmkbgx6XlYmnAQzctut9SBmHdVlR2FqgUXMAFPoTo/idKQr
         BkcRIDvWXEMEhxrdF0h31tct+ifcg8+GreFgQLl+wQN/Nquy/e4OJt2TUbvZ9L0b2b1/
         D+OA==
X-Gm-Message-State: AGi0PubPwg8QMketkWtEgrph5WdUtNoj6qX2FUTx3pXkmlu7U7SZe13d
        53NgaU8Q4QefI/SImlfe63GjtBf7H5fYTKeIITY=
X-Google-Smtp-Source: APiQypK5mc39JcPKJ95HTFHxODqS9bTXTCmH6NP30VeFQhC9A6oEapwgdS6Sd4FijRi0aBsz1TRRIF4gicYkfhchc/U=
X-Received: by 2002:aca:4c0b:: with SMTP id z11mr3959880oia.92.1588795044664;
 Wed, 06 May 2020 12:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com> <CAFqZXNt0+BstXTn2yTMHHf=n10SY74nSrj8cfELP26-mcmYkfQ@mail.gmail.com>
In-Reply-To: <CAFqZXNt0+BstXTn2yTMHHf=n10SY74nSrj8cfELP26-mcmYkfQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 6 May 2020 15:57:13 -0400
Message-ID: <CAEjxPJ5=6FhOukWThYeO+LrNTAfPSeCq-7Z27c+zhAdesPbDXg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 6, 2020 at 3:37 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, May 6, 2020 at 2:54 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > diff --git a/policy/Makefile b/policy/Makefile
> > index dfe601b..f86aac4 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -40,6 +40,8 @@ CIL_TARGETS = test_add_levels.cil test_glblub.cil
> >  endif
> >  endif # GLBLUB
> >
> > +CIL_TARGETS += test_mlsconstrain.cil test_overlay_defaultrange.cil
>
> This causes a problem on RHEL-6, since it doesn't understand CIL
> modules. We'll probably need to detect if semodule supports CIL before
> trying to add the modules.

I thought we had stopped worrying about RHEL compatibility in the
upstream testsuite going forward and deferring all of those tweaks to
downstream?  I'm not fundamentally opposed but that was the impression
I had received earlier.  If we are still carrying RHEL support, then
how old of RHEL do we still care about?  RHEL-6 is six months away
from regular EOL?

> > diff --git a/policy/test_execute_no_trans.te b/policy/test_execute_no_trans.te
> > index 79ba868..f699f56 100644
> > --- a/policy/test_execute_no_trans.te
> > +++ b/policy/test_execute_no_trans.te
> > @@ -24,4 +24,4 @@ userdom_sysadm_entry_spec_domtrans_to(test_execute_notrans_t)
> >
> >  #Allow test_execute_notrans permissions to the allowed type
> >  can_exec(test_execute_notrans_t,test_execute_notrans_allowed_t)
> > -allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_file_perms;
> > +allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_exec_file_perms;
>
> This causes the testsuite to fail on RHEL-7, since there
> mmap_exec_file_perms includes execute_no_trans for some reason. And on
> RHEL-6 mmap_exec_file_perms is not defined at all. Can we solve this
> bz defining mmap_exec_file_perms as mmap_file_perms in test_policy.if
> if mmap_exec_file_perms is not defined?

Yes, if we are still providing RHEL-7 compatibility for the testsuite,
that's easy enough.
