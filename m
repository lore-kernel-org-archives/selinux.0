Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CB7C4332F
	for <selinux@archiver.kernel.org>; Mon, 12 Dec 2022 15:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiLLPFx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Dec 2022 10:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiLLPFw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Dec 2022 10:05:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3913CEB
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 07:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670857490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVzVO74JLOF6iGbryaBGrclM3Bj7atgMQ+vEwSxz3sc=;
        b=aIpA9Vl5ss9o8dLHekNgaCdIbVqjwuSmaI/Ce3fpxvKV7bGjHZ4j1XDQPVUMzbq4WD9G1Y
        JGgZJ/wDzdBmHXu3+zPN6znh9CQKtkbgk+a1HT95VauM6k1muHEuMtipJ7pnyvEbmBUORj
        t3eEjTC9HO1P8PoGV6GNO8D6KAbu4x4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-AKg_vjh6NsuUkusQrIcc4Q-1; Mon, 12 Dec 2022 10:04:48 -0500
X-MC-Unique: AKg_vjh6NsuUkusQrIcc4Q-1
Received: by mail-pl1-f200.google.com with SMTP id p6-20020a170902e74600b001896ba6837bso10684728plf.17
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 07:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVzVO74JLOF6iGbryaBGrclM3Bj7atgMQ+vEwSxz3sc=;
        b=WyAgkRoty9T6yKv+kD4c8t8tk2bH9FRj2iEkXGwvtNXLBfKitEaqmfHxMpnehJhfSA
         nD/x5iyAKMVZRucVpdm+KgdF/2z2xA5boavdQKkOpixzZm/3a7ABA5af3VNZEKyjrYUI
         BRY8zAky2xeschJi6253WEosBk7fsGK8Nm3pjC/7BBT85SUzLPNIbrpZ15w0LbTai1zk
         oqbO5cyMQL+5+5UbMpB1VNc+ABDh788IRYC0SqTxqNESAXYkBN648NFqGGQkS4kox31B
         vL/VICzXwBz1vlrgk0zk7dunoQJ/hOfjGOlMr/VR0eGB8HOfF2hTxvIoq0Fem1U6KTRF
         6jew==
X-Gm-Message-State: ANoB5pk+Jc0ZZ5peQQpjkftYtJeUMIpkJIPyeiWiPImKTYC1E73gQebe
        gsFrfXY386ZRaTM24jZVd4DAOzxgQIFlu9y10DmkINZcClebFEfnMx9xM4/9oUIarZQeRgWCHIJ
        rvsl1EmQzGOe3aMKlyvVO8iJU94yfveYBnw==
X-Received: by 2002:a05:6a00:188f:b0:578:72c4:252a with SMTP id x15-20020a056a00188f00b0057872c4252amr313847pfh.78.1670857487152;
        Mon, 12 Dec 2022 07:04:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4E/fVrr1N5RXdYw19JuEqw91Vr1HXQtADzYKJf7idtdhPDUDo42IfJx5qJ/AH0Efa2uiuMibaYOV86DAWfKLE=
X-Received: by 2002:a05:6a00:188f:b0:578:72c4:252a with SMTP id
 x15-20020a056a00188f00b0057872c4252amr313844pfh.78.1670857486832; Mon, 12 Dec
 2022 07:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20221208132522.309657-1-omosnace@redhat.com>
In-Reply-To: <20221208132522.309657-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 12 Dec 2022 16:04:35 +0100
Message-ID: <CAFqZXNsBb6ySF-UpyPpqhqyVtqYECGNm4oDnfo2MOVf2j=-SrQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/4] Bump Fedora versions in CI
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 8, 2022 at 2:25 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> ...and massage the code to satisfy the latest perltidy and -Wall -Werror
> with latest libselinux (plus other minor fixes found along the way).
>
> Ondrej Mosnacek (4):
>   tests: adapt style to new perltidy
>   tests: use correct type for context string variables
>   tests/execshare: remove special cases for arcane architectures
>   ci: bump Fedora versions
>
>  .github/workflows/checks.yml                  |  4 +-
>  tests/bounds/thread.c                         | 17 +++----
>  tests/dyntrace/parent.c                       | 13 +++---
>  tests/dyntrans/parent.c                       |  9 ++--
>  tests/execshare/parent.c                      | 16 ++-----
>  tests/exectrace/parent.c                      | 13 +++---
>  tests/filesystem/check_mount_context.c        | 13 +++---
>  tests/filesystem/create_file_change_context.c | 46 +++++++++----------
>  tests/filesystem/fs_relabel.c                 | 10 ++--
>  tests/filesystem/test                         |  2 +-
>  tests/fs_filesystem/test                      |  2 +-
>  tests/inherit/parent.c                        |  9 ++--
>  tests/keys/keyring_service.c                  | 15 +++---
>  tests/prlimit/parent.c                        |  9 ++--
>  tests/setnice/parent.c                        |  9 ++--
>  tests/tun_tap/tun_common.c                    |  4 +-
>  tests/tun_tap/tun_common.h                    |  2 +-
>  tests/tun_tap/tun_relabel.c                   |  3 +-
>  18 files changed, 99 insertions(+), 97 deletions(-)
>
> --
> 2.38.1
>

This series is now applied.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

