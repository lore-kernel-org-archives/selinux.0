Return-Path: <SRS0=eLZI=A6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B5C433E4
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 11:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E127D20734
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 11:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU9T0yY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgGSLcI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Jul 2020 07:32:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30843 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbgGSLcI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Jul 2020 07:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595158326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2fotOfgPHcQiNV1pWoz+S/xzFYGLOmYS9ahE+I7Qxo=;
        b=LU9T0yY6rLNj4I/NvJI2AV4BvgZwVzW60Nlr6A08NTXYHksEpYfth6+Gq7u1GJk1/s9aCy
        Rv7K77almJgAK+XK7gGDXXchH/ZTN0ZAYxJCC85JLUod0vGdJb7iC+3pev1OgVS5wNIeRe
        FPaMItQmYeW/gdUdZbiI+dX1wIrbShA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-R3n5vsGJMtuXfP31UdB7tw-1; Sun, 19 Jul 2020 07:32:03 -0400
X-MC-Unique: R3n5vsGJMtuXfP31UdB7tw-1
Received: by mail-lf1-f69.google.com with SMTP id t18so6734032lfe.7
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 04:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2fotOfgPHcQiNV1pWoz+S/xzFYGLOmYS9ahE+I7Qxo=;
        b=psTyjEPH+X8BifBFF2fXRKqIZvldwp03mTb8EVPegbLqrlUN1PEzdivcNua6KVFWRs
         Ds01JtmgD3qtPZzkF3eaz9oiUpnjar8Zu9TDN+S8jNOqNfj6GYnYEQDT/x2fhvJNA7+B
         Yn3Q+WnQ0xCj5qHkV3aMD9Vp2KrC+ZRw0MTSfVX4ey6Lu4lFp23XoTD+BeZ8Rs1xDk25
         GJ2hnNoc2ovPFs9/djM+A1YQsSmj1NKQMRhD9mbtfW6Q/7petQdGkR7IgvhhZD7LKv4L
         DPjRjTw176TupH/g+/Vqg7Du1vMinEX6Qq3ZgKVwY+KfUz5fzYgmocSVrKk6/6FUXClU
         7UEg==
X-Gm-Message-State: AOAM530hlYVumP1/lB+SBLPUYtf1s57K73yVg3m1Iy15EYkJbmlDkiwb
        13R9y8ckKUXSgG7XI1ABgEQTH/2FweqHjbbCv5TCKCrjHg8KCpV1k/FVQ2AAwck1M70g10nxt53
        qgs7PoYnr0oQgIp9bxiKbwUxk6V4KhwaEVg==
X-Received: by 2002:a19:be53:: with SMTP id o80mr8512628lff.33.1595158321690;
        Sun, 19 Jul 2020 04:32:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzQfn5uNvbVUdEm4B79Rea4u9L7kH9gVeRzo1c8A44X8ygWQDqTixvpc2gnHT7hEC5YLrKzNHEcVrY6Rn/9l4=
X-Received: by 2002:a19:be53:: with SMTP id o80mr8512618lff.33.1595158321474;
 Sun, 19 Jul 2020 04:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200719103506.865962-1-omosnace@redhat.com>
In-Reply-To: <20200719103506.865962-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sun, 19 Jul 2020 13:31:50 +0200
Message-ID: <CAFqZXNtJziNtxG-yrTiBPq3Z0H7zOYX62ydmJ0SneJCsLMiMtg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] userspace: Implement new format of filename trans rules
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 19, 2020 at 12:35 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> These patches are the userspace side of the following kernel commits:
> c3a276111ea2 ("selinux: optimize storage of filename transitions") [1]
> 430059024389 ("selinux: implement new format of filename transitions") [2].
>
> The first patch changes libsepol's internal representation of filename
> transition rules in a way similar to the kernel commit.
>
> The second patch then builds upon that and implements reading and
> writing of the new binary policy format that uses this representation
> also in the data layout.
>
> See individual patches for more details.
>
> NOTE: This series unfortunately breaks the build of setools. Moreover,
> when an existing build of setools dynamically links against the new
> libsepol, it segfaults. Sadly, there doesn't seem to be a nice way of
> handling this, since setools relies on non-public libsepol policydb
> API/ABI. I have prepared a preliminary patch to adapt setools to these
> changes - I'll open a WIP pull request for it soon...

And the setools PR is here:
https://github.com/SELinuxProject/setools/pull/50

>
> See also this discussion about the setools impact:
> https://lore.kernel.org/selinux/daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov/

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

