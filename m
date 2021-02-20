Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F319CC433E0
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 14:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6B864EE0
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 14:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBTOpN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 20 Feb 2021 09:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhBTOpN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 20 Feb 2021 09:45:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CAC061574
        for <selinux@vger.kernel.org>; Sat, 20 Feb 2021 06:44:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c6so15958766ede.0
        for <selinux@vger.kernel.org>; Sat, 20 Feb 2021 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcH1Au1axr2FL2n0WJkJ/xnkEcygLgIq8xrE+zFFwww=;
        b=w7X4mpyrT9sF+2GccS55jwZtx7nlagHGAtA8eFYKBiJWKTWRmHenRWrZUzTdyF09Ix
         E7VaO1x48yPxVOCemGgUjhPNd2BhUdjP3MWZ95NeiSkxdiV0oj6BXcBCf+ZDHMudr7Ro
         MJyxpI55FyekOXQWX7qPw3uadMmBL8nxWM2xxmplHY1PqY8210EQE1WICnuPPTIpQg5i
         hwLkXA9M8K7owDYz77/CT2QX3zXp04fb6OD1BW6lCqM6ArRIQ7lEI2fVC9qV0IBysLP7
         u5X34uilU6eiOWwpt71DUrh4p3BRhXWBiIpzEh6sZ18I5zxRX4kQQ6qvaPaFsiExWP89
         LFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcH1Au1axr2FL2n0WJkJ/xnkEcygLgIq8xrE+zFFwww=;
        b=adCzssT5u+HgCCDWFS5ZSDDaSdhBkaCi0yqSy/0zoxmNujMYklfX4QCYnjOoJCKQrz
         5MNIb3B/L+FccjmsnytnmQ7MyTD/DzQdN/xZ2XtMcg0CIsLuBs/wQp7b9GZxFQNhymre
         PkoFU3tSvGsmywBbfM+q3U2LgCfTnDbBFLutaAgRvU3Wfuq36qfn0Cznt+wza/KzdmDR
         NK+uX883FzlgbZK2uyEF+63UzajbPX89dHK3TYLjUfy5T8sfeBSw9nxJXc57rJMK7uhq
         zLDDtliT51rcojZO/P5l/o0Dkmg88GmUkdqRp6mBcayDi3wBorlbcpi1965frOvMSvOy
         HYQw==
X-Gm-Message-State: AOAM532H6Uy1fpZCrgrKjrtQbmfCu82FMUMyICMZEF1bJyObejPxL6qV
        oWhECFr2SUovCGqctfAROcSSdNSctfICBzTe0l1e
X-Google-Smtp-Source: ABdhPJw4uzG6aOVrE1Bv5LOsRcaI3+fRj1Lk88hkXx94Q7+sJvBX8lqme6hlap+E/TVRsyXRt2DfqPOJFuxo1NhawLY=
X-Received: by 2002:a05:6402:4391:: with SMTP id o17mr14334079edc.196.1613832270244;
 Sat, 20 Feb 2021 06:44:30 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl> <eda68a4e-f4f5-88c9-e748-1f1831f0266a@namei.org>
In-Reply-To: <eda68a4e-f4f5-88c9-e748-1f1831f0266a@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 Feb 2021 09:44:19 -0500
Message-ID: <CAHC9VhRJ-CHMag-dmxDVBp0efQbj7mgGdhs2AjfWFP_kDCGTfw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 19, 2021 at 9:57 PM James Morris <jmorris@namei.org> wrote:
> On Fri, 19 Feb 2021, Paul Moore wrote:
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index c119736ca56ac..39d501261108d 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
> >               u32 secid;
> >               size_t added_size;
> >
> > -             security_task_getsecid(proc->tsk, &secid);
> > +             security_task_getsecid_subj(proc->tsk, &secid);
> >               ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> >               if (ret) {
> >                       return_error = BR_FAILED_REPLY;
>
> Can someone from the Android project confirm this is correct for binder?

Yes, please take a look Android folks.  As I mentioned previously,
review of the binder changes is one area where I think some extra
review is needed; I'm just not confident enough in my understanding of
binder.

-- 
paul moore
www.paul-moore.com
