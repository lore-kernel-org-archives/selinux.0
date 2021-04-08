Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4447FC433B4
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 10:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCD0610FB
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 10:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhDHKA4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 06:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhDHKAz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 06:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617876044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xkqOx5BZaGmSmZbKiIeuRf8bJP1j9FK4DbJUxTUIKFk=;
        b=g6d+QOJLqTVaQIiOVDDWeMwBggmr2/GyUlfVNoEgu9HjOw1Cu8yqUPrN7xJDpTBPlC5K1P
        8pddDjZcn7scxQe2HnjQNPGofnNa7hA+et6QFlkyydF4CpPUCwbM45qBcQy9IVrchSS199
        rT1ukGEJqdkFcWC7S87elnzZixsuntY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-sXtYLawdPgyMAZP6l-KERg-1; Thu, 08 Apr 2021 06:00:41 -0400
X-MC-Unique: sXtYLawdPgyMAZP6l-KERg-1
Received: by mail-yb1-f199.google.com with SMTP id n67so1631425ybf.11
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 03:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkqOx5BZaGmSmZbKiIeuRf8bJP1j9FK4DbJUxTUIKFk=;
        b=BvYjtVlT/i3j86C2qKzzNgTztDDzt+aHbjSSRX04k3gtMHAaX7gFDWkS/Z0YQqHyOj
         3EYAkZn/tJGrLCU1diYBVYCkIoYXDSj1ldWN+2dAcQgRJjfa92/9Bb/HPr4USO/VpdDN
         3Iq8O9K66KZTDHf2f+jCoG8FgmtKcbkrdbcnM2egJQplqw7NkS2w9KzIJ4TQqtUiULkU
         EzgJcjr0m34RrqSIpb/fPanEHG5VRIC/ePmrnFBxIJKGDpJiHxmp91Tp4Ydfn7INrtZ4
         bA91OnAUrjcPdVdcmnn29kj0+Wb6esykEY/hEmiWNCtoT7T98WcvCwOOFPXcQhRsp353
         brxQ==
X-Gm-Message-State: AOAM530YX7O5CQzT/i8yoBqGun7KsvIB7bmyXSDbgml71gTih0bXGw+m
        xA2K5Hdp2U+sPJTAQiK8LlhAvWLUOIKM4JuHbf+ji9Pv+cKmynEp3K0YWkpulne51WRiedHDvni
        cPADVhgtDTQ8YTm0444oJhJTpDwKTpbStMQ==
X-Received: by 2002:a5b:8c9:: with SMTP id w9mr10902109ybq.289.1617876041242;
        Thu, 08 Apr 2021 03:00:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+8UMHOxF6+C/Xwraf9++IqpSr+miGT0Rww/VAHvnoer6VM/3hIYCA0Cby5R6RKHNglA8OpmCiBaI4PnO1LAs=
X-Received: by 2002:a5b:8c9:: with SMTP id w9mr10902085ybq.289.1617876041022;
 Thu, 08 Apr 2021 03:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210406111022.2472280-1-omosnace@redhat.com> <CA+EESO6p+KuHC+6v3BjsWPNPqNBSmCFBz+T_eG5wLtDXZOKpbw@mail.gmail.com>
In-Reply-To: <CA+EESO6p+KuHC+6v3BjsWPNPqNBSmCFBz+T_eG5wLtDXZOKpbw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 8 Apr 2021 12:00:27 +0200
Message-ID: <CAFqZXNusU6TMSCWH4=S8Dnngux_Nbcg1qR_vp6xY6tk4gi=VNA@mail.gmail.com>
Subject: Re: [PATCH testsuite] Deactivate userfaultfd test policy if no xperm support
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 6, 2021 at 6:16 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
>
>
> On Tue, Apr 6, 2021 at 4:40 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>
>> The userfaultfd test policy uses also extended permissions, so only
>> enable the test or its policy if these are supported. This makes the
>> testsuite runnable on certain old distros again.
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
>
> Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>

Thanks, I just merged the patch:
https://github.com/SELinuxProject/selinux-testsuite/commit/1defa850ae71bc27c9dd101d19f543a42abc9537

BTW, for some reason your message didn't end up on the mailing list...
it seems the vger lists are acting up again :/

>>
>> ---
>>  policy/Makefile | 9 +++++++--
>>  tests/Makefile  | 2 ++
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/policy/Makefile b/policy/Makefile
>> index b092bb3..91364d5 100644
>> --- a/policy/Makefile
>> +++ b/policy/Makefile
>> @@ -29,14 +29,19 @@ TARGETS = \
>>         test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
>>         test_transition.te test_unix_socket.te \
>>         test_mmap.te test_overlayfs.te test_mqueue.te \
>> -       test_ibpkey.te test_atsecure.te test_cgroupfs.te test_userfaultfd.te
>> +       test_ibpkey.te test_atsecure.te test_cgroupfs.te
>>
>>  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>>  SUPPORTS_CIL = n
>>  endif
>>
>>  ifeq ($(SUPPORTS_CIL),y)
>> -CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil test_userfaultfd.cil
>> +CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
>> +# userfaultfd test policy uses also xperms
>> +ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
>> +CIL_TARGETS += test_userfaultfd.cil
>> +TARGETS += test_userfaultfd.te
>> +endif
>>  ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
>>  ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
>>  # If other MLS tests get written this can be moved outside of the glblub test
>> diff --git a/tests/Makefile b/tests/Makefile
>> index c19fcd7..7d4e39b 100644
>> --- a/tests/Makefile
>> +++ b/tests/Makefile
>> @@ -135,9 +135,11 @@ SUBDIRS += watchkey
>>  endif
>>  endif
>>
>> +ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
>>  ifeq ($(shell test -e $(INCLUDEDIR)/linux/userfaultfd.h && echo true),true)
>>  SUBDIRS += userfaultfd
>>  endif
>> +endif
>>
>>  ifeq ($(DISTRO),RHEL4)
>>      SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
>> --
>> 2.30.2
>>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

