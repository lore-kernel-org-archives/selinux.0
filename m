Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02A5C433EF
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A6B6120C
	for <selinux@archiver.kernel.org>; Thu, 21 Oct 2021 15:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhJUPpI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231748AbhJUPoy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Oct 2021 11:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634830958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIvvdbcFghy0loK4UezRtBpuJzZqIMCSdGRQESJeGsA=;
        b=etFBo4uCj4l0N0y74pv8Im/dJotE9VpKgg976QHgTnAmjGmA6wsxtUZL042pc17C22m4sn
        rufRLDyMVnqutWipVupmg5ffQk319w68Pl7rKDqu3JFibe7fL+mS2k3SSInWuHcnq10lhf
        iYGgkeBpkiOaLk2CQTdES4LYq388sKg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-l_yw_Bh4MP-_BsBJafukfg-1; Thu, 21 Oct 2021 11:42:36 -0400
X-MC-Unique: l_yw_Bh4MP-_BsBJafukfg-1
Received: by mail-yb1-f199.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so70536ybm.18
        for <selinux@vger.kernel.org>; Thu, 21 Oct 2021 08:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIvvdbcFghy0loK4UezRtBpuJzZqIMCSdGRQESJeGsA=;
        b=vCKEYz2bXlt1CRMhrnkpv+LjErHl5IxEOpo+SBWdfWsCrNMt6MwTYXJf3+5J4cWWAj
         YFTGrR4U+dbXgWTBmJOOj0YrUiS38ZsSwS1sqw97zkCIQJPOSfUmv7P4FXWhwPSl8uKr
         hZQRi9Eu+Kh1lrhuvWZVxp1BrNmcXYsjpv8GDKI3avnXxUcUDBUmoN2cIyVMMvwPmGyS
         fJZvAtWsINBoRC7tyuApGI9tPjz9wuwxFjY9beSSvgbwligdaGkqAnwDvrrD21CHijgn
         UbLQfS1NACs/47gpjatwLziiJsVwpKYwpldVj4e2ZO+AamCHJf8VkQ96G+Nmt26alyQ+
         wtkA==
X-Gm-Message-State: AOAM5322/xMke1Thyw3NMmqnqtROaocgiw95YeO0jKWi4KmZNYTk511G
        L4nh74Bl/yjBVWY+oxcc/VxFj9oKLaXLv0fpql6GKnxTvvn8TTuOhx8JRI5ebPi5hUARzx2c7JL
        XdDLvoIkla4hQuuXYNlcsZJkf8Msveto8bw==
X-Received: by 2002:a25:c07:: with SMTP id 7mr7072312ybm.25.1634830956470;
        Thu, 21 Oct 2021 08:42:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxojkgcWYoKAXJzIMab+q2TMtmXi+9nDJ+c24BdUdAgfc9LobgcyHogILc55bM+PFpympnOvBTc3OYtubsjJIs=
X-Received: by 2002:a25:c07:: with SMTP id 7mr7072293ybm.25.1634830956260;
 Thu, 21 Oct 2021 08:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211021144543.740762-1-omosnace@redhat.com> <CAHC9VhRzAzmw9wif=p9N1Ym3sdq4c+0wQx5bXgHPfbtr1RBEWw@mail.gmail.com>
In-Reply-To: <CAHC9VhRzAzmw9wif=p9N1Ym3sdq4c+0wQx5bXgHPfbtr1RBEWw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 Oct 2021 17:42:25 +0200
Message-ID: <CAFqZXNssiWe5K=CoomFHof5LfDuWUhN4u7FDsFqVpT0GS9AjQQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/sctp: add client peeloff tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 21, 2021 at 5:12 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Oct 21, 2021 at 10:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Currently the testsuite only verifies that SCTP peeloff works on the
> > server side. However, it can just as well be used on the client side as
> > well, which isn't being tested (and actually is buggy at the time of
> > writing).
>
> Can you elaborate a bit on that last part, curious minds want to know ...

There's a bit more information in the relevant kernel patch I have just posted:
https://lore.kernel.org/selinux/20211021153846.745289-1-omosnace@redhat.com/T/

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

