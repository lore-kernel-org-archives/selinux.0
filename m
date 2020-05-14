Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A180C433E0
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 08:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A071206B6
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 08:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmEvQuI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgENIui (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 04:50:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725925AbgENIui (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 04:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589446236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7t18TPsr0mP0nFuykwheN8038FeKc7oNaLxAsJ1EF0=;
        b=VmEvQuI7M/N3YUrYB84ub7ip5R0bFWMqQmYh/Tcihaoyp3ldVtD2cUVydrIM0qeQQj9i7Y
        OxJ3bnwwCQ2hmm0goUkeNx3yu8ZY7UGxKE/YzDEx+fkOuKveyuo0Fr9aGC9jKBx62vrWI8
        17v/6OTESQc6irZpILD0+jAj9zzKDFo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-Hdko1OKEN6SfL_ptwtogog-1; Thu, 14 May 2020 04:50:34 -0400
X-MC-Unique: Hdko1OKEN6SfL_ptwtogog-1
Received: by mail-oi1-f198.google.com with SMTP id j19so4952610oie.18
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 01:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7t18TPsr0mP0nFuykwheN8038FeKc7oNaLxAsJ1EF0=;
        b=ZorXoLNtXEf/Gb6La1VhxF5wNvcFb9Sn3UWj+SI5Bkqy5YKbX0/CQ2+rAIrbWjLg1d
         C2FG6YxYQrzsQ954FOUp0ziWWHKODtGg+ajvbjqoU0JC434cRLUQMH2kicpz+3lehFng
         hAnyat3a7x8uzQHXtTKBlIDJwKFdt50DMjd8WDb15jhL5wSX6oXV4I43s4sS9BRuXU1/
         yoTOiFc6G0x/vxc3Lv81llnRdqwljCv4aK61HtCw+Fqh827SU61DlZYQd7cDAmXiSsG8
         Mds1wAqg6Y3of371OwZUKo4BKz0qlNR93cdoYA2qzLGmXCl+NjoMKVlvXTduZ9uB45YI
         2ysw==
X-Gm-Message-State: AOAM533vfPjA2fAjq/Mz5RLW+G32x3hD2amL3bAFt9dMnjvOU0LbeTPA
        6kW12JqrssAISXGuQzdAzG9HjZ778Dqk+g30HFNxfv1TXJacAYJ67GwLzD1dYlDT3RYu1PTG8Xa
        khCgXIZvodD7lBirsti5VVjgRmvcU2V0edQ==
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr2782382ooo.58.1589446233788;
        Thu, 14 May 2020 01:50:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPPKD+if/szTthCQf23/t9xcxRdHc9gMDbmlT4ypqpQ81Zj1Le1OEPiPpqc7y+NU9VEqXog5yYguA4/VokTLo=
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr2782371ooo.58.1589446233450;
 Thu, 14 May 2020 01:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200417163804.307854-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200417163804.307854-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 14 May 2020 10:50:22 +0200
Message-ID: <CAFqZXNtrXaYR3tJ1awcu6_CAG=syA0GqcHg+UTCZQFpQv3hY-w@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux-testsuite: Add check for key changes on watch_queue
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        David Howells <dhowells@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 17, 2020 at 6:38 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Kernel 5.7 introduced the watch_queue service that allows watching for
> key changes. This requires key { view } permission, therefore check if
> allowed or not.
>
> Note that the keyctl_watch_key() function is not yet built into the
> keyutils library, therefore a syscall() is used.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

OK, so I tried to build kernel RPMs(*) from the linux-next tree and
try out this patch, but I ran into a few problems:
1. <linux/watch_queue.h> includes <linux/fcntl.h>, which conflicts
with glibc's <sys/fcntl.h>. This will maybe get fixed in glibc/kernel
eventually, but I can't apply the patch as-is (maybe we can #define
_LINUX_FCNTL_H before including <linux/watch_queue.h> as a temporary
workaround?).
2. Even when I got the test program to build, the test failed. I ran
out of time to dig further, but it may be due to the issues I spotted
later in the test policy (see below).

(*) I wanted to try out the new Fedora's kernel build machinery, so I
burnt too much time on this... but I now have a semi-automated way to
build linux-next kernels as RPMs, which might come in handy in the
future :)

