Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8752C35280
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 20:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5552166E
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 20:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7FzQlkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgEAU3U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 16:29:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41125 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726045AbgEAU3U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 16:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588364958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tTe8z8pOekvqGA4Fh/3b1E13z03U3Y5nyf+u0trzCy0=;
        b=L7FzQlkkZ27F0HF8lXctrkp7zpgoCCN9WkZVRRY+JQW4rbq8x6pKgh1+JzPkyQnMvD2n5V
        tI8GtMoMSU3+4d+aM60kRb4ML/O2K0iPPhQDio+1kIJZVVWVeqBYNdw6YBckae8qNYEqik
        eHWin6B1utW8u66420yO6asjbk42TPc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-vudVzpBsPxeCKhAo49va9w-1; Fri, 01 May 2020 16:29:16 -0400
X-MC-Unique: vudVzpBsPxeCKhAo49va9w-1
Received: by mail-ot1-f69.google.com with SMTP id k10so2436617otp.19
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 13:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTe8z8pOekvqGA4Fh/3b1E13z03U3Y5nyf+u0trzCy0=;
        b=ZFdv1PVEJu4u2UbdmTTPqJbBCs3m/SpyBoY8CRcXsIuZutE1ddA5btbCwdCzS4fHOn
         plXsnoQ5ves2vDcyq8W2F+aM0ciFkQngjcx3WnwSwfZghPTXiQynyjHpk7Dia/hjxd8Q
         JnAr7aQ0/PlRIlvbTsOXxwUASoCa/Pb9/tRHwjSq2fHj36vqFM0cNQrrAT2HiYN6+1+d
         /pjXvJA+rwKseiiCLC0xNQQ6aN4/Hs57BVreTSyKwB1cQA+bWFILRNgf6hH0fiQ4H4Yk
         4k5x0VjOC4HY1TsJqjbVwHLzHWCxVGrE7YFTvC6Z5O0EQQB2bFs/fyZ4JDFiOsX8zUnL
         y0kg==
X-Gm-Message-State: AGi0PubQfKbRqFbRKcqzRu4D+QNkqeoADmkc4oW+i+uyLUz5yH3j05cA
        7BgR7ZumN8/XvGybo+uDTccVmZcTVGjLW1vE6H24fAUE9jMeti+TiJzeudHT1VwK591GSWq4cmt
        eSfkbbhN0PU7gb+9fH1On6XHFb2+c4IECuQ==
X-Received: by 2002:aca:b6c2:: with SMTP id g185mr1087090oif.166.1588364955740;
        Fri, 01 May 2020 13:29:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJzYmvZY1O6JX9ITjWTF9pNCbtbL1SPrvDs9bBAPvqkfFor5rP3GWt6IleMHOf7VvFsJbBUyU4Loyz0m+HWInM=
X-Received: by 2002:aca:b6c2:: with SMTP id g185mr1087077oif.166.1588364955514;
 Fri, 01 May 2020 13:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200428125514.2780171-1-omosnace@redhat.com> <20200428125514.2780171-3-omosnace@redhat.com>
 <CAHC9VhTr3cvYwJZyS_GPXW+8_VNoiO=qoJx2WBfpPq+MGsVunA@mail.gmail.com>
In-Reply-To: <CAHC9VhTr3cvYwJZyS_GPXW+8_VNoiO=qoJx2WBfpPq+MGsVunA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 1 May 2020 22:29:04 +0200
Message-ID: <CAFqZXNt631OAZZ0i7BEXm+hVDkJNi8OtAsgO1Enhg55_SCS9yg@mail.gmail.com>
Subject: Re: [PATCH 2/4] selinux: do not allocate hashtabs dynamically
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 1, 2020 at 10:20 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Apr 28, 2020 at 8:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > It is simpler to allocate them statically in the corresponding
> > structure, avoiding unnecessary kmalloc() calls and pointer
> > dereferencing.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/hashtab.c  |  51 ++++---------
> >  security/selinux/ss/hashtab.h  |  13 ++--
> >  security/selinux/ss/mls.c      |  14 ++--
> >  security/selinux/ss/policydb.c | 126 ++++++++++++++++-----------------
> >  security/selinux/ss/policydb.h |   6 +-
> >  security/selinux/ss/services.c |  44 ++++++------
> >  security/selinux/ss/symtab.c   |   5 +-
> >  security/selinux/ss/symtab.h   |   2 +-
> >  8 files changed, 116 insertions(+), 145 deletions(-)
>
> Merged into selinux/next, thanks.

It looks like you didn't resolve the conflict with the return value
fix correctly. You left the line that sets rc to -ENOMEM, which is now
useless, because the value is immediately overwritten on the next
line:

        rc = -ENOMEM;
-       p->role_tr = hashtab_create(role_trans_hash, role_trans_cmp, nel);
-       if (!p->role_tr)
+       rc = hashtab_init(&p->role_tr, role_trans_hash, role_trans_cmp, nel);
+       if (rc)
               goto bad;

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

