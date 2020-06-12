Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C7FC433DF
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 19:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB5C2063A
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 19:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="G4RVPz7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLT2p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLT2p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 15:28:45 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC0C03E96F
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 12:28:44 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c35so7226660edf.5
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfSHu+2AwpTaHABFBzekfCatR3Mkl86+NAEoKQmw1sw=;
        b=G4RVPz7qBuQTF+cL3+x+zNsZjbMKLld34plWhFtEgtTvAvH3S8qWH/If8pZoy+4wrU
         O3KXb28D0OpE0wSZu4KIEj+hPCRD6iHTMv58tyqwAXrmfDwF9aiBY7Jwwq0tuSQCPVh/
         XKeqTk6FKoC1Ecl8dAWcPAULljLgSH/RdKU9Q2OivKJee8HDmw4dfvqginNkslQMXXlY
         TW4IngW1eZKU+G9CGQgRtB3KabQscHKr2CBrY42Z12+U4I/7eicUchb5NsFl+8fUx737
         3IH526O9hZmT3B7siAP4qbt3mFJToZRc39taLD0bpMtU6z0m21qQkk02HCPVKCzAqpOb
         kATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfSHu+2AwpTaHABFBzekfCatR3Mkl86+NAEoKQmw1sw=;
        b=d/GGe1HJwQstqxNwTZ2z8vVtB8XD7OPZ3pVT27BxSM38fUaKlvV72CzuTHU+gH2OLE
         xW1bYjiszcqJwQmh5tJwNdahalt187mE658D9iAsfl1cB9CnthI0MbTryXzamJ+dyP/s
         FueySv4ZISKtJixw0YHIrndhzoDfRzG/yuOSGqWMH7q9MvgJBQPifit4/BGZERZcdQVp
         XUxFJI0SAeOHMHx7h34qunHyzDzxhLs2MWbuq/JaCESFVpUqV8uRDnfqSLSkbM50L8Yb
         VnddLYeQ3L61YeiOmccRney3z/LMneBnwoLpozanNzBmcbJ5TELhd38kmvK8jLIVSFjH
         z9ZA==
X-Gm-Message-State: AOAM533Ewc4vvVG61ik/zhXvDxK3v/W0uENq851OuH5l11LPqeb1k5xU
        EP0Clo+lDHYGRvTG4tgR8KBj6rF2/ZW75076pdoy
X-Google-Smtp-Source: ABdhPJzWlykKSRqSwvvTk4sdeTZ0cE7rDPghq3kZb8v6ji+J9NEvqVKcLm8p87FA4v/fH1h1ueRI4z7RBf+5/lFSjCE=
X-Received: by 2002:aa7:da46:: with SMTP id w6mr13036953eds.31.1591990118705;
 Fri, 12 Jun 2020 12:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com> <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
In-Reply-To: <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Jun 2020 15:28:26 -0400
Message-ID: <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 9:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Good point about the installer. I have already started working on
> preparing Fedora for the runtime disable removal, but so far I'm only
> at the beginning. Updating anaconda to add selinux=0 to the kernel
> params instead of using /etc/selinux/config will be one of the main
> steps.

...

> I also prefer to rather go somewhere in this direction rather than
> introducing the delay. I was kinda OK with the delay at first, but as
> Stephen points out, it would punish users rather than distros, even
> though users are (normally) not the ones that make a conscious
> decision to use the runtime disable.

...

> Yes, I was under the impression that some changes in libselinux are
> needed before this works transparently, but apparently it already does
> the right thing now. In that case I'd say that it may be better to
> skip adding sleeps etc. and just remove the feature at some point. But
> please let's wait with that for a while longer so we can prepare
> Fedora for it first. It's hard to tell at this point how long that
> will take, but it could be several months.
>
> Then again, the sleep might be helpful to wake up potential non-Fedora
> users (if any) and in Fedora we can always apply a revert as a
> downstream patch until things are sorted. So if you guys really want
> it, I think we can deal with it.

I'm glad to hear Fedora is making changes to move away from the
runtime disable, please keep us updated about once a month so we know
where things are at with Fedora.

As I mentioned previously, I'm okay with postponing the delay so long
as Fedora is making progress - and according to Ondrej they are - so
I'm okay with holding off for now.

-- 
paul moore
www.paul-moore.com
