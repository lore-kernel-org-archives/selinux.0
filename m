Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9E0C2BB41
	for <selinux@archiver.kernel.org>; Tue, 16 Aug 2022 07:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiHPHI6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Aug 2022 03:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiHPHIm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Aug 2022 03:08:42 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786D2CD568
        for <selinux@vger.kernel.org>; Mon, 15 Aug 2022 20:31:37 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10edfa2d57dso10397984fac.0
        for <selinux@vger.kernel.org>; Mon, 15 Aug 2022 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T1b0NK+n1SqAz2Svwoix8DVYHLKcE2/eAUmUN2sYhs8=;
        b=vUwJll22o/C6MxDNt8fjQ1/42rG6oE6BtfRBXjFohwe7bsgmGH4h22o7gL4K8tBET0
         E4gojFhzA7Vamc3I9VdJ70zbyar3/85iSLXm2FurulLmw3752dwdPH4oXtGZfgGv0OUb
         mHTNJui7pp0iMZn1ydkAmzR06KpJf6Nu4pRG7RztcKaFjSic9DL3HMHiNUJgE4P9yHKp
         yxJJve6AyL9XV0O7WFkTaUQT3hR+w75DVrTCXAixs8OWGEjfYCs1Mcr1iJggZHwsDpKt
         /evEs19zB4C/0NBUYJhmsducvMdPm4EnhFJoc06tufsnS0ltaWcVr12feLzjw++516cw
         ULWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T1b0NK+n1SqAz2Svwoix8DVYHLKcE2/eAUmUN2sYhs8=;
        b=nqWYu1VM4fk4OyzR1H0rhuEV7WUbBM6kQLSSPkUshnBkJymoAB2vDRXnuhgFPvV3vf
         XDzbR6AuWLqiaB5C6i+7Fs+Co1hTHA8FkUUDK8sjUJt7jcXld5QziktnO4V2i2ek0Srq
         A7T6MQVqknSIsJVp+ViKz5jByxQrxmR9jpmqcn2KqCiGbZZYSSHfgguJgkXGvaIE7eMn
         93oAzBct3Qk8IVUmxRleTNH8yHimCG05SxWgEqbEGbyfI3tG9gbQvVlUy+kqU9/mAn+L
         c4QxL59s3DtOkX9NfZX9/ds9ShDNGycUBtF1m5rx1UGttVH1k+z9jAG32+YwFjLeEav9
         I6fw==
X-Gm-Message-State: ACgBeo2KStxu2Jj9K9Ll/zEVX4EPE90byImKsPkog7oXlitNvMYJ6QHP
        eeVuW52o3YlO55RojlRoKkFLxymAIqtBXK6w61FWtnWdWw==
X-Google-Smtp-Source: AA6agR4eS5O5tkLI0UhK+nbjJTM7n80mHavLeRJHYsxYyjXrANJnyfLuZc7iLg8Kf3Kvjp5mZvd2BbdDE14ORVaJUOU=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr12483799oao.41.1660620696477; Mon, 15
 Aug 2022 20:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220808144900.125242-1-omosnace@redhat.com>
In-Reply-To: <20220808144900.125242-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Aug 2022 23:31:25 -0400
Message-ID: <CAHC9VhTkRAVFhfD5zhgQ75ztfv1-mPoe1s+rwW9Rk289gWa+oQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: add a new warn_on_audited debug flag to selinuxfs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 8, 2022 at 10:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> When debugging SELinux denials, it is often helpful to know which part
> of kernel code triggered the denial. Thus, this patch adds a new
> /sys/fs/selinux/warn_on_audited flag that, when set to 1, will cause any
> audited AVC event to log a WARNING to the kernel console, which
> naturally comes with a kernel stack trace.
>
> While the same can be achieved via the "avc:selinux_audited" kernel
> tracepoint and the perf tool, that approach has several practical
> disadvantages:
> 1. It requires perf to be installed on the machine.
> 2. It requires kernel debug symbols to be available when decoding the
>    stack trace.
> 3. It requires a perf process to be running in the background.
> 4. The stack traces can only be obtained at the end, after the perf
>    process is terminated, not live during the capture. (Though this may
>    be solved by writing a custom tool on top of libtraceevent.)
>
> Thus, providing a simple native knob for this in selinuxfs is still
> valuable.
>
> The warn_on_audited flag is always set to 0 on boot and is expected to
> be set to 1 only temporarily by system administrator in order to debug
> SELinux denials. It is not intended to be used on production systems.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/avc.c              |  6 +++
>  security/selinux/ima.c              | 11 +++++-
>  security/selinux/include/security.h | 11 ++++++
>  security/selinux/selinuxfs.c        | 61 +++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 1 deletion(-)

I'm sorry, but I'm not going to merge this.  At least not now.

In general I don't like using WARN/WARN_ON/etc. for this; I believe
their use should be limited for rather serious kernel issues and not
as a developer's debugging tool.  I also don't like duplicating the
tracepoint functionality.  I understand there are hurdles to using
perf on a system, but I would much rather see work go into fixing that
than duplicating its functionality

-- 
paul-moore.com
