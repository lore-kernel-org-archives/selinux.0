Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEDC433E9
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FA32072A
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 15:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WW3sDmFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgICPO7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:14:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37052 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728887AbgICPOt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 11:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599146080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ChRJz78D+X4H0LIls5Lp2kgwf4YluncLSO058zU8Wr0=;
        b=WW3sDmFjrespqatAXW1CaPw+MXknjwAPUtcw4SwH+VQ/lUM4cqu3EL30Y7OWHu8AqcCFa2
        T581tgLC+iY9eLOEeTRbBTK8tg/S0AEtIXR3z+0n/f0+B3ZLRZNp8sVoLomXd2WC5TwYIT
        yLuSD32r8GgmYuQQuaqvOB2wdCRIxks=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-V9lzd5AFP4u3_jDpqgKMdA-1; Thu, 03 Sep 2020 11:14:39 -0400
X-MC-Unique: V9lzd5AFP4u3_jDpqgKMdA-1
Received: by mail-lj1-f199.google.com with SMTP id d8so1068100lji.5
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 08:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChRJz78D+X4H0LIls5Lp2kgwf4YluncLSO058zU8Wr0=;
        b=Uj3nk5zttGnpkZ5n3I6E7avGlstSXOnC0naICms9PV5ei4pNGP/K+X8CN7hMK1NXCe
         EM7N7wL0TIhfr7cvc9UHlzywF/tuLda+AXFqE6HUs9DV8+sJqLuhPXZjMV9z+eWDwiiG
         r/oryWBZoh9a5g7io4Bt3UIxS1DGxoMgRt1dPVTz6GortERZ3iaNGoKmKqQ7gmoBLdgm
         RQK6JsoIK6uXV6XuJlX+eV+ypnUDxhD5jm5OP+fDkIMy3bjbMsM1JPQBAbe/EsS9M+ml
         EobUnuQ0L2D/x47euowlmCXZKThE+eQ4M9Z48+1HdADYWmOPCXQIn/yu5jO+uZgGxF7y
         O9fQ==
X-Gm-Message-State: AOAM5305xQy1ArG0ioIYf/16pf82cDP7gqW2C4sHUBTzC1QCLDus4ggp
        xwHovhbMKy9XgAYW+Jt/vUNE8UROQKLYisSxPC+P8fiuKO9Hql6eIc/FkWN8nTuWVJTFACpvopf
        BPih+NEZZOlwi/dFNlWMjmeT3J5nc7Cekcg==
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr1527113lff.125.1599146077698;
        Thu, 03 Sep 2020 08:14:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIcA49YIBdNTgV9D6aG4Pp7hzPvs42Vr5ZolBW1Dui1LCoS8WDzA5UJUGJ8yhQGvIiZVYXvv7gMGVFY/ciSrU=
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr1527103lff.125.1599146077502;
 Thu, 03 Sep 2020 08:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200903072812.2281009-1-omosnace@redhat.com> <CAEjxPJ7amfVLYxknKtaFNqtFWsLW71PaFmgB3a4YnhMmR=wW2A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7amfVLYxknKtaFNqtFWsLW71PaFmgB3a4YnhMmR=wW2A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 3 Sep 2020 17:14:26 +0200
Message-ID: <CAFqZXNvXqX-tZh7cbcXT5pVA0wu1YHvPEOGsqPPpXiC0NC7mDA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/Makefile: add kernel version check for watchkey
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 3, 2020 at 4:15 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 3, 2020 at 3:28 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The corresponding header files might be available even when the running
> > kernel doesn't support the tested functionality, so add a kernel version
> > check for this test (key notifications were introduced in kernel 5.8).
> >
> > Fixes: 34b7da22ef88 ("selinux-testsuite: Add check for key changes on watch_queue")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Merge at will.

Thanks, also merged.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

