Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C1C433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 21:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446A12087C
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 21:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Se4PgoB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgGaVLk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:11:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23647 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbgGaVLk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 17:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596229898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/cV/Qzw+m6vy3WX4hnJbiztl48D5GgRBllbpSaxlaE=;
        b=Se4PgoB60jnAchzANeSO959FREWWfp1KOBv564waFFzmJ4IG7t3YOhiSOtqS7JDJMWwMsR
        xZRj77WgXBKrpMo4MYky3m0DICIxpoU7/QRm3KnxIkLk6WwUkKwRScxhNJq2x7vaIy939A
        tmk0qpBLtfMZwxd41KQS+xnFEVnHDMI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-0qSgwAd0PsiQQyJ5wUsIJg-1; Fri, 31 Jul 2020 17:11:33 -0400
X-MC-Unique: 0qSgwAd0PsiQQyJ5wUsIJg-1
Received: by mail-lf1-f71.google.com with SMTP id p192so9412331lfa.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 14:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/cV/Qzw+m6vy3WX4hnJbiztl48D5GgRBllbpSaxlaE=;
        b=EOlLZu+HR/f71b59xouhKKphATqn9fwywH2YvTMaE2zatbIP1F21WlyBILp6BCxE1/
         mO1Gm27Ejj9ObEUcduO3PtJNcZjr4C20J1fhktlTrqrJSGhbqbL8nP8seZ4Wq6MxMt05
         /deWKJAql4haJ3RUJZ2aqr2poZ3tlDVm0gFThUMZQwnVzO1h6yfstRiXvTH8hw9A7Xtv
         GUq4uD7qxc1FoBc+hq0MLDMyIvroT5fkqNQO/T4L6/pB5cCqWjXw5Ip8IqHoQTyzm2pX
         CrDeCPGBOfIKchggkEGbY6zne+nrFrqzDsjwyblBnou0/wrsS+8IRyytfK7KxeY38ura
         l8/A==
X-Gm-Message-State: AOAM5303mXABPY00EFFKJTxEJr1eTCOMN9Gcz8che7AjBDnLrl/uFEug
        FBwkmqN+3VdJ8TXwPFiQGAxhyM4ZQ3Sta1H2C/wgRilPgBqMUVFtjUe6+SVWz4kBJgnyxjPFXdF
        RRBnI+WHjksl/DLifY6E9Z0ZcBZ3BaKWB1Q==
X-Received: by 2002:a2e:91da:: with SMTP id u26mr2717495ljg.311.1596229891693;
        Fri, 31 Jul 2020 14:11:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkgAgkjNraM6smS/ppkFqgoSRvP100WF7cTneBaAlw3Aw8TBEIJjlS7YG58fdsMdaZetuADElTcjbJ9drquU0=
X-Received: by 2002:a2e:91da:: with SMTP id u26mr2717484ljg.311.1596229891457;
 Fri, 31 Jul 2020 14:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdo2XOU1iH1Gn1bf8UF7VLHVXF9wuop9SOHj44P4pet-kQ@mail.gmail.com>
 <20200731173309.31528-1-william.c.roberts@intel.com>
In-Reply-To: <20200731173309.31528-1-william.c.roberts@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 31 Jul 2020 23:11:20 +0200
Message-ID: <CAFqZXNtnzP=F_-n_6VRuEnErqmFex0x0C7z5nP=970-n-4aurw@mail.gmail.com>
Subject: Re: [PATCH] scripts/ci: license as Apache 2.0
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 31, 2020 at 7:33 PM <bill.c.roberts@gmail.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> License the ci scripts with a permissive, OSI approved license, such as
> Apache 2.0.

Thanks! On second thought though, I guess any open source license
would be fine, since the scripts don't "link" with the rest of the
testsuite (which is GPLv2). So if you prefer some more permissive (or
shorter... :) license or just public domain, you can probably use
that, too.

>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  scripts/ci/LICENSE               | 202 +++++++++++++++++++++++++++++++
>  scripts/ci/fedora-test-runner.sh |   2 +-
>  scripts/ci/travis-kvm-setup.sh   |   2 +-
>  3 files changed, 204 insertions(+), 2 deletions(-)
>  create mode 100644 scripts/ci/LICENSE
>

<snip>

> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> index 569723387f6b..8d6a572eb094 100755
> --- a/scripts/ci/fedora-test-runner.sh
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -1,5 +1,5 @@
>  #!/usr/bin/env bash
> -
> +# SPDX-License-Identifier: Apache-2.0

I think you should also add a copyright line alongside the SPDX header. See:
https://matija.suklje.name/how-and-why-to-properly-write-copyright-statements-in-your-code#why-have-the-copyright-statement

>  set -ev
>
>  #
> diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
> index 8d4cfb79f7d7..275d05299971 100755
> --- a/scripts/ci/travis-kvm-setup.sh
> +++ b/scripts/ci/travis-kvm-setup.sh
> @@ -1,5 +1,5 @@
>  #!/usr/bin/env bash
> -
> +# SPDX-License-Identifier: Apache-2.0

Ditto.

>  set -ev
>
>  TEST_RUNNER="scripts/ci/fedora-test-runner.sh"
> --
> 2.17.1
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

