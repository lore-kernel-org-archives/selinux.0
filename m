Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0475C28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A666B2063A
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 20:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7nBTew7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgEFU1B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727970AbgEFU1B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 16:27:01 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01413C061A0F
        for <selinux@vger.kernel.org>; Wed,  6 May 2020 13:27:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z25so2386203otq.13
        for <selinux@vger.kernel.org>; Wed, 06 May 2020 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1NcMQGfU+2+lLQ7qmedUAZHUnQ+MzTnqPEpwV7JFj0=;
        b=D7nBTew7f3IyxsDr69emZ+snn8OZ141UtHKdukzIqC6Druh5jgIIdiOrYS0a1JH3QT
         9DpLH2tNPWDzB+J8Q4Iue/j6sAKw8sh/nPrfdIGhQTRvKBxCKiRa0UJ/awlCqhd3CO1p
         WoNX03eQCv8dK/V4EdbbYNUpvWEcIQbHVQtRTzZBAG/4xLGgdDawXAe18aHk6pUvRnG+
         FxRCMnaePcWal7Y2pypPXK/8vGxvKdVWETVQmmYIVtJmw4My0g12Ef4BrGdwzBZ1yMAx
         +ljxQFZapAl3bstRdc5vmY9iDU08HEgR4QP+pSCze41QtLpvMJ3u1n8CXVM5PO9BstjI
         bx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1NcMQGfU+2+lLQ7qmedUAZHUnQ+MzTnqPEpwV7JFj0=;
        b=OmlsylmBIsFAkHYW9933XVIDVhm2jiTKTh8CUnmNWEYaR1C3ATwA+xK3bkTWNi3KSx
         PJo5hDxAO9gar7MZ6eOzmUZa8rLgOTPbo7KJ2hguQEc0ZhgU9X6Y/9IEP8SqgrH0nrgE
         dwC1TMvVpN5F6c34o5Zy3Tnc4Nb3WqP8zhuFI/jW0ljMVU0e0IWAtI7Mta6yrf1u8pqj
         ohmibqIfKdJiYUVrxHsoSoZfhqjecjTqUugiJuO7V52Ukt+B/ZoBxrcXSXw2rWB00OxS
         XxTAiO2jF4cuJ8krGaAH8rUaS0czp3USJ93eERzJZTn3CmBZx+WI7dns7hytw6KghoI3
         /EBg==
X-Gm-Message-State: AGi0PuYm74FqgS4e4z4CRgd8AP6bJ7gL7VMoD+Rc13WdNWQvySMOAbwI
        Q8rUrrp5491iUBLeY35oCvz4x4fR3/KyKjbMKkM=
X-Google-Smtp-Source: APiQypI45MDZQ/MRWv1CfP5HFuAkaaun6LNscLFfbf1Ev5ArYjuBRTAMO4azyJguz3wTkhNhBcKlRdAGKCXYHhnnyt4=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr8036677otb.162.1588796820386;
 Wed, 06 May 2020 13:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFqZXNt0+BstXTn2yTMHHf=n10SY74nSrj8cfELP26-mcmYkfQ@mail.gmail.com> <CAEjxPJ5=6FhOukWThYeO+LrNTAfPSeCq-7Z27c+zhAdesPbDXg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5=6FhOukWThYeO+LrNTAfPSeCq-7Z27c+zhAdesPbDXg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 6 May 2020 16:26:49 -0400
Message-ID: <CAEjxPJ7ZsE=ArK0HZiZMOZ0u_z-b8mdADpj+jWto7r+6+1Jozg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 6, 2020 at 3:57 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 6, 2020 at 3:37 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, May 6, 2020 at 2:54 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > diff --git a/policy/Makefile b/policy/Makefile
> > > index dfe601b..f86aac4 100644
> > > --- a/policy/Makefile
> > > +++ b/policy/Makefile
> > > @@ -40,6 +40,8 @@ CIL_TARGETS = test_add_levels.cil test_glblub.cil
> > >  endif
> > >  endif # GLBLUB
> > >
> > > +CIL_TARGETS += test_mlsconstrain.cil test_overlay_defaultrange.cil
> >
> > This causes a problem on RHEL-6, since it doesn't understand CIL
> > modules. We'll probably need to detect if semodule supports CIL before
> > trying to add the modules.
>
> I thought we had stopped worrying about RHEL compatibility in the
> upstream testsuite going forward and deferring all of those tweaks to
> downstream?  I'm not fundamentally opposed but that was the impression
> I had received earlier.  If we are still carrying RHEL support, then
> how old of RHEL do we still care about?  RHEL-6 is six months away
> from regular EOL?

Also not sure what we would test here to determine whether CIL is supported.
It isn't directly linked to a particular kernel or module binary
policy version, and the version of libsepol that first introduced it
in RHEL-7 probably differs from upstream (assuming it was back-ported
there).

>
> > > diff --git a/policy/test_execute_no_trans.te b/policy/test_execute_no_trans.te
> > > index 79ba868..f699f56 100644
> > > --- a/policy/test_execute_no_trans.te
> > > +++ b/policy/test_execute_no_trans.te
> > > @@ -24,4 +24,4 @@ userdom_sysadm_entry_spec_domtrans_to(test_execute_notrans_t)
> > >
> > >  #Allow test_execute_notrans permissions to the allowed type
> > >  can_exec(test_execute_notrans_t,test_execute_notrans_allowed_t)
> > > -allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_file_perms;
> > > +allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_exec_file_perms;
> >
> > This causes the testsuite to fail on RHEL-7, since there
> > mmap_exec_file_perms includes execute_no_trans for some reason. And on
> > RHEL-6 mmap_exec_file_perms is not defined at all. Can we solve this
> > bz defining mmap_exec_file_perms as mmap_file_perms in test_policy.if
> > if mmap_exec_file_perms is not defined?
>
> Yes, if we are still providing RHEL-7 compatibility for the testsuite,
> that's easy enough.

Actually on second thought that seems problematic since RHEL-7 defines
it but defines it differently.  So essentially I'd just need to
undefine it and redefine it always, or just inline the definition
itself here.
