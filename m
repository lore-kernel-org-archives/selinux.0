Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8114C38145
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 23:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIGXFB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiIGXE6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 19:04:58 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0EA5F11B
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 16:04:57 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so11257197otq.5
        for <selinux@vger.kernel.org>; Wed, 07 Sep 2022 16:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rzpqvzAG19vj81N/vafFARz4ok6aBt1qMHDPgDSBNCQ=;
        b=gEC+ple3CgCtrQCFmqwANIT74Fxy7OzdthG9yMZ0q2QcNkU7P2sRC9xcpSt+a6voES
         unRDnrkWv4aW7dUUp+5tjWpc2uvmjyaJfXIsWBi+X//UDIIKuO7uOidDCds+4a76oAyh
         GUIKAzS3j7Rogku06GgdntdH76ThYCeFDcFQVQjk02kRZvLfXVJo41U2ilqXmji588Iv
         up4uNFjQERlvqfi7XNpSj5oHMJTmFDq+B5+NPOajSSPskx0s6L7Q2OkoTWsZVrTP2esW
         fs67dHd+9hODCqlA1vdDZshLe0lLUWxYKBNMV4OYOxxAShBNzjLOoj1rCsTpha5PpD+z
         P55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rzpqvzAG19vj81N/vafFARz4ok6aBt1qMHDPgDSBNCQ=;
        b=busU/VvMt7JcngoftZ6Wiinyb+gzCjXfQXKcUGWcQ4/GxuAV3VaMGYkLEKaXg2V50u
         4TjGWRGu08m9JEQ7nDDNJULYpG4YHDl7fAwpVGK4nxxEIw8e1SXqmg+KVzurBJzG3rlh
         iM6zKgSpL4r8ct3vwgDOI0GGJl2g7UmxF16FjB9fGGL+IHpUiYu0hC9Pzhv0l5MplzHb
         miMqgfVCK3y1ymgpZZw3USO5jRJdSNTTw7lRApTB5PCrPOhqz2cK1P/n0/iBIZKrQIu6
         NcGOasg/1vlWwJkp3wB7iPyFm9DwaGpEnA0EwpTH/VN0RZJdRZnaymni48xt4HwYb/dK
         Uxzg==
X-Gm-Message-State: ACgBeo0Ce6AhlUhXbFFtOsZzyahIgdO9biPf/8nsb7jOANVA+ccLwF30
        xEPLexUUhN808usnUB7JMYC2Fbqw+GB50zz8NFET
X-Google-Smtp-Source: AA6agR4FEN7nFNqcGZrZZyFgg7YF0piny8iK6gB/IJoQi1cyM4cU84+ow2Hnmk1c6v04JePLWJaOPDnLZc4Lwu0QBYg=
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id
 r30-20020a056830449e00b00638c72b68ffmr2417216otv.26.1662591896530; Wed, 07
 Sep 2022 16:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <9f79faa7-0d6a-c023-4561-15a261d4c60d@schaufler-ca.com> <CAHC9VhQBHNmYf3vMSFrcw_=a=LaqoxVLqFirbMfSZeHqL5fxWQ@mail.gmail.com>
 <9c89b121-8dbd-dfa8-e427-8b90d1333e36@schaufler-ca.com>
In-Reply-To: <9c89b121-8dbd-dfa8-e427-8b90d1333e36@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 19:04:45 -0400
Message-ID: <CAHC9VhTLe4F3gXeNHZL8vCgEsz+m5-vbkihFcpzbB+F0M1TNbw@mail.gmail.com>
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

