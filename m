Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D90C433DF
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 20:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D27207D8
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 20:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFicVKUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391067AbgEZUVI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 16:21:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24194 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390940AbgEZUVI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 16:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590524467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uV6JJfVk2YIkvDFUFAB7JIDoHHZIKHb/Ev2vxxioz8c=;
        b=jFicVKUrijJ2azzfSw/NOKOHcrja8GNZ99V+eo/R/bzp7HEXy7hsA3RJvxE8+0RPq2nR/Z
        UdiaAWgOlxGgzS1XyLJN0bu5FpTZ3ZKdXr7gkFk6Zq2yL1DqgQrJQZPy6kMXeZ21XQaK8K
        OiX33LkertC8AhjaZzx43XHMdqeGTfk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-R1G_lPyxOXqOumvByYbaBQ-1; Tue, 26 May 2020 16:20:51 -0400
X-MC-Unique: R1G_lPyxOXqOumvByYbaBQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9so16462455pll.12
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 13:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uV6JJfVk2YIkvDFUFAB7JIDoHHZIKHb/Ev2vxxioz8c=;
        b=n/t2ssZXw9nA1po8Gt0lKMVbb3gBdf3TlKK94428UZ9izNfeJfrti48zzR3jK9ClZz
         Tg8u1KQZHAZI+ZIHsqugxVX6uNLO9rzmnBIhvRepjFrO/q5RzvCwnxL5Hb7NXijf4RKH
         45cB72TWsQCpgZ9Axei+8dl9D7N27g4cFaE3BIdMBUC0wWbSnQStEhgcqBLO7GD+vmxF
         sxj4eGNxb67sgtQhthGtSEOTaR5OF05LliORylLRnsVNsou0qT/WO+eHfinhVOxq51nI
         4KSOcc6plDQLZEbwxW18HnI3O9MOfN9eAat/9KjB5id1XsSYqXz+2VY6kdsNeRvdqrQd
         87FQ==
X-Gm-Message-State: AOAM531Xe3gY6X/zbOfS5d6qa6BtC4rMZgehDvAqZr0+yyEwK1jVX6ut
        CHy7JphOtJdcw1A1LabbD2FeVSgtP3zgk6sbcECrdLZsVN/ywb/vXj6+ULbtAmB7W6j8oXccVK+
        uW4CN6d52/Qo+VVSrH1ifkTvYyj7LmIYH1w==
X-Received: by 2002:a62:6042:: with SMTP id u63mr541065pfb.79.1590524450146;
        Tue, 26 May 2020 13:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv9wUvyiV362KAdFAP7j/DsQIKrMGme3pdxrA66KohTEqcu6vccyTC4fQJHOcaH3JrEWvqr2Vg3KExKSaCP14=
X-Received: by 2002:a62:6042:: with SMTP id u63mr541028pfb.79.1590524449758;
 Tue, 26 May 2020 13:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200523195130.409607-1-jlebon@redhat.com> <CAFqZXNsuJ7S9zFhHBJNJxUr4=_ZGmKdzTU29PrWRuziMfJJkGQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsuJ7S9zFhHBJNJxUr4=_ZGmKdzTU29PrWRuziMfJJkGQ@mail.gmail.com>
From:   Jonathan Lebon <jlebon@redhat.com>
Date:   Tue, 26 May 2020 16:20:38 -0400
Message-ID: <CACpbjYpAGLXxxeV119d8zRevH0CAdEPQqjOp=khQW+yyTQK7tw@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow reading labels before policy is loaded
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 25, 2020 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> I might be missing something, but couldn't you achieve the same by
> simply adding something like this in here:
>
> if (!selinux_initialized(&selinux_state))
>         return -EOPNOTSUPP;
>
> (Or by adding it to the condition above.)
>
> Then you should hit this condition here and be all set:
> https://elixir.bootlin.com/linux/v5.7-rc7/source/fs/xattr.c#L337

OK, I tried this now and it does work well at least for our use case.
It's clearly a much simpler patch as well, which is nice. So assuming
my questions from the previous email don't raise any concerns, I'm
happy to switch to that instead.

One thing worth mentioning is that both patches change the behaviour
of `getxattr` for inodes on SE_SBGENFS superblocks. For example,
before, `getxattr("/proc", "security.selinux")` would return
`unlabeled_t`. Now it gets EOPNOTSUPP instead.

Anyway, I think this is fine overall and consistent with the behaviour
change proposed, but just wanted to flag it.

