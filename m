Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00366C433E2
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 07:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67AE206EB
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 07:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UihOjpY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgICHPo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:15:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgICHPk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 03:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599117339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXhk0paan2bN0pn4Jac5hq5xuN6sN+Vk1aDoEgg+14Y=;
        b=UihOjpY1YFblujla60eo2Pb5WBHXM0QoLEDBcKWgFS7mpyghd0YrVBU8eDWxtPnhYX8ZS4
        weYTbPZpONZKJu1mCbMxtlBODiQ+jEj2XF/y0byCO7qtAJ6EsZd51P+q4l/C+BYzUuDDHD
        TDtH++D6+dUPy0aTouEaiGsx93T0csw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-9lJUwjUFNEOtKpwok7l0jA-1; Thu, 03 Sep 2020 03:15:35 -0400
X-MC-Unique: 9lJUwjUFNEOtKpwok7l0jA-1
Received: by mail-lj1-f199.google.com with SMTP id s11so472565ljh.8
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 00:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cXhk0paan2bN0pn4Jac5hq5xuN6sN+Vk1aDoEgg+14Y=;
        b=gUzNKxj4fzBLQucWTV/z+ChQ5HF9taXdVa5uj352HVt+uruF6BCukMXCADgd8JzTko
         GKWQ+WbQEHUYeJmKKpcjTcXS4EOVLV+cE4IrtpcvbIuPm9dOBW7PKHiq8Luwvv5TNezW
         hrKbb3zSRCYMVU8TEAmi/XOUifXBf80kMJ7JJofZdrxUshfe4oxWrI3X+ViMVYPbP+c0
         dkGBEn9DGONlfy+4tqdIz8g/F7QhXJcvaX2Z3/fvBFnFKPu3qAN/km0nnOaz6be/5/5/
         hjnuCk2Dr6UhuOhUJGx2pQ3rIjYxlBhceYFW+ywXIdieEwrVvdw/i2Ws/Emr5oKe/0AG
         qslw==
X-Gm-Message-State: AOAM530CWnbaH3s8XYvh924ZOtuYn7PuSzmJSfUtNsk/OmihxLOzdV2Z
        Ogd/RJYaKsfu0XM/ApW/3YlqwnbYx4RO6VKJzooghzPnLmMsv0A6nht9+uxt5nZIiqTt/idxvDP
        ibIWNN+se3pRDepHP18P/tBQtBzZaPTLGRw==
X-Received: by 2002:a2e:541c:: with SMTP id i28mr505403ljb.77.1599117334207;
        Thu, 03 Sep 2020 00:15:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7VrFZDeI50cX4rI30si5k/kccJQla2ebGtDfU2DVz4rs44pIC89Hoi+4jzaHOg8XbVA3SyGcN341Fwr9/EKc=
X-Received: by 2002:a2e:541c:: with SMTP id i28mr505383ljb.77.1599117333889;
 Thu, 03 Sep 2020 00:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200902111456.20610-1-cgzones@googlemail.com> <CAEjxPJ4qNYRDOgNX4fYzJvKMg3fwAxS4xzNdG2ydiT7qyeORHA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4qNYRDOgNX4fYzJvKMg3fwAxS4xzNdG2ydiT7qyeORHA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 3 Sep 2020 09:15:23 +0200
Message-ID: <CAFqZXNsUec30mFS9kFgTdhP=JMm3i7ttJDaDJd9AUTWWYcCoaw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: do not issue an audit on unprivileged operation
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 2, 2020 at 5:17 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Sep 2, 2020 at 7:18 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > sched_setattr(2) does via kernel/sched/core.c:__sched_setscheduler()
> > issue a CAP_SYS_NICE audit unconditionally, even when the requested
> > operation does not require that capability.
> >
> > Use an unaudited check first and perform an additional audited check
> > only on an actual permission denial.
>
> Could we just delay calling capable() until we know we need it?

Yes, please - because with this patch it could happen that an LSM
policy changes between the ns_capable_noaudit() call and capable()
call, such that the first one is denied and the second one allowed, in
which case the operation would fail without being audited.

--=20
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

