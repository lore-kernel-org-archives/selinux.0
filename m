Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47741C433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9C720723
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py7lufHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbgFWNNt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732626AbgFWNNt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 09:13:49 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF5C061573
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:13:48 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id p70so18723490oic.12
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt04EgZdJjuPmIh3vn5fi+dkxDflt8CBp0huVSSUyCg=;
        b=Py7lufHpZiLwhJWxAIkBTBPoSczVJrVRKILEsvKuG46Tm0XN74Q2L0JxRHwDA7uDRC
         qyaEJlBV44mIfZ2Ru9vQiyc+BfNcWUtZIAL5/MneVK7Hh/iSsph/zUgimvFTb+VLRr4d
         Ac8qhFoq1LXj9YvuiQBnefEYv1qMyXvoz+/nHsVRqSCv0HrqBiM1xEUz4V8E+nfjTCQK
         aLUlQ3U6Y2HKrOr+LTG5zcVO3GBzz4Sbvvl4jOtVs3Efs98t4eq9nEZ3pyv3CifT7UhB
         lLgSxaSdC7wx+jhnYsFO5iQ4YQOrJS293/TBrfa+aRSr6X9A2yuUAAaxxcouljSLJZnr
         9PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt04EgZdJjuPmIh3vn5fi+dkxDflt8CBp0huVSSUyCg=;
        b=pFZccZ220UNryDwaSE4zrFNWl3fzw9/9BvIKpZ3DzmWW7oGuEkSc1Fag3J5G5tdAi8
         rJt7iVrE2dCbGBFIi+FLGnxKW+jWuiU1iRhte1Uxf7V1NvruPXRUjuCLpvoX+tOxlqWh
         RQhe0TiJqxjUn3DiKXn7gqUuIhEZhQ1gi5bEzqdRnAzzh9RLw294OIsvJcUhawzpZ+M8
         iuoulAPLo17WdVZEwrW7gzKIBlsRn7dzsKmqn59Bc3mvSs+5BFxM8QUkcJCIBMdoVHpp
         aF6+EOkr95jJ4CjYziv/NB9qMbUocdpA1J4mEjnBUUiI03PtF0sSUCDSMrdpsqJQOsSA
         aWMg==
X-Gm-Message-State: AOAM532W9BDmi88yFXyFxmMJwneRwxRWBhy4rELR1MitBKgicBefgqyy
        95mi2SKa5lwTV6hoh1eWxwD6+uYy44zxij7tNQB4mFIkNGg=
X-Google-Smtp-Source: ABdhPJzVoa+6eaEDiC49KnX+1GYhjdtfltmlLEqb1FwO6rzn3ggrObQt/3IzViO5T1gnve8P2fkSJmJZ35di2CrQJxk=
X-Received: by 2002:aca:3283:: with SMTP id y125mr16316798oiy.140.1592918027805;
 Tue, 23 Jun 2020 06:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200623123702.401338-1-omosnace@redhat.com> <20200623123702.401338-3-omosnace@redhat.com>
In-Reply-To: <20200623123702.401338-3-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 23 Jun 2020 09:13:37 -0400
Message-ID: <CAEjxPJ6OPt0r2Dv2u2Skt=ojKTVpNMcvDFKkoyw50naHetLC7Q@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/4] travis: add missing node to fake selinuxfs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 23, 2020 at 8:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since commit e95fe9503816 ("Add tests for default_range glblub") we look
> at $(SELINUXFS)/initial_contexts/kernel to determine the type of the
> policy. However, this node is not provided by the fake selinuxfs created
> by our CI scripts, leading to non-fatal errors like this:
>
> [...]
> make[1]: Entering directory '/home/travis/build/WOnder93/selinux-testsuite/policy'
> cat: /tmp/fake-selinuxfs/initial_contexts/kernel: No such file or directory
> [...]
>
> Create that node and fill it with the ussual kernel context to silence
> the errors.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Not objecting to fixing this but wondered if you had considered
extending the .travis.yml to actually run the testsuite in a
SELinux-enabled VM as per the selinux .travis.yml.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
