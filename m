Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80CCC4361B
	for <selinux@archiver.kernel.org>; Sat, 19 Dec 2020 11:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC5B233A2
	for <selinux@archiver.kernel.org>; Sat, 19 Dec 2020 11:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgLSLOU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Dec 2020 06:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbgLSLOT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 19 Dec 2020 06:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608376372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NkKxD14BTxc8KsjSCUrd7RJBgO1Js5kVPiaZwEefDiQ=;
        b=Ky2MrK7dTMn5Y10uuUqJ0gDLh6hRKCt/h0x+GKaUsP0K5HD1l04sSyfptRfI/xYIDynvAH
        FXYozluEXJ5bX1bG6ZfVcQ+J+L3jOHlBgNecM/zEl2iZ9tpTPT1uztgRx8mMxUM7WCO69Y
        NNRXpiNC2peUx3n+g9ZPHnOf64ijHDc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-mVqxX6vlN5unTA6Z8Fg3Zw-1; Sat, 19 Dec 2020 06:12:49 -0500
X-MC-Unique: mVqxX6vlN5unTA6Z8Fg3Zw-1
Received: by mail-lf1-f72.google.com with SMTP id b11so3270474lfj.21
        for <selinux@vger.kernel.org>; Sat, 19 Dec 2020 03:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkKxD14BTxc8KsjSCUrd7RJBgO1Js5kVPiaZwEefDiQ=;
        b=Nbizn0B0D6EeVCX57z11qHjiOPPtoMt4smhGzAe8/QyRAwf7iUFoGTWZ56VLw2MwuE
         eYVVc7qg0fEhujbWSIqUvc/N0wTPywsz/4C1tyugJCL4shRCz7BN4e3O534GF1OxB30d
         4Pu7ZKnsOvMd4dq0PA8kaSn9est3o8+e+zhNitSHcxWsEK3ExHbVKJZUdkwpd80w3ZGf
         /xKVkI1XEczLNJ8eIjcmLreMmXVqJOs9fRIkUfvOcb9tkD3ytCiqkxmOPgJJSZ10gxqj
         6jmj0Fn2FPoDxy/olsW77i9qEsE9IgJ0kJq76wTkxJVlivEsP55fGHRnzK8N7XZ11qrt
         JanA==
X-Gm-Message-State: AOAM5339B73pTii4ipfFswTEkGtRImPd42axXFMLYhs3ETcMy/K5s97L
        YZc82eYfidMCZ1U14o6OuaWyoQklAH9ggpIcbok90i3qzJPciOJbkSG8L9bWeXyn4Q0bKAbjMh5
        IltrkYWtMrgGkmL5OS5T4Q4vSHzZB7XXttg==
X-Received: by 2002:a19:8213:: with SMTP id e19mr2991142lfd.600.1608376367398;
        Sat, 19 Dec 2020 03:12:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQyXrMuGmXiMXwI4bI70s/Ri2zwhuFvj4jhXjbG6okE8QhXoIK1aw8c2Nm2HjHAOtq4FyVS8FXW97CulpVbrQ=
X-Received: by 2002:a19:8213:: with SMTP id e19mr2991137lfd.600.1608376367168;
 Sat, 19 Dec 2020 03:12:47 -0800 (PST)
MIME-Version: 1.0
References: <X9vP2uwRZb1l1ySE@server-build.lan>
In-Reply-To: <X9vP2uwRZb1l1ySE@server-build.lan>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 19 Dec 2020 12:12:30 +0100
Message-ID: <CAFqZXNtvY4tJnH07wNvTGuynzGYQQrwVQiXVWBTDfzWUPCWpsw@mail.gmail.com>
Subject: Re: [kernel-secnext] Automated Testing Results Linux
 5.11.0-0.rc0.20201217gite994cc240a3b.102.1.secnext.fc34.x86_64 [12/17/2020 16:38]
