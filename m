Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364AFC83000
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 07:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE20206B8
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 07:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1HcV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:32:21 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:35585 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD1HcV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 03:32:21 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 71DF9564967
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 09:32:18 +0200 (CEST)
Received: by mail-ot1-f53.google.com with SMTP id 72so31028070otu.1
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 00:32:18 -0700 (PDT)
X-Gm-Message-State: AGi0PuYl4NRlAsv9nrvd52i9lwIebiXzjxodMyukzSSxDt+IDo+b4UX+
        BbWEmIEKCjLQuRQ5PePLv3In/81W/+v28SxV20E=
X-Google-Smtp-Source: APiQypKCianSqsVKrY7KpIXP63Epo4pCYu11IQKgoEipqGuoHGhOqKVGyE9DT6VbUSR2Uwa/wZL1u8emcYk/THPdjrE=
X-Received: by 2002:a9d:7082:: with SMTP id l2mr20515715otj.361.1588059137495;
 Tue, 28 Apr 2020 00:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRe25+PkmjaM8GcFZzFgDM5F3S65rfR5LuCBkangOtjGw@mail.gmail.com>
 <20200423185449.223595-1-plautrba@redhat.com> <CAHC9VhQdgvihTJPLPAzZ7O0QPTtLehdGn18vs19+mOGTG_ev3g@mail.gmail.com>
 <CAJfZ7=mz0=QT_OdZHg_eZwOqS=7KZPBB1q=16Qsav7gZSoV97A@mail.gmail.com> <CAHC9VhTBk0SEA9t-B6_Hkg70NqEt-L=6MN9oEb44gxbO=xZYNA@mail.gmail.com>
In-Reply-To: <CAHC9VhTBk0SEA9t-B6_Hkg70NqEt-L=6MN9oEb44gxbO=xZYNA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 28 Apr 2020 09:32:06 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==WpQvBtbfqV9+VkagNgLGc9wEXMqRE1K8iR-UDhKZy1A@mail.gmail.com>
Message-ID: <CAJfZ7==WpQvBtbfqV9+VkagNgLGc9wEXMqRE1K8iR-UDhKZy1A@mail.gmail.com>
Subject: Re: [PATCH v2] Convert README to README.md
To:     Paul Moore <paul@paul-moore.com>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Apr 28 09:32:18 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 26, 2020 at 10:54 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Sun, Apr 26, 2020 at 9:02 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Thu, Apr 23, 2020 at 9:29 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Thu, Apr 23, 2020 at 2:55 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > >
> > > > It should make the document readable for github users.
> > > >
> > > > Fixes: https://github.com/SELinuxProject/selinux/issues/225
> > > >
> > > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > > > ---
> > > >
> > > > - Fixed indentation in yum command
> > > >
> > > >  README    | 25 -------------------------
> > > >  README.md | 41 +++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 41 insertions(+), 25 deletions(-)
> > > >  delete mode 100644 README
> > > >  create mode 100644 README.md
> > >
> > > Thanks Petr.  For whatever it's worth, here is my ACK.
> > >
> > > Acked-by: Paul Moore <paul@paul-moore.com>
> >
> > Thanks :) I will improve the README a little bit more (adding a
> > Travis-CI badge, listing Debian build dependencies, adding
> > "install-rubywrap"...) and send a patch to be applied on top of this
> > one.
>
> I think those all sound like good improvements.  Thanks guys.

I merged the commit and am still preparing improvements (if you are
interested, the work-in-progress is available at
https://github.com/fishilico/selinux/blob/wip/README.md).

Thanks,
Nicolas

