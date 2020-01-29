Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2CDC2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 16:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A70207FD
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 16:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FHuRwcQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgA2Qpt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:45:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43337 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgA2Qpt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 11:45:49 -0500
Received: by mail-vs1-f66.google.com with SMTP id 7so110875vsr.10
        for <selinux@vger.kernel.org>; Wed, 29 Jan 2020 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdmYpbmfWUCZFo4/ZO68tO8na1kRkHd2ptsUR1EcnFc=;
        b=FHuRwcQIiIgp7ILC1bIFtGFxD5rg5rQLluHm9uM1gJg6swoCSrpU0lZ6mFtfUrE0x6
         PHEK79iicR6F4BN8HUMWVja1O6NIVO2ErLbKshBoUMCH4X1jILNMgfPRVqwK7LsK2zbZ
         0u04ddkrYFNsNKriA4/0uXuRGPIDL15bjd6bgsvQwXTcehcaYyKd9cjbZCJB0hYNSJin
         r4i+eLJx1WIPbeBb92Dx/CweBIIkBTjkewFfXjWDjaAZDKo3wyw9EoQfrdh+i5VboEc+
         rGgmOv1S/h4ECLdywht526Oa7v+rBk7eHpChTnXefh35KV2AWxAovwV7ajissmV3spAA
         v9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdmYpbmfWUCZFo4/ZO68tO8na1kRkHd2ptsUR1EcnFc=;
        b=URWpUDHq1zlEr9+9nKOVJM6pMmi6TnDh8RprH61K6FeBAm2vTLLDNsWMJSQ3iH1D9H
         LUR8Mq1uNQr272tasGSTcNj1quSbUNf0oGpXhY3y7DS2cIIa8L0OUi4ZFQ78oBBptRcE
         NAp+NXezKZdU71go4n6TA5hHyLmXH0YJuYswVKKjZAGxKx1zBLkM4bkFm3NBv77Viwpe
         cKgH0WzQfbeEjh0ZR5femQBRPPDnCSwh8PnfLmFHLS6nxwyI7wSrBCtjg3yUe1PYFi9u
         x6UlXRH8Xx0ZFsyNnbgBBhHEZJG2KDL4bFIp41fATeZ9DT3/7HN1WdXSfMyGbkE6ynt2
         2ksA==
X-Gm-Message-State: APjAAAVFHALnrtVwB88rlU3qWdMODIvL1XTxV4efegdi6ef36veHm9gq
        RBMZsvqAOgRz0NgaEgiNGNBw9uLIBj5eDZHZGtl4OcQC
X-Google-Smtp-Source: APXvYqz/RZIUon36Yf95yRvUw0gPkBF8g2gNODzIHfMatTP0ePH4W567PZpm0TnSj0BklO9EITWxwwFagpobF53k59A=
X-Received: by 2002:a67:5e45:: with SMTP id s66mr212139vsb.200.1580316347912;
 Wed, 29 Jan 2020 08:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20200124184221.322248-1-cgzones@googlemail.com>
 <20200128191656.111902-1-cgzones@googlemail.com> <fea9b8ba-c95b-3629-fcc8-6f6d7a345b71@tycho.nsa.gov>
In-Reply-To: <fea9b8ba-c95b-3629-fcc8-6f6d7a345b71@tycho.nsa.gov>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 29 Jan 2020 17:45:36 +0100
Message-ID: <CAJ2a_DdWRL+rpAJc4z9dwJoPFQ8NKtqaiQ052KdQYBS_B4O16Q@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: allow kernfs symlinks to inherit parent
 directory context
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mi., 29. Jan. 2020 um 14:34 Uhr schrieb Stephen Smalley <sds@tycho.nsa.gov>:
> This looks fine to me code-wise.  Have you tried enabling this new
> policy capability in policy and seeing the effects of it?  I remember a
> problem in the way-back time that motivated adding the S_ISLNK()
> exception for proc.  IIRC, the issue was that policies specified
> "genfscon proc /net system_u:object_r:proc_net_t:s0" to label everything
> under /proc/net with proc_net_t by default, and when /proc/net was
> changed to be a symlink to /proc/self/net as part of the network
> namespaces work, this caused the symlink to be labeled proc_net_t, but
> since previously there were no symlinks labeled proc_net_t, no processes
> were allowed to read/follow the symlink and existing systems broke.
> Exempting symlinks caused the /proc/net symlink to be labeled proc_t
> instead, which was already widely allowed.  To avoid this problem when
> enabling this capability, you will either need to allow
> proc_net_t:lnk_file read widely or you will need to change the genfscon
> statement to avoid labeling the symlink (there is an optional file mode
> field in genfscon statements similar to that of file_contexts, e.g.
>   genfscon proc /net -d system_u:object_r:proc_net_t:s0
>   genfscon proc /net -- system_u:object_r:proc_net_t:s0
> would only label directories and regular files with proc_net_t.

I tested it with a refpolicy alike policy, where
kernel_read_network_state() allows access to symlinks [1].
Just systemd pid 1 wants to read the symlink only without reading any
files, so I added kernel_search_network_state(systemd_t).

[1]: https://github.com/SELinuxProject/refpolicy/blob/7e191b008e70ca535ceca2405967ddddd2ed975d/policy/modules/kernel/kernel.if#L1437
