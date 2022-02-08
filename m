Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05512C433FE
	for <selinux@archiver.kernel.org>; Tue,  8 Feb 2022 16:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383305AbiBHQ0k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Feb 2022 11:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378190AbiBHQ0j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Feb 2022 11:26:39 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411DCC0611DA
        for <selinux@vger.kernel.org>; Tue,  8 Feb 2022 08:26:38 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d10so53882340eje.10
        for <selinux@vger.kernel.org>; Tue, 08 Feb 2022 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImkfyIyZ8i1PfiNj2l6cA/EKazGt96Tzn+D2+4cuRHI=;
        b=qKTUQ3TbpAxAgSJdmblcHcVywXNlWJR2haIkknzdbcYf1grhB5IKnWqf0T/YcfuFGr
         pgzJEMDsJjE4b1LwuIIzEUCQX+dzbV9LEVMvaoWAc421xUpD7g4Xx3rotzFCh5eOMYhs
         ApguJo6vY8r+4mctC7Lio9pXb2m8+dgacp4T9+AG91FfcEf6ZiDLqSbQR6LNsoVNimkF
         AOHPBHwWJ5iutvPTtSXw5JQPIYUOjCprviRZ2vkqb4P8DRrosmuYcTW0FYweTBxvPKlB
         YeLTcBuBJWPK7gzTGZJEhfGtngzOWOusc9Om2mKU2LdIIPvCxf49HZg09OeiLa7U5wzl
         yo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImkfyIyZ8i1PfiNj2l6cA/EKazGt96Tzn+D2+4cuRHI=;
        b=5Wcp8//5iVrgFMLA1pR8lo9L2+4ge2JGbdRSGd8TTgK7Utqx6K0ddbmkLxc2ymnQ0b
         mPw1y47yygpsmxShq+1bmiO0mYo9OEHcq0Mw0U2tGiGuf205yUsCQYEHH/O+jqR7mRW4
         lIZB+VE9wkYUTgPtYHQB9njw+6SIHk9QlKHgHC8kaSBGCn2wOTDQdw2oVNnb5sdQUvQP
         YDVkaSQ0fdPVKS3D9dgkjwRDg9+GiEvUk/9DbQGV/DbqjOxz6LK0KBLdq5s0xF1ZE5oJ
         Z07gPLCjOwdr/jt9Pp/loZgxY3QGZS452Y9SrnyTArQplcLe2HioJzmBBlsEb0eNRA6t
         YiHg==
X-Gm-Message-State: AOAM533wz9gIcqVkTAoKK4gRZ56kVDhDiSP0pRNSV+MbS3clQKd5UPHJ
        uuREugsHue4BZLdvJHiTX9DDsME+uHPUt8Vfeuuq
X-Google-Smtp-Source: ABdhPJxoLHwQMTqmBv5zt3aqK9FGXZMmwBIzM8dswdyfvAurdgiUzkKUwLWfmFzPq/QBVXC+EH1VkzUN7uLCu7yOF1s=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr4458717ejc.12.1644337596750;
 Tue, 08 Feb 2022 08:26:36 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com> <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com> <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <CAFftDdpxmf4R9zPVGUUCFinST_2t8iW2SAJYG4e=3JeWtDowJw@mail.gmail.com>
 <7798e61c-eb22-7b19-0849-35e5bfccad8b@gmail.com> <CAFftDdpXm3VubMW_d51uEM+F_6eSGZerJbVQ=c8w7B-L1zT+3Q@mail.gmail.com>
 <99d51c4f-d067-2687-e7ae-d42a6d1326b2@gmail.com> <CAFftDdq6VfNfTpAHAYqLitvJcZ+4XuSVb0pMAXkwAPMd5tj-XQ@mail.gmail.com>
 <CAFftDdrhvNTSM0AV4F29xmFktJ0hZjsTTbGQ89dT2r78XaDm2Q@mail.gmail.com>
 <CAHC9VhRZY2n6ubzih6Qkh6SBcEWu_pT0A0_+w_HgzwehPZiD_g@mail.gmail.com> <CAFftDdoBjBeQqc2tvqnh-tO44JfR_adyKtnZuPC=okdwjOD20g@mail.gmail.com>
In-Reply-To: <CAFftDdoBjBeQqc2tvqnh-tO44JfR_adyKtnZuPC=okdwjOD20g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Feb 2022 11:26:25 -0500
Message-ID: <CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Demi Marie Obenour <demiobenour@gmail.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 8, 2022 at 9:05 AM William Roberts <bill.c.roberts@gmail.com> wrote:
> On Mon, Feb 7, 2022 at 6:02 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Feb 7, 2022 at 4:51 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> > > On Mon, Feb 7, 2022 at 3:42 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> > > >
> > > > + NNK and Dan
> > > - nnk and Dan.
> > > + Jeff
> > > Let me try again, looks like Nick left, not sure about Dan.
> > > Jeff, can you look this over?
> >
> > FWIW, I'm still not convinced merging this kernel patch is something
> > we want to do, so please don't assume that it's a done deal on the
> > kernel side.
>
> I agree and I don't think we can hit the merge button until it gets buy-in from
> in-use policy holders.

One thing I should have mentioned yesterday, my current thinking is
that if we do make the kernel change it needs to be wrapped with a
policy capability just as we do with other kernel changes which have a
potential impact on policy.

-- 
paul-moore.com
