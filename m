Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B1CC433E6
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 10:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E7064F27
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 10:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhCDKFT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 05:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhCDKFA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 05:05:00 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D3C06175F
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 02:04:20 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 18so33639690lff.6
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 02:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HmF/e/2OcwQXp/j0kIXsyRnmJkQXEhil+DWEn4X3ys=;
        b=fgX9tc69q4ApDzuFlaS1nZ/mWvC1YeR2oyfazbXk38okVU+DKMXenTAq9+XSJMCbtd
         T86l5CFPMAspe7QJ60oowGkR4qas9VWi4ON1fkz6ss2K9n/idVsP1HWwGKozD/0uBw9l
         280BfFQqgVF5t2wki94vcJZDZT88PeX5qKOmB/we3LPKSyqssZc2hCEL0A6+IAewjUwa
         mU/J+MEUNN1EnFjyZ2YMQdd7J86vKfyffGTTPgPAPJ/kF0gSaXjyMcZ5AuZrPXnEY3TY
         lIOZoaxRZKNT58ZoThRBO38zoX2aHK1LHFq2Vvc0AhEgHPmNgdjQW9hzhHBtizx1vZz0
         G45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HmF/e/2OcwQXp/j0kIXsyRnmJkQXEhil+DWEn4X3ys=;
        b=W/W6imE7xWfJiRRhTmhHx+BgDI8FmQkgWFUpV8dbId4f44KMGZRkvus0V5VUQTgdmJ
         AiGPmv5vAZ82JVTuIolURoeZveakrTOGY1uWVvvjjVZ+gzTkw90UAGMYiE9rE+1dbLxW
         Ls5Cuwag8N2l4/qBXU6eWylCZvOUY8webxDLM4haPr9p3gLz9zL6xwcRnf7IG9KdkGqo
         QIzLndhGCJ8SFDmP/4abhQWnQLrz6mfOQT4xE5dH6KrbVFKuseJzcgvmU+PPbrQfBxuC
         W70RsAeBqU/DigLlyU5BY/23+YrECnCB02JCZmcB4SrUS7MvFMo7kSrh8wfD1pejS4UL
         vFSw==
X-Gm-Message-State: AOAM532bIWhrYjWewCFVmz3Lv++iDJ8X6l51feGJ8tiCA9TtYlRvTVEY
        Mmym7sJlrZKzTgY5J7k3ClRBcLRm/y+M5GtvKbOqxi4eSqUX6g==
X-Google-Smtp-Source: ABdhPJyl1u4pWz3yNDHUKgDfDvH1MVqlmeYrM203Ucy1U0m2qSyuIg1rqpKYE0SyAb+kXOd4HvFOAWDMUs8erTwzhUg=
X-Received: by 2002:ac2:48b1:: with SMTP id u17mr1930986lfg.627.1614852258548;
 Thu, 04 Mar 2021 02:04:18 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <eda68a4e-f4f5-88c9-e748-1f1831f0266a@namei.org>
 <CAHC9VhRJ-CHMag-dmxDVBp0efQbj7mgGdhs2AjfWFP_kDCGTfw@mail.gmail.com>
In-Reply-To: <CAHC9VhRJ-CHMag-dmxDVBp0efQbj7mgGdhs2AjfWFP_kDCGTfw@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Thu, 4 Mar 2021 11:04:07 +0100
Message-ID: <CABXk95AXH=KHtQFYw6p76BLC-OEBBbxZnL9hA8tiBqdN8Dj6Pg@mail.gmail.com>
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

On Sat, Feb 20, 2021 at 3:45 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Feb 19, 2021 at 9:57 PM James Morris <jmorris@namei.org> wrote:
> > On Fri, 19 Feb 2021, Paul Moore wrote:
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index c119736ca56ac..39d501261108d 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
> > >               u32 secid;
> > >               size_t added_size;
> > >
> > > -             security_task_getsecid(proc->tsk, &secid);
> > > +             security_task_getsecid_subj(proc->tsk, &secid);
> > >               ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> > >               if (ret) {
> > >                       return_error = BR_FAILED_REPLY;
> >
> > Can someone from the Android project confirm this is correct for binder?

This looks correct to me.
>
> Yes, please take a look Android folks.  As I mentioned previously,
> review of the binder changes is one area where I think some extra
> review is needed; I'm just not confident enough in my understanding of
> binder.
>
> --
> paul moore
> www.paul-moore.com
