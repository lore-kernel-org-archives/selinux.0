Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FCBC388F7
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 21:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE10206CA
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 21:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKLVGb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 16:06:31 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:38640 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVGb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 16:06:31 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 920EF5654BB
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 22:06:28 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id h16so2876761otq.9
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 13:06:28 -0800 (PST)
X-Gm-Message-State: AOAM530wPLyQjeIINT+ObidEjZx4ReXXKCJbSXGP951FdLR8qBReDD5q
        Xs+TmAHH+1R8bPCXHMQORdp/wDiB4waK8qepVGc=
X-Google-Smtp-Source: ABdhPJwLcszaxxaCZ3+cTtyzjry/CHuRxP+igAOURSSrjAo8tgHc7k2OkJyYOEyizd1r1Y9515kmiDyTTa6HxTBIfSY=
X-Received: by 2002:a9d:123:: with SMTP id 32mr815899otu.279.1605215187614;
 Thu, 12 Nov 2020 13:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20201112091519.577246-1-omosnace@redhat.com>
In-Reply-To: <20201112091519.577246-1-omosnace@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 12 Nov 2020 22:06:16 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nD2tUjUDdCzQDe_6yAxwrzVZP3C5ATky_26-d_MTFKFg@mail.gmail.com>
Message-ID: <CAJfZ7=nD2tUjUDdCzQDe_6yAxwrzVZP3C5ATky_26-d_MTFKFg@mail.gmail.com>
Subject: Re: [PATCH userspace] ci: add new dependencies needed by selinux-testsuite
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Nov 12 22:06:29 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 12, 2020 at 10:15 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The testsuite now runs filesystem tests also on other filesystems than
> just the default ext4. [1] That means a few more userspace utilities are
> needed to format these filesystems. [2]
>
> [1] https://github.com/SELinuxProject/selinux-testsuite/commit/071ec9c5e5f0442aae0b14f455ea6e6b34ada1e0
> [2] https://github.com/SELinuxProject/selinux-testsuite/commit/d4e507f78a1784334611421cdfa3683a8214b22d
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  scripts/ci/fedora-test-runner.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> index 78218963..be2cb7d8 100755
> --- a/scripts/ci/fedora-test-runner.sh
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -58,6 +58,9 @@ dnf install -y \
>      quota \
>      xfsprogs-devel \
>      libuuid-devel \
> +    e2fsprogs \
> +    jfsutils \
> +    dosfstools \
>      kernel-devel-"$(uname -r)" \
>      kernel-modules-"$(uname -r)"
>
> --
> 2.26.2

As the patch is very straightforward and it fixed the issue in
Travis-CI tests, I merged this patch directly. Now
https://travis-ci.com/github/SELinuxProject/selinux whould be green
again :)

Thanks!
Nicolas

