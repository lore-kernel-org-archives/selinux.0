Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC61C282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0939E218EA
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 16:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mnE7oanY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfBAQJa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:09:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34758 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBAQJa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 11:09:30 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so6305838lje.1
        for <selinux@vger.kernel.org>; Fri, 01 Feb 2019 08:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wZ70Fqo9BPy7zMwqYpEnF2sd0lOIXDSoZODXxbXGfEA=;
        b=mnE7oanY0fDX6DSsBSu7I/TvKFa6IQZ3au/RzEd85nM+V1XjC1406hzR4keMQXamkA
         mSDoibowjPDa7PdDfmtGhKlD5Lu9LLogkS6upBejjfBYlLHxlwiWCAcNSTw6lXmN2RBj
         kzj8/VdJ394KZWzjYdm5WJg21wOoqqaWLqPqPzmHcrzZxd7ycJTxOTo4GBD0n0D7PyRC
         co1DGf8OMa1iKB8EgFC91i81dEQwkfhzFRDoo72CpmACPuFZKvvkJbU5FzbScu0rv/h6
         uVtUV5GG43JdtZmyM+cYZdtYvBp+NhZsWDNM+nc6jBP76AwvNSTNGU9CEIh1GaCUoP5T
         X/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wZ70Fqo9BPy7zMwqYpEnF2sd0lOIXDSoZODXxbXGfEA=;
        b=op3d6J79ZjnOFxthuN1gYDf9jGNZnR9W8uFgff9NC/cdkXkCCK8LBLXoorfspvUp6o
         i3ASCjF1tg2wmoQOx6c3K205umupULkvG+9MXkpTTTEP45wCBJbhCPfZP+9vgpF9ZE68
         RuocOKb9z46ojyRt99EF8YhRIF//palpAfQqRePhjuhdaTkUV8w7NtNvOoYdmOJ4T/UB
         mqrtTgAYnQRLA360n+cb6iMtMQXG9Y6npL7K0mkthd542Yf+gq3y605ptYBvYPfXvlaE
         qXv1YBp6Id5eMwyXXFzJmcQobx438RjmcmxZohRz+ETfPfl7WrmT/cAvbTTaDjU7+sCz
         0rcw==
X-Gm-Message-State: AJcUukfe49V5y3cvAYCqcRrvBC+BCIfPqoPWGXTLUVyTW/fzx6js6AQN
        XiQ3O1e9vHcXhdlGTtSb+m1LjB1x0Ok8pRWOiF55
X-Google-Smtp-Source: ALg8bN5M2vr7E8+nwQp4F4UpcA9r9vMRBoAbSeAKMtt+r1+bBYm21gP/Nudq0hilD+1918JUShD2mAQsedyIEVk98aY=
X-Received: by 2002:a2e:9c87:: with SMTP id x7-v6mr30333255lji.196.1549037368142;
 Fri, 01 Feb 2019 08:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20190127081023.21124-1-leon@kernel.org> <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com> <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com> <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com> <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
 <CAHC9VhRWHzrR84ueJHzmBgyQviL-36-ezvDb0u-xRfQmBsBO2g@mail.gmail.com>
 <3cf233f6-4ca7-1667-7d09-0d2b6879046d@mellanox.com> <CAHC9VhQWG7z0dV4=bULLGdU3SXjQH-da9vkyZo6a+Wy5Bw29_A@mail.gmail.com>
 <CAHC9VhQc-_iYUid1PYnRA8_cJG+Ji5zkoz80Pg++C-wY_GKrvw@mail.gmail.com> <3c92c876-8ef7-aff9-59ab-966ee95978e6@mellanox.com>
In-Reply-To: <3c92c876-8ef7-aff9-59ab-966ee95978e6@mellanox.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Feb 2019 11:09:17 -0500
Message-ID: <CAHC9VhQoEZY3s=SjQQe+OR8A9bPN_v8u5fHxmtd=iN==iYkH3Q@mail.gmail.com>
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM notifications
To:     Daniel Jurgens <danielj@mellanox.com>
Cc:     Don Dutile <ddutile@redhat.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 1, 2019 at 9:16 AM Daniel Jurgens <danielj@mellanox.com> wrote:
> On 2/1/2019 7:57 AM, Paul Moore wrote:
> > On Tue, Jan 29, 2019 at 4:13 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Tue, Jan 29, 2019 at 3:58 PM Daniel Jurgens <danielj@mellanox.com> =
wrote:
> >>> On 1/29/2019 2:51 PM, Paul Moore wrote:
> >>>> Okay, so let's attempt the change above where we just do the access
> >>>> check directly.  Although I'm a little concerned that without a
> >>>> reproducer we might not end up fixing the problem we're trying to fi=
x.
> >>>> Is anyone in touch with the person who originally reported the
> >>>> problem?  It would be great if we could get that person to verify th=
e
> >>>> change ...
> >>> I decided to go with maintaining a list in IB core. The notifier call=
 is done under rcu_read_lock vs spin_lock_irq for register/unregister, so w=
e shouldn't have any problems in that case. So only registering once basica=
lly achieves the same thing as taking it all out. I'm testing it now. I'll =
send it for internal review today assuming it checks out. Hopefully Leon ca=
n get it posted tomorrow, I know Don has some schedule pressure here.
> >> Okay sounds good.  We're still at -rc4 so as long as we can get
> >> something posted this week, or early next, I see no reason why it
> >> can't make the upcoming merge window.
> >>
> >> I'm guessing Don's schedule pressure is more a RH deadline, and not an
> >> upstream constraint.
> > I just wanted to check in and see how this was progressing?  I didn't
> > see anything in my inbox, but perhaps I missed it ...
> It's passed internal review. Leon should send it soon (Sunday at the soon=
est, IL has Friday-Saturday weekends), he may be waiting for a regression r=
un to finish.

Great, thanks for the update.

--=20
paul moore
www.paul-moore.com