To:     Paul Moore <paul@paul-moore.com>
Cc:     kernel-secnext@googlegroups.com,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 17, 2020 at 10:38 PM <paul@paul-moore.com> wrote:
>
> SYSTEM: test-rawhide-1.lan
> DATE: Thu, 17 Dec 2020 16:38:34 -0500
>
> KERNEL: Linux 5.11.0-0.rc0.20201217gite994cc240a3b.102.1.secnext.fc34.x86_64
>
>    audit-testsuite: PASS
>  selinux-testsuite: FAILED
>
> ### START AUDIT TEST LOG
> Running as   user    root
>         with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>         on   system  Fedora
>
> exec_execve/test ......... ok
> exec_name/test ........... ok
> file_create/test ......... ok
> file_delete/test ......... ok
> file_rename/test ......... ok
> filter_exclude/test ...... ok
> filter_saddr_fam/test .... ok
> filter_sessionid/test .... ok
> login_tty/test ........... ok
> lost_reset/test .......... ok
> netfilter_pkt/test ....... ok
> syscalls_file/test ....... ok
> syscall_module/test ...... ok
> syscall_socketcall/test .. ok
> time_change/test ......... ok
> user_msg/test ............ ok
> fanotify/test ............ ok
> bpf/test ................. ok
> All tests successful.
> Files=18, Tests=200, 28 wallclock secs ( 0.08 usr  0.06 sys +  3.77 cusr  5.35 csys =  9.26 CPU)
> Result: PASS
> ### END TEST LOG
>
> ### START SELINUX TEST LOG
> Compiling targeted test_policy module
> Creating targeted test_policy.pp policy package
> domain_fd_use --> on
> Running as user root with context unconfined_u:unconfined_r:unconfined_t
>
> domain_trans/test ........... ok
> entrypoint/test ............. ok
> execshare/test .............. ok
> exectrace/test .............. ok
> execute_no_trans/test ....... ok
> fdreceive/test .............. ok
> inherit/test ................ ok
> link/test ................... ok
> mkdir/test .................. ok
> msg/test .................... ok
> open/test ................... ok
> ptrace/test ................. ok
> readlink/test ............... ok
> relabel/test ................ ok
> rename/test ................. ok
> rxdir/test .................. ok
> sem/test .................... ok
> setattr/test ................ ok
> setnice/test ................ ok
> shm/test .................... ok
> sigkill/test ................ ok
> stat/test ................... ok
> sysctl/test ................. ok
> task_create/test ............ ok
> task_setnice/test ........... ok
> task_setscheduler/test ...... ok
> task_getscheduler/test ...... ok
> task_getsid/test ............ ok
> task_getpgid/test ........... ok
> task_setpgid/test ........... ok
> file/test ................... ok
> ioctl/test .................. ok
> capable_file/test ........... ok
> capable_net/test ............ ok
> capable_sys/test ............ ok
> dyntrans/test ............... ok
> dyntrace/test ............... ok
> bounds/test ................. ok
> nnp_nosuid/test ............. ok
> mmap/test ................... ok
> unix_socket/test ............ ok
> inet_socket/test ............ ok
> overlay/test ................ ok
> checkreqprot/test ........... ok
> mqueue/test ................. ok
> mac_admin/test .............. ok
> atsecure/test ............... ok
> cap_userns/test ............. ok
> extended_socket_class/test .. ok
> sctp/test ................... ok
> netlink_socket/test ......... ok
> prlimit/test ................ ok
> binder/test ................. ok
> bpf/test .................... ok
> keys/test ................... ok
> key_socket/test ............. ok
> glblub/test ................. ok
> infiniband_endport/test ..... ok
> infiniband_pkey/test Yeah........ ok
> cgroupfs_label/test ......... ok
> module_load/test ............ ok
> tun_tap/test ................ ok
>
> #   Failed test at perf_event/test line 61.
> # Looks like you failed 1 test of 9.
> perf_event/test .............
> Dubious, test returned 1 (wstat 256, 0x100)
> Failed 1/9 subtests

So as you can see, we finally added the perf_event class to Fedora
policy :) (at least that one for a start...)

The failure seems to be caused by the introduction of CAP_PERFMON (and
the fact that we haven't yet added *that one* to the policy...). I'll
try to come up with a patch, but it probably won't happen until next
year, so if someone wants to have a go at it, they are of course free
to do so :)

> filesystem/ext4/test ........ ok
> filesystem/xfs/test ......... ok
> filesystem/jfs/test ......... ok
> filesystem/vfat/test ........ ok
> fs_filesystem/ext4/test ..... ok
> fs_filesystem/xfs/test ...... ok
> fs_filesystem/jfs/test ...... ok
> fs_filesystem/vfat/test ..... ok
> watchkey/test ............... ok
>
> Test Summary Report
> -------------------
> perf_event/test           (Wstat: 256 Tests: 9 Failed: 1)
>   Failed test:  2
>   Non-zero exit status: 1
> Files=72, Tests=1226, 276 wallclock secs ( 0.46 usr  0.29 sys + 11.69 cusr 77.38 csys = 89.82 CPU)
> Result: FAIL
> Failed 1/72 test programs. 1/1226 subtests failed.
> make[1]: *** [Makefile:162: test] Error 255
> make: *** [Makefile:8: test] Error 2
> ### END TEST LOG
>
> --
> You received this message because you are subscribed to the Google Groups "kernel-secnext" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-secnext+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-secnext/X9vP2uwRZb1l1ySE%40server-build.lan.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

