Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469ECECAAD4
	for <selinux@archiver.kernel.org>; Fri, 26 Aug 2022 14:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiHZOoW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Aug 2022 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245208AbiHZOoV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Aug 2022 10:44:21 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522621C93A
        for <selinux@vger.kernel.org>; Fri, 26 Aug 2022 07:44:16 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11cab7d7e0fso2300119fac.6
        for <selinux@vger.kernel.org>; Fri, 26 Aug 2022 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oXHluCSgHrKtvZXb+avGYXJyh1UM8z/BWx1HdXaH5Dg=;
        b=51GM2paNvKPfzPYWBZAERXNBxSVxjONRtgA9TK4OWHq0Mi95TxbLatgEax2RhBNMUC
         hyRyfBZbuCWQJYAP92IU1zJc0F8cMh6TsACYXbjxeIwEDjdVYPYvDKFLQcAZhSmJmcU6
         jO9q/N1qR87S5+clx4d03kqSQ8kH4Qv25EE0DaA97mtv36Kx9fRhG2htA+vEJB9tU/PL
         B+xCKgzKi3aSmj1I5ZIX02Ne4iC8E3j2P19WtCZDPBdLqKeYgKxJ84e705oUkzRIGThr
         G7O5XzIy9VC2a5T9QRZ+GH1KZkQCZnjf+7mZDEjkn5jGOt1jpeTu2zDu6gaKFDpimnwf
         nuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oXHluCSgHrKtvZXb+avGYXJyh1UM8z/BWx1HdXaH5Dg=;
        b=61QVdcbB3gRhPAQWn3oZ8OwnOgHSkC6kR8sc6QcE67HPlCnIhCzvKX/IIMYKhueR1+
         TewPUGsdJk5cymzqCmhvRJa5sX89NhIGLp9HxBZUKc9PZ9ifAwDScc38k7RfiZ3ZsdkD
         my9Es9//aXh8ryo7B4dqB/SvXNVPJDg48ZKgmIXjEXVp6AzeVl2msmHsZwNH2E55qik6
         oOSWynpTMA985UK6ttUXFjUgIQAwaHRU7xjwGj9gGJU5ttW28TH1lcBE7ZVGGnQdKBbQ
         aQ3h0OAqjXoCIfFLxNUDciZqZ4P4m5rg1KvNfGqb0hTZ2keTKFj1twuo5OYbccElrw4H
         fMXA==
X-Gm-Message-State: ACgBeo3EizGlYPPcDs2ValYqqcnSMTt1ViF9HLjOe65oxIIdx84yeodu
        SpMBNrhnj7sdm8UVUDeW3NoRoRN8eU863+fmVl0tKOETrQ==
X-Google-Smtp-Source: AA6agR5wh879P8FFNDXZKMSEOe9+q64rJJLPsdXC8OV4e38vYPRaLb6ERoBVkEZg5K9F5lKVBMUi281wB/idwTVKDLY=
X-Received: by 2002:a05:6870:7092:b0:11d:83fe:9193 with SMTP id
 v18-20020a056870709200b0011d83fe9193mr2047873oae.41.1661525054896; Fri, 26
 Aug 2022 07:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <166061510477.614432.940552725841920786.stgit@olly>
 <CAFqZXNsHyi_ga68=jFXh=qb4SQR9HOwCUNgHcascMn_ycOTtWw@mail.gmail.com>
 <CAHC9VhTbNSS_SkgyWAjXq+soOa_LUfFZR5eV0auG4K-cLFRTTw@mail.gmail.com> <CAFqZXNs4f026E+2Ncsn72C=WYob=GyX_6C8xzr2ix+=0X3gcDA@mail.gmail.com>
In-Reply-To: <CAFqZXNs4f026E+2Ncsn72C=WYob=GyX_6C8xzr2ix+=0X3gcDA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Aug 2022 10:44:04 -0400
Message-ID: <CAHC9VhSe8fjKqm1hXmFfB6x8dFYaHfJ4_2=-p=s1DohxEaRSxw@mail.gmail.com>
Subject: Re: [selinux-testsuite PATCH] tests/binder: remove stray flag files
 with 'make clean'
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 26, 2022 at 3:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Aug 25, 2022 at 8:54 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Aug 25, 2022 at 9:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Tue, Aug 16, 2022 at 8:50 AM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > Failed or incomplete test runs can leave temporary test files in
> > > > the binder test directory, remove them with 'make clean'.
> > > >
> > > >   mkfifo: cannot create fifo \
> > > >     'binder/manager_flag': File exists
> > > >   mkfifo: cannot create fifo \
> > > >     'binder/service_provider_flag': File exists
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > ---
> > > >  tests/binder/Makefile |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tests/binder/Makefile b/tests/binder/Makefile
> > > > index e78ad16..b89d4db 100644
> > > > --- a/tests/binder/Makefile
> > > > +++ b/tests/binder/Makefile
> > > > @@ -18,6 +18,6 @@ endif
> > > >  all: $(TARGETS)
> > > >
> > > >  clean:
> > > > -       rm -f $(TARGETS)
> > > > +       rm -f $(TARGETS) manager_flag service_provider_flag
> > > >
> > > >  $(TARGETS): $(DEPS)
> > >
> > > Thanks, though it would be good to do the same cleanup also in other
> > > tests.
> >
> > I agree, but I didn't/don't have the time to do that for the other
> > tests, I saw this one and I fixed it :)
> >
> > > I extended your patch to almost all other dirs in [1] - is it
> > > OK if I apply that version?
> >
> > No, but not because I think those changes are wrong, it's because I
> > don't agree with the approach.  Let me try to explain ...
> >
> > It is my personal opinion that with few exceptions, a maintainer
> > should not alter a patch significantly beyond the normal fuzz that can
> > sometimes happen when there are merge conflicts.  Of course there are
> > trivial changes sometimes, e.g. a missing semicolon, whitespace
> > issues, etc. which are okay to fixup (with a note in the commit!), but
> > changes of more than a couple of lines, or changes that impact the
> > logic of the patch, are not something a maintainer should be doing as
> > a normal practice.  I am not a lawyer, so please don't take this as a
> > valid interpretation of the laws involved, but I can see legal reasons
> > for this: if the maintainer changes the patch in a significant way, I
> > imagine that could potentially muddy the idea of authorship, would the
> > maintainer now also be considered an author of that patch?  How could
> > one clearly distinguish between the original author's code and the
> > mainatiner's changes?  Sure, there is the mailing list, but what if
> > the mailing list is not available and all you have is the git log?
> > However, the biggest issue that I see is that of community building.
> > Having a back-and-forth with a patch contributor can help both welcome
> > them to the community and teach them what is expected from a patch
> > submission point of view.  It might be easier and quicker for you just
> > to edit the existing patch, but it's better for the community to take
> > the time and ask the original submitter if they could make the change.
> >
> > Does that make sense?
>
> Yes, I agree. Looking back at what I did with the patch and
> communication I can see I went the completely wrong way about it and I
> apologize.
>
> Actually there is really no good reason for me not to simply add the
> extra changes as a separate patch/commit... I guess I just
> instinctively tried to keep the one logical change in one patch and
> didn't think it through properly... I'll scratch that embarrassing
> commit and just post the extra changes as another patch.

No worries, thanks for doing the other fixes.

-- 
paul-moore.com
