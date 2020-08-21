Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3825C433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0982063A
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 15:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNwFlwjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHUPdw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgHUPdi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 11:33:38 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2DDC061573;
        Fri, 21 Aug 2020 08:33:37 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v6so1849709ota.13;
        Fri, 21 Aug 2020 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0UODExHNr70hBlkw5NoS5M2zRCjpoudfpEgGYewpYzs=;
        b=GNwFlwjsiQxOVZviBYqlzbDjeXaxMBoPCAKXZVtOFmIvyuZ+huJwdDvOja03AHtGt2
         0KnvciGXYm9+XVry8EWqq5D4Z8/qAeFs9X6Q8s5guGEHnhbVGfFDdPbKcetmLnlZnhQF
         S22FTMIHJoUzOJVOJczmL/WeK1fa6ogypu41P0M8KpkcioYvYbbfIGmtW186JpCNk5Eb
         OGvEMDRxL94maTmzwF7Ct57rq9lsoXPW8ZleHDPUYl08ovc8zXQ53YoJMFaa12Qlk0Xn
         dsrTdYHkqQex3f8K0IqoSQIxNAaRUTg3M4YyTLuHdbNaoAmfNgZil3wzjoKffSMnDf00
         KCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0UODExHNr70hBlkw5NoS5M2zRCjpoudfpEgGYewpYzs=;
        b=e7eWNYb5yiBMcNMHTiPjMX11ip9aaQiHHFC2hzuq065Rc3bzl+Y9MPKxx2rtogm+KK
         ysNv69r/ac3shc3ynuQ5ovG3OBmZcinbEs/3qdgpnpyibGG4qVGLFvzZOR2rXznB1Fcb
         A9RDNUGg/YFCt6siNryz9pxUTt2F8jDyBXeDeWDQZllQyWMo8b4PGNnLNWRa2jDmb+sU
         DPfBZgPiITlCUWJknuTn39NDdif2I4xJr5qIMwFhfMKR5DPrmeQ1bxO2rkkMtmbel25B
         w6Bqu+1q1a7zdQc/m3xUb5740EYgG3Qk9Im8gT3SRvI3VJq4WL9CJxcDx9OzoSGu2dhT
         2AAA==
X-Gm-Message-State: AOAM532/bGdpdKSFUQK41elDDTqG9BlgCimRZEa9EHn30EL5YubhkJnn
        6Jc7w3Xlgt/A4Upr4vsNg6Kklqw1JGw7X3Celj4=
X-Google-Smtp-Source: ABdhPJzTaWWS4KFsWhwVdexjyVS9FPsLuG66C3W4pSO1JfmW5mnH24nERLmoJY89ZSAcHLBxXqdy4UPcx98HFEllh6s=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr2243264otr.89.1598024016342;
 Fri, 21 Aug 2020 08:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200821140836.3707282-1-tweek@google.com> <20200821140836.3707282-2-tweek@google.com>
In-Reply-To: <20200821140836.3707282-2-tweek@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 21 Aug 2020 11:33:25 -0400
Message-ID: <CAEjxPJ7TF8cq_C+rh08vmq-aBMTH8FFgQaREkgUWB7fqTQWtQw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] selinux: add tracepoint on audited events
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Paul Moore <paul@paul-moore.com>, Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 10:09 AM Thi=C3=A9baud Weksteen <tweek@google.com> =
wrote:
>
> The audit data currently captures which process and which target
> is responsible for a denial. There is no data on where exactly in the
> process that call occurred. Debugging can be made easier by being able to
> reconstruct the unified kernel and userland stack traces [1]. Add a
> tracepoint on the SELinux denials which can then be used by userland
> (i.e. perf).
>
> Although this patch could manually be added by each OS developer to
> trouble shoot a denial, adding it to the kernel streamlines the
> developers workflow.
>
> It is possible to use perf for monitoring the event:
>   # perf record -e avc:selinux_audited -g -a
>   ^C
>   # perf report -g
>   [...]
>       6.40%     6.40%  audited=3D800000 tclass=3D4
>                |
>                   __libc_start_main
>                   |
>                   |--4.60%--__GI___ioctl
>                   |          entry_SYSCALL_64
>                   |          do_syscall_64
>                   |          __x64_sys_ioctl
>                   |          ksys_ioctl
>                   |          binder_ioctl
>                   |          binder_set_nice
>                   |          can_nice
>                   |          capable
>                   |          security_capable
>                   |          cred_has_capability.isra.0
>                   |          slow_avc_audit
>                   |          common_lsm_audit
>                   |          avc_audit_post_callback
>                   |          avc_audit_post_callback
>                   |
>
> It is also possible to use the ftrace interface:
>   # echo 1 > /sys/kernel/debug/tracing/events/avc/selinux_audited/enable
>   # cat /sys/kernel/debug/tracing/trace
>   tracer: nop
>   entries-in-buffer/entries-written: 1/1   #P:8
>   [...]
>   dmesg-3624  [001] 13072.325358: selinux_denied: audited=3D800000 tclass=
=3D4
>
> The tclass value can be mapped to a class by searching
> security/selinux/flask.h. The audited value is a bit field of the
> permissions described in security/selinux/av_permissions.h for the
> corresponding class.
>
> [1] https://source.android.com/devices/tech/debug/native_stack_dump
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Suggested-by: Joel Fernandes <joelaf@google.com>
> Reviewed-by: Peter Enderborg <peter.enderborg@sony.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
