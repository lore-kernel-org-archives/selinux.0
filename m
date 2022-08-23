Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB483C32772
	for <selinux@archiver.kernel.org>; Tue, 23 Aug 2022 17:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiHWRnO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiHWRmo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Aug 2022 13:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77AAB4D6
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661269068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEkKJSE1ggGh9FGqNahqejNyD2IlJkyzy9SdAQXyFLY=;
        b=GBgVzBoisvAuT9TA1fCKBSK37cIgdtR7bCriofE6pqhV/tmhd5UKWBJY40DCFMYD4iBGP5
        snkK3cuff0lodvnfJWPkn5wTKJQ2cPLe4jUgzAPARsM8gs9HqzjHypl6h8KidpwOoiSbZa
        AJqBQVainEBTeZwBSRKd3Kon3V2oLjg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-0d4tJOV8MWGcrE6nyXrLug-1; Tue, 23 Aug 2022 11:37:46 -0400
X-MC-Unique: 0d4tJOV8MWGcrE6nyXrLug-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-337ed9110c2so202689917b3.15
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 08:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TEkKJSE1ggGh9FGqNahqejNyD2IlJkyzy9SdAQXyFLY=;
        b=bSx9KWYzk1WhuubmEbI/5Wmggza3qGz++mEnM6RI8xARN6ovrZWRZt9IJYbCnLCE8d
         3QSSTenawhxtbq2kIgvGCQ4A1zhjWQOtujdrst+Y7zqJm59/qEwVRo09sBvNn5HUquvH
         K3EeeSHrUr6fBYrPnNtw5tiaz+01PYP8S8C4QxP9mjvde3YNOr/0sgrufXTqNtyCsvVJ
         D7osJLcQUaTxkweCGJgV8CONs4MXJ4LUrnDPM5ZZvEqltn/txckmJ28mTyvcCz6YrM3J
         J2Z8j5N0xzjbC9yi2mVda0E5t3AiUpRAkqFYlp7NyGJw7B8U+wrsZRtl5NGSS0B0CaFR
         9z1w==
X-Gm-Message-State: ACgBeo0DfNaltQqF8s4KB0U/r/lYNl9l4N6H65DXoQxoZkS3C5yzrseD
        UC/Cu8FYZuyi4vV7Ys4SOOuoEZwCK8dBKTk79VFn7XKKUSVEKWenoofScoDeDcLGqpx7+2ib/fd
        s7Diw8CT01jACfEmMX1AeY9oMTt6v3NyRSw==
X-Received: by 2002:a25:cec9:0:b0:695:8151:a8e4 with SMTP id x192-20020a25cec9000000b006958151a8e4mr14775367ybe.336.1661269066308;
        Tue, 23 Aug 2022 08:37:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4BlOpLyHCRn32tsXPVeIs4vIMnRNvAOK7+e2a2UnwRxjOOOXJR+qAnI8zJLOPAQCjta3XkSZ1Wgz8U63HzQIA=
X-Received: by 2002:a25:cec9:0:b0:695:8151:a8e4 with SMTP id
 x192-20020a25cec9000000b006958151a8e4mr14775355ybe.336.1661269066070; Tue, 23
 Aug 2022 08:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220808144900.125242-1-omosnace@redhat.com> <CAHC9VhTkRAVFhfD5zhgQ75ztfv1-mPoe1s+rwW9Rk289gWa+oQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTkRAVFhfD5zhgQ75ztfv1-mPoe1s+rwW9Rk289gWa+oQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 23 Aug 2022 17:37:34 +0200
Message-ID: <CAFqZXNs5adb=0vt_pXYTVHn+UKVJ4FbOZNkV4BcOnXkEV0bT5g@mail.gmail.com>
Subject: Re: [PATCH] selinux: add a new warn_on_audited debug flag to selinuxfs
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 16, 2022 at 5:31 AM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Aug 8, 2022 at 10:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > When debugging SELinux denials, it is often helpful to know which part
> > of kernel code triggered the denial. Thus, this patch adds a new
> > /sys/fs/selinux/warn_on_audited flag that, when set to 1, will cause any
> > audited AVC event to log a WARNING to the kernel console, which
> > naturally comes with a kernel stack trace.
> >
> > While the same can be achieved via the "avc:selinux_audited" kernel
> > tracepoint and the perf tool, that approach has several practical
> > disadvantages:
> > 1. It requires perf to be installed on the machine.
> > 2. It requires kernel debug symbols to be available when decoding the
> >    stack trace.
> > 3. It requires a perf process to be running in the background.
> > 4. The stack traces can only be obtained at the end, after the perf
> >    process is terminated, not live during the capture. (Though this may
> >    be solved by writing a custom tool on top of libtraceevent.)
> >
> > Thus, providing a simple native knob for this in selinuxfs is still
> > valuable.
> >
> > The warn_on_audited flag is always set to 0 on boot and is expected to
> > be set to 1 only temporarily by system administrator in order to debug
> > SELinux denials. It is not intended to be used on production systems.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/avc.c              |  6 +++
> >  security/selinux/ima.c              | 11 +++++-
> >  security/selinux/include/security.h | 11 ++++++
> >  security/selinux/selinuxfs.c        | 61 +++++++++++++++++++++++++++++
> >  4 files changed, 88 insertions(+), 1 deletion(-)
>
> I'm sorry, but I'm not going to merge this.  At least not now.
>
> In general I don't like using WARN/WARN_ON/etc. for this; I believe
> their use should be limited for rather serious kernel issues and not
> as a developer's debugging tool.  I also don't like duplicating the
> tracepoint functionality.  I understand there are hurdles to using
> perf on a system, but I would much rather see work go into fixing that
> than duplicating its functionality

OK, I'm not going to argue against that, but I had to at least try :)

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

