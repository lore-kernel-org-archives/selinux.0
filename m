Return-Path: <SRS0=7tXC=QF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16764C169C4
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 21:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D245C20881
	for <selinux@archiver.kernel.org>; Tue, 29 Jan 2019 21:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="z9pd8hch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfA2VNa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:13:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37550 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbfA2VNa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Jan 2019 16:13:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so15758745lfj.4
        for <selinux@vger.kernel.org>; Tue, 29 Jan 2019 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zm2eR3EvN6npJPVBQTdZCcj7uGulVU2H8WsoZIL9Qg8=;
        b=z9pd8hch2MZy8FBeTCl2inneqN5p42+rI2gQEBk4TqBIYOPND6rAzAnkoRO7sUx1+B
         G/vXAppqaf+BvvvgXLnpHCYzxbGwOslavJ/49R6fb46tZcPAogMqnZlDCUfrozovI/7q
         YKxc46t4FeA/CS2lRze0NTqc6eU6M4T/EJmIcN7JaYTB/IPTBiYtl2hhlOXU+1bJccAC
         zgqw6BXJaRMsI3pM9QTzp2euMTRmltwfkCsnU6X7vik1wGbYGCDFcLQYWnxQLFBQqUCn
         GMPez/DxWCq19H4LiPPUwz+XwDPAyoPDrh4o4hsmkJ/NgEe1irpxIA0QZMMpc7U0gt6n
         isLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zm2eR3EvN6npJPVBQTdZCcj7uGulVU2H8WsoZIL9Qg8=;
        b=cvaCupC/XJU8M0vYMSGvBlkJwYNtkyIj9GZquxHebRj4s14BAxaXPqbw2zlGmJb7nt
         k1HeF4P18GYQ+CI9mmlhxYY8Rx90Xt8TEhYF++WXOXLKhiYRtV+1hwVLU5yo2OsSplot
         VSq5JV20hgQHAl5gPDfPgUWCxVbsvO8ZmLRsk8Bf/dXj6bphLKSieOBxmhDKdVGgTVF7
         zf5+EdlWJ2un8eVSG/ZEcYCnd2I3gfcUtKpiNSmhlYGZK7ctVC7OrvwQjDTyK+PL0aZZ
         yr6xYTI02LKntVPKuDKyd0mHhVqPGiGEUk0oDMxhsYWnEhuy7pkHKfHNXNxz7y+5JYfb
         +9xA==
X-Gm-Message-State: AJcUukeLk5bLPxNOs+H/fHjmQ0Auop2xmBuK/NIAn6lP8e/aLnAys4Wb
        ekNaqEj52O/OltfwFv9PUrpFMn5JWCW6G3CMC98c
X-Google-Smtp-Source: ALg8bN4Zy0/4UpzWLszAtYGmNdodabzmiMl88wKbt97rhcKoEsyl5RbrDwSjjal0lDkAxcgMXvk/MXL5VBQXU37TifM=
X-Received: by 2002:a19:db54:: with SMTP id s81mr22574612lfg.102.1548796407648;
 Tue, 29 Jan 2019 13:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20190127081023.21124-1-leon@kernel.org> <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com> <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com> <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com> <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
 <CAHC9VhRWHzrR84ueJHzmBgyQviL-36-ezvDb0u-xRfQmBsBO2g@mail.gmail.com> <3cf233f6-4ca7-1667-7d09-0d2b6879046d@mellanox.com>
In-Reply-To: <3cf233f6-4ca7-1667-7d09-0d2b6879046d@mellanox.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Jan 2019 16:13:16 -0500
Message-ID: <CAHC9VhQWG7z0dV4=bULLGdU3SXjQH-da9vkyZo6a+Wy5Bw29_A@mail.gmail.com>
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

On Tue, Jan 29, 2019 at 3:58 PM Daniel Jurgens <danielj@mellanox.com> wrote=
:
> On 1/29/2019 2:51 PM, Paul Moore wrote:
> >
> > Okay, so let's attempt the change above where we just do the access
> > check directly.  Although I'm a little concerned that without a
> > reproducer we might not end up fixing the problem we're trying to fix.
> > Is anyone in touch with the person who originally reported the
> > problem?  It would be great if we could get that person to verify the
> > change ...
>
> I decided to go with maintaining a list in IB core. The notifier call is =
done under rcu_read_lock vs spin_lock_irq for register/unregister, so we sh=
ouldn't have any problems in that case. So only registering once basically =
achieves the same thing as taking it all out. I'm testing it now. I'll send=
 it for internal review today assuming it checks out. Hopefully Leon can ge=
t it posted tomorrow, I know Don has some schedule pressure here.

Okay sounds good.  We're still at -rc4 so as long as we can get
something posted this week, or early next, I see no reason why it
can't make the upcoming merge window.

I'm guessing Don's schedule pressure is more a RH deadline, and not an
upstream constraint.

--=20
paul moore
www.paul-moore.com