> ---
>  defconfig                 |   5 ++
>  policy/Makefile           |   2 +-
>  policy/test_watchkey.te   |  34 ++++++++++++
>  tests/Makefile            |   4 ++
>  tests/watchkey/.gitignore |   1 +
>  tests/watchkey/Makefile   |   7 +++
>  tests/watchkey/test       |  29 ++++++++++
>  tests/watchkey/watchkey.c | 113 ++++++++++++++++++++++++++++++++++++++
>  8 files changed, 194 insertions(+), 1 deletion(-)
>  create mode 100644 policy/test_watchkey.te
>  create mode 100644 tests/watchkey/.gitignore
>  create mode 100644 tests/watchkey/Makefile
>  create mode 100755 tests/watchkey/test
>  create mode 100644 tests/watchkey/watchkey.c
>
> diff --git a/defconfig b/defconfig
> index 0574f1d..9afbc2f 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -78,3 +78,8 @@ CONFIG_KEY_DH_OPERATIONS=y
>  # Test key management socket.
>  # This is not required for SELinux operation itself.
>  CONFIG_NET_KEY=m
> +
> +# watch_queue for key changes.
> +# They are not required for SELinux operation itself.
> +CONFIG_WATCH_QUEUE=y
> +CONFIG_KEY_NOTIFICATIONS=y
> diff --git a/policy/Makefile b/policy/Makefile
> index 87b2856..b3f5e3d 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -86,7 +86,7 @@ TARGETS += test_bpf.te test_fdreceive_bpf.te test_binder_bpf.te
>  endif
>
>  ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && echo true),true)
> -TARGETS += test_keys.te
> +TARGETS += test_keys.te test_watchkey.te
>  endif
>
>  ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
> diff --git a/policy/test_watchkey.te b/policy/test_watchkey.te
> new file mode 100644
> index 0000000..e1d4c78
> --- /dev/null
> +++ b/policy/test_watchkey.te
> @@ -0,0 +1,34 @@
> +#
> +######### Check watch_queue for key changes policy module ##########
> +#
> +attribute watchkeydomain;
> +
> +################# Allow watch_queue key { view } ##########################
> +type test_watchkey_t;
> +domain_type(test_watchkey_t)
> +unconfined_runs_test(test_watchkey_t)
> +typeattribute test_watchkey_t testdomain;
> +typeattribute test_watchkey_t keydomain;

You declare attribute "watchkeydomain" above and later call some
interfaces on it, but assign all the types to "keydomain". I assume
you meant to assign them to "watchkeydomain"?

> +
> +allow test_watchkey_t self:capability { ipc_lock };
> +allow test_watchkey_t device_t:chr_file { ioctl open read write };
> +allow test_watchkey_t self:key { view };
> +allow_map(test_watchkey_t, device_t, chr_file)
> +
> +################# Deny watch_queue key { view } ##########################
> +type test_watchkey_no_view_t;
> +domain_type(test_watchkey_no_view_t)
> +unconfined_runs_test(test_watchkey_no_view_t)
> +typeattribute test_watchkey_no_view_t testdomain;
> +typeattribute test_watchkey_no_view_t keydomain;
> +
> +allow test_watchkey_no_view_t self:capability { ipc_lock };
> +allow test_watchkey_no_view_t device_t:chr_file { ioctl open read write };
> +neverallow test_watchkey_no_view_t self:key { view };
> +allow_map(test_watchkey_no_view_t, device_t, chr_file)
> +
> +#
> +########### Allow these domains to be entered from sysadm domain ############
> +#
> +miscfiles_domain_entry_test_files(watchkeydomain)
> +userdom_sysadm_entry_spec_domtrans_to(watchkeydomain)
[...]

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

