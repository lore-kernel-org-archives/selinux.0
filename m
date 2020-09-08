Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD4C43461
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 19:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29E92098B
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 19:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/+vZA/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbgIHT0k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731066AbgIHQAE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 12:00:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30930C0619C3
        for <selinux@vger.kernel.org>; Tue,  8 Sep 2020 08:27:17 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e23so15183620otk.7
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2020 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmLpx3/c94QUJe1Ht1dEQ/aGMxhaUwSf/xC/peCG9K4=;
        b=L/+vZA/SgKof0J47fTP3eaFcrTo7h6qntvah2XoKY06P90dTuIWUPQZjoxQV5k8B5p
         B5nOO2xfCzC4vdxhOqZYjMyOjLrFcU5HTWEKRmzUQ1ddpYmOEcKe52iEYKMLmoL0Asor
         C1gWq07MXJtRJ0q8oSp66KVcr6221QgydJjKgahDiJbUyL8poEY0KfqkqEQ2FBER0KKR
         8ENWbuFbAJ+wpPu2k9uYGEJqbU1KNmGFWwhNNsPAT47UAqoQM8orzoHHVXMeOVuXmiMw
         5ERxUoOxkHLAG9ji9L0NHU2Dy9G8cd2O/limKEBQx1iMapOhUG6wCIT2aa6IdyaHaShu
         gadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmLpx3/c94QUJe1Ht1dEQ/aGMxhaUwSf/xC/peCG9K4=;
        b=NjghYRovFqNqEIjQSgaypZr+gpswrt5YTPzxNsxUechMRKhMC0jDiAu3yw6bHaJOD/
         nBUvUFBENFgRUILxKr09XPIGY4n9nqoAiBmuqI3H2V3xiZxE2ztqsHnkXOx4GWEfDrSq
         5x7QJtxsGwj7nnhylTmTqOsD7YkxPX107NMmuqAp5KqgIgjcQzk7MsaChCwvJWIYq+tB
         e3Z3oK89G7BrvgW0lsAa4xH2z93IRRq2jQ3wPX3qjEjhfoEHfKrEoCeKOnhnDPc58rZA
         zOLGQgvbQa+5ASgNOMHfgdEpACxegdFpT2WJMVZO639DM4Th967H0eDGGMV0e0xTF+XR
         ccKg==
X-Gm-Message-State: AOAM533KvRLWsGlKnjU4BZXv+WcIEcztRd5MthRj3otWOThCuvOtYCJr
        mPpNcrk87EeKZ42jW4KFxN2joca3I3FHLWge0Lo=
X-Google-Smtp-Source: ABdhPJyJMzDm8jhLlovzh37CA6oQoH6+u17xcbdedZlsTK7iKJurT43kiBtrPSVGeM0MIPJs6oaS9LZuvL523v2Y4Ro=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr18371309otb.162.1599578836564;
 Tue, 08 Sep 2020 08:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181900.81179-1-jwcart2@gmail.com> <CAEjxPJ53Z6z2VAw75QOHZdK-kFz1fnkEFth7acyUGh_2nzpGkQ@mail.gmail.com>
 <CAEjxPJ6EXg5B8pjCxs2SdqBGe91u7PZnBPEphWgvvQ_u1mZtYA@mail.gmail.com> <CAEjxPJ7fd62jYjhT18tNRhdMiRHt1Nt6QGexHDaDx4DcrBY42w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7fd62jYjhT18tNRhdMiRHt1Nt6QGexHDaDx4DcrBY42w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 11:27:05 -0400
Message-ID: <CAEjxPJ5GmedEWv_7=nAh+ete8gaeRgRmdyrfpwxifC26KRbGjA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Give an error when constraint expressions
 exceed max depth
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 8, 2020 at 9:50 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 8, 2020 at 9:46 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Sep 4, 2020 at 8:49 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Sep 3, 2020 at 2:19 PM James Carter <jwcart2@gmail.com> wrote:
> > > >
> > > > CIL was not correctly determining the depth of constraint expressions
> > > > which prevented it from giving an error when the max depth was exceeded.
> > > > This allowed invalid policy binaries with constraint expressions exceeding
> > > > the max depth to be created.
> > > >
> > > > Correctly calculate the depth of constraint expressions when building
> > > > the AST and give an error when the max depth is exceeded.
> > > >
> > > > Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> > > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > >
> > > The fix for conditional boolean expression depth checking can be a
> > > separate patch.  For this one,
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Actually, this breaks selinux-testsuite. Will have to look into why.
> > /usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil
> > test_overlay_defaultrange.cil test_add_levels.cil test_glblub.cil
> > Max depth of 4 exceeded for constraint expression
> > Bad expression tree for constraint
> > Bad constrain declaration at
> > /var/lib/selinux/targeted/tmp/modules/100/base/cil:919
>
> Here is the failing cil module:
> $ cat policy/test_mlsconstrain.cil
> (mlsconstrain (peer (recv)) (or (dom l1 l2) (and (neq t1
> mcs_constrained_type) (neq t2 mcs_constrained_type))))
> (mlsconstrain (packet (recv)) (or (dom l1 l2) (and (neq t1
> mcs_constrained_type) (neq t2 mcs_constrained_type))))
>
> Maybe an off-by-one in your depth checking?

Actually, the depth computation logic doesn't seem consistent with
checkpolicy's define_constraint().
