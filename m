Return-Path: <SRS0=9Q29=IE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BBBC433E6
	for <selinux@archiver.kernel.org>; Sat,  6 Mar 2021 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555A564FC8
	for <selinux@archiver.kernel.org>; Sat,  6 Mar 2021 15:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCFPUt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 Mar 2021 10:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhCFPUi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 Mar 2021 10:20:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562FBC06174A
        for <selinux@vger.kernel.org>; Sat,  6 Mar 2021 07:20:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w9so7325937edc.11
        for <selinux@vger.kernel.org>; Sat, 06 Mar 2021 07:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouNkwVvUNOlvrAvhIBhujOWK5gTXDvs7zzrwziJ3Of4=;
        b=P/8T3mcYIZRqoqbZawkMJe8owJ3JReFVoOZkBscLEhbLxiX3QlF/OHM70tVAUbN8sH
         NezZqy5TJt6G+R7I9HAFbQgzFEPXNS4kSAKFga0Z23kV2d8g9Qechildk7pQMBHVx1Al
         iTPzPPiQa6lipHobJYyQuiU8BFaivo+ZUc84ILDmjfa/k95pO7w00x7bigjRIkVVxFEu
         QbvfMW6jYmzfCvWTAlxF3yQn7JLaIx9lPV9X4UX2eC5puUsu52SVbc9h5O2vD+DwMdOw
         mLutyEYQuDZ7tjZoCqpGZheUSx3k0wrE8wPnfEE3JL1Wcpb5pduPo8nlgaIMMney18uc
         VQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouNkwVvUNOlvrAvhIBhujOWK5gTXDvs7zzrwziJ3Of4=;
        b=ZD50pNcIcGMLfFwbBDmrcDnoy1VUbLs1x5/0vMw3/Qhoc4Q7R3Xg5VkUg7wPVO/4sF
         Iallxfzkneai8sdHQIL3i/XvnUmQAJlD3+JsZtSSo+WLSWGTFFBBNpf/omt/rRJ57GmT
         EVcQlQkCHYqOMnp8rcq6+Fc1yzuEKH8Az3/T8FIPryxNwy2kJ0qWcVrJhVCea+1Bd6KF
         R7fXLimuOi/OYLABSIwqH6aGTvmwslpeq9lIMs9BUM7kEsmo60+rFoxRFUnKjS2GtSbo
         SVI7mzXwiAYNVbm+Nzj+zKZUm/k1MyWofZVRuxe1xtnD3Bm6JpemKfgGe+XgKjUMsffB
         k6JA==
X-Gm-Message-State: AOAM5301g9yAQT6g9GFRZ+F5STSRZP4UnWqpPSPn5g71EYcif1WeuyVo
        PFYvU4V+6VXnRLYGFwcTVZpT68uFmQ+auvpKhuPKe13LdlN9
X-Google-Smtp-Source: ABdhPJziTk9KvlzaFYUdYafjefUBCyTgNnq1CQUlfaLKtyNHSzJ1uJu1nLsDlWG+8Vm+vbDan2K8MgOLnXmYd4J3Ppk=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr10579609edb.135.1615044035974;
 Sat, 06 Mar 2021 07:20:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhTUJAD9KQyb0ibFtCZx1nRRLLRuepbMP_CS3Ni+EQMa0Q@mail.gmail.com>
 <CAHC9VhQOzw2aV+kT+b_cdmnAJk21MDP7jhoVy3Y-YVrCbqxBJA@mail.gmail.com> <20210306150002.GX2015948@madcap2.tricolour.ca>
In-Reply-To: <20210306150002.GX2015948@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 6 Mar 2021 10:20:26 -0500
Message-ID: <CAHC9VhTv8kvWEXsTcTo3FLr_p-OaMbhkPESup5MQ+aFxJNZsNA@mail.gmail.com>
Subject: Re: Quick announcement on the selinux/next and audit/next branches
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Mar 6, 2021 at 10:00 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2021-03-05 12:56, Paul Moore wrote:
> > On Thu, Mar 4, 2021 at 9:03 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > Hello all,
> > >
> > > As many of you are aware, normally with the close of the merge window
> > > and the release of -rc1 I typically reset the selinux/next and
> > > audit/next branches to Linus' -rc1 tag.  However, as you may have
> > > heard already, there is a nasty problem with the early v5.12 kernels,
> > > including -rc1, which could result in some fairly serious fs
> > > corruption (see the LWN article below).  With that in mind, I'm not
> > > going to reset the selinux/next and audit/next branches for this
> > > development cycle ...
> >
> > That idea was spectacularly short lived :/  Assuming -rc2 fixes the
> > swapfile bug, I'll plan on rebasing both -next branches to -rc2 early
> > next week.  This should have zero impact on the audit tree (audit/next
> > is current empty), and a minimal impact on the selinux/next branch as
> > we only have one small patch in there at the moment.
>
> Well, it appears you are far from the only subsystem maintainer doing
> that for this cycle.

FWIW, not rebasing the -next branches would likely work out okay for
most release cycles, we just happen to have a SELinux/IMA patch which
has a dependency on code that was merged during the v5.12 merge window
so we need to rebase selinux/next at the very least and since the
audit/next branch is still empty I figured I might as well rebase that
too.

I suspect this will have little to no impact on anyone, but I wanted
to let you folks know regardless.  No one likes surprises when it
comes to upstream trees.

-- 
paul moore
www.paul-moore.com
