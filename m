Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C6EC433E1
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 21:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFF320791
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 21:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jQ8xvgEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHUVJM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgHUVJL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 17:09:11 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01D4C061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 14:09:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id si26so4006841ejb.12
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mScZuT333eFPJltqlW+xpkpAoyeB+4wo8236mWISgBI=;
        b=jQ8xvgEnc5aL2xYjcB4OF8wR+AxKYEy2Fva6FQTl37Wz1JvALyaaVQ0U6GSpKGD1oW
         ojrd6isMvbBQY1yC/d593Fp1O6k3zdEgWS/dZHMS1ZMlnLQXEFBSzUfr37APeD0WwmRZ
         jU6bYdRAlKc0xGYw7dvgtO7aKYTw5LnAp1u3vY8lB/Qqi4YUdQecU9zHLFnGk711XGU1
         ijPaebpYJhd+PAz7E4kee5aaqP/mXytSloLwCT/1Dv3D7+6a9HZ81Nj0T1j/Aq1AJXey
         L+J5Rq27psI4+tYTUd9sRZScikl3x4tgw6T7cHUVSb9pAQiozwh3jR5PYK3fx+rphcL3
         JobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mScZuT333eFPJltqlW+xpkpAoyeB+4wo8236mWISgBI=;
        b=SAT8NIShqDM2tEisEOrJ45dKQ4JM57KkicWpByxCEE0ivoykQDSQ7LdCaD/IRAhxkJ
         QLbSfLqozbtdiiFFqXgZo1AYh4SGajyszSGVUbFC+jWmYHFwiCxlsrsofn4Wi+Xpkygg
         QMSmxD0KFhVvu6vrIrxxFYBPegREU1gv3ohbNMLv+mVjiKMWjXs9dy4Y8Re3QhEHE0Q/
         1hKiR5mKuSPmG787r+9ABMRwWWCb1fkiDg4ErAie6Y95GAbHP1cQqFlnJTec/E2kAe85
         SZghJx+b4hT6Y69QlHfVDy9XnSulbjOmXsB5+fhQOb6D5MGKr6t6TXTR7Jikrbqj+U+G
         8UrA==
X-Gm-Message-State: AOAM533Sn4HE1SfndVvLywlEcNg4Ce6UGYfFxSMB0aviaIdgD0mH+brp
        MoiYsnTOzu5biwVoXvqTttmjg+GrbsmbxFH/BPsw
X-Google-Smtp-Source: ABdhPJygRg+bnaEbvHnqo1liwnz2gy8moHpQyJhGF/zi1X9+91VIvTX/4Fbl5/X8Nhf1/CQErKG1h0boaVnw4nLyJGM=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr4713021ejn.542.1598044149342;
 Fri, 21 Aug 2020 14:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200821140836.3707282-1-tweek@google.com> <20200821140836.3707282-2-tweek@google.com>
In-Reply-To: <20200821140836.3707282-2-tweek@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 17:08:58 -0400
Message-ID: <CAHC9VhRiz1ezDj6J5Yuv17EU8nnrOBKfHScB-njVUKptSoxowg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] selinux: add tracepoint on audited events
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
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
> ---
>  MAINTAINERS                |  1 +
>  include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++++++
>  security/selinux/avc.c     |  5 +++++
>  3 files changed, 43 insertions(+)
>  create mode 100644 include/trace/events/avc.h

Merged into selinux/next, thanks!

--=20
paul moore
www.paul-moore.com
