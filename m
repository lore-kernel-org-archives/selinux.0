Return-Path: <SRS0=GP52=75=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77243C433E0
	for <selinux@archiver.kernel.org>; Tue, 16 Jun 2020 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5312220767
	for <selinux@archiver.kernel.org>; Tue, 16 Jun 2020 08:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqXuL1Yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgFPIN2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:13:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31204 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726259AbgFPIN1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Jun 2020 04:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592295206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJezEl7pEpz0+81cqj9YoCVXqx3lyo7ppqkURJNiPRo=;
        b=JqXuL1YfJzUmSCwtMI+CNs6dKnJ19jS4E0cLvML0PFSxi7bFlBjBBAsuFgjRga3rmGl7Pi
        b2MsMBGId71SZMzr6lUW6dgF+7vgSuI674VZZHvmuqMrQB5OzwUQHXU4Xrwjn13N6gQHCC
        D0KLA8/MojQwd14z8EuDpkHUgV8Y3Qs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-KQyIRWqsOY2A4mhybdAmCQ-1; Tue, 16 Jun 2020 04:13:21 -0400
X-MC-Unique: KQyIRWqsOY2A4mhybdAmCQ-1
Received: by mail-lf1-f69.google.com with SMTP id x4so5979844lff.21
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2020 01:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJezEl7pEpz0+81cqj9YoCVXqx3lyo7ppqkURJNiPRo=;
        b=iX8vS6AjyXcT7RYF5SVq8OjiMeH5gHrbJBFuaQ1geLSj74Uvw+CdHRk7RxXvqccBQJ
         ILfsbwE6rj1m6bQCAxviZ48ZhcmvXTK9e+v57uk9Ir4iaoQr3Hb78LJ1wAZk8a3d5884
         L8UuUvgu4vXPXTlf0fL3jCpTEw/6DiUD6PdrxdSQfx6xOan4MzJp2oKtzn1GfDmCDKDC
         +AS69LJsPI9EaiYHCk2nH3OY5ptlzS+hWzBOtmI1AL5Nfsb/i79zZIZVYwU5W778Ouyl
         x0/UXgYaromw/z7h4ZX2D9qnsGCQoDjjT4oStAzRG3YHrHRFfmwpZOgqcTcjfsHkID9H
         HsDw==
X-Gm-Message-State: AOAM532UoucjDy9sQE9AsI2IWACgkapKaXD58+P30VS5DoFov3iU66jL
        C/tWfuOoTCyY+OpzB/GNTGRyrqx9X53yhRRssO/7l02T1y5GWPPKOo2gz35iHpMCYb5wAGJ1ZcH
        Tpuixbr4gW8YS/2KWVjgxhtC/eKmgXze4MQ==
X-Received: by 2002:a05:651c:288:: with SMTP id b8mr847613ljo.337.1592295200066;
        Tue, 16 Jun 2020 01:13:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7qrdC5T62BF7nV77TjyavouOG0cM1YBZzNrbhMaYpZujAqdcq1j77cfzdkME5RyZdybB6wrxRkUZGtsUsmZw=
X-Received: by 2002:a05:651c:288:: with SMTP id b8mr847599ljo.337.1592295199705;
 Tue, 16 Jun 2020 01:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200615204548.9230-1-trix@redhat.com>
In-Reply-To: <20200615204548.9230-1-trix@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 16 Jun 2020 10:13:08 +0200
Message-ID: <CAFqZXNsK8HEUVSEr9ENGMtx6Q2=f6hMYO03J5wgSMM2KesNMGg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: fix another double free
To:     Tom Rix <trix@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 15, 2020 at 10:46 PM <trix@redhat.com> wrote:
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this double free error
>
> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(node->expr.nodes);
>         ^~~~~~~~~~~~~~~~~~~~~~~
>
> When cond_read_node fails, it calls cond_node_destroy which frees the
> node but does not poison the entry in the node list.  So when it
> returns to its caller cond_read_list, cond_read_list deletes the
> partial list.  The latest entry in the list will be deleted twice.
>
> So instead of freeing the node in cond_read_node, let list freeing in
> code_read_list handle the freeing the problem node along with all of the
> earlier nodes.
>
> Because cond_read_node no longer does any error handling, the goto's
> the error case are redundant.  Instead just return the error code.
>
> Fixes: 60abd3181db2 ("selinux: convert cond_list to array")
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks!

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

