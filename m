Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66B7C2D0A3
	for <selinux@archiver.kernel.org>; Mon,  9 Nov 2020 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FCE206E3
	for <selinux@archiver.kernel.org>; Mon,  9 Nov 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5XZzp5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgKIPHu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Nov 2020 10:07:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730470AbgKIPGQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Nov 2020 10:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604934375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yq6VFIAuXfDFwmqcVflZ/Q/zLk3yy4N9mqlQK8Vd4G4=;
        b=i5XZzp5XbvBD1afLGxK14oyz68h6xUf9cRAWvQw+5CVs11r9KKbD8xfNkPN3r5sO9VgC2q
        e67gQtIxSZVc5g4IH7LpWgz+X45lraOIkdzN3GZuGQVRpUKmaL9Vz3kXclMPTa0CfqbI8X
        qGEViqMBfgT00fG3+XuvkBmBAjYkZiU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-YugQrZZ3Oe29Y1UAA3y-zg-1; Mon, 09 Nov 2020 10:06:11 -0500
X-MC-Unique: YugQrZZ3Oe29Y1UAA3y-zg-1
Received: by mail-lj1-f199.google.com with SMTP id r26so449264ljc.12
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2020 07:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Yq6VFIAuXfDFwmqcVflZ/Q/zLk3yy4N9mqlQK8Vd4G4=;
        b=pWU/4JEt+tjJSYGw/I7UyG75F6uR1vt2CBPXie/V3QGjr6qIg8o6rbcKZI22bCzGLl
         2G8l43wTFxTANczseZlIcEnxUPPEd3Wu4ffBxApMs6LwPpp3zRd+4PBJ217AVl3gD+QG
         5J8PjFXcalniJqzyUHI65JZJCEst8JHk8/0FmCZgGuy8T4T+Yh3AO5oGBXXYGmh24/h5
         UNqQpk3loXj0D5NhPNrNy7Y3ltIH09mfcqBHz9rb/ewpLm9gROoC5xETAO2UXM5WYoGZ
         rsxNP4nxn8n7pUIxIQmxZwdJsBECEn3BY29uk5Ng7HwSTosqiwe0/qrdcw3frSmBsw+C
         qLtQ==
X-Gm-Message-State: AOAM531MTgFboFr7igucB16/lyKRvTbAwdhzKF2jzP0uAgQhQ0oC9cKE
        UfjS5LZ7Kew3gLmPHH4uXse3C2nSenxTwSTAn4Lbl8sVgOT3E/2iHd2nUFZixjm7cUhyHlzP1qL
        5vZ19e2ucTBgTPqzBuCpr9ocUHFixN2+HcA==
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr6224370lff.9.1604934369922;
        Mon, 09 Nov 2020 07:06:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0cGpfyti/IHVzbh0VXc76R8yWnHgaILZZmMv0/Qh/DYI1KtCDiaUQVoRXuje5jqXqHJu679I7E6TVnSXcJPc=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr6224367lff.9.1604934369751;
 Mon, 09 Nov 2020 07:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20201104073456.820079-1-omosnace@redhat.com>
In-Reply-To: <20201104073456.820079-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 9 Nov 2020 16:05:59 +0100
Message-ID: <CAFqZXNuAiYZ2nRrDs2y2oWywg8_BkCdQpxfdET8nPH-oFnuRFA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/overlay: replace Python script with a C program
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 4, 2020 at 8:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This was the only Python script in the whole testsuite. No need to
> depend on Python just for access(2)...
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/overlay/.gitignore |  1 +
>  tests/overlay/Makefile   |  4 +++-
>  tests/overlay/access     |  7 -------
>  tests/overlay/access.c   | 16 ++++++++++++++++
>  tests/overlay/test       | 26 +++++++++++++-------------
>  5 files changed, 33 insertions(+), 21 deletions(-)
>  create mode 100644 tests/overlay/.gitignore
>  delete mode 100755 tests/overlay/access
>  create mode 100644 tests/overlay/access.c

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/ce70a925a4c7766fab698330a626d9a5f5194cc5

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

