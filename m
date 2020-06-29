Return-Path: <SRS0=DMlc=AK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79211C433DF
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593662078A
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 21:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJW27OIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404675AbgF2V7o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:59:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40017 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgF2SfZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jun 2020 14:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593455722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ty74lRLhmebZg9eqfLEnA9Ds7vkhb7jTgvLl9GMVzUQ=;
        b=GJW27OIb5tAgkRdpbJc9jHajsUi7EXYSlrdN9rmEkL2riEb56y8T6bGEr0CPbAig8WVWek
        kU0L4mpIJfr5v8EZj3QW98GGrO7/HsiVKxITFw7V4fysG7rCBVAfZdyXJsn0he6U/BksMg
        xERHvMhpgNmpzX363PA16oEVQpuVj78=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-3p4lB4vXNBS8NwNssE4XzA-1; Mon, 29 Jun 2020 04:31:51 -0400
X-MC-Unique: 3p4lB4vXNBS8NwNssE4XzA-1
Received: by mail-lj1-f197.google.com with SMTP id t12so6355007ljd.13
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2020 01:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ty74lRLhmebZg9eqfLEnA9Ds7vkhb7jTgvLl9GMVzUQ=;
        b=KiGY/Xo69Lp5dHcDq2MPrqYtC/AKDeVoIBXs+F9OZUR5eNgwKL1pZn+oaH08z2bIkV
         heF1WfyEDipHp0ix5D62MLcEYz+w4ErW//XQOg9xfMEcEDS+8yP6wKwc/z3ZDSrXbuu9
         mySOe6jY7F5UCkrlBQFwL8TkTOOn8lSv4D8wJvzrS02Uct+9pnVUsKNNOM0c5iYpw2Be
         XQBjhtSOcjqGQ8udai3SXCBbidjwnofQBXXSSXFVVugoRIZKVwoqJD0SiPUnag4Zl304
         b/86mdv3i+knoRZ+CWsfTmJYRkbezbV6iZV39FkvOiuBKVhm6bEoUUhpw+31CKK+bZ3G
         2Ihg==
X-Gm-Message-State: AOAM5305un0hFneObmeQgiHKv3rEHpZEOKLzOR5Bg0kaFlo9wJtfcIRd
        WgbzYNrFOqYAXzsPQc5zezbnf1oAKRPpu4xWl9uAbhF8TBmeVUSa6oQwgXbM6mtTJG9rHGNvsG9
        SsOBvMV7Qp5tcgyAflGY9Kx+UChhEaZUZlw==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr710156ljn.38.1593419510106;
        Mon, 29 Jun 2020 01:31:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY5WO5pFOb1hVm1sjdEJ4Vp56XaeFbEPTH8Pvj7xRPfIE3oXlvj7R5mysyX+QjC+qp3NFupOetpAMEKMqXyrQ=
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr710147ljn.38.1593419509795;
 Mon, 29 Jun 2020 01:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200626114359.80134-1-omosnace@redhat.com> <CAEjxPJ5+FhHLp01JWaALV6TCwkFP4PO=Y9KrjhKJCS-potV1TQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5+FhHLp01JWaALV6TCwkFP4PO=Y9KrjhKJCS-potV1TQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 29 Jun 2020 10:31:38 +0200
Message-ID: <CAFqZXNt0YZg_zEVhbG3ARguH6dUvRddQRGkWm86Z3B++CrU2Nw@mail.gmail.com>
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

Thanks, it is applied now and the Travis build passed:
https://travis-ci.org/github/SELinuxProject/selinux-testsuite/builds/703080617

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

