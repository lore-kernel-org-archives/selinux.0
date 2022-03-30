Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B272C433EF
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 15:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348370AbiC3Poc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348367AbiC3Poc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 11:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B01634644
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648654966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9AS1z2582a3FJfxqzeg5TjkcghP2NURNzVpfyoBZJ3w=;
        b=HAbxtFlYi43Nues/1M2rbLkV+OCegHAQJmFc14dKIRHG0QAiLFAS8daa5e4RRWErSZkUgI
        t0IDCH1lDAqnRvCFoaWGuVXN0zrP2LbTZdkoes424UUDjcnOaDeml80jWD2+wyO9q7BjYz
        HEEKxMFKVty8k/2jE+GMrTr5DUwlD7M=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-9wReCudPO_y5veyrpedU_g-1; Wed, 30 Mar 2022 11:42:44 -0400
X-MC-Unique: 9wReCudPO_y5veyrpedU_g-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-2e61c5a0eb7so172557067b3.22
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AS1z2582a3FJfxqzeg5TjkcghP2NURNzVpfyoBZJ3w=;
        b=folIG73MNpKbYhknV3TdJR7SZeZeJOuqypv6Lyrl4yRcjG+VshCp/yF1tJinoWr2vZ
         hZrJJIOd2AuJHWfLu4IbCV2mCAxqdfTA555hlKpEfNCBGA/rcXIb4IQu2BQSERKi9nkF
         aZ71zaGxJ09MwLEo+9p9OIKv47kt1gwYc/BVBU88swkLEn+VpXaZIkT4BxjKKHZq0r4H
         i6J3GwNsZbuMi+e/dJ9swe6vTOfjghuka+4mNitv/QyTGDewCclamBBE3YJ1t+a/AkLE
         Xt3w7oAwogQwFvgM5fryM/uhGZtAX0WubLET9aX/EH6pHajHHaAUvGv8Fqz4YQ4Z0IbE
         wcAQ==
X-Gm-Message-State: AOAM532FwlMlSHGWARnAZgRvX+KbBNduRlO0i3dtp8Tq5DCf5AVfNIim
        ttbFIO5hg3mDqYtcAY6OE+2RTigjO1br7knb2xqCuAl0s+7u0nyTIKHdaGiuU98XTdaPgVVXoqR
        9IPH1UC6JGI3ZGKiuUzDigXreHhdzTZvsBQ==
X-Received: by 2002:a25:b9ca:0:b0:619:649f:1bf6 with SMTP id y10-20020a25b9ca000000b00619649f1bf6mr226423ybj.196.1648654963655;
        Wed, 30 Mar 2022 08:42:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUJPvKGKJLPlLXjGC1EjmiTo6Peb7dfw5Xc6tnNubWjjZm9U464gx/aKvFlQ4G82cWN7cO1aiRj0fEQRXZP2s=
X-Received: by 2002:a25:b9ca:0:b0:619:649f:1bf6 with SMTP id
 y10-20020a25b9ca000000b00619649f1bf6mr226408ybj.196.1648654963442; Wed, 30
 Mar 2022 08:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220324095251.1561597-1-plautrba@redhat.com> <20220324120034.1570408-1-plautrba@redhat.com>
In-Reply-To: <20220324120034.1570408-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 30 Mar 2022 17:42:32 +0200
Message-ID: <CAFqZXNstUu0s4P2iXPmdvdu-86_tajuV+RQKzMK_+xYBk-y+bw@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: Fall back to semanage_copy_dir when
 rename() fails
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Joseph Marrero Corchado <jmarrero@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 24, 2022 at 1:01 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> In some circumstances, like semanage-store being on overlayfs, rename()
> could fail with EXDEV - Invalid cross-device link. This is due to the
> fact that overlays doesn't support rename() if source and target are not
> on the same layer, e.g. in containers built from several layers. Even
> though it's not atomic operation, it's better to try to copy files from
> src to dst on our own in this case. Next rebuild will probably not fail
> as the new directories will be on the same layer.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/343
>
> Reproducer:
>
>     $ cd selinux1
>
>     $ cat Dockerfile
>     FROM fedora:35
>     RUN dnf install -y selinux-policy selinux-policy-targeted
>
>     $ podman build -t localhost/selinux . --no-cache
>
>     $ cd ../selinux2
>
>     $ cat Dockerfile
>     FROM localhost/selinux
>     RUN semodule -B
>
>     $ podman build -t localhost/selinux2 . --no-cache
>     STEP 2/2: RUN semodule -B
>     libsemanage.semanage_commit_sandbox: Error while renaming /var/lib/selinux/targeted/active to /var/lib/selinux/targeted/previous. (Invalid cross-device link).
>     semodule:  Failed!
>     Error: error building at STEP "RUN semodule -B": error while running runtime: exit status 1
>
> With the fix:
>
>     $ podman build -t localhost/selinux2 . --no-cache
>     STEP 2/2: RUN semodule -B
>     libsemanage.semanage_rename: Warning: rename(/var/lib/selinux/targeted/active, /var/lib/selinux/targeted/previous) failed: Invalid cross-device link, fall back to non-atomic semanage_copy_dir_flags()
>
>     COMMIT localhost/selinux2
>     --> d2cfcebc1a1
>     Successfully tagged localhost/selinux2:latest
>     d2cfcebc1a1b34f1c2cd661ac18292b0612c3e5fa71d6fa1441be244da91b1af
>
> Reported-by: Joseph Marrero Corchado <jmarrero@redhat.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> v2
> - improve the commit message
> - use WARN() instead of fprintf(stderr,
>
> v3
> - WARN without \n at the end
> - split long line

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Note that I didn't give the logic a thorough review, so I'd prefer
someone else to give it a final look and merge it.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

