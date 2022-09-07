Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C4CC38145
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 15:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiIGPNg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiIGPNQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 11:13:16 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F38696CB
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 08:13:12 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-12803ac8113so3474577fac.8
        for <selinux@vger.kernel.org>; Wed, 07 Sep 2022 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JptBMo1jf61UZZjNNLad88RdOTNmTiMdPmyYsfIIHr8=;
        b=XQYvkY1G2PoQCOwPa71WvpMtv0x34HDNixdIylY5zKRRn7cVhmJFWVzXZOr4euhFni
         62Szmeadb+1BBF84JKBhwLt6xdGl/CPCDrNwzAZbG3UxA15tVaAHrrzL2hftOo3eUnPd
         Nkd0cxnMv0fWSDcWiVP3MHlDYRUDnqfwRMc7Sswi8ckXaQBMPi/KrbDjxkZyB0MSdEJR
         PTU/bgeUp6k0OydeMx+SftPkK9oUpSK1TEVJdM42HpBJSKR72OakJhJwHt4zLJTUnoKS
         sfTQm3wba8e+/f60Go19WiwT8aNBoYUoRVTIgNw8ZIbiNlluBkS9ni+wREoAKhByAuDY
         0AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JptBMo1jf61UZZjNNLad88RdOTNmTiMdPmyYsfIIHr8=;
        b=Sd/wDHpdVGNKRmNtC3aFr7wUUSOVvn0yVlASsyU5e/Q7UA/o6vjunj/s3q6tJABRRX
         XdiM+ANWDRyJeR2r3YeqZidMDU6k34+ba3LjvzDvNUzyRuIL8a7+oNpKn8wIKe3n1AcK
         /nYxWrLeDJZGhIp/3cOKlfOrgHXr0RF4EqF/jYYr8KW51ykLmhJV0EaB5B5DFAcjLVRF
         Nmv4LImJPmQwkTABk9nzMLGUIRaq6AbmZLVH9KP7kTdP1s94UbmALvKbwi9oBwFw25J+
         1WU1XvV2PMoTWxN+4+Vv6sJx0HHT9qEZuNNEGszQjIb9+q1O5e5uB9M0lMaeFMGUEpu9
         Cofw==
X-Gm-Message-State: ACgBeo3wdAD5B284msKLJOQUb2+3yv2Tf+WItGI/uHXcQGnnJyZ5eyco
        a16gIeIkFw14pIYWQ6w9iVSUoQE/g6pho/dJhn48
X-Google-Smtp-Source: AA6agR4eT4/rZcodHH7C/hmD//ntQMwoU2KuaNWOx4QmvyOJuNvGGx1/N0HitvJ2Q2evi4QjWn2yw0BW2YIWibPi19I=
X-Received: by 2002:a05:6871:796:b0:11e:b92e:731e with SMTP id
 o22-20020a056871079600b0011eb92e731emr15124549oap.41.1662563591403; Wed, 07
 Sep 2022 08:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <9f79faa7-0d6a-c023-4561-15a261d4c60d@schaufler-ca.com>
