Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A357C433E1
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715C2206F5
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 15:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHxIBJZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgG3Pua (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3Pu3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 11:50:29 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678F7C061574
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 08:50:29 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id d21so5021933vke.8
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JL7d/GYAFB+5pG9vCEX85rXuP9tjsls1j3dhvO8t7ps=;
        b=eHxIBJZJyEDUcyYCgG8zUhvwQm3MmmdLN3Zd4P8cv5rHSkF15QerTSP+bch0tE6YPG
         NcUxPxvMTD4k7akyVaF348mZbdFB0tsjBIctFpPZSmUSXmKmN1Tqfi/xq0HneZGCmUpl
         u9BarQ45Jfb0U/gFzZ/40RsrPnFv/Ko46Lyd3Or2Dj+k2QUlyM9wBTRZtwIw520g6MnM
         ya87MAk8pmkK+iyFu62WhJZ+Dmnd0dIuFi3Gg0sYjhMaRcuqXhYvC+omB348ulsAad+3
         0O7zLPgtqQt0VLLiijtB0I+WYkALubc9RDbs/lbaFtxNkUwTGcwwJDpDirsjvWYiEU/c
         SpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JL7d/GYAFB+5pG9vCEX85rXuP9tjsls1j3dhvO8t7ps=;
        b=GpATV2WOn+bUVKF8G+v7JsI7Xfv30By7tNWZeHYT3WS3BB1QlzmZiMOmRYz/89alO4
         gDFIeyyeW9K029aL5m9RGDgDouJUfisyhaGKmcV3nmKBfKgjiXiuqg5j9DiAC+aMfLY6
         TG5tPQPnbi4+S1VJuVx9GGRqvthKZLie3GPztpK9cT5epcqXRA4oeTpeIuvIsOlKXUfJ
         rfX3v5Z3Ch6bBIa7D/vsGJciDNOmodksCOoGiVJcZV09mP20v9cOpWrOOQIcbj7lZi/M
         F85Vqb3fPDCJ9o5p6YmiUB3tjHOfeNCS763cRJCA9rNdGgPBNOVmpzjtRSRp14TFoPd6
         XCzQ==
X-Gm-Message-State: AOAM533LiRI26/PWFYOaHJjdsf3buEIGuCe+N9BNHQSTVb+esdXjbhrZ
        2ThZ8iSc9wugn2qJkmNw/y4uF3KPnL9vLn9KhuhPEA==
X-Google-Smtp-Source: ABdhPJxcDSv4VcG+eAEQec3WjYJ5ftdV7vKqbPySdbQ5H1zJPQ7M+8y+PVK8uKt6L6IlQuXJ9Jxtu16PzTngAuMTy9g=
X-Received: by 2002:ac5:cce9:: with SMTP id k9mr2598319vkn.17.1596124228344;
 Thu, 30 Jul 2020 08:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
 <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
 <CAHC9VhT1sGSpfCKojbKR+O2Hf_h+wnKnBwwSo09CbFaCYLcOHA@mail.gmail.com>
 <CA+zpnLecz_gvXYnrwNGW8SLaJsu==M_n9MuJgjqX9nPJtuTZBg@mail.gmail.com> <CAHC9VhReYQwxvHeJ8jAUKZ8P+N2yyGNN3rGRb_9t7hZpW=+HVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhReYQwxvHeJ8jAUKZ8P+N2yyGNN3rGRb_9t7hZpW=+HVQ@mail.gmail.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Thu, 30 Jul 2020 17:50:11 +0200
Message-ID: <CA+zpnLfgqY-ZgaBFoBN0_VATU-YM4jQ-1nBuD1Cv_nT-pqg9yQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     Paul Moore <paul@paul-moore.com>,
        peter enderborg <peter.enderborg@sony.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 28, 2020 at 6:20 PM Paul Moore <paul@paul-moore.com> wrote:
> I probably wasn't as clear as I should have been.  I think it would be
> helpful if you demonstrated how one would take the SELinux data in the
> perf event and translated that into something meaningful.

So the data itself is not that relevant. What is important is the
ability to hook the kernel at the right location, at the right time.
Here is an example on how this patch can be used on Android
(simpleperf is the Android equivalent of perf), running dmesg as the
shell user which is not permitted:
# simpleperf record -e selinux:selinux_denied -a -g --duration 10
# simpleperf report -g --full-callgraph
Cmdline: /system/bin/simpleperf record -e selinux:selinux_denied -a -g
--duration 10
Arch: arm64
Event: selinux:selinux_denied (type 2, config 493)
Samples: 1
Event count: 1

Children  Self     Command  Pid   Tid   Shared Object
                 Symbol
100.00%   0.00%    dmesg    3511  3511
/apex/com.android.runtime/lib64/bionic/libc.so  __libc_init
       |
       -- __libc_init
          |
           -- main
              toybox_main
              toy_exec_which
              dmesg_main
              klogctl
              el0_svc_naked
              sys_syslog
              do_syslog
              security_syslog
              selinux_syslog
              avc_has_perm
              slow_avc_audit
              common_lsm_audit
              avc_audit_pre_callback

You can see the combined user and kernel stacks which is useful to
understand where and why the denial happened.
The key point is that simpleperf is doing the heavy work (i.e names
resolution), while the kernel only shares the strict minimum for that
to happen.
This can be correlated with the pid of the avc denial message (I'm
assuming we are trouble shooting one specific denial).

It is also possible to manually use ftrace. For instance, after
enabling and triggering the denial:
bonito:/sys/kernel/debug/tracing # cat trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
           dmesg-3624  [001] .... 13072.325358: selinux_denied: denied
pid=3624 tclass=4 audited=2

This can be correlated with the following avc denial:
[ 2180.183062] type=1400 audit(1596111144.026:27): avc: denied {
syslog_read } for comm="dmesg" scontext=u:r:shell:s0
tcontext=u:r:kernel:s0 tclass=system permissive=0
Here, there is limited value of having that tracepoint as we are only
duplicating the avc message content.

Nevertheless, the filtering part of Peter's patch would be useful to
be more precise on which denial we are targeting (I'll reply to the
other thread as well).
I hope this clarifies the usage. Thanks.
