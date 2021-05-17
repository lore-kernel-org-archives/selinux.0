Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4345DC43460
	for <selinux@archiver.kernel.org>; Mon, 17 May 2021 13:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240A96128A
	for <selinux@archiver.kernel.org>; Mon, 17 May 2021 13:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhEQNrh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 May 2021 09:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235497AbhEQNrg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 May 2021 09:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621259179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O6gr94SKde4B9VQO2zKDR9PV8wUiJnB7z5q1aL8r6mE=;
        b=g6tnM7mXjTreJhnuhfR+kd5FMMVZoBuDUyt0tCcQfrnIL40c8n6YxnYnSHx8JoCkVWnKHP
        AAIUdkKsZnPyOM00f0bG+boBkRSpDGU4jUaANt43lB5/GUuEQuUHaX5ml7znnEv2jSLrrt
        0v/tkL8NMmOs6aBD+JNH3EZmC3j0kls=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-2FSvmcWlNJCygaiXKmBZ9g-1; Mon, 17 May 2021 09:46:18 -0400
X-MC-Unique: 2FSvmcWlNJCygaiXKmBZ9g-1
Received: by mail-yb1-f199.google.com with SMTP id i124-20020a25d1820000b029050f314917c0so2262024ybg.9
        for <selinux@vger.kernel.org>; Mon, 17 May 2021 06:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6gr94SKde4B9VQO2zKDR9PV8wUiJnB7z5q1aL8r6mE=;
        b=IsY9i66mo8Q66UOCAJJx6VQ1htQDuVe46j8H5AtfKG5uZunOhPVIxuqKJubXEdRw2j
         RL71BSAS+tKxBIKM6PIHCoYkewtryrzwkgZ7icLMhvcxerxoj7RhPcaK4h8pIjDLKs9V
         Gzs/Tq3qs4ie0oBE2UBXTq1Eu15TP/x4AgFdUSzXn+Kl3U69JxSU/5bBQI4ANqmSDH7w
         Pzv3GtnrNX0A7LGVDpCT6N72uZ9r+YsLWwHFMpvLDQGyGiIme8qA8+iQ/Qhfqjz8xitO
         tfls3FaqhKnODW1hZQbS1wZPPHaAIVLtbGutKWX9iPhI1DUwhaOGaWdExM8a1UOdEoCI
         i2aw==
X-Gm-Message-State: AOAM533vzVx51LVYukOHybmKp6bIRvQR7Sk2OSod3k3S+vI1zATLKwdR
        ChUiZ2dZ7WMG+J+633uUBVCC600PGabcIQidyvmiXc6Yl7pQCDBPQJlsZyD6VSjMZlh4rdWJXjF
        Jpf6m1NvgYXIlKYYKg0Q0fsS7gZhhRZSDQw==
X-Received: by 2002:a25:ed12:: with SMTP id k18mr18195728ybh.340.1621259177106;
        Mon, 17 May 2021 06:46:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwK+KojIQGBbY/tivk0bWRjrdOpNQ4CP1gdoVKuvMZGWmwJCCUScXooFAbY7pwFCMtgUCp0ALpfKPY3u5ezt4=
X-Received: by 2002:a25:ed12:: with SMTP id k18mr18195683ybh.340.1621259176769;
 Mon, 17 May 2021 06:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210409111254.271800-1-omosnace@redhat.com> <YHBITqlAfOk8IV5w@zeniv-ca.linux.org.uk>
 <CAFqZXNuhog5YfaG9CBVmZ+C3mSzAEgZkSC-mrQGOD4vyLEz4Xw@mail.gmail.com>
In-Reply-To: <CAFqZXNuhog5YfaG9CBVmZ+C3mSzAEgZkSC-mrQGOD4vyLEz4Xw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 17 May 2021 15:46:04 +0200
Message-ID: <CAFqZXNs6dVkAj4GYme1-COU-EvmTxRXAgS6oTUQpxxjNiamyzg@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs/security/NFS/btrfs: clean up and fix LSM option handling
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 9, 2021 at 7:39 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Apr 9, 2021 at 2:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Fri, Apr 09, 2021 at 01:12:52PM +0200, Ondrej Mosnacek wrote:
> > > This series attempts to clean up part of the mess that has grown around
> > > the LSM mount option handling across different subsystems.
> >
> > I would not describe growing another FS_... flag
>
> Why is that necessarily a bad thing?
>
> > *AND* spreading the
> > FS_BINARY_MOUNTDATA further, with rather weird semantics at that,
> > as a cleanup of any sort.
>
> How is this spreading it further? The patches remove one (rather bad)
> use of it in SELinux and somewhat reduce its use in btrfs.
>
> Hold on... actually I just realized that with FS_HANDLES_LSM_OPTS it
> is possible to do btrfs without FS_BINARY_MOUNTDATA and also eliminate
> the need for the workaround in vfs_parse_fs_param() (i.e. [2]).
>
> Basically instead of setting FS_BINARY_MOUNTDATA | FS_HANDLES_LSM_OPTS
> in btrfs_fs_type and neither in btrfs_root_fs_type, it is enough to
> set neither in btrfs_fs_type and only FS_HANDLES_LSM_OPTS in
> btrfs_root_fs_type. The security opts are then applied in the outer
> vfs_get_tree() call instead of the inner one, but the net effect is
> the same.
>
> That should pretty much do away with both the non-legit users of
> FS_BINARY_MOUNTDATA (selinux_set_mnt_opts() and btrfs). All the rest
> seem to be in line with the semantic.
>
> Would [something like] the above stand any chance of getting your approval?

So I posted this variant as v2 now:
https://lore.kernel.org/selinux/20210517134201.29271-1-omosnace@redhat.com/T/

>
> [2] https://lore.kernel.org/selinux/20210401065403.GA1363493@infradead.org/T/

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