In-Reply-To: <9f79faa7-0d6a-c023-4561-15a261d4c60d@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 11:13:08 -0400
Message-ID: <CAHC9VhQBHNmYf3vMSFrcw_=a=LaqoxVLqFirbMfSZeHqL5fxWQ@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 6, 2022 at 8:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/6/2022 4:24 PM, Paul Moore wrote:
> > On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 9/2/2022 2:30 PM, Paul Moore wrote:
> >>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
> >>>>> patch set in the LSM next branch for 6.1. The audit changes have polished
> >>>>> up nicely and I believe that all comments on the integrity code have been
> >>>>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
> >>>>> There are serious binder changes, but I think they address issues beyond
> >>>>> the needs of stacking. Changes outside these areas are pretty well limited
> >>>>> to LSM interface improvements.
> >>>> The LSM stacking patches are near the very top of my list to review
> >>>> once the merge window clears, the io_uring fixes are in (bug fix), and
> >>>> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
> >>>> and SCTP stuff can be finished up in the next week or two.
> >>>>
> >>>> Since I'm the designated first stuckee now for the stacking stuff I
> >>>> want to go back through everything with fresh eyes, which probably
> >>>> isn't a bad idea since it has been a while since I looked at the full
> >>>> patchset from bottom to top.  I can tell you that I've never been
> >>>> really excited about the /proc changes, and believe it or not I've
> >>>> been thinking about those a fair amount since James asked me to start
> >>>> maintaining the LSM.  I don't want to get into any detail until I've
> >>>> had a chance to look over everything again, but just a heads-up that
> >>>> I'm not too excited about those bits.
> >>> As I mentioned above, I don't really like the stuff that one has to do
> >>> to support LSM stacking on the existing /proc interfaces, the
> >>> "label1\0label2\labelN\0" hack is probably the best (only?) option we
> >>> have for retrofitting multiple LSMs into those interfaces and I think
> >>> we can all agree it's not a great API.  Considering that applications
> >>> that wish to become simultaneous multi-LSM aware are going to need
> >>> modification anyway, let's take a step back and see if we can do this
> >>> with a more sensible API.
> >> This is a compound problem. Some applications, including systemd and dbus,
> >> will require modification to completely support multiple concurrent LSMs
> >> in the long term. This will certainly be the case should someone be wild
> >> and crazy enough to use Smack and SELinux together. Even with the (Smack or
> >> SELinux) and AppArmor case the ps(1) command should be educated about the
> >> possibility of multiple "current" values. However, in a container world,
> >> where an Android container can run on an Ubuntu system, the presence of
> >> AppArmor on the base system is completely uninteresting to the SELinux
> >> aware applications in the container. This is a real use case.
> > If you are running AppArmor on the host system and SELinux in a
> > container you are likely going to have some *very* bizarre behavior as
> > the SELinux policy you load in the container will apply to the entire
> > system, including processes which started *before* the SELinux policy
> > was loaded.  While I understand the point you are trying to make, I
> > don't believe the example you chose is going to work without a lot of
> > other changes.
>
> I don't use it myself, but I know it's frighteningly popular.

All right, I'm going to call your bluff here - who are these people
running AppArmor on the host and SELinux in a container?  What policy
are they using, it's surely not an unmodified Fedora/RHEL or upstream
refpol policy?  Do they run in enforcing mode without massive
permissions granted to kernel_t (I'm guessing all of the host
applications would appear as kernel_t)?  How do you handle multiple
SELinux containers?

I'm aware of *one* use case where SELinux is run in a container and
that required a number of careful constraints on the use case and a
good deal of hacking to enable.  I'm sure there are definitely people
that *want* this, especially in the context of Ubuntu, but I really
doubt this is in widespread use today.

> >>> I think it's time to think about a proper set of LSM syscalls.
> >> At the very least we need a liblsm that preforms a number of useful
> >> functions, like identifying what security modules are available,
> >> validating "contexts", fetching "contexts" from files and processes
> >> and that sort of thing. Whether it is built on syscalls or /proc and
> >> getxattr() is a matter of debate and taste.
> > Why is it a forgone conclusion that a library would be necessary for
> > basic operations?  If the kernel/userspace API is sane to begin with
> > we could probably either significantly reduce or eliminate the need
> > for additional libraries.
>
> I'm using my experience with the "hideous" context format
> ( "apparmor\0unconfined\0smack\0User\0" ) as a guide. Creating
> a "sane" API for returning multiple lsm/context pairs is going
> to be tricky. No one wants to require iterative calls to get a
> collection of values for example. I've spent the past few years
> trying to pound out APIs that are somewhat sane. I don't want to
> spend another few years repeating the process for kernel APIs.

See my earlier comment to John.  I care a lot about getting things
right, and very little about how long it takes.  I'm sympathetic about
the time and difficulty involved, but I see that as no reason to merge
a not-good design.

> >> The addition of multiple subject labels to audit would be the same regardless
> >> of /proc or syscall interfaces.
> >
> > Yes, that's why I didn't bring up audit as it doesn't weigh on this
> > decision.  If you really want to include audit for some reason, I'll
> > simply remind you that I pushed back hard on overloading the existing
> > subj/obj fields with a multiplexed label format, asking for individual
> > subj/obj fields for each LSM.
>
> Just pointing out that the stacking patches aren't that complicated.

Ha!  Let's just agree to disagree on that point :)

-- 
paul-moore.com
