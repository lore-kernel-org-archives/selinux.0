Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47952C4361B
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F9323372
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 14:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgLGOog (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 09:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgLGOog (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 09:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607352189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VjXd09VYmbE4d0LNTmaeKQ/DhBdnWs2YOaxPT936BQM=;
        b=ATQZVSJ9JavkmPzDI3vfN3fRuuDkUltBSHyNuZnbWakbesPelRMVChFQdo2UPhT/UabaKx
        7uWhIuaKrLIP1jUlXn2g6H2bRLxtv2C/XqZIxHBWiv9DJiF4NwOtvdAGaCShPotxleCsHA
        ahGj5KsL6MvKqHFjUVsXonbLeUK0LCA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-tN864yulPia10zGyCTAn9Q-1; Mon, 07 Dec 2020 09:43:06 -0500
X-MC-Unique: tN864yulPia10zGyCTAn9Q-1
Received: by mail-lf1-f69.google.com with SMTP id 74so2856052lfg.20
        for <selinux@vger.kernel.org>; Mon, 07 Dec 2020 06:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VjXd09VYmbE4d0LNTmaeKQ/DhBdnWs2YOaxPT936BQM=;
        b=OqetSl6eFAdnfhHbwS9LzeoZ6vJYhxrEbzh7gcwU16G5NmJO7E+4DG685WMM3j3lRB
         z8jXG42hYesJW4y7VfWGdkUW8F+Im7yHBZcHUJpmob0LvmkJwZqj+ugXwB+W7wbcPzO9
         HrzBv/yI1JE8jnrbxW/2ik9SVW2wbLdtF9Mv5yFBxn9GWXGDWPM97bUDZUc0sNl7Jpf6
         hmGZdPPhHKK2V7Ma/90iJ5KfPbPcktwr2Do/RMKyXKwqR7pBtS4CkiqX88FUuQo4GSbx
         ud4eEgC1w/L2HKkEYnTHP8RHEZGISKDu1jyn5P2TT2ydc42qdgcT+jBbclvlU98R8LMm
         LU6g==
X-Gm-Message-State: AOAM531iTj69xOwaJPyyhasgM1eOh9KlSZBHygH/QV6fRYLb/Q9Nt1Y6
        c/+oLxtl4hAQHJN/jASgTqN9W3KIvQQHq9H+O85R5ClIEv9y0zb88n1Iz4o52uiEyOHZVjxFlWs
        E0/8RhfXm2YbiIEzD0BS06NqhsInltQ4P7w==
X-Received: by 2002:a2e:94d0:: with SMTP id r16mr3401750ljh.123.1607352184415;
        Mon, 07 Dec 2020 06:43:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznhM+sqkZZXGGLO4UDwJOXUvjz50Zr8HlmbHWnoKEVQ8CduevM7RMdG+S7SqqRmeyHGxLZaSINSLNDBlL5Ywo=
X-Received: by 2002:a2e:94d0:: with SMTP id r16mr3401740ljh.123.1607352184224;
 Mon, 07 Dec 2020 06:43:04 -0800 (PST)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 7 Dec 2020 15:42:53 +0100
Message-ID: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
Subject: virtiofs and its optional xattr support vs. fs_use_xattr
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi everyone,

In [1] we ran into a problem with the current handling of filesystem
labeling rules. Basically, it is only possible to specify either
genfscon or fs_use_xattr for a given filesystem, but in the case of
virtiofs, certain mounts may support security xattrs, while other ones
may not.

So we can't use the xattr support by adding fs_use_xattr virtiofs
(...); to the policy, because then a non-xattr mount will fail
(SELinux does a mount-time check on the root inode to make sure that
the xattr handler works), but we also don't want to stay on genfscon,
because then we can't relabel files.

So my question is how to best address this? One option is to use a
similar "hack" as for cgroupfs; i.e. do a kind of mixed genfs-xattr
labeling, but that's ugly and requires hard-coding another FS name in
the selinux code. The only other alternative I could come up with is
to add a new FS labeling statement that would specify some kind of
mixed genfscon / fs_use_xattr behavior. That would be a better
long-term solution, but leads to more questions on how such statement
should actually work... Should it work the cgroupfs way, giving a
default label to everything and allowing to set/change labels via
xattrs? Or should it rather just detect xattrs support and switch
between SECURITY_FS_USE_XATTR and SECURITY_FS_USE_GENFS behavior based
on that? In the latter case, should the statement specify two contexts
(one for fs_use_xattr and another one for genfscon) or just one for
both behaviors?

Any thoughts/pointers welcome.

[1] https://github.com/fedora-selinux/selinux-policy/pull/478

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

