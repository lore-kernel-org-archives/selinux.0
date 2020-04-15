Return-Path: <SRS0=gWJv=57=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11936C2BA19
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 13:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9242076D
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 13:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uh1vSDhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633520AbgDONpB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:45:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47141 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2633518AbgDONo7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 09:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586958297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6sLRnp9fbhNyMJ7LdSt+iphCXQMe4Ofp9j0IK7H+KjY=;
        b=Uh1vSDhVQCn3EhD7Pi8kmkzAxcfHOpP6rPSj+mZv/Gq+bWf5/P4CqXUZQ9c3KXj80jKMMi
        oUIz8ucemypvx3lhimVXv+HU3ZQCwojrZ/rOlNZk8dfbwHjDwbP0tBn4IK5lw5/CCF93XE
        AC3R4jvuptfkjDEerWZSvNa5/eeBrk0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-T5lPBnPfNYmkfyjCKkzshw-1; Wed, 15 Apr 2020 09:44:54 -0400
X-MC-Unique: T5lPBnPfNYmkfyjCKkzshw-1
Received: by mail-oi1-f198.google.com with SMTP id d191so3399424oib.10
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 06:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6sLRnp9fbhNyMJ7LdSt+iphCXQMe4Ofp9j0IK7H+KjY=;
        b=C5TsEVNmiAgOnuJyPE9IsxqqF1UCM1VPexG/bt/Ddnxh8IqprSW/y9FtDiVNTYg5a2
         fXPL3vliz3Bnsdx12JeiNWwqfWa1l0ADvbjMbIjpogFLPT/6oGxEcfYHBTF4lg3Rid9L
         D745XM55/1LmwE8XRUmsrIn8MM9UcJjDKxeOsgSgKXWgk/ORSHvLCHSd96yjpJa7LdHI
         y5WbLEt2cqrFU5CLxo5TtKP4MaJJsV5hqP0bEH18Q70Sn0i9Qhw6ncKXun3HrIVIF0DY
         lMVRa6XeRmZdS4HkUjMl3vkd5zs7ea3pwkdmjkCO4n+P4TcDpUR4L+N5CY7dQHdISwdL
         5+fw==
X-Gm-Message-State: AGi0PuZe4d1KMt9JtJt0SWLOsPkYTekhIpsU9FMrJ4NxlRKGet3BsmAO
        600YufbBuw8UCYezxnYEnF9w0dHqMHTZi9b3JNJAKi3h1+SOenSNwy9x+Lnf1NrN3ZlqlNvOOGK
        RfyXnjiC8sjyzWBRpLHxJFtX5NnjiwGKaLg==
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr23098006oto.197.1586958293264;
        Wed, 15 Apr 2020 06:44:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypJA/S2MYXeWvTdo9dKrrSiNeDrGM4sT5kWTbg0qDXn0fjXNBu5ouUlp9KoN0vh0AbsO+Yt548CO+sgCPQtuFnw=
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr23097981oto.197.1586958292885;
 Wed, 15 Apr 2020 06:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <ebe1a7cc-6a42-0e2d-d704-23011ee2d1d3@gmail.com>
In-Reply-To: <ebe1a7cc-6a42-0e2d-d704-23011ee2d1d3@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 15 Apr 2020 15:44:41 +0200
Message-ID: <CAFqZXNsafaBpZ1x7f7xBYHbqFyPYx-9Tgy0pnCnNH6hY3CHW9A@mail.gmail.com>
Subject: Re: ebitmap_node ate over 40GB of memory
To:     =?UTF-8?B?6YOt5b2s?= <anole1949@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 15, 2020 at 2:31 PM =E9=83=AD=E5=BD=AC <anole1949@gmail.com> wr=
ote:
> I'm running a batch of CoreOS boxes, the lsb_release is:
>
> ```
> # cat /etc/lsb-release
> DISTRIB_ID=3D"Container Linux by CoreOS"
> DISTRIB_RELEASE=3D2303.3.0
> DISTRIB_CODENAME=3D"Rhyolite"
> DISTRIB_DESCRIPTION=3D"Container Linux by CoreOS 2303.3.0 (Rhyolite)"
> ```
>
> ```
> # uname -a
> Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38 -00 2019
> x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel GNU/Linux
> ```
> Recently, I found my vms constently being killed due to OOM, and after
> digging into the problem, I finally realized that the kernel is leaking
> memory.
>
> Here's my slabinfo:
>
> ```
> # slabtop --sort c -o
>   Active / Total Objects (% used)    : 739390584 / 740008326 (99.9%)
>   Active / Total Slabs (% used)      : 11594275 / 11594275 (100.0%)
>   Active / Total Caches (% used)     : 105 / 129 (81.4%)
>   Active / Total Size (% used)       : 47121380.33K / 47376581.93K (99.5%=
)
>   Minimum / Average / Maximum Object : 0.01K / 0.06K / 8.00K
>
>    OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 734506368 734506368 100%    0.06K 11476662       64 45906648K ebitmap_nod=
e
[...]
> You can see that the `ebitmap_node` is over 40GB and still growing. The
> only thing I can do is rebooting the OS, but there are tens of them and
> lots of workloads running on them, I can't just reboot whenever I want.
> So, I run out of options, any help?

Pasting in relevant comments/questions from [1]:

2. Your kernel seems to be quite behind the current upstream and is
probably maintained by your distribution (seems to be derived from the
4.19 stable branch). Can you reproduce the issue on a more recent
kernel (at least 5.5+)? If you can't or the recent kernel doesn't
exhibit the issue, then you should report this to your distribution.
3. Was this working fine with some earlier kernel? If you can
determine the last working version, then it could help us identify the
cause and/or the fix.

On top of that, I realized one more thing - the kernel merges the
caches for objects of the same size - so any cache with object size 64
bytes will be accounted under 'ebitmap_node' here. For example, on my
system there are several caches that all alias to the common 64-byte
cache:
# ls -l /sys/kernel/slab/ | grep -- '-> :0000064'
lrwxrwxrwx. 1 root root 0 apr 15 15:26 dmaengine-unmap-2 -> :0000064
lrwxrwxrwx. 1 root root 0 apr 15 15:26 ebitmap_node -> :0000064
lrwxrwxrwx. 1 root root 0 apr 15 15:26 fanotify_event -> :0000064
lrwxrwxrwx. 1 root root 0 apr 15 15:26 io -> :0000064
lrwxrwxrwx. 1 root root 0 apr 15 15:26 iommu_iova -> :0000064
lrwxrwxrwx. 1 root root 0 apr 15 15:26 jbd2_inode -> :0000064
lrwxrwxrwx. 1 root root 0 apr 15 15:26 ksm_rmap_item -> :0000064
lrwxrwxrwx. 1 root root 0 apr 15 15:26 ksm_stable_node -> :0000064
lrwxrwxrwx. 1 root root 0 apr 15 15:26 vmap_area -> :0000064

On your kernel you might get a different list, but any of the caches
you get could be the culprit, ebitmap_node is just one of the
possibilities. You can disable this merging by adding "slab_nomerge"
to your kernel boot command-line. That will allow you to identify
which cache is really the source of the leak.

[1] https://github.com/SELinuxProject/selinux/issues/220#issuecomment-61394=
4748

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

