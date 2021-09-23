Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D7C433F5
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1F860E9B
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 15:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbhIWPyO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbhIWPyN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Sep 2021 11:54:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879CBC061764
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 08:43:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u27so24697870edi.9
        for <selinux@vger.kernel.org>; Thu, 23 Sep 2021 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCqhKC48Ib46nZOgyDtYvMpK1Oh3xFWx5ZwtZeirTi4=;
        b=DXcsVudKdVqjRNW+msi7GFg4ORsGEDDKrRqhXgtJuErK5Ilgrm9sbmop5lo89WqLW8
         7Ww7N3T7H2Il4BA9fMcyFhNevAc2sxO6Ntc1FQcqsmld7If6M1BwUK8Vah8z7i6e7bs5
         bQrV5WEeouOpgHi96i3/PFqes/VhcqyULcMiof0sOUfKCVBAIjww7Ygy1xpxB4Z37fuP
         S/23MCOVKN5ZVWU8u8Qt/bOM+C7fd5qMknizwVpLWfiDhznd5Hh5U1p4m0XtMApxxvSj
         f15H3QfCaH9OIRktUMurfDwXjgwMl2yZuzpwoeTTR0PZ/MmKByMQm3OOIIaNBbyUC8i9
         8tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCqhKC48Ib46nZOgyDtYvMpK1Oh3xFWx5ZwtZeirTi4=;
        b=flBYRNHGrE5g3/UL77nfv7KPiSqM5Yfekw4kz+Rern8//PQL+RxtGgwpmW/ycGWrPK
         OikeRaVbQItXNjLkXCOFHkEUx3EHjvT7bpfyJiUM/iDlc+2n1uLg4QTLDHLsnSMjx92i
         7NgWDs99h9X7minrV8TPTM/uQcQls/DA19r07U+wNzauI4WDgmzEs1GB7c0kUwbmfmFu
         VPOFvbyyEbQSL6wJ5AmP5sqpB2ppg0/GgzVk6x3gpOSsn/vy7boOx90lSd8xZjAiBH6I
         4+oxRvipVHhp2k3HwJKddTzgv0Hx9SzOyh93BwclUT2xhXI4CiSpeYZekKHUCP1SIMtf
         mhew==
X-Gm-Message-State: AOAM532PYg6YodyIkxj6Ks9lWMqdHzeBnsAYaRW7E3GWYXMqMpkv6Fsk
        9ScuW0NwkwFmDZGJyNBCYo5F/TDUCUEaQl6o4z8p
X-Google-Smtp-Source: ABdhPJy83COw5p8Q5Ilg+btpwgWRQxkNonsH+wQ0Nbm+1kO8xf/vOFZ5SX3YI3NhjjmBoolF6ftnlL0sTIDhmYfTnvc=
X-Received: by 2002:a05:6402:3587:: with SMTP id y7mr6222941edc.362.1632411821608;
 Thu, 23 Sep 2021 08:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
 <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
 <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
 <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com> <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com>
In-Reply-To: <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Sep 2021 11:43:30 -0400
Message-ID: <CAHC9VhTtz_aNY6MOCM6ypbz+SHvS30hx42PWjXJhG1Z=t5jpBw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 22, 2021 at 7:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Sep 22, 2021 at 2:40 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > The basic idea, or problem from a LSM point of view, is that in some
> > cases you have a user task which is doing the lockdown access check
> > and in others you have the kernel itself
>
> I don't understand. In that case, it would be a boolean for "kernel vs user".
>
> But that's not what it is. It literally seems to care about _which_
> user, and looks at cred_sid().

Well, yes, it does look at the credential if it is passed; I guess I
wrongly assumed that was understood.  If it was just a simple
user/kernel decision then yes, it would be a boolean (or similar).

> This is what makes no sense to me. If it's about lockdown,. then the
> user is immaterial. Either it's locked down, or it's not.

If all you have is the lockdown LSM, then yes, lockdown doesn't take
into account the context of the request, it is simply a test of the
lockdown threshold: only disclosures on the proper side of the
lockdown value are allowed.

However, we have the LSM framework because there is never one way to
solve a problem, and the LSM hooks have always changed to support
these different approaches to access control.  While the lockdown LSM
takes a context-free approach to enforcing the lockdown setting, the
SELinux LSM takes a different enforcement approach which not only
better integrates with the SELinux policy, but it offers new
functionality beyond the lockdown LSM:

* Access based on the integrity and confidentiality reasons can be
specified independently with SELinux.

* Provide the ability to define the lockdown level within the context
of individual security domains.

It's also worth noting that with LSM stacking and the combination of
the lockdown and SELinux LSMs, the SELinux lockdown controls would not
grant any additional disclosures beyond what the lockdown LSM would
allow, the SELinux controls would only further restrict the disclosure
of specific security domains as specified in the SELinux policy.

--
paul moore
www.paul-moore.com
