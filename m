Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29DFC433EF
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 21:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C116F611CA
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 21:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbhIVVlo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbhIVVln (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Sep 2021 17:41:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C62C061756
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 14:40:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c21so15188525edj.0
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yUAunh6/B1SSbZrz9wmLc4dr4D+i+n+StWnT5gfwxI=;
        b=8AMS1OWfH+m8OlWLakX39s9CFCl10Wb1+IQBBz1G9wBBbUxcQTDmbczC0bJ7SlHarh
         +n8UXbfSyXblRygBYIp/CcSdPPol63rkMONHJCSNkEpnSvN0Cu6oJ5E/pfbKoybDOJkB
         XzR4PfS/1H0KsVW7mn8xQ+aYfbVJW4RvXIA3AyE4ghg8Bl2CFkyVpTv3K+Aqrh/b4qvL
         Au15lRofpVsQAWeASOv8XxyuW4fTOfqw/PvXmR2n8YoWsNOnfk0i6Sg4Wuw0UDlT1WEI
         j1LABZbQhoy04as9QqXfnX6c0v6o6qwGlgAtQGSu3tvPtZE7P4qWv+VHh7Ei873MmqTq
         317A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yUAunh6/B1SSbZrz9wmLc4dr4D+i+n+StWnT5gfwxI=;
        b=jYw0VPM0pJGshxP7bXXgOePl2UK/9a+zfcCbSz5Zs5EGctYGeZNC7almZd/wgt2DL2
         F8EDwdvzueRH6mD2/XxKkauEpW1M9Iym6XhfIm3gx0KfKRJ7OlFTsohyZ0/dEsmw3CJ3
         rLF1lkGETFSwLPqMTW+XA81yGA6Lu+EnoHbmTNtyAQuJIttkUZH/B2/YOCjoga4AVQwh
         wt6LRNvTaUHw1K6STLr/Ial6qVQEDWgyGX4dGE62g/bPm4fvCL18+ljH/wMLcxNdl+1I
         8oPimwXJQmwFi72IJY2miM+JfpdGqw/GLhLiBnB/x0FtmVngCifFQe68bSzTOrmHPKc0
         939w==
X-Gm-Message-State: AOAM530TqjL9rIQBkCPla1ch8ulf6WgNlcbwCsfu+FdlBhcC1efWPqIJ
        iIBSLFzZazfflev3xBKmsbYl0ST+o4cz7wmYrkmwJIvz+Q==
X-Google-Smtp-Source: ABdhPJw9Jd3adL5gvFPfg8v5tsZxNf8e5DGyBzypEea1X9T7NzGxvH9h8cT+f4Q44+P9M1hCL5QNgsXcobRxjmKV284=
X-Received: by 2002:a50:cf48:: with SMTP id d8mr1708015edk.293.1632346811617;
 Wed, 22 Sep 2021 14:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
 <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com> <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
In-Reply-To: <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Sep 2021 17:40:00 -0400
Message-ID: <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 22, 2021 at 5:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 22, 2021 at 1:55 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Make the regular security_locked_down() function do that, and add a
> >
> >     if (WARN_ON_ONCE(!in_task()))
> >         return -EPERM;
> >
> > so that any bad cases get flagged and refuse to continue.
>
> Actually, no, I take that back.
>
> It's not the "!in_task()" case that is the problem. That's just the symptom.
>
> The real problem is that we clearly have some lock-down rule that
> seems to care about credentials and who it is that does the lockdown
> query. That seems to be the real issue here. Doing lockdown checks
> from interrupts should be fine.

The basic idea, or problem from a LSM point of view, is that in some
cases you have a user task which is doing the lockdown access check
and in others you have the kernel itself; the creds parameter to
security_locked_down() hook was intended to be used to indicate if it
was a user task (param == current_cred()) or the kernel (param ==
NULL).  There was a discussion about using two different hooks/funcs,
e.g. security_locked_down() and security_locked_down_kern(), instead
of the creds parameter, but there were more votes for the param
variant.

As I type this I'm trying to muster something other than indifference
towards this patch, but the reality is I just want to be done with it.
If you'll merge a revision of this patch that does away with the cred
parameter and goes with the two hooks I'm not going to argue against
it.

During the review of the latest draft of this patch I half-jokingly
said it was cursed, perhaps it's time to honestly consider it cursed.

-- 
paul moore
www.paul-moore.com
