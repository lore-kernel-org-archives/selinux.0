Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DEAC2BA83
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 11:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BD320675
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 11:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIH0hcA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgBLLk3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:40:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30753 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbgBLLk3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 06:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581507627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FfAXyeidMWXjbA4H6fILpgXDELOT1ZKn0WXC3ILBGCI=;
        b=TIH0hcA14S8y2RB2a8JNoJI2I0bbi98MMETTqPkkfPoZhUvaU3RRSf83NW6U3rHNE4DLvr
        rSTfqyDAUomU1/OJHz3Jr9iEhg/3NdhmPM7hHRlZtMjVo6d8VhO9VdqCTxOzMZ2itrXP9c
        GKpor4O+fLzEZsV3Ndz+GP2cVr3bZpc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-9FX5lk-6NK6RsTbDe46ClA-1; Wed, 12 Feb 2020 06:40:22 -0500
X-MC-Unique: 9FX5lk-6NK6RsTbDe46ClA-1
Received: by mail-oi1-f199.google.com with SMTP id 16so807164oii.18
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2020 03:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfAXyeidMWXjbA4H6fILpgXDELOT1ZKn0WXC3ILBGCI=;
        b=EUEfRPraTd9XW+UrMICllQVDlG2daOazEFZc4kLxm6w44V0yvVDW6nHFA8uDyw/Ez7
         DUawfYGCnvjE7G/gkAbq/pf1iQJCRnZWwwBLRl8R4BQtYO9SZOpXMaEwMaBnPw1sOhol
         +k2gw1qHMdpULUAaB/o67e/fPlpVgEq5q6Vze4RebvcugHwaUm6HEjZh5M3c+CJ4LKS0
         Gq8uBK9Fddb1fI42n3GDLJFTqc610l5rI319IMfCyZYx/UORq/GXDquKgP96lQwAUpYE
         RYXoGJXZJ4WGdNCMuBlmrvqxkGGth6i/Xx+CV1os3bbOHZ2QNsK34fQM3x554fqfR5EP
         WMHg==
X-Gm-Message-State: APjAAAXFNObvj8fFkF+07sLqeYtdIskCq9/G23Jvfvr2nNiw6YcZkS4I
        m2siA+YLm8S4diuHwVlCHfzCBrxmIsnisVQFBcI1ZZsDgvmCvw/oGbH+Xh+BAufC5fNalMZcD9n
        MmjTjTcDdUasASvRrbsVIYDjtBhhT6Dhy5A==
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr9308333otn.22.1581507621551;
        Wed, 12 Feb 2020 03:40:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmHPAusedPvn3NasHIbzIUy+Tp1fDKbJiLYR5qrXn7uN8K4/voeKPT4Ne4t4VyOHDj4v1CVWz7vv9Y1PtVlwI=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr9308318otn.22.1581507621291;
 Wed, 12 Feb 2020 03:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20200116213937.77795-1-dev@lynxeye.de>
In-Reply-To: <20200116213937.77795-1-dev@lynxeye.de>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 12 Feb 2020 12:40:07 +0100
Message-ID: <CAFqZXNsfq+JbTtEZtk-2NO8ciGLFy+n3hNP6HX9hTDOdCit5hA@mail.gmail.com>
Subject: Re: [PATCH RFC] selinux: policydb - convert filename trans hash to rhashtable
To:     Lucas Stach <dev@lynxeye.de>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Lucas,

On Thu, Jan 16, 2020 at 10:48 PM Lucas Stach <dev@lynxeye.de> wrote:
> The current hash is too small for current usages in, e.g. the Fedora standard
> policy. On file creates a considerable amount of CPU time is spent walking the
> the hash chains. Increasing the number of hash buckets somewhat mitigates the
> issue, but doesn't completely get rid of the long hash chains.
>
> This patch does take the bit more invasive route by converting the filename
> trans hash to a rhashtable to allow this hash to scale with load.
>
> fs_mark create benchmark on a SSD device, no ramdisk:
> Count          Size       Files/sec     App Overhead
> before:
> 10000          512        512.3           147715
> after:
> 10000          512        572.3            75141
>
> filenametr_cmp(), which was the topmost function in the CPU cycle trace before
> at ~5% of the overall CPU time, is now down in the noise.
>
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
>  security/selinux/ss/policydb.c | 140 +++++++++++++++++++++++----------
>  security/selinux/ss/policydb.h |  14 ++--
>  security/selinux/ss/services.c |  31 +-------
>  3 files changed, 109 insertions(+), 76 deletions(-)
>

FYI, I posted a related patch series [1] that should have a similar
effect on the file create performance, plus it also reduces memory
taken up by the file transition rules. It would be great if you could
test it vs. your (fixed) patch to see if it works for you.

Thanks!

[1] https://lore.kernel.org/selinux/20200212112255.105678-1-omosnace@redhat.com/T/

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

