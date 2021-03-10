Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F7AC433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 00:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B0364F55
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 00:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCJA27 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 19:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhCJA2i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 19:28:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1D6C06175F
        for <selinux@vger.kernel.org>; Tue,  9 Mar 2021 16:28:38 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lr13so33436804ejb.8
        for <selinux@vger.kernel.org>; Tue, 09 Mar 2021 16:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWzIof0L0fIHv8j6LIVzi88k2G7f3A/I4dXn402meCY=;
        b=snRMOu9AnX6xo2qLF36VVjCaPtb55CI0/b/XO7Y3aWiifvQNABTRfE3fQiR3KrBJui
         hWkXkBJZ9R6NRg0lhTinGufVU2OV3cSfo7jc3QJK1MP2aB/xlpm+29VcqhHFMdqlI171
         poHSGm0xqQD20dlHXZCjXAH+HJ+RxZwihTiZPBp+sR1xND35QHZ51YIyMCFuLWHI7hKf
         B+D+PXLqqKsR4AiMNURmUvZU8zcW7EjUVyGISH0qUrtp0q/Kw/haWS/xfMAe/mP2zT9U
         RSi0H+9GCxqbn2bF5NlIHRu/rOc/OuL0ahHrw6yVtCwzvQdXPH1Ou/wgbd2BFP6J8JRu
         aqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWzIof0L0fIHv8j6LIVzi88k2G7f3A/I4dXn402meCY=;
        b=Li8XoaluU9ghHupjZdXb5TFskxAo61ybUPqoVUkCR1ObGCW5juAeWTlQrd+vMxJsov
         pUiMYd+sXW8Q/IjV7i7AdJjYijLPp2nDRn57rcck1l2mi/Ba3ByAoanPwKWaR/2T86my
         ZBPbGFtRW876wSLOxOA3QUN1Klv57WlrxHXWKy9HC1gY5uEAngUQXGJhlro97ny6BwEQ
         OkhR2NguhIPd+uDJTzhJoV3xeJGcdI2I8ZyYQFHXUaKA2GAgXj16Xcg/KFMLmF4SgU8d
         AT7S8t2IKiWW0yCoFmlgwoOk0GcoMqIrEVdh70UuUFdbaPCZDiwp03JxtjxxPd0mHjku
         OSWQ==
X-Gm-Message-State: AOAM531Bq7GsyqLwp+49ctdPsN8fOgefy+vpBTnq3Tk/tZfX8lIUj8aG
        t12VMfK1JxIOG7CyDvRZ4/I4+8Aef2pjNqLLfSKW
X-Google-Smtp-Source: ABdhPJzU56Iq5dEyrnK2659w7Z77qfmF4u28zLAmtz2ebPrLR6+jjCJbvaIt4rRdIGMiinUjLn1/figOLnCUDFqc26U=
X-Received: by 2002:a17:906:e116:: with SMTP id gj22mr674940ejb.398.1615336117231;
 Tue, 09 Mar 2021 16:28:37 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <b2f85cf5-a110-68ae-47b6-276dd8062be7@canonical.com>
 <CAHC9VhTn33cSX=n7a6kr-5=TKeEx8iRbTY8-2XGxG0YC+GhvaA@mail.gmail.com>
In-Reply-To: <CAHC9VhTn33cSX=n7a6kr-5=TKeEx8iRbTY8-2XGxG0YC+GhvaA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 9 Mar 2021 19:28:26 -0500
Message-ID: <CAHC9VhRVxFiMTzrdtNzKy=1KN10JXU=JC-rohTNH1bGSNj9K_w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 3, 2021 at 7:44 PM Paul Moore <paul@paul-moore.com> wrote:
> On Sun, Feb 21, 2021 at 7:51 AM John Johansen
> <john.johansen@canonical.com> wrote:
> > On 2/19/21 3:29 PM, Paul Moore wrote:
> > > Of the three LSMs that implement the security_task_getsecid() LSM
> > > hook, all three LSMs provide the task's objective security
> > > credentials.  This turns out to be unfortunate as most of the hook's
> > > callers seem to expect the task's subjective credentials, although
> > > a small handful of callers do correctly expect the objective
> > > credentials.
> > >
> > > This patch is the first step towards fixing the problem: it splits
> > > the existing security_task_getsecid() hook into two variants, one
> > > for the subjective creds, one for the objective creds.
> > >
> > >   void security_task_getsecid_subj(struct task_struct *p,
> > >                                  u32 *secid);
> > >   void security_task_getsecid_obj(struct task_struct *p,
> > >                                 u32 *secid);
> > >
> > > While this patch does fix all of the callers to use the correct
> > > variant, in order to keep this patch focused on the callers and to
> > > ease review, the LSMs continue to use the same implementation for
> > > both hooks.  The net effect is that this patch should not change
> > > the behavior of the kernel in any way, it will be up to the latter
> > > LSM specific patches in this series to change the hook
> > > implementations and return the correct credentials.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > So far this looks good. I want to take another stab at it and give
> > it some testing
>
> Checking in as I know you said you needed to fix/release the AppArmor
> patch in this series ... is this patch still looking okay to you?  If
> so, can I get an ACK at least on this patch?

Hi John,

Any objections if I merge the LSM, SELinux, and Smack patches into the
selinux/next tree so that we can start getting some wider testing?  If
I leave out my poor attempt at an AppArmor patch, the current in-tree
AppArmor code should behave exactly as it does today with the
apparmor_task_getsecid() function handling both the subjective and
objective creds.  I can always merge the AppArmor patch later when you
have it ready, or you can merge it via your AppArmor tree at a later
date.

-- 
paul moore
www.paul-moore.com
