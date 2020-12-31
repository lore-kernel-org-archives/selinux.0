Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7093DC433DB
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 14:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39401223E8
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgLaOnx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Dec 2020 09:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgLaOnx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Dec 2020 09:43:53 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A9EC061573
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 06:43:12 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z5so17298481iob.11
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUKl2T8KmVV5f5dLukBey5kxf5EVCLB/VM6GVpbLwNM=;
        b=IAEb2S4h0Fr++617/EOI+pG5c1EwB8LnYbBIaGyFDy7PZ6TsRBBztzv5kTcN5j5cUf
         8R3Lhf2CI1cdHbJd3nEh8JIbychCLHQhdCMqHdz7ApD8hcIJQnFkWUSnEK53FR91GvFW
         MlG0LJMYtU/DAWoWRGUKrcp5iIy6L4lSvGX3nr676sbqGqDRkuWmo4fkysIbTs1kngIb
         nTUdfazIdAQapHcqIAoIXl0553SpqdWZh5xLLgeGeWYN7Ekc7TB2vIPQ1zKcWMfCEnv3
         sqbUZ83aaDiTnIipBzDbo5YQl+cEG0+1Uuey4v7j2Bl7fjcbGCDX9zcKCmSRb4Gg3eSC
         b4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUKl2T8KmVV5f5dLukBey5kxf5EVCLB/VM6GVpbLwNM=;
        b=Yk54KqjaROU6rXq68eJK9yMIPWTBvrRAAGmV2oBnn6X2iiwL66BDeCb3ErlfxtD7Vq
         kT/OmMCyyZqJWsrAup1eJr4CAmLbEv6i2uD06J//Ncypz1olmlKNpqZhlSOPTLRZbO2S
         4pCVd61uILXxPhx6qnm1vD6L59lSLRMj0BxuAlxA93tFXx84HV6fO6GbAlvFHX7XQq1s
         9rakZjIj/IlCBGl8zMA6/6axYrhb+LAV+1ilCRlm00Dck1sxWLDgpgWQvtUv8Z+S3mv+
         xqL35c90kZhDP7+plY/fpxwVvli6NIZ8G4Vn6GkkPQHON/WoBy9G4m4wVSohAJUE5gNo
         JjcQ==
X-Gm-Message-State: AOAM5318i0w5Wgg8LKxmJRFMia728Z6eYcZU5ecRZQ3S3LGLJDWuy0eX
        K/6b2ctbFZTM+91J6k3o7gk5hOAcbJsOrUQIEvQ=
X-Google-Smtp-Source: ABdhPJzVGnnDALOCJw1X5ATB1RUIpv2T9C5MbNfyjwW0Odvf1fq+9lMpJymkf2GAC5jTy/+sn9iWtDM+CKcY1mSa8kE=
X-Received: by 2002:a6b:5018:: with SMTP id e24mr46390376iob.184.1609425791883;
 Thu, 31 Dec 2020 06:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20201230200821.3454892-1-nicolas.iooss@m4x.org>
In-Reply-To: <20201230200821.3454892-1-nicolas.iooss@m4x.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 31 Dec 2020 08:42:59 -0600
Message-ID: <CAFftDdoTGNizbiX68drThF=M_QUyRdCD7zb3MGjuKtU-yi_+Vw@mail.gmail.com>
Subject: Re: [PATCH 1/1] GitHub Actions: run SELinux testsuite in Fedora
 virtual machine
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 2:12 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Use the Vagrant configuration in scripts/ci in a workflow for GitHub
> Actions.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
> Example of run: https://github.com/fishilico/selinux/runs/1627586446
>
>  .github/workflows/vm_testsuite.yml | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 .github/workflows/vm_testsuite.yml
>
> diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
> new file mode 100644
> index 000000000000..af2fad1e73f5
> --- /dev/null
> +++ b/.github/workflows/vm_testsuite.yml
> @@ -0,0 +1,22 @@
> +name: Run SELinux testsuite in a virtual machine
> +
> +on: [push, pull_request]
> +
> +jobs:
> +  vm_testsuite:
> +
> +    # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
> +    runs-on: macos-latest

Good find, they support nested virtualization.

> +
> +    steps:
> +    - uses: actions/checkout@v2
> +
> +    - name: Create Vagrant VM
> +      run: |
> +        cd scripts/ci
> +        vagrant up
> +
> +    - name: Run SELinux testsuite in the VM
> +      run: |
> +        cd scripts/ci
> +        vagrant ssh -- ./run-selinux-test.sh
> --
> 2.29.2
>

LGTM ack. Do you have any fork that has a build with this just to see
it running?
