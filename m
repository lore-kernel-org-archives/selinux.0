Return-Path: <SRS0=DMlc=AK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6254C433E1
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 20:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80AD206F1
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 20:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A99fv9jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgF2Uxi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:53:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59277 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731322AbgF2TNU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jun 2020 15:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPVl8nZtaDUuMbNPOf+J3CWyhdjTXYg/AvYdpgqyb84=;
        b=A99fv9jzPDgp8hieMRzBLVlrMr7nUIcssckEkKoJQkLD8XS1yVr4Fd1lll4Qu74LdDfk7g
        0XmNuod0tV4sHDrinaJ/VM/QeITz1A+ZpY0MMpWqiupo9StQ5vB0l1oVMhnm7lp0DVdlY8
        ZvG+dY13k8Dgp5/Jj/2qILLVqCiS33A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-AxQy0n37M0emFOZTRdcClg-1; Mon, 29 Jun 2020 15:13:15 -0400
X-MC-Unique: AxQy0n37M0emFOZTRdcClg-1
Received: by mail-lj1-f199.google.com with SMTP id f25so354836ljo.13
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2020 12:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPVl8nZtaDUuMbNPOf+J3CWyhdjTXYg/AvYdpgqyb84=;
        b=YMqMVparpbWI7e/rXgd1piFLZOyHgxOyWC7xTfgnWi+R13+Dq0u07kDUSiYkaZOvJQ
         Y9mOz8dYf89tOgxI1DcCzV7XnQs8eRA77iyRkZ+8GwJbX92YoIwgGWHYuFmMfsGXcRIS
         hdUNktMlG587xkbYrnynfZPy4eniAdj4JoT2ZMvScOd/0trGVb47llEAFpiv68y9Lo1X
         X29FJtQNvHsa7VIGFdTQJIp/XeMra3eWbjM1Hixna5vzx+NUX3IxlZa/ueNgvnC4AzVY
         G3jkeN9R0MADagrT/vtBh8P1HvwypOV8ZSOV1D2YCw1hN6UhsME58NEFgCoKgAUpmjmk
         GoHA==
X-Gm-Message-State: AOAM533NV4Jon16/YQmWa2HT7Dw2wSZyJyedfesyahHVDo33X6cDb+kD
        1f9FOXbOFUpntPbukHXuyvneV28RSTwRghURtuvAofWomXPPYdsV6XDXJMJ2w6E30TO+x8wzpM7
        9sIz6KGT7QB90JVNdbqv/yos23ZASJTberQ==
X-Received: by 2002:ac2:4557:: with SMTP id j23mr10341416lfm.124.1593457993172;
        Mon, 29 Jun 2020 12:13:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyJCWW161qqAeklK99YuGT3thQ2tuUvQV5PGscfKtCXY2Mh1hduDT4oPFcrPhb9IjnQ6Eol31RvNm/tHrXmPE=
X-Received: by 2002:ac2:4557:: with SMTP id j23mr10341408lfm.124.1593457992955;
 Mon, 29 Jun 2020 12:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200626114359.80134-1-omosnace@redhat.com> <CAEjxPJ5+FhHLp01JWaALV6TCwkFP4PO=Y9KrjhKJCS-potV1TQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5+FhHLp01JWaALV6TCwkFP4PO=Y9KrjhKJCS-potV1TQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 29 Jun 2020 21:13:01 +0200
Message-ID: <CAFqZXNsipXMWAgYFxxe9sB5y+_yiJ6RbXUACmqCQUakits17Eg@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: fix `make conf` invocation
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 26, 2020 at 2:49 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jun 26, 2020 at 7:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > In refpolicy when a module is added/removed, the policy build config
> > may need to be rebuilt. Currently we run `make conf` just once and then
> > reuse it via cache. Instead, we need to run it unconditionally, since
> > the other targets won't trigger that implictly.
> >
> > In Fedora policy the default module config is included and maintained in
> > git, so we don't need to (and must not) call make conf at all.
> >
> > Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Feel free to apply whenever; I will not be around next week to do so.

(Third time's the charm, hopefully... vger.kernel.org seems to be
working again.)

Thanks, it is applied now and the Travis build passed:
https://travis-ci.org/github/SELinuxProject/selinux-testsuite/builds/703080617

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

