Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9050EECAAA3
	for <selinux@archiver.kernel.org>; Fri, 26 Aug 2022 07:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiHZHfG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbiHZHeo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Aug 2022 03:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E67D3E64
        for <selinux@vger.kernel.org>; Fri, 26 Aug 2022 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661499275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3tQlXBRvlbINJ8yTBWxT9ZH9oE73pU3EbXk2gsEaS/Y=;
        b=eBUKLpKr2//KFc/dTaPvA9sP2eWoTi6jrj8mutDh8c4jj2nJwjhU+je2yIC40sKMFUpjyC
        lvduupneHD5eHFX24YEw4VZN0nQh1uMgxPHBWD1Hijnl8xxH4qsORNhZyd8b2Eya9u8J98
        IDxLhgOd4D1JxvH3H4iE8mKFWKFWRFM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-oEdsv6g3O1auCil93keTTw-1; Fri, 26 Aug 2022 03:34:34 -0400
X-MC-Unique: oEdsv6g3O1auCil93keTTw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-336c3b72da5so13353427b3.6
        for <selinux@vger.kernel.org>; Fri, 26 Aug 2022 00:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3tQlXBRvlbINJ8yTBWxT9ZH9oE73pU3EbXk2gsEaS/Y=;
        b=dMaoSzcaa0lBgg4eyErQWCwIklL1oogZlSZAErRctOvlcJGbCH2ongQ9da8JZZMGbr
         y5lFUK2TYjM2lv7Z04hr7rcV6gcgCnvK3aQI8WDmaar3H0leX3BDhkHZuV/RIPruOedJ
         e5xwJ+ErRxxyeVYYoyzlxdAcnmCsvzspsry+5M7E8EsRG1B3WlFKzKAy6/5QLK2wHNpz
         BbeFC3DbZjNJZea3hQ11WjqSbMgRkR2JiGafTBKuuzRvEHtygKsbjpsl5cKJuHNTK61B
         3g4tofiCXjQEfL/JRsb4Kmm82NH7MEqB/I/B22fAfBXxwlJnCJO5FapcXJuFvgZMLlzu
         D66w==
X-Gm-Message-State: ACgBeo12XRKTtIjanw8iCw3ao1ZveHgUlT3y892ydxHFqRCF/DhwJW+g
        Vm2eESJPHoDnxCnNnSc11SE1UXa++BPwD+V4QRP/uN8lo8CWJDvEM3AUVDWJxpE4u3/DUrvyV55
        YniqqOrMgciVGJx3+AabzPRvO38oH3X2bFw==
X-Received: by 2002:a81:c30a:0:b0:328:4a6c:bc89 with SMTP id r10-20020a81c30a000000b003284a6cbc89mr7518435ywk.29.1661499273779;
        Fri, 26 Aug 2022 00:34:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4YCMybV1e0BmWIgavkSk23Pr75XGDjK1A/nh+/c0JV/+CetaAPW+rgqJBurs6ZAd1NFv5JDef/1KqAOm9jMEw=
X-Received: by 2002:a81:c30a:0:b0:328:4a6c:bc89 with SMTP id
 r10-20020a81c30a000000b003284a6cbc89mr7518421ywk.29.1661499273470; Fri, 26
 Aug 2022 00:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <166061510477.614432.940552725841920786.stgit@olly>
 <CAFqZXNsHyi_ga68=jFXh=qb4SQR9HOwCUNgHcascMn_ycOTtWw@mail.gmail.com> <CAHC9VhTbNSS_SkgyWAjXq+soOa_LUfFZR5eV0auG4K-cLFRTTw@mail.gmail.com>
In-Reply-To: <CAHC9VhTbNSS_SkgyWAjXq+soOa_LUfFZR5eV0auG4K-cLFRTTw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 26 Aug 2022 09:34:22 +0200
Message-ID: <CAFqZXNs4f026E+2Ncsn72C=WYob=GyX_6C8xzr2ix+=0X3gcDA@mail.gmail.com>
Subject: Re: [selinux-testsuite PATCH] tests/binder: remove stray flag files
 with 'make clean'
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 25, 2022 at 8:54 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Aug 25, 2022 at 9:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Tue, Aug 16, 2022 at 8:50 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > Failed or incomplete test runs can leave temporary test files in
> > > the binder test directory, remove them with 'make clean'.
> > >
> > >   mkfifo: cannot create fifo \
> > >     'binder/manager_flag': File exists
> > >   mkfifo: cannot create fifo \
> > >     'binder/service_provider_flag': File exists
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  tests/binder/Makefile |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/binder/Makefile b/tests/binder/Makefile
> > > index e78ad16..b89d4db 100644
> > > --- a/tests/binder/Makefile
> > > +++ b/tests/binder/Makefile
> > > @@ -18,6 +18,6 @@ endif
> > >  all: $(TARGETS)
> > >
> > >  clean:
> > > -       rm -f $(TARGETS)
> > > +       rm -f $(TARGETS) manager_flag service_provider_flag
> > >
> > >  $(TARGETS): $(DEPS)
> >
> > Thanks, though it would be good to do the same cleanup also in other
> > tests.
>
> I agree, but I didn't/don't have the time to do that for the other
> tests, I saw this one and I fixed it :)
>
> > I extended your patch to almost all other dirs in [1] - is it
> > OK if I apply that version?
>
> No, but not because I think those changes are wrong, it's because I
> don't agree with the approach.  Let me try to explain ...
>
> It is my personal opinion that with few exceptions, a maintainer
> should not alter a patch significantly beyond the normal fuzz that can
> sometimes happen when there are merge conflicts.  Of course there are
> trivial changes sometimes, e.g. a missing semicolon, whitespace
> issues, etc. which are okay to fixup (with a note in the commit!), but
> changes of more than a couple of lines, or changes that impact the
> logic of the patch, are not something a maintainer should be doing as
> a normal practice.  I am not a lawyer, so please don't take this as a
> valid interpretation of the laws involved, but I can see legal reasons
> for this: if the maintainer changes the patch in a significant way, I
> imagine that could potentially muddy the idea of authorship, would the
> maintainer now also be considered an author of that patch?  How could
> one clearly distinguish between the original author's code and the
> mainatiner's changes?  Sure, there is the mailing list, but what if
> the mailing list is not available and all you have is the git log?
> However, the biggest issue that I see is that of community building.
> Having a back-and-forth with a patch contributor can help both welcome
> them to the community and teach them what is expected from a patch
> submission point of view.  It might be easier and quicker for you just
> to edit the existing patch, but it's better for the community to take
> the time and ask the original submitter if they could make the change.
>
> Does that make sense?

Yes, I agree. Looking back at what I did with the patch and
communication I can see I went the completely wrong way about it and I
apologize.

Actually there is really no good reason for me not to simply add the
extra changes as a separate patch/commit... I guess I just
instinctively tried to keep the one logical change in one patch and
didn't think it through properly... I'll scratch that embarrassing
commit and just post the extra changes as another patch.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

