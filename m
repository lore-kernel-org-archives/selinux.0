Return-Path: <SRS0=GP52=75=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A16BC433E0
	for <selinux@archiver.kernel.org>; Tue, 16 Jun 2020 09:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A7E20786
	for <selinux@archiver.kernel.org>; Tue, 16 Jun 2020 09:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpMax/1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgFPJBy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:01:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45894 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbgFPJBy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Jun 2020 05:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592298113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Z6BnqdG1cz3m5CyL7XHuiWvWMy39uD8UoFP8AUY5oo=;
        b=WpMax/1UGbZYTETIM3JFH/z+GAYdy4zXajycoS3jC9cB6J1jtuSAyodr+H+BP9+dcOUbku
        aLBPCDjUmXt6iL3ux60oAFvvczS11FHeyNtrlSFASGzwWbJlP38TzYeClqyH54R4Omtjdc
        zh5W/O9+9JAhLBxypKRnf7wUGRGq5Dg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-IUJssDQ4MPigNiwwQJ9JGw-1; Tue, 16 Jun 2020 05:01:48 -0400
X-MC-Unique: IUJssDQ4MPigNiwwQJ9JGw-1
Received: by mail-lf1-f71.google.com with SMTP id y23so6080871lfy.0
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2020 02:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Z6BnqdG1cz3m5CyL7XHuiWvWMy39uD8UoFP8AUY5oo=;
        b=EUlIyNIYGgelTZtIHUoT4ZnLTmM54me9UsoLn1YGdwZlMQFUmby8tDazPxhLS4jcHP
         8tCQiOh8aumxg6SzCKP7uscwJYmJLihZ/zaQBm9IwKPgSn1ZvsN01dOKFbeZvhrE8FN6
         /RqW1LV22HDhnhbdBVBl41qeeypXtyzsLn5XoNbR8XahoB0eUouSeF9zhdo2TkRixiCU
         eGzxkx3ztMOe5h1hXHRkvDrhnEzZF9zG+u75RwwF19aRYTVca9s2KACN74xzlfLJNRQb
         4/HP0810U2pZbzNAFi32HCQjrPvO40SCYJJWCoX7W9GfyMrDO+vVcbXoHMREXFZrd4ok
         qaqQ==
X-Gm-Message-State: AOAM531/yb/qhEWFubZmXN/zfcxytf3cRCNU6ZAQo4uP5Hbh2EIhaGgY
        0/A8gaexF6qZ23S9Bpy8H7+2iLEgu7TiNrGbtYGlpcgQWOVxvVlHCOclwEFnRAcMCQhcq8QjzsQ
        ljsO+N1Ph78fbVp1oF9oCZ7jN2NlvvcDzQw==
X-Received: by 2002:a19:c194:: with SMTP id r142mr1166157lff.87.1592298107034;
        Tue, 16 Jun 2020 02:01:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgL+pwMCePDQcygpo9eXM1gVnzYf22xfltINu3Szd1zhC/mtbZPEPLDz8yKkGkSPEV5scREaHhMJdV/JRdp7k=
X-Received: by 2002:a19:c194:: with SMTP id r142mr1166148lff.87.1592298106837;
 Tue, 16 Jun 2020 02:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200609151833.43523-1-stephen.smalley.work@gmail.com> <CAHC9VhTo-B5PVsvsgvRamv8+j=owvfGHAcZaCBy1_yuEbBmgRQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTo-B5PVsvsgvRamv8+j=owvfGHAcZaCBy1_yuEbBmgRQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 16 Jun 2020 11:01:36 +0200
Message-ID: <CAFqZXNswa5Yys4y0JJDa-K0zcd_WYhm_T90qrb-dg_6iX8Dn=A@mail.gmail.com>
Subject: Re: [PATCH testsuite] defconfig: add NETFILTER_XT_MATCH_STATE and NFS_V4_1
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 10, 2020 at 4:40 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jun 9, 2020 at 11:18 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > When generating a kernel config for testing per the README.md instructions
> > based on localmodconfig followed by merge_config.sh with this defconfig
> > fragment, I found that certain tests were failing due to missing options.
> > We need NETFILTER_XT_MATCH_STATE for some of the tests/inet_socket tests
> > and NFS_V4_1 as a dependency for enabling NFS_V4_2 for the labeled nfs
> > tests.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Now applied, thanks!

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

