Return-Path: <SRS0=GjD/=DB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB1CC4346E
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 23:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E1622208
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 23:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js4r9KRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIXXnF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Sep 2020 19:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIXXnF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Sep 2020 19:43:05 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F89C0613CE
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2020 16:43:04 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t13so645104ile.9
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2020 16:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9pyDTD+facH7Jp49oO3o3Y31S3usxM+4ryGZ/T++JY=;
        b=Js4r9KRoGs4EKAWAvnLTYNppzIPnoJA66dgkSa7UlI6W8V5Z92/9XBHlDhzHrJW6RA
         APUwezEem6m7TIBX4F3/XEoXfvUDZRf+X0A0JM6rvIZu0doeh9S+bCySz+HI5DKtK5t/
         h6OijXsdBHDKQ2GlbVbz2hgvL6EDiFG9x9Ss5uSdnQZnu+nbhhFctLu48H7fm5CDKhe6
         YlrW7DxMu8a/gzlNBqiQhz7rBfBGk142vzfDxqzGNQuCRH+XNWWz1Ax4SY1mzUjkLQP2
         aEFKCsQ6jT1qcvAwumcHIxDt1AlYL3IuiSV9gR9FOVpJd0Ol+eN0rdmfmLhS7awOS7Cm
         zPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9pyDTD+facH7Jp49oO3o3Y31S3usxM+4ryGZ/T++JY=;
        b=aowfsAFgKtAXl7nnjOZTgu+Z+v96TcQy4RBH13QxF/9cIKOf8c4r08dJcDKTE/gtnl
         MrR6ylNAyXTaYftoE4Sj7N9NoXEepXy4s4+vu6KHmUjDzzFHiQlbQGzQuMc0k5TZrfQi
         z5kFp/qnOfiZq7q0r9fT0x0PiXhrgO0KYY4HxtRTNevgEGKh6/R4pjtLHNhL3TEqe+tB
         SU8taloaS9opzhFyphhkC8G4N3PNQNvLoCSSJzG5YoQMQxR2DMXqdRpddYr8ppCenTLg
         cF+pilPtXabV+WxNNNRHIznTOeVOeeGGlkIoYaSaUPbtasua2zlMBCkO86gJLiQKDmVt
         r9WA==
X-Gm-Message-State: AOAM533tiLSFxMu8tsi3hY8YXywiJ5G/vvbV862NO2e7KcxAW9VIAmeD
        kyfONKurucfvxCVHqh1UOetispi7QhG1JCa5xUj5WtX3
X-Google-Smtp-Source: ABdhPJyhvCDIBRKTMvPE/w4vlTjmMPjzGfnNWEhzrrAGrMMYPWDo5YwjngzG6086FbLlReMirdp7GJEScoiB6sHyQEs=
X-Received: by 2002:a92:6f07:: with SMTP id k7mr912907ilc.57.1600990983977;
 Thu, 24 Sep 2020 16:43:03 -0700 (PDT)
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
 <CAFqZXNuPCwvf2BNYrxxL-DqcwLQBCS9b78iQBfKDsWXOy8pvyg@mail.gmail.com>
 <CAEjxPJ7t4bmmom=ORduFqG5JYkbk+JW1dB4XxLyTULu709=b4A@mail.gmail.com> <CAHC9VhR4RBT6ZRxbAH13NWTZ0p7UPGiWSZuB_3trVd4qPoVCAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR4RBT6ZRxbAH13NWTZ0p7UPGiWSZuB_3trVd4qPoVCAQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 24 Sep 2020 19:42:52 -0400
Message-ID: <CAEjxPJ43GGLcBkPL_YZOWQWrpiyiU_CHK6VupVkLNw__ruZ3cg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 23, 2020 at 2:33 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Sep 10, 2020 at 8:34 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > > Speaking of this, I noticed that Documentation/ABI/README says that
> > files under obsolete should say when to expect the interface to be
> > removed, and at least a couple of them do, e.g.
> > sysfs-class-net-batman-adv:This ABI is deprecated and will be removed
> > after 2021.
> >
> > Should we add similar lines to the two sysfs-selinux-* files, and if
> > so, what target date should we propose for each?
>
> Sorry, I overlooked the updates to this thread in my inbox until I saw
> the LWN article today and revisited this thread.
>
> The lack of a specific date in the disable sysctl was a deliberate
> omission on my part as when the commit was made it wasn't clear when
> Fedora would be ready to make the transition.  As we documented in the
> the sysfs-selinux-disable obsolescence notice:
>
>   "Fedora is in the process of removing the selinuxfs "disable"
>    node and once that is complete we will start the slow process
>    of removing this code from the kernel."
>
> As far as the checkreqprot notice is concerned, it probably would be a
> good idea to outline a process for its eventual removal.  It isn't
> quite the same as the runtime disable issue since the distro work
> should all be done at this point, it's just a matter of finally
> blocking any "1" writes.  The deprecation made its first appearance in
> v5.7, which was released in June 2020, and a year seems like a
> reasonable amount of time for this so perhaps we target summer 2021?

Sounds good to me.
