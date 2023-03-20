Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76D1C7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 13:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCTNBP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjCTNAz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 09:00:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02829211F
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 06:00:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t83so6516029pgb.11
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 06:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679317241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHQLKDsNWxNB5YBarDMklHQXAjopSOXUp6bxHftznjs=;
        b=bK6+nJl0diSx1T/qBqjWQhmohUheZsON0TEeBjuJJqx1db9UHJP4BUsGaK6HtM53pA
         NRzzroCU01p0zRV6p7mUkepTqghJrkBCt47QeFZIp/hEw+B4+d1OTO229hkW5d9UcZV8
         Ym9gbquI1LaMMVNH/5/mPcQgKUL6yyUQ2A1iOThwSUYiYURD/Drqd1YUNbl4FD9QPu61
         WlhEanscLRfuSYHjL3bQwctIfRL8fgqbmybMHNSPEegoxfaKSreWrwcJSyewrfP0taXk
         qTlNzCV62n44Joux+KT16KmW/NjJe6yuGRUyrzrJ0G2cSzfhjbF2CEFw6Qlnx0enOQ55
         c16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679317241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHQLKDsNWxNB5YBarDMklHQXAjopSOXUp6bxHftznjs=;
        b=sBhVBc2P2YxuhUJiC2g0cbYQuEY5mpAZpOG3VeMOdvWBXuHHxuvCI26IE8uzoD2VtS
         flgLumI+WxqwPZqJ8TfvGAieqAcWHVO5zo0oNTn9+nieQG/ki3ZJzcu9kz7JzPNaxPkk
         lIHNgbqNt5W8VEduD7EX0urX8K6MpO8Mdf4YMM2bJ1mF2awvPHpKN079esneUN7jLLSk
         y92wOIu2qXz6CElzTkPlnOxIKGPLps7qNtZc1uP7Q0j0akdzzCPSlUc53me4cHC1AT5L
         H+e6ypZTGC/l0Srh9HaDsDCUresuRVy7TJhRTJ/ulwBYtQ3yR6elJkeX+wMgldfF/8L4
         uFYQ==
X-Gm-Message-State: AO0yUKXtTqJEL2OctXX+oR3OZL/LS8nl7MY6KAxtXxFJW2vfwkTJzlWF
        JCPCD6Itr33Ht/NDmgMVx873PbJH4Hld0zJvbdI=
X-Google-Smtp-Source: AK7set/G2MvMeKPO/Odr5O9apRTPlkvldbgRaF02KrzSahR5AoedIreeoGkEs2IC0KPunEl9JNbouDatTXloEZBjCn4=
X-Received: by 2002:a62:a512:0:b0:5a8:a475:918f with SMTP id
 v18-20020a62a512000000b005a8a475918fmr5687638pfm.4.1679317241278; Mon, 20 Mar
 2023 06:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230320123956.181765-1-omosnace@redhat.com>
In-Reply-To: <20230320123956.181765-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Mar 2023 09:00:30 -0400
Message-ID: <CAEjxPJ7xMXaqwewRWhDNkrsViNOfpdSaHBUZ=sET7dDcqmpjyg@mail.gmail.com>
Subject: Re: [PATCH userspace] scripts/ci: install rdma-core-devel for selinux-testsuite
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 8:45=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> It is required to build it as of commit 4b4922e115e2
> ("tests/infiniband*: simplify test activation").
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Feel free to merge it.

> ---
>  scripts/ci/fedora-test-runner.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-ru=
nner.sh
> index 7676f6ea..331b9ec7 100755
> --- a/scripts/ci/fedora-test-runner.sh
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -61,6 +61,7 @@ dnf install -y \
>      e2fsprogs \
>      jfsutils \
>      dosfstools \
> +    rdma-core-devel \
>      kernel-devel-"$(uname -r)" \
>      kernel-modules-"$(uname -r)"
>
> --
> 2.39.2
>
