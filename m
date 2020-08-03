Return-Path: <SRS0=5Yje=BN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFB7C433E0
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862E1207DF
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 16:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqdkRvuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgHCQbc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:31:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46300 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbgHCQbb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 12:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596472290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmNaCPhnbzLYAQIQOpvAu7+8xsqvCN8uKzGpWsRhpec=;
        b=VqdkRvuAmtXzvqFTnqbpjzblRoMPz7XaeTYBtiS4HdBiwevCLTtXKKUOPjgCLPfJrm5FXz
        EoSmMW9j0iiF50ZW4GHvDDNs833unxiuXQWYR6XB/52utWKexadHBSicmW5h3btyABH/BF
        HjTg64Jz9MxFzS4NXXvdG+4bEVpZfqo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-dPHlL1gJPZCSO5stkkcVmg-1; Mon, 03 Aug 2020 12:31:25 -0400
X-MC-Unique: dPHlL1gJPZCSO5stkkcVmg-1
Received: by mail-lj1-f199.google.com with SMTP id e22so1605944ljo.11
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 09:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bmNaCPhnbzLYAQIQOpvAu7+8xsqvCN8uKzGpWsRhpec=;
        b=YvAuapiUE8f9QWB9ER3znqd6sDAaftWbHIGbS4tVxb1+cGfqN05IaZVvDwL5wD7mjm
         c3tg1B4GvdMbRBTSsbr0LhFChsoBb99WnL0+3Ss6N7pg4RkcoJpu/IXGSt5rsBfhpZ/q
         I5/JzMKyh5hoMIgkvYhJeXadaAcCxHcGJWTjyZKiz3BFXE0ZwtXS0TMss4XQHJL55/xS
         6gziPikuOXSeGEtCfSKWM1NZyPExZWST41f8hYWLi8nn9KyXRai1CDaWrNu8Laz6W7JR
         wWC0NcZfz8LdjhvWmnib/NQ8rL1gpgHsijGGntYhMmfdiXoeXw9yeqA1XBVakalNE+sN
         D2aA==
X-Gm-Message-State: AOAM533Zsxoqy9uhWM2whN0lYqjzApTLBtbSgSASkhHIQHm9EMIRzqL9
        luvh5iLP8GiliPDQKYB1Q5EpF6/gjJrVFk31oMH2TcSKdF518qeULmhpXNgycPavhPLWOWfibgM
        nnU4i9NSBkTMjun7G9GTs7YnCwLXCt0DcSQ==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr7690830ljn.38.1596472283491;
        Mon, 03 Aug 2020 09:31:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4chrkYJH23TpZiqvQlZ4jC6PqnaWpaJIUkMEEKvnjwozn9kC1qW6eAIsGzP+8S3Cs9xSWc1tiORyVueYFQ+E=
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr7690820ljn.38.1596472283190;
 Mon, 03 Aug 2020 09:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvh9q4qTSN-Fj108JrO8DAfMiDkOzTDHs6n3Pxg+DOtXg@mail.gmail.com>
 <20200803151428.15166-1-william.c.roberts@intel.com>
In-Reply-To: <20200803151428.15166-1-william.c.roberts@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 Aug 2020 18:31:12 +0200
Message-ID: <CAFqZXNtTZio0-9_T9yheg0JmUP-TDa2OsUkgvHrNphGCrjhMVg@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/ci: license as MIT
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        "Roberts, William C" <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 3, 2020 at 5:14 PM <bill.c.roberts@gmail.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> License the ci scripts with a permissive, OSI approved license, such as
> MIT.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  v1: Apache 2.0
>  v2: MIT
>
>  scripts/ci/LICENSE               | 7 +++++++
>  scripts/ci/fedora-test-runner.sh | 2 +-
>  scripts/ci/travis-kvm-setup.sh   | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)
>  create mode 100644 scripts/ci/LICENSE
>
> diff --git a/scripts/ci/LICENSE b/scripts/ci/LICENSE
> new file mode 100644
> index 000000000000..6cd7b7924ef9
> --- /dev/null
> +++ b/scripts/ci/LICENSE
> @@ -0,0 +1,7 @@
> +Copyright <YEAR> <COPYRIGHT HOLDER>

You should probably put an actual year/name here?

> +
> +Permission is hereby granted, free of charge, to any person obtaining a =
copy of this software and associated documentation files (the "Software"), =
to deal in the Software without restriction, including without limitation t=
he rights to use, copy, modify, merge, publish, distribute, sublicense, and=
/or sell copies of the Software, and to permit persons to whom the Software=
 is furnished to do so, subject to the following conditions:
> +
> +The above copyright notice and this permission notice shall be included =
in all copies or substantial portions of the Software.
> +
> +THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,=
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL TH=
E AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LI=
ABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,=
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN =
THE SOFTWARE.
> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-ru=
nner.sh
> index 569723387f6b..0aaba87c421b 100755
> --- a/scripts/ci/fedora-test-runner.sh
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -1,5 +1,5 @@
>  #!/usr/bin/env bash
> -
> +# SPDX-License-Identifier: MIT

As I said in the v1 thread, also the individual files should contain a
copyright line in addition to the SPDX line. See:
https://matija.suklje.name/how-and-why-to-properly-write-copyright-statemen=
ts-in-your-code#why-have-the-copyright-statement

>  set -ev
>
>  #
> diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup=
.sh
> index 8d4cfb79f7d7..2b5734178096 100755
> --- a/scripts/ci/travis-kvm-setup.sh
> +++ b/scripts/ci/travis-kvm-setup.sh
> @@ -1,5 +1,5 @@
>  #!/usr/bin/env bash
> -
> +# SPDX-License-Identifier: MIT
>  set -ev
>
>  TEST_RUNNER=3D"scripts/ci/fedora-test-runner.sh"
> --
> 2.17.1
>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

