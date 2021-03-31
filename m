Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F080C433B4
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6003B61056
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 23:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhCaX0l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Mar 2021 19:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhCaX0X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Mar 2021 19:26:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E85C061574
        for <selinux@vger.kernel.org>; Wed, 31 Mar 2021 16:26:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so124237ejr.5
        for <selinux@vger.kernel.org>; Wed, 31 Mar 2021 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RS1uy0nT2eztFaawDfuJmQ5srj3zOrvKjoC/5Bc8EKc=;
        b=cgFdY+4b0ISNRwQIe1hp36OkRxiJ1tOA5a2eOyk4/ZMefQbFix3DeSVbXPFSEn8lLt
         o9K9eRq6p4PQx1r5k1b8qI9KJkYQDP3zY2N72ACPK2fptrRn4ac4i83EoSdwvnH9pTDa
         UAMAXWF97XrPEfsJ/j4LNXa26xU5+INAai0J0va2var5xnRsEAJo+c6qhW+GtMBPvZf0
         1GADlXxBvA2bGuu3bIAJsoTzDME2FOSblharGLrswJEKyTRDl9MpffnuTmZujWh18CSO
         kl+3mjt4+7rvD1QSG5Rcr9cmF0qYJthEj2QOX/hZjCQlCOyHLqKsaquAsznL8wOdOAKs
         O6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RS1uy0nT2eztFaawDfuJmQ5srj3zOrvKjoC/5Bc8EKc=;
        b=U9l/l1JtTXywH6XDGpCrp+/wDRtss88dN2JEv0NuSfYZ2oacZDkIKK3kQZ65Aexd8s
         PiNwqVFgUoVeJK4LTcH3BwN1gZ+sPBjQwyfkrG10L15hnyF311HiyXA8TNgvGnbzzQDu
         c1iGCKhuumopRGtzqcUVEQmKSPiOdr8KY4K2V5OaJ3Kas4CT+QWw8UyYmXvnE3JXRing
         R/JOXSeAfPBePOBcROjF8BmKRaqvo8yPpkuDJ9mjM1RhvdTWkILMGmU0la1NxyitRfrn
         TnXCMzotaH5lGDS7egh95kJ+K/SvDqH1EDYu2lcPkq4vfY22Qq9b1AM2vp8ZB9LDBzh8
         1XBA==
X-Gm-Message-State: AOAM532KJ0Q90yuVMORQciMQKVwtuSDy9SHvomDyGXmzf/sQQvLyC4np
        ARZo+ajkKEKaVuQ9bLfSJ+/lggz4jrX1LVBIh3rjkY2clQ==
X-Google-Smtp-Source: ABdhPJxuwJHBoHON7kyFdUfIUKNFFcSTTadNKWQMv3m+QKvH0qF+kS1CE5l2Pjvx/Kn+pNtgZ02/oAnfhIs54nExgnU=
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr6411063ejd.106.1617233181153;
 Wed, 31 Mar 2021 16:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <CAHC9VhQHTP4eXTEDtd=TztN-wPC=EZ84SG44sX9bZ=KtLfzp=g@mail.gmail.com>
 <CAFqZXNvoDLmjYBEpgnC5Ba6nDVdi11Hbdj=6v=dJYA_bihQERw@mail.gmail.com>
In-Reply-To: <CAFqZXNvoDLmjYBEpgnC5Ba6nDVdi11Hbdj=6v=dJYA_bihQERw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 31 Mar 2021 19:26:10 -0400
Message-ID: <CAHC9VhT_odeqzaY1z=NODAk=tZGihD=h6Tmhvr8B5H2R6L8Kqg@mail.gmail.com>
Subject: Re: [PATCH 0/3] selinux: fix changing booleans
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 31, 2021 at 4:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Mar 31, 2021 at 3:13 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > This series contains a patch that fixes broken conditional AV list
> > > duplication introduced by c7c556f1e81b ("selinux: refactor changing
> > > booleans") and a couple "and while I'm here..." cleanup patches on top.
> > >
> > > Ondrej Mosnacek (3):
> > >   selinux: fix cond_list corruption when changing booleans
> > >   selinux: simplify duplicate_policydb_cond_list() by using kmemdup()
> > >   selinux: constify some avtab function arguments
> >
> > Please don't resubmit, but in the future if you are submitting a patch
> > (or two (or three ...)) which is potential -stable material (and so
> > far I think 1/3 qualifies) don't submit it in a patchset with trivial
> > cleanup patches.  Adding cleanup patches to a patchset that adds a
> > feature is okay, but fixes should generally stand by themselves.
>
> Okay, but in this case the patches are sort of interdependent, so I
> didn't want to mess with a rebase and sending conflicting patches... I
> did move the bugfix patch to the bottom so that at worst you can pick
> it out and ask me to resubmit the rest some other way.

That's understandable, but it results in a patchset which is never
going to be applied as a whole (the bug fix(es) would go to stable-X,
the rest to next).  It's not the end of the world, but it's nice when
there is at least some hope that a patchset could be merged all at
once.  Moving forward I would suggest keeping the fixes separate and
submitting the cleanups in a separate patchset with a note that the
depend on the other patch(es).  Depending on the particular patches
I'll either just merge them and deal with the conflicts, or hold the
cleanups until they can be applied without conflict.

> Since I'll need to respin the bugfix patch, will it be better if I
> repost just the one patch?

Let's try the above suggestion and see how it works; if it turns out
to be a mess, we can work on "patching" the process :)

-- 
paul moore
www.paul-moore.com
