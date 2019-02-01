Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0526C282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 13:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD482084C
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 13:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="C4Q11wWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfBAN5i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:57:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45903 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfBAN5i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 08:57:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so5080042lfa.12
        for <selinux@vger.kernel.org>; Fri, 01 Feb 2019 05:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zuKJUz43GAMX1gDm+Ne2gI6mtDje/TAktzKXhxlHDAQ=;
        b=C4Q11wWxZryPkBdCyKhoBFpBwAizKPy9u+hnEJdLkCFZs5T7r9FJADJswXLPuPCJ2B
         lTse3y0os2MVXVb6dsUZuJdF7g4CJduSRCM6tZpPBu0jamNi5Yhe1q1dHt9xW/Mb0w2x
         6r0pdGMoORSqnFW7NprrIbTblEQoJ1L8yfk8Bn5SB/EWiOwWtLlMaLym8zCjWDU6TGtZ
         dYGCOhFZCnk8JDDcUTjbQY+DSwLv1dVYZji+PnqIJSKbBCtShJRIkS8vaRpFQMVo3yxD
         jtioMOrPTj4YW1IfA6EZLC//jFOuM5L4fYz7B++QWtZeLlolNnsye+mC5uRrll7QKAy6
         h0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zuKJUz43GAMX1gDm+Ne2gI6mtDje/TAktzKXhxlHDAQ=;
        b=fLY+oEFxtXKSSLyEszWl6SShmON4OpZejBj2grmIpfSeAVyYcDDJOSDxQfeu5syAwL
         70Hw8Y7dv4sV5ezmiYTvA7CfQgmw8m00zvAKYD+VGXN5GpzIeyDR/L4rcebmTx5zbmwt
         25Ciy7J0/VIJbTpfz80ObmkVt4Odeyag5N0106AdGdxafB+EB3UqxU8xYGcBOIx/5g9C
         0yRHkTWqQw9IvWXcuLdRfwv9q9Vvz3t8a7zrCQig1+d93Gca+rCOeWXwHH787rELkm5v
         vWeMXeBbP89drFkRX61qvo/Dm+RWCMZgS/q/t4xwunzaR/gq4d3SqvRfKJ2w0WVdptGA
         Cf4A==
X-Gm-Message-State: AJcUuke15PfuUGpyz1O9NoYnGJTZMPNZWmZPOIOtpkGC0NxBIaNdjuW6
        MK35M2q7Xvm97sfVm1TMTWnmRtzlk9ryyKtSfT8q
X-Google-Smtp-Source: ALg8bN4nqxQLbPST06M/3bNEZB+Jd5HL3BLgs5bQvuAIWYPrlLd/524GRsTZU3U8zrQp1ZdJ1Imx5MMD2afyX5K1cOY=
X-Received: by 2002:a19:c995:: with SMTP id z143mr30211666lff.79.1549029455364;
 Fri, 01 Feb 2019 05:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20190127081023.21124-1-leon@kernel.org> <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com> <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com> <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com> <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
 <CAHC9VhRWHzrR84ueJHzmBgyQviL-36-ezvDb0u-xRfQmBsBO2g@mail.gmail.com>
 <3cf233f6-4ca7-1667-7d09-0d2b6879046d@mellanox.com> <CAHC9VhQWG7z0dV4=bULLGdU3SXjQH-da9vkyZo6a+Wy5Bw29_A@mail.gmail.com>
In-Reply-To: <CAHC9VhQWG7z0dV4=bULLGdU3SXjQH-da9vkyZo6a+Wy5Bw29_A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Feb 2019 08:57:24 -0500
Message-ID: <CAHC9VhQc-_iYUid1PYnRA8_cJG+Ji5zkoz80Pg++C-wY_GKrvw@mail.gmail.com>
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

On Tue, Jan 29, 2019 at 4:13 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 29, 2019 at 3:58 PM Daniel Jurgens <danielj@mellanox.com> wro=
te:
> > On 1/29/2019 2:51 PM, Paul Moore wrote:
> > >
> > > Okay, so let's attempt the change above where we just do the access
> > > check directly.  Although I'm a little concerned that without a
> > > reproducer we might not end up fixing the problem we're trying to fix=
.
> > > Is anyone in touch with the person who originally reported the
> > > problem?  It would be great if we could get that person to verify the
> > > change ...
> >
> > I decided to go with maintaining a list in IB core. The notifier call i=
s done under rcu_read_lock vs spin_lock_irq for register/unregister, so we =
shouldn't have any problems in that case. So only registering once basicall=
y achieves the same thing as taking it all out. I'm testing it now. I'll se=
nd it for internal review today assuming it checks out. Hopefully Leon can =
get it posted tomorrow, I know Don has some schedule pressure here.
>
> Okay sounds good.  We're still at -rc4 so as long as we can get
> something posted this week, or early next, I see no reason why it
> can't make the upcoming merge window.
>
> I'm guessing Don's schedule pressure is more a RH deadline, and not an
> upstream constraint.

I just wanted to check in and see how this was progressing?  I didn't
see anything in my inbox, but perhaps I missed it ...

--=20
paul moore
www.paul-moore.com
