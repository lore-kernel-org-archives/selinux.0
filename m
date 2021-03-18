Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC07C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 09:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25D264E61
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 09:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCRJ6X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 05:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229805AbhCRJ54 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 05:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616061476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=BH8P3EYwMkhigavw/TWThSE0zfS9S0sF0ekK5ILeyYM=;
        b=WfYT4mP1EIQAxHF/oA/MLLCtMeLlbFKblN7zXYzN04cL6uR3Xq7RKXlQE6YMlEO7NXq58c
        3UqRUzv+yL81oWxucngLCrNArRqrnVY4PUEKVyT1RR0MkeMzxeAl/u7r7u6oZ9oJKgBsOT
        HsT07wOoDkHDkMFkM7a9A8WFFsaYmuQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-ph1nkiqPOMCcUfMrC9f0dA-1; Thu, 18 Mar 2021 05:57:53 -0400
X-MC-Unique: ph1nkiqPOMCcUfMrC9f0dA-1
Received: by mail-yb1-f197.google.com with SMTP id t1so882567ybq.1
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 02:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BH8P3EYwMkhigavw/TWThSE0zfS9S0sF0ekK5ILeyYM=;
        b=DsAtb/9/xJ/SfbyVENQrFZhdVqNJSbYHAGv1xedf3S+/kjB4EWD8Kj+7y1Eaw5mE5K
         XG5lrNU+0dlg0kmvBYCVxY6T5JwTuzhfyKiGvbTCPXwmpo8sBbTbvoGFikwKkBs2rP3w
         u2lHbhNZNqx4ZZHAHNgfk35KFOVHzCn8Iy8xdNFmIgtVlsS2m+o+HHL1vpEPFnCguUSt
         nJPvoaRZSaOleBLBWhbwOP7KlxpvrwVgpf69jpfPghfWthXYOiAS0YqwPZu/wDszFgUx
         P6eSTgetuHM92vnXZ3mEN4SBv32pb+mar4RT4X8jHkqhaY90EmaD0am5ssPgcqpQBRW+
         ETBg==
X-Gm-Message-State: AOAM531B1d7qXX0oSFNA9zTJFGk6GttGBnQ5F+rvTHtsziMihsKsYcNZ
        SkpRsE7P87cvtqzj19vAy8E54BjFVT7TXY1pM22F1AeXcyUvFPk6ls2VFqBmoD3UkTCNZA1lfJ1
        M7Eap69fR3rBMUYKq85R2KoLCxINaw1uvjA==
X-Received: by 2002:a5b:4a:: with SMTP id e10mr10724783ybp.436.1616061472516;
        Thu, 18 Mar 2021 02:57:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznWNgF+UqmwE0Vr1txYDJ6H9GSN5dwdTDRlHV9zJ2OgaCU49sN0AIkEpEkg4SrDkEi0koa5JJbYSDTwXVPM1c=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr10724770ybp.436.1616061472336;
 Thu, 18 Mar 2021 02:57:52 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 18 Mar 2021 10:57:40 +0100
Message-ID: <CAFqZXNvotgdUEvLBfbUNsU1ZNLYvrjO3N8ygyLo45-336u4=ZA@mail.gmail.com>
Subject: Weird bug in NFS/SELinux
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

While trying to figure out why the NFS tests in the selinux-testsuite
[1] are failing, I ran into this strange bug: When I mount an NFS
filesystem on some directory, and then immediately attempt to create
exactly the same mount on the same directory (fails with -EBUSY as
expected per mount(2)), then all the entries inside the mount (but not
the root node) show up as unlabeled
(system_u:object_r:unlabeled_t:s0). For some reason this doesn't
happen if I list the directory contents between the two mounts.

It happens at least with kernels 5.12-rc2 and 5.8.6, so it's likely an old bug.

Minimal reproducer (assumes an SELinux-enabled system and that nothing
is mounted at /etc):
```
# set up a trivial NFS export
systemctl start nfs-server
exportfs -o rw,no_root_squash,security_label localhost:/

#
# reference scenario - single mount
#
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt

ls -lZ /mnt    # labels are correct
ls -lZd /mnt   # label is correct

#
# double mount - BUG
#
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt

ls -lZ /mnt    # all labels are system_u:object_r:unlabeled_t:s0
ls -lZd /mnt   # label is correct

#
# double mount with ls in between - OK
#
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
ls -lZ /mnt    # labels are correct
ls -lZd /mnt   # label is correct
mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt

ls -lZ /mnt    # labels are correct
ls -lZd /mnt   # label is correct
```

I haven't had time to dig deeper. Hopefully someone who knows the
internals of NFS will be able to find the root cause easier than me...

[1] https://github.com/SELinuxProject/selinux-testsuite/

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