On Wed, Sep 7, 2022 at 1:08 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/7/2022 8:13 AM, Paul Moore wrote:
> > On Tue, Sep 6, 2022 at 8:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 9/6/2022 4:24 PM, Paul Moore wrote:
> >>> On Fri, Sep 2, 2022 at 7:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> On 9/2/2022 2:30 PM, Paul Moore wrote:
> >>>>> On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>>>> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>>>> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
> >>>>>>> patch set in the LSM next branch for 6.1. The audit changes have polished
> >>>>>>> up nicely and I believe that all comments on the integrity code have been
> >>>>>>> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
> >>>>>>> There are serious binder changes, but I think they address issues beyond
> >>>>>>> the needs of stacking. Changes outside these areas are pretty well limited
> >>>>>>> to LSM interface improvements.
> >>>>>> The LSM stacking patches are near the very top of my list to review
> >>>>>> once the merge window clears, the io_uring fixes are in (bug fix), and
> >>>>>> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
> >>>>>> and SCTP stuff can be finished up in the next week or two.
> >>>>>>
> >>>>>> Since I'm the designated first stuckee now for the stacking stuff I
> >>>>>> want to go back through everything with fresh eyes, which probably
> >>>>>> isn't a bad idea since it has been a while since I looked at the full
> >>>>>> patchset from bottom to top.  I can tell you that I've never been
> >>>>>> really excited about the /proc changes, and believe it or not I've
> >>>>>> been thinking about those a fair amount since James asked me to start
> >>>>>> maintaining the LSM.  I don't want to get into any detail until I've
> >>>>>> had a chance to look over everything again, but just a heads-up that
> >>>>>> I'm not too excited about those bits.
> >>>>> As I mentioned above, I don't really like the stuff that one has to do
> >>>>> to support LSM stacking on the existing /proc interfaces, the
> >>>>> "label1\0label2\labelN\0" hack is probably the best (only?) option we
> >>>>> have for retrofitting multiple LSMs into those interfaces and I think
> >>>>> we can all agree it's not a great API.  Considering that applications
> >>>>> that wish to become simultaneous multi-LSM aware are going to need
> >>>>> modification anyway, let's take a step back and see if we can do this
> >>>>> with a more sensible API.
> >>>> This is a compound problem. Some applications, including systemd and dbus,
> >>>> will require modification to completely support multiple concurrent LSMs
> >>>> in the long term. This will certainly be the case should someone be wild
> >>>> and crazy enough to use Smack and SELinux together. Even with the (Smack or
> >>>> SELinux) and AppArmor case the ps(1) command should be educated about the
> >>>> possibility of multiple "current" values. However, in a container world,
> >>>> where an Android container can run on an Ubuntu system, the presence of
> >>>> AppArmor on the base system is completely uninteresting to the SELinux
> >>>> aware applications in the container. This is a real use case.
> >>> If you are running AppArmor on the host system and SELinux in a
> >>> container you are likely going to have some *very* bizarre behavior as
> >>> the SELinux policy you load in the container will apply to the entire
> >>> system, including processes which started *before* the SELinux policy
> >>> was loaded.  While I understand the point you are trying to make, I
> >>> don't believe the example you chose is going to work without a lot of
> >>> other changes.
> >> I don't use it myself, but I know it's frighteningly popular.
> > All right, I'm going to call your bluff here - who are these people
> > running AppArmor on the host and SELinux in a container?  What policy
> > are they using, it's surely not an unmodified Fedora/RHEL or upstream
> > refpol policy?  Do they run in enforcing mode without massive
> > permissions granted to kernel_t (I'm guessing all of the host
> > applications would appear as kernel_t)?  How do you handle multiple
> > SELinux containers?
>
> Beats me. All that SELinux policy stuff is over my head. ;)
>
> Seriously, once they got the stacking patches applied they thanked
> me for the help and disappeared until they decided to update the
> kernel version and asked for help with the next round of patches.
> They told me what they wanted to do, which was to run Android in
> a container, but how they accomplished it was a set of details they
> didn't share. I assume that you are right that they had to do
> horrible things to either AppArmor or SELinux policy, or maybe both.
> I also assume they wanted this as an environment to develop Android
> applications, and may not have cared much about actual enforcement.
> But they are happy users.
>
> > I'm aware of *one* use case where SELinux is run in a container and
> > that required a number of careful constraints on the use case and a
> > good deal of hacking to enable.  I'm sure there are definitely people
> > that *want* this, especially in the context of Ubuntu, but I really
> > doubt this is in widespread use today.
>
> What I know is that there is a community out there using it. I think
> you're right that the way they're using it would be displeasing to
> most of us.

Based on other comments in this thread it doesn't appear that there is
anyone using it, or at least not a significant percentage of users.  I
get that sometimes we need to interpolate/extrapolate a bit to
understand what users are actually doing, especially with certain
security-focused users, but I think you extrapolated (or assumed) a
bit too much in this case.  Please be more clear when you are
speculating in the future, there may be folks reading these mailing
lists that don't have the background or understanding to tell
assumptions from actual truth.

-- 
paul-moore.com
