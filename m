Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F13CA90AF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 11:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED21206CC
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 11:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmjdPJ/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbgEML5q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 07:57:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728165AbgEML5q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 07:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589371064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JQEK+O3wp7rM/maOMlJMlNgOfllU5tadcTEX6ig2TdY=;
        b=OmjdPJ/TV8uCBTOwDojBqXa/eYrU9VJOGLHmidO4lOWCz1dHBl4EoglQh37P6OL/IUsk02
        goGFxHtLlqSiUicUdDivc+X6wthgr1+n8lZ7FlNHfhdxYLWsGGjfNbntF0FdLZI+u21YCB
        nAQYzUJdoM60APQQdrLCzpWFEHhue7g=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-C2mKjPG-NKaH_ET-QX4gZQ-1; Wed, 13 May 2020 07:57:39 -0400
X-MC-Unique: C2mKjPG-NKaH_ET-QX4gZQ-1
Received: by mail-oi1-f197.google.com with SMTP id n5so3686156oia.16
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 04:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQEK+O3wp7rM/maOMlJMlNgOfllU5tadcTEX6ig2TdY=;
        b=bu3Jtom04+FOGNFsKHO4rz/Mi/QkFBpc/dz/2iLMHyi8+03be5D6yzfnHvGcvdXrUM
         WqLRZlyImIMZcEdO1TnDA2HYshWwM5SZ4T6dOzXPVhaN3d6QRQUK4qzfBryv9VPfcXsT
         f70Fq5CZELFo6fbprBmWLdbGPLT4aBkP9yisgqYVYHUiDRgxc6KCpRAVXRuHIydS8Gz9
         C/136HkYLdVngc0mRWG8WW64k3+Oy1rt5XWnztTmfF+AEYb5yMRYYmtMyGMc3tXtbJqn
         KUFPW5WWFhw37xGn3QqlVg9liC5+WcxrqZzXmyRHWn/KJPdU2MMgBJpxMJwpHhBlRD6w
         2bGw==
X-Gm-Message-State: AGi0PuY31k8vENJquVcOA0DMrOFEgUyjjYw+mLVMSgCo8VIJjRSz46Bz
        1wP9Fyu79a/9JaSRAMZ5dLkcHIj0GteIshyAhuQ6wZEwtl84JGEf2JyAJSwVSIXRy5m5D5OCatv
        hnppGmcGe5fSmS6Ww/iiQE19FTF1PWQ6p7A==
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr19713886otb.367.1589371058062;
        Wed, 13 May 2020 04:57:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypJiFonrbxqOCxNhzU/13G46jhco4h36IjYyqOkISO6WHEJcNYjh37UYS+oUXHfgDj6rjVwbKVrmXG+6RawNqfw=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr19713877otb.367.1589371057827;
 Wed, 13 May 2020 04:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com> <CAFqZXNtA0PX9nKH0Growa9zwffyD6-yB0vJkbaHXTcp23p+ADw@mail.gmail.com>
In-Reply-To: <CAFqZXNtA0PX9nKH0Growa9zwffyD6-yB0vJkbaHXTcp23p+ADw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 13 May 2020 13:57:26 +0200
Message-ID: <CAFqZXNsX0r5=cxFrUFUU=5tSWVK06LfHWxusz3ZMp0=uOSqpug@mail.gmail.com>
Subject: Re: [PATCH v4 testsuite 00/15] Update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 12, 2020 at 11:43 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, May 8, 2020 at 5:42 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Update the selinux testsuite to work on Debian and provide
> > instructions for building and running it there.
> >
> > v4 splits the patch into one patch per logical change, updates
> > some of the descriptions, drops an unnecessary constraint
> > (only appear to need the peer recv constraint from Fedora for
> > the current tests, not the packet/SECMARK constraint), cleans up
> > the Makefile, and updates the test for noexec dev to match
> > any "/dev .*noexec" instead of just devtmpfs since not everyone
> > uses devtmpfs.
> >
> > Stephen Smalley (15):
> >   test_capable_net.te: remove corenet_tcp/udp_sendrecv_all_ports()
> >   test_execute_no_trans.te: stop using mmap_file_perms
> >   test_ibendport.te: use dev_rw_infiniband_mgmt_dev()
> >   test_global.te: allow test domains to statfs selinuxfs
> >   test_inet_socket.te: switch from generic_port to
> >     _all_unreserved_ports()
> >   test_sctp.te: make netlabel_peer_t a MCS-constrained type
> >   test_policy.if: use ptynode instead of unconfined_devpts_t
> >   test_overlayfs.te: allow test_overlay_mounter_t to read user tmp files
> >   policy: Add MCS constraint on peer recv
> >   policy: Add defaultrange rules for overlay tests
> >   test_filesystem.te,tests/{fs_}filesystem: do not force user identity
> >     to system_u
> >   policy/Makefile: conditionalize setting of allow_domain_fd_use
> >   tests/cap_userns: set /proc/sys/kernel/unprivileged_userns_clone if
> >     needed
> >   tests/mmap: skip /dev/zero tests if /dev is noexec
> >   README.md: Add instructions for Debian
>
> With the exception of 07/15, on which I had a small comment:
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> (No need to respin the whole series in case you are going to respin
> 07. I can just splice it in before merging or apply on top.)

All patches now applied (with v5 of 07/15).

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

