Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A25C54E4A
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 09:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745B1206A3
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 09:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S54IxRX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgELJoK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 05:44:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23387 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726187AbgELJoJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 05:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589276648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=43RYyvEBnzR4zbheWuBXAGclh+rnN6/5KFGgPecxNqc=;
        b=S54IxRX3FKozbnvIi2PN+Sa+WxZaLhKWP0IiwrxailmbKlvOCc00XMjhgWAPyN2d6d/ENh
        DU7PZsNVl12PvNa1CRROzIKKYWhmPKw9teJ6G1dR82sbiZE+MuLLmIHgEoZXiGCzShaNJP
        L4PLu1NpPidXip+uFMDfqv6iwkgPGFY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-PhQd7iITMx22ThDOFSxllQ-1; Tue, 12 May 2020 05:44:03 -0400
X-MC-Unique: PhQd7iITMx22ThDOFSxllQ-1
Received: by mail-oi1-f200.google.com with SMTP id u64so13906942oie.22
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 02:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43RYyvEBnzR4zbheWuBXAGclh+rnN6/5KFGgPecxNqc=;
        b=NWluXPHlf5XFKEvB6MqCw8c2oZyQCjCrjvezC3hgH86Zc1M4uoDOsxjcwHfgSf5yZk
         //pUfZ/3yBiQgItMbCSTo4r+DoejlIUGWFeJu3MCDud0hXBSdvqgDTh5NvYnQf6aERgu
         CqmgcoMqMVprJD+I0sz5R2tP2hoBnSBVFf0xXe5PbCWqIgKPBr2v74a/qqrXCCD39y2u
         IMFJNP3+JbkBX8TsAROgtsXnwm0/SjXStG4pY4mGqqndwHiDut67L9mYeLA+JCQW5Oxp
         oCs1ocl0DBEuapnMLkVNC4dfC824gc3tGf4UMxFpg5mtKx/gNqsVTaFPmPU3qb466rNP
         9K3w==
X-Gm-Message-State: AGi0PubrxJcddl85JQLmi+X+NSke56WTlgeNxRqbR5UMgnFs2g8D7Zqt
        p9LrCZnfpjNnhU976TdUScqcc8VT72oyWvcG5w0PzmgIxEtavVDvVfvKY3wYNELJnIQ7iDRvQUe
        OOgui/U7Z292ycyfjQPjs8lwjdldyhkrZ8A==
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr16134284otq.66.1589276642360;
        Tue, 12 May 2020 02:44:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypI6LMKTzp3Dr9DTNHVXSuad5UBhgt3uDriDp/pOpTOLrjcbZQT5QV2I0IB9Yqkm+tqHBG0HtFo3MMs0n6ZhzOc=
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr16134274otq.66.1589276642121;
 Tue, 12 May 2020 02:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 12 May 2020 11:43:51 +0200
Message-ID: <CAFqZXNtA0PX9nKH0Growa9zwffyD6-yB0vJkbaHXTcp23p+ADw@mail.gmail.com>
Subject: Re: [PATCH v4 testsuite 00/15] Update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 8, 2020 at 5:42 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Update the selinux testsuite to work on Debian and provide
> instructions for building and running it there.
>
> v4 splits the patch into one patch per logical change, updates
> some of the descriptions, drops an unnecessary constraint
> (only appear to need the peer recv constraint from Fedora for
> the current tests, not the packet/SECMARK constraint), cleans up
> the Makefile, and updates the test for noexec dev to match
> any "/dev .*noexec" instead of just devtmpfs since not everyone
> uses devtmpfs.
>
> Stephen Smalley (15):
>   test_capable_net.te: remove corenet_tcp/udp_sendrecv_all_ports()
>   test_execute_no_trans.te: stop using mmap_file_perms
>   test_ibendport.te: use dev_rw_infiniband_mgmt_dev()
>   test_global.te: allow test domains to statfs selinuxfs
>   test_inet_socket.te: switch from generic_port to
>     _all_unreserved_ports()
>   test_sctp.te: make netlabel_peer_t a MCS-constrained type
>   test_policy.if: use ptynode instead of unconfined_devpts_t
>   test_overlayfs.te: allow test_overlay_mounter_t to read user tmp files
>   policy: Add MCS constraint on peer recv
>   policy: Add defaultrange rules for overlay tests
>   test_filesystem.te,tests/{fs_}filesystem: do not force user identity
>     to system_u
>   policy/Makefile: conditionalize setting of allow_domain_fd_use
>   tests/cap_userns: set /proc/sys/kernel/unprivileged_userns_clone if
>     needed
>   tests/mmap: skip /dev/zero tests if /dev is noexec
>   README.md: Add instructions for Debian

With the exception of 07/15, on which I had a small comment:

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

(No need to respin the whole series in case you are going to respin
07. I can just splice it in before merging or apply on top.)

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

