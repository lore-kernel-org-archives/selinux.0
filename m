Return-Path: <SRS0=s12v=DA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7238CC2D0A8
	for <selinux@archiver.kernel.org>; Wed, 23 Sep 2020 18:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EF8235F7
	for <selinux@archiver.kernel.org>; Wed, 23 Sep 2020 18:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JUAqeAq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWSc7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Sep 2020 14:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWSc7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Sep 2020 14:32:59 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50217C0613CE
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2020 11:32:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so1029089eja.2
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2020 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnbVYvB3iDR46XUPcZhQbxeleNDJGsFuPxF/DhKxP6o=;
        b=JUAqeAq974wGX8g/L3IRWcVHWsJQrEFHpLrtv/6jYM1RN9xvz1AtcYU2JbGGTl4QRa
         YOuhEo1vlmA9aEaytVXaNlQx1q3s0rJeEC/+LYiyQG0cHjMVJwdvGI/QHDpWDXeObDvV
         PRgD9NgJzRCfiCsSEU5KvA2E553cYCXTngHGwlPivROsiJYNOfFTS48+Vq+F5T0fPA2A
         LNqOFNozasPtMLJQtvl4gef5g5OUnM0/PlSpGyzMaZ9xjRuLeYG0WRZ5+aWweF+cq6Q7
         quwYAFAY5NS8hSCuLBuOkAuDe4YIuTSjH3QSUr4hwVSp/9foPsh4FugrJvVRBfcdohi/
         JCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnbVYvB3iDR46XUPcZhQbxeleNDJGsFuPxF/DhKxP6o=;
        b=iF1CHGTFQr0piOTbNW1UukWwFROw6OuM2nmymD4a9tNsA3N+EVBqsHEA0+4HB0Cn7N
         n895aIMn0sBcWswOFoZUE+nCMcPZmqPCoEVZ6m7e+ImJv2Vf/T8nUfBXIN28FbUn0jvv
         TSu1nF/N1RwaBsChaMppePsr0mxQOGH1S3eo0INjXi7N9/r0HniMZKCmScm1yLt+ImKw
         G5t6z1JdzE8NKCy2eJdc5DaIGtZdZj4tkSQSxqXMtYJ+ugDuWTmoNuxlzunW8dba6HwN
         Xghjspgo2BLOGQjLuQ4iIMwhPae/Bo18DWP4OoWnMX9z0WJy7ylQooY3HjVKBaYxSNSd
         lUVw==
X-Gm-Message-State: AOAM531OWEYfPyHUfyipCCyIPBquDcfg3F5fx2Le+ExamAi8zWX8V6XV
        yu5z401tFYV7TvONx3H7xPKgMZv/E9eZyjzE86aM
X-Google-Smtp-Source: ABdhPJxP2awQDMnmN0FmT9XQsB4r6f4R4IOBCje+BLkBf755rEuUnrpgv8RKyb+UGJxnBUdt9c+RodA0E5b9dOKNveA=
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr898246ejz.431.1600885977745;
 Wed, 23 Sep 2020 11:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
 <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
 <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
 <20200819171459.GA57975@localhost.localdomain> <CAEjxPJ54j6PD6oBMWj7wOVskJuUY=BLpMCkdmmqwrP1DGJ0VqA@mail.gmail.com>
 <CAFqZXNuPCwvf2BNYrxxL-DqcwLQBCS9b78iQBfKDsWXOy8pvyg@mail.gmail.com> <CAEjxPJ7t4bmmom=ORduFqG5JYkbk+JW1dB4XxLyTULu709=b4A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7t4bmmom=ORduFqG5JYkbk+JW1dB4XxLyTULu709=b4A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Sep 2020 14:32:46 -0400
Message-ID: <CAHC9VhR4RBT6ZRxbAH13NWTZ0p7UPGiWSZuB_3trVd4qPoVCAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 10, 2020 at 8:34 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 10, 2020 at 7:39 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Wed, Aug 19, 2020 at 9:07 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Aug 19, 2020 at 1:15 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > <snip>
> > > > So I've started to compose Fedora Change proposal
> > > >
> > > > https://fedoraproject.org/wiki/SELinux/Changes/Disable_CONFIG_SECURITY_SELINUX_DISABLE
> > > >
> > > > It's not complete yet, but I believe it contains basic information. I'd
> > > > appreciate if you can help me with text, phrases and references so that it would
> > > > be easy to sell it as security feature to Fedora community :)
> > >
> > > I'd simplify the Summary to be something like "Remove support for
> > > SELinux runtime disable so that the LSM hooks can be hardened via
> > > read-only-after-initialization protections.  Migrate users to using
> > > selinux=0 if they want to disable SELinux."
> >
> > FYI, the change proposal has now been announced to the Fedora devel community:
> > https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/YQIYMWKFQEWCILU7UZWXO3YFNS2PLDG4/
>
> Speaking of this, I noticed that Documentation/ABI/README says that
> files under obsolete should say when to expect the interface to be
> removed, and at least a couple of them do, e.g.
> sysfs-class-net-batman-adv:This ABI is deprecated and will be removed
> after 2021.
>
> Should we add similar lines to the two sysfs-selinux-* files, and if
> so, what target date should we propose for each?

Sorry, I overlooked the updates to this thread in my inbox until I saw
the LWN article today and revisited this thread.

The lack of a specific date in the disable sysctl was a deliberate
omission on my part as when the commit was made it wasn't clear when
Fedora would be ready to make the transition.  As we documented in the
the sysfs-selinux-disable obsolescence notice:

  "Fedora is in the process of removing the selinuxfs "disable"
   node and once that is complete we will start the slow process
   of removing this code from the kernel."

As far as the checkreqprot notice is concerned, it probably would be a
good idea to outline a process for its eventual removal.  It isn't
quite the same as the runtime disable issue since the distro work
should all be done at this point, it's just a matter of finally
blocking any "1" writes.  The deprecation made its first appearance in
v5.7, which was released in June 2020, and a year seems like a
reasonable amount of time for this so perhaps we target summer 2021?

-- 
paul moore
www.paul-moore.com
