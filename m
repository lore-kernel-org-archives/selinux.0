Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2851CC433E1
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 09:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B1620812
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 09:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRI5ymuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgEVJA1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 05:00:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57386 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728424AbgEVJAZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 05:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590138024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eV3ECgqOh2V0vXSFIlAc8cyL8ZQIrSGiaEx/D1msOcA=;
        b=fRI5ymuP57+XsFZIf9vgf3u9kNMj+ihOrzHCb8dLPjRQFtkI8BQIJPMz3xaqnSPcFjbiGZ
        dRtAm/k2hF0+AbzcDgEjRyY19uxGVze1SLa9H9lCAikjT2yf5iJ+Phlu1fLpnm3167B5HA
        rSpLZmqzdPS6oDvScn4rCudSy3wQvbo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-vqt5lDF-OpmNv7X1Djrm0g-1; Fri, 22 May 2020 05:00:14 -0400
X-MC-Unique: vqt5lDF-OpmNv7X1Djrm0g-1
Received: by mail-ot1-f69.google.com with SMTP id h15so4501921otj.9
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 02:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eV3ECgqOh2V0vXSFIlAc8cyL8ZQIrSGiaEx/D1msOcA=;
        b=WeAoocpH+ogQ0ex46f37mDfOa89CuZ9eDHf9EC1d2mMZ2W8Pu+1nTyauI4LnprG/eZ
         W+VPc9bLoXF+cUIKmKULlSQVC+iNQOVtgtT3qn1ITX0B2bHKQO1kQWD/4gV091v+vTGb
         08xj/NRSzaloQwla5Iw7fW6w610CJmjGDAGjh4gIrBARn+6Xv1s7bcZqJjLb4l0awJ/3
         VLlteDzi55Zngmha3PpgyLUUgc5X3f3uFQHGifMn0/cOtSOSr8CbDOCq3vfqgoHpBGSZ
         kuIpzcZ0SOAqHy0m6JBvtCNoBa4Fyf3s7z7jePL+ZygJcvSQwvm2Pvw65Wyhw7pO4So9
         SqHQ==
X-Gm-Message-State: AOAM533KTrOcotlohvBbpp35EINUsYhZYFnjgb/0lnBeiFV1l/loiewg
        rYQdVgM5piAfw5zr/FQnol50y1ZZTD6JOiEMtC4Ey4ky/hqLZl3mWlkHbKu1oyp8G8KC4BPzqN2
        jAp3lRriQyfTuv/Ejn8QBO0XrS6GoK9bF8A==
X-Received: by 2002:aca:230e:: with SMTP id e14mr749018oie.127.1590138013648;
        Fri, 22 May 2020 02:00:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTS5pr3XA6xHv1xYIREU+IuflvlQIjj60De8wogkwN4kIV/iBIfctxPsp7ZjyqRoWl/IgwzaDC4YGrgUQn36Y=
X-Received: by 2002:aca:230e:: with SMTP id e14mr749009oie.127.1590138013383;
 Fri, 22 May 2020 02:00:13 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 May 2020 11:00:02 +0200
Message-ID: <CAFqZXNveic7xQQkZY=9jZKeG7_DFR+fSJzgsOj9eLAYdmQY=Uw@mail.gmail.com>
Subject: Question about SELinux and hard resource limits
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

H alli,

while debugging an AVC that started popping up after a change of
default RLIMIT_NOFILE on RHEL-8, I came across the SELinux setrlimit
check, where I don't quite understand what is the motivation for
requiring permission also for lowering the hard limit. The code
comments [1] [2], as well as the prlimit hook's commit message [3],
explain that the hard limit is used as the reset value when inheriting
the parent's limits is not allowed and I understand that raising a
task's hard limit can have unwanted security consequences due to that,
but I don't quite see what's the concern with lowering it. Yes, the
child process would indirectly "inherit" this limit even when
inheriting is denied, but it could only get a lower value than
otherwise, which doesn't sound like a security risk.

In a situation where setrlimit is denied by default, this seems to
"punish" the processes that want to play fair and lower their limits
to the minimum they need. So what would be the security implications
of always allowing a process to lower its hard limits?

Thanks,

[1] https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L4092
[2] https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L2465
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=791ec491c372f49cea3ea7a7143454a9023ac9d4

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

