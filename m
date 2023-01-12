Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974A7C54EBC
	for <selinux@archiver.kernel.org>; Thu, 12 Jan 2023 12:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjALMMG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjALMLp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Jan 2023 07:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E074BA0
        for <selinux@vger.kernel.org>; Thu, 12 Jan 2023 04:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673525164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IYIi3DuN4Sb8opE2437YnzyyTRVBYhIQ0gN/ZKmUxKA=;
        b=b4Tmpw5y18fT24aE0q+HZERZrmFOBdZ8RS0R/fjD0T6W7j9ZX1mmovFQV9KCMTuZ7k4BOt
        Z7wyw7E0aR6wBNp9LtSCh7iIuR+OdNxElADL9GYwgme3PCWvW7/lQmqm5Qys1viRhzcvIh
        MsatXNbnXp/mxy/RaFwRsPw27rQeRrY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-120-2WLGytGrM5ONWyhP7cJP2Q-1; Thu, 12 Jan 2023 07:06:02 -0500
X-MC-Unique: 2WLGytGrM5ONWyhP7cJP2Q-1
Received: by mail-pj1-f71.google.com with SMTP id h6-20020a17090aa88600b00223fccff2efso13104833pjq.6
        for <selinux@vger.kernel.org>; Thu, 12 Jan 2023 04:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYIi3DuN4Sb8opE2437YnzyyTRVBYhIQ0gN/ZKmUxKA=;
        b=JqjkNj+aHKWk6dg6NbyCeK1QohQIGbQUHqd3ACHISdoC+m2SJZHR89PvErRTqE5+Gk
         HyDWQ7waRkDn1AfgzLWPnS1oSeQ7C5AycNZuqqHsG8sFEHJDGHZzaLoG/vBrBpdhwx4W
         8FSq0cw9YTBww0ppjaqt59EhAz89XxR+vZDKPURV1QWHnnC7J9ksp45mE+RfYDa4KTR6
         zb61DbVeRN4aOUjCxmv0JeBFvpbxQdggMM1Gz0ZUXyzVLh0FyS6MEA8qke+9scxWVSzV
         wbEEx6QNqaGkCyVYxPdYiAvh+G4ioNCUb8Fp/oPXgIHIqBP4718c4Ci1b1EQHq/KxlX5
         BF6Q==
X-Gm-Message-State: AFqh2kqlTAdzTgs9tx/T9ilY8/CsXbnpWyJsJ5x8vIt+IR+2jwuI9jgq
        7P2EDNgOGJaAfClkhwiChi+DEasJMQ3SrFkcgGDXQRVqwJDiUr2M/c6+WaFF7CZ0irEFj8pHMtd
        de9os36MnbqLEfKo+oD0WOqdYxlYdUf7ssA==
X-Received: by 2002:aa7:904f:0:b0:586:d41d:8bc3 with SMTP id n15-20020aa7904f000000b00586d41d8bc3mr1695909pfo.26.1673525161425;
        Thu, 12 Jan 2023 04:06:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuDlTM0CFCGfx0LEfWHgsERK9mn4Qbq2krjM4fHXlwQdQ4TFix2WiStM8gZmAfd7+vwb640p8D1jAoAxDzdt+c=
X-Received: by 2002:aa7:904f:0:b0:586:d41d:8bc3 with SMTP id
 n15-20020aa7904f000000b00586d41d8bc3mr1695908pfo.26.1673525161174; Thu, 12
 Jan 2023 04:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20230109211834.1950163-1-omosnace@redhat.com>
In-Reply-To: <20230109211834.1950163-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Jan 2023 13:05:49 +0100
Message-ID: <CAFqZXNtENHs3JvV+3zB+o8bJuOUZuQRNKswpzYefRZ8J-J2vsg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/keys: remove extraneous zero byte from
 the DH prime
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 9, 2023 at 10:18 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The extra zero byte at the beginning is unnecessary and not expected by
> the kernel. While the generic DH implementation is able to deal with it,
> at least one hardware driver implementation (intel_qat) rejects it.
> Since the kernel's test vectors do not include one with zero bytes at
> the beginning, assume that it's invalid and remove it from our prime
> byte array.
>
> While there also regroup the byte values by 8 instead of 10, so that it
> is easy to verify that the size of the array is a multiple of 8 as
> expected.
>
> Verified on a machine with the Intel QAT accelerator, where the test was
> failing before.
>
> Fixes: 85832b99b430 ("tests/keys: use a longer prime in DH params")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/5dda1f3f2dc2274a13e423dcb20292129b6633d5

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

