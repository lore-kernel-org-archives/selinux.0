Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E6AC433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 13:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiFNNOp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiFNNOp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 09:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D33E1369FA
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655212482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7m3eXuKimo46thc1GwJ8FdulWb8YF8ZFjNDak6o76w=;
        b=crB5AMjDBag37jsw+6LLoVBQYeHAOYzFxUBpuVgFWjAXErWEfV8DCbo0DcanlmaWF/g1HO
        a1sDgsC6bpojNLL2Mm+r8XGVTVjrszuEm3nuoO2e4T4iZbY0x+rK28mpuOn3cuOtsz0Pfh
        sMsc/VCAGG+am7ApgKtBJ4IvMG8bIGE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-M2dXfoYfPk6xsKuOnfA_ig-1; Tue, 14 Jun 2022 09:14:41 -0400
X-MC-Unique: M2dXfoYfPk6xsKuOnfA_ig-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-2eb7d137101so24995707b3.12
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 06:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m7m3eXuKimo46thc1GwJ8FdulWb8YF8ZFjNDak6o76w=;
        b=7hZoI+BacjjQdTMPVgi84lmxLJ2dhQFCwrCVMtp6QyAcThqHQeZHk3i4oA0PcQVink
         TKMk3MfKzjTGm3T/UycwWbtHA+dyxYjOk2rnygzX86ffCBiGTgTbX5Nrd9YXFpB67tcX
         +Sn8GCWupT9HD9AY3MfUMjmBui+D774GCSQtq1JPjJv6LpEdGbeQmI6bnWLhkL058S6s
         tSAkjgVm1yfy2v5pmXthvRJht8svkugtSJ/J7iOtlq+/RAYnmiG65cJox2P1XGCsbRYQ
         t56MeN12pRGZNuIjiGwYHJ2GsmyLxl1tuQcmjJWB11MYoVK84Jl/OPD4wZl2VL90gYCm
         aMSQ==
X-Gm-Message-State: AJIora+E0qrdoCWXAAdUj9su1jb/m1qCod4nxFFZf8GSzqJuGy/JiyuZ
        kICbpSgUiDG0yZMH4p6RoLJf2ON11K8erITQ0KZGMI6zeThdYDJIPxc2EMEu4a/11nF+Ixwap+8
        p7UXriDoJsAusKzDoOtVcDLnEOw/xlOY9+g==
X-Received: by 2002:a25:2ac9:0:b0:65d:3dca:9638 with SMTP id q192-20020a252ac9000000b0065d3dca9638mr4936506ybq.196.1655212480705;
        Tue, 14 Jun 2022 06:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tdodd3C8bHrRF/HF94U9FA+cbakiTAVXj8Z1+blJyluHxVeJI9rsSgHq0Ac2HAKmNF4l1WXxOItl/29JaJLOE=
X-Received: by 2002:a25:2ac9:0:b0:65d:3dca:9638 with SMTP id
 q192-20020a252ac9000000b0065d3dca9638mr4936464ybq.196.1655212480242; Tue, 14
 Jun 2022 06:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220614102029.13006-1-cgzones@googlemail.com> <20220614102029.13006-2-cgzones@googlemail.com>
In-Reply-To: <20220614102029.13006-2-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Jun 2022 15:14:29 +0200
Message-ID: <CAFqZXNtgbZcXMTMxh9TXSTi4Zdzjc-tceip18ML04ZHPUQ-Zjw@mail.gmail.com>
Subject: Re: [PATCH 2/4] support perf_event_paranoid=3
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 14, 2022 at 12:20 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Debian uses a downstream patch[1] to allow further restriction of
> perf_event_open, which requires CAP_SYS_ADMIN for all perf_event_open(2)
> operations.
>
> [1]: https://salsa.debian.org/kernel-team/linux/-/blob/debian/5.17.3-1/de=
bian/patches/features/all/security-perf-allow-further-restriction-of-perf_e=
vent_open.patch
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  policy/test_perf_event.te | 29 +++++++++++++++++++++++------
>  tests/perf_event/test     | 39 ++++++++++++++++++++++++++++-----------
>  2 files changed, 51 insertions(+), 17 deletions(-)

Could we rather temporarily set the sysctl to 2 if it's 3 rather than
adapting to the Debian's downstream patch? The testsuite already does
a lot of various temporary system-wide tweaks, so I don't think it's
worth adding all this complexity just to avoid touching the sysctl.

And actually if we are already going to touch it, we could iterate
through all the normal values (0-2) and check that each works as
expected w.r.t. CAP_PERFMON (but I'll leave it up to you if you want
to implement that or not).

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

