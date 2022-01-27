Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47F6C433F5
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 17:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiA0R1w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244685AbiA0R1t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 12:27:49 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD598C061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 09:27:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jx6so7562165ejb.0
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 09:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlan4PzCiljACVL7fehL/4B02ykJFYUpcK0nKt4UZ5A=;
        b=4DQqFg3FDfh6r7JA03LvNbXcx/W8QbObXSb84zWYTDDmpWxCE+ejuvTaUme/lGAov9
         q2u9RXr6y7rQN8Flk/nR6ht0sRWWUS7ZOwtg+QheHUdGUqM1AMsZ4wkYLpZKRIG3cNb/
         LAT+UB3B/S5DlClgtvrRsoZ5fKM6XTS3C4b7OCgm3+Ge4Uy26nKoBgDzb4llfgR3Af43
         JuNFUeEGMn75zf/wOr8jmNCsRFGSvloxYqeDdsOwOWehZ/6/c5Xdo/WgdbzBKGHtDQ93
         P+dAKFEOhNDgt4+xvfRJG5HDJNqOwtVfhhTePD51YJ51LbYJpHOEK9Rfar7NGDk8chTm
         YqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlan4PzCiljACVL7fehL/4B02ykJFYUpcK0nKt4UZ5A=;
        b=8C9hyCToNwC4tu+noYHLKqheMTi+Zg+WeWdh6AiDwLA+pvS9Ky3BbUri+r7N9SvGVO
         DBijtQayR0gDPsYEnlIiIlUVdqJQOOj35ccHWr7HomSVq7fCa9x1+Bb0U2OS+mSsiLDs
         sT4A+XO6NHBvAtiMLiUHGqC8cV0VGppwKZaUI4ntge21EoBQbwvNLLtAntarnvj6gbww
         bbB4VO2kVPG19ihyzQJmr6NKUJaC9EGSvgsuMgZYGMe9pVR4UInB2pRuh4G85mFyFJ5T
         wmi1jMRxbqfTlS6cevpqgTpiBFr/C7FcaxfBcWCmlDVHY7Zxl572kvS0zWoN6Mu49tjh
         fX4w==
X-Gm-Message-State: AOAM533IFK4gV3YgHwGmN1Ma1yaIl5WPJZs3SyKAA/5EA0jK6aXDUeL2
        Gf3U4SW1h/t4p14N3WfmGR83IaLIAF+2ufTWmDTZlgFdHA==
X-Google-Smtp-Source: ABdhPJzR+Kds1+tZtWtPbNAxjAiTzmQWyzvmSuEvKnKRRvDOotsz1kA7IYbFKlCcgmU2/F3x6QXK5Ok2TcIAooJgVA0=
X-Received: by 2002:a17:907:7f29:: with SMTP id qf41mr3769224ejc.12.1643304467211;
 Thu, 27 Jan 2022 09:27:47 -0800 (PST)
MIME-Version: 1.0
References: <164329905457.31174.9220154812163631144.stgit@olly> <CAFqZXNsKDLyz7E20uc7=1NaABcf8Gu8fhHExkttMN_5e59tY7g@mail.gmail.com>
In-Reply-To: <CAFqZXNsKDLyz7E20uc7=1NaABcf8Gu8fhHExkttMN_5e59tY7g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 12:27:37 -0500
Message-ID: <CAHC9VhRkeaicR-i1YvB--FMNLneO1ydf9dPmtHduOkD376GdOw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a type cast problem in cred_init_security()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 12:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jan 27, 2022 at 4:57 PM Paul Moore <paul@paul-moore.com> wrote:
> > In the process of removing an explicit type cast to preserve a cred
> > const qualifier in cred_init_security() we ran into a problem where
> > the task_struct::real_cred field is defined with the "__rcu"
> > attribute but the selinux_cred() function parameter is not, leading
> > to a sparse warning:
> >
> >   security/selinux/hooks.c:216:36: sparse: sparse:
> >     incorrect type in argument 1 (different address spaces)
> >     @@     expected struct cred const *cred
> >     @@     got struct cred const [noderef] __rcu *real_cred
> >
> > As we don't want to add the "__rcu" attribute to the selinux_cred()
> > parameter, we're going to add an explicit cast back to
> > cred_init_security().
> >
> > Fixes: b084e189b01a ("selinux: simplify cred_init_security")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index eae7dbd62df1..c057896e7dcd 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -213,7 +213,7 @@ static void cred_init_security(void)
> >  {
> >         struct task_security_struct *tsec;
> >
> > -       tsec = selinux_cred(current->real_cred);
> > +       tsec = selinux_cred((__force const struct cred *)current->real_cred);
> >         tsec->osid = tsec->sid = SECINITSID_KERNEL;
> >  }
>
> How about using unrcu_pointer() instead of the cast? It seems to do
> effectively the same while looking less ugly :)

Ah ha!  I didn't know that function/macro existed :)

I'm stuck in meetings most of the rest of today but I'll get out a v2
as soon as I can.  Thanks.

-- 
paul-moore.com
