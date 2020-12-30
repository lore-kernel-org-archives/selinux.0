Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AB6C433DB
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA8020723
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgL3UOY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:14:24 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:46770 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3UOY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 15:14:24 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EEF9B560791
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 21:13:41 +0100 (CET)
Received: by mail-oo1-f41.google.com with SMTP id p72so3921933oop.4
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 12:13:41 -0800 (PST)
X-Gm-Message-State: AOAM530NFvxZYXbJQxnGlstsoM3lUlosBCQyB1GlBtBSPksp4sqno7Lz
        YgqFoCN8n246oOi6C8EOTfSyrvrRTbk1PLTmODc=
X-Google-Smtp-Source: ABdhPJytrC79AO/3bdLruxJDvQvx0v+i369iUbTlyVnk0aylWalgjc8K2TCNmd+91HEJgDwxDUfMlAaZ14VRglFAERQ=
X-Received: by 2002:a4a:520f:: with SMTP id d15mr37102643oob.29.1609359220698;
 Wed, 30 Dec 2020 12:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20201230200821.3454892-1-nicolas.iooss@m4x.org>
In-Reply-To: <20201230200821.3454892-1-nicolas.iooss@m4x.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 30 Dec 2020 21:13:29 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nZXN6kghgKV5R6a+TridWNxE5i14yYWRnU1rNXDYJQkg@mail.gmail.com>
Message-ID: <CAJfZ7=nZXN6kghgKV5R6a+TridWNxE5i14yYWRnU1rNXDYJQkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] GitHub Actions: run SELinux testsuite in Fedora
 virtual machine
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec 30 21:13:42 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Right after sending the patch, I realized there could be some
confusion about this patch: it is for SELinux userspace repository
(https://github.com/SELinuxProject/selinux).

On Wed, Dec 30, 2020 at 9:09 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
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

