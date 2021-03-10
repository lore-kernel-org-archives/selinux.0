Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A3C433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84ED164FE3
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 08:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCJIVd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Mar 2021 03:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCJIVX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Mar 2021 03:21:23 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB04C061760
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 00:21:23 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t9so24426307ljt.8
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 00:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DphxTuMCEpgHKRaen67zVxU/WlSz40n3RnzWZz5fZ/U=;
        b=hkB98JNi6GVUaUzi+cDGghcuo8+TkXWgycu1DMSFaMpSwWDIIFX5XFpv1jh22axdAL
         B+liBAyMhoNbXQStTb4tOpCeZBz9G50U0Olrga54KXKY/HIKAUnn51n93mAf1bXZ84Uj
         A4W3G1ew+AaUVetM7mAAEDiHNpkoF6XBsV2wr0LFxcE7wsQhicU1wSxEfgEMrkMdmpuh
         YUNZy5+cx9zgMdBQmxA/nGn5P5zJV6t8iFoGR3oMAbo5HSgsqNLnNaLrv5PxThdeMR4q
         LpviLjlHJkmvkQYmtE8r3oiYvjrx4x5mQQ9vhp/Jg9QJoXTFKIljR6ZvEi24Jp2vn4/H
         gcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DphxTuMCEpgHKRaen67zVxU/WlSz40n3RnzWZz5fZ/U=;
        b=Mfvp48svN2n3SEoMJUL6SQlvaA4gonWBYbqmTKZ2I1TXjuwp7olhIO/g0j73QkcdXA
         jCwCrQfKLszo6Hg0thorPD/LgFvVtYRkJMKhSySIeSMGtMW9CLV6721GYuxWO/X1FXlH
         0LtzGoYz7QN527yzYiA2/xMqoqM8zsY0Uf7kdsK7n+7SzhFNVC9to5Ip9/nXWqbDQ9Wz
         TBGMbVrmOgAiuxVWhkzEKWE70ZYVWLrXFwijcw0ZtK7a6jGf5JbSZkFqz+FNs6k5A5to
         OD5EEjpesA8Chrx+iwR9WJt25LUv7AjRaAmIPdbS/WVyMV5MO/BiCFdKwkvIWhRmbAkY
         sIig==
X-Gm-Message-State: AOAM533YcRQLRLPQnInM+gK55m9LksRBHYpLkTAijXpz6iVHtI64NnwB
        vFLK00qkOH1VqcHz9FVciHpw93u62GOFDhWDlnWFow==
X-Google-Smtp-Source: ABdhPJwhjLj6sQ6ZjEKwaRzEHOKoqu9UHbgNBLzLvQO/EGBmh1THPhSxBLGTtUEArL0AHLOR0qKXzBhP2SjgDDUl1Vw=
X-Received: by 2002:a2e:7a11:: with SMTP id v17mr1156617ljc.403.1615364481490;
 Wed, 10 Mar 2021 00:21:21 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <eda68a4e-f4f5-88c9-e748-1f1831f0266a@namei.org>
 <CAHC9VhRJ-CHMag-dmxDVBp0efQbj7mgGdhs2AjfWFP_kDCGTfw@mail.gmail.com>
 <CABXk95AXH=KHtQFYw6p76BLC-OEBBbxZnL9hA8tiBqdN8Dj6Pg@mail.gmail.com> <CAHC9VhQzNN=_iq_9xLs6k92__bY1WL+8oFqh7kHTY5iRc7xK7Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQzNN=_iq_9xLs6k92__bY1WL+8oFqh7kHTY5iRc7xK7Q@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Wed, 10 Mar 2021 09:21:10 +0100
Message-ID: <CABXk95AodFLLH+ay7tF8fUhScBAMUPjbABr3CdK=M50hB0z4sA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 5, 2021 at 12:44 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Mar 4, 2021 at 5:04 AM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> > On Sat, Feb 20, 2021 at 3:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Feb 19, 2021 at 9:57 PM James Morris <jmorris@namei.org> wrote:
> > > > On Fri, 19 Feb 2021, Paul Moore wrote:
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > index c119736ca56ac..39d501261108d 100644
> > > > > --- a/drivers/android/binder.c
> > > > > +++ b/drivers/android/binder.c
> > > > > @@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
> > > > >               u32 secid;
> > > > >               size_t added_size;
> > > > >
> > > > > -             security_task_getsecid(proc->tsk, &secid);
> > > > > +             security_task_getsecid_subj(proc->tsk, &secid);
> > > > >               ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> > > > >               if (ret) {
> > > > >                       return_error = BR_FAILED_REPLY;
> > > >
> > > > Can someone from the Android project confirm this is correct for binder?
> >
> > This looks correct to me.
>
> Thanks for the verification.  Should I assume the SELinux specific
> binder changes looked okay too?
>
Yes, those also look good to me.
> https://lore.kernel.org/selinux/84053ed8-4778-f246-2177-cf5c1b9516a9@canonical.com/T/#m4ae49d4a5a62d600fa3f3b1a5bba2d6611b1051c
>
> --
> paul moore
> www.paul-moore.com
