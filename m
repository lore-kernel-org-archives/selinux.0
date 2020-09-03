Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DCBC433E2
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 15:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D282072A
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 15:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyvQkWdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgICPOI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728358AbgICPN7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 11:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599146036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMd4dDa0jKKgpNgKhEJG8ahnGkNn7O108e1LE/jyTlA=;
        b=PyvQkWdcS60VKawqY8josVLI8FKpC9G8mIeKVo0/au0a+Rap5E7FhEUyJ5GkXHhtovBx8I
        N+Am3p1G+vYytLcFfzD50H5mh/wqJy2S9sULPUYI0miDFAPEfVADCsYiBaj0ofRZ3bwRzj
        7ldYE+z1TpYANYv5txNKFC9SXjhpIPY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-GmWU0eXYP1KcqRMyfX2JWQ-1; Thu, 03 Sep 2020 11:13:54 -0400
X-MC-Unique: GmWU0eXYP1KcqRMyfX2JWQ-1
Received: by mail-lj1-f200.google.com with SMTP id t9so1062623ljt.13
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 08:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMd4dDa0jKKgpNgKhEJG8ahnGkNn7O108e1LE/jyTlA=;
        b=i33HXzojra+owQX+wNH6lkTzOnj6buN/RWtJeGc06C/WDZSJcKyTZBGpr7W1UGvt2s
         JIhXvhFQV1P7MoQEHDlMBgnNUiXALAS0d1rFzlVZsLdzOfxmpE4ZHFkztUfGjxPHcitF
         FR2ZNU0iQanBMS+cu6sjitHn2HUI0huH4+OFliPgTY2X3srxl5gbr2bVzdREgyzYAnJJ
         nW916LKn3RDy3w107w+ypbTZOANmiaBU/vnhkz4BcUVRVvbzWrG2Qvn7gFE+RWIu/pNG
         XJCQ8A9Sh9TJiKR/xGlBM0J5JRSeyc4LOqTqUgcdR1+2KKWadqufq79AXEt0uVKdkara
         94/w==
X-Gm-Message-State: AOAM531OHTnlBZ5DDFoxgi/tTBB36V2ElSmkPtd+wkFaYhX3fk+i/tqj
        rU/55D/oEL7HeWKHkBpgHeTz+Su4G1CniSi0tnvSg5xWSeLBK82Y8RNqogELCwMLsHx0pW4Nfk2
        SoceRhoPZKa+ixCboCYd6SHXh0no6c624yQ==
X-Received: by 2002:a2e:3208:: with SMTP id y8mr940124ljy.123.1599146032704;
        Thu, 03 Sep 2020 08:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRM+0dWeT9CsFttdQnsFsgXUFxM6atVxqzJ5UzRpHYkaCuU2EBDGhiil1hUh42DrDNUiXV14Lvf4CwF5+jyHg=
X-Received: by 2002:a2e:3208:: with SMTP id y8mr940116ljy.123.1599146032454;
 Thu, 03 Sep 2020 08:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200827081100.1954467-1-omosnace@redhat.com> <CAEjxPJ7vAvyamDEUK1oAx9kyQHJiUoAKySd1fkfNwCHMukKw_g@mail.gmail.com>
In-Reply-To: <CAEjxPJ7vAvyamDEUK1oAx9kyQHJiUoAKySd1fkfNwCHMukKw_g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 3 Sep 2020 17:13:41 +0200
Message-ID: <CAFqZXNubdNxjFrDEnjwMQJrYH12+Nas8VG_xLVhmcKDKd62xkg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/sctp: bump connect timeout to 4 seconds
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 31, 2020 at 4:13 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 27, 2020 at 4:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The current value of 2 seconds causes transient failures too often in
> > certain slow/unstable environments (including the nested KVM Travis CI
> > setup). Our experience from downstream testing at Red Hat (across a
> > variety of HW and architectures) has shown that a value of 4 seconds
> > yields only very sporadic failures.
> >
> > Therefore, change the value to 4 to trade off some testing time for more
> > stability.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> As much as I dislike relying on timeouts and making the testsuite even
> slower, I don't have any better solution.
>
> Acked-by:  Stephen Smalley <stephen.smalley.work@gmail.com>
> (feel free to merge it yourself)

Thanks, merged.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

