Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92853C433F5
	for <selinux@archiver.kernel.org>; Mon, 22 Nov 2021 11:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhKVL71 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230425AbhKVL70 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Nov 2021 06:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637582179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wv9IgKbPhGDJ9b6u3OmzjkSEhN7fjEKVN9rjBjy86PA=;
        b=VcH5zr3FBxQ87+rbrYhX2Zi+X4/l+KUBBk1ETsBK8fPSHmAoTeDB6FpUwx40kk9+b+paEv
        jeHk+bU9ULkIKYkThFsskEtRho+J8AhbE5i7SyARRIb5/3j3Y0RRO93gzVvc3pPJlVX3Dp
        e6SGTV9/k9UtWjoe2oARuIHN9V9BHns=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-2BaUlB6UNe-8dou-RQVY2g-1; Mon, 22 Nov 2021 06:56:18 -0500
X-MC-Unique: 2BaUlB6UNe-8dou-RQVY2g-1
Received: by mail-yb1-f199.google.com with SMTP id q198-20020a25d9cf000000b005f7a6a84f9fso6724474ybg.6
        for <selinux@vger.kernel.org>; Mon, 22 Nov 2021 03:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Wv9IgKbPhGDJ9b6u3OmzjkSEhN7fjEKVN9rjBjy86PA=;
        b=U52/ktmN7czOo5+549uxrCx56aiRgUPD1pc/kFWxnXZHR9+EQeY7CPjE94XV2z6b+q
         fg7v6v34vh4vxM3mYQFbk2rJBIKJq/5ix+MHEBilFBxggTENgHsDAb7HBRRK64HBhIBa
         vY0McTcAj3ocpPjEy32hChyxQfGpF2Z2vaj8IUO6vogmekKeL4rhrddJq/PGro5rghGB
         4c98NzLdfHTt0DR9rFa7QvK0O6KdKCno9v5QQyn+lmJvcXB/iJl+7QkjlM2ZgNoEWUNU
         Kwggvu3Cp/KnrkJJ74boH9rmcVGum1yVqj3uU6UK+TEPw81zA6te9nWvvQ98cmLGlbXi
         D0jw==
X-Gm-Message-State: AOAM532wuVeH48VBMWWEOyr+LEjeXnvBD5ItqrgO5IG2wVryANVOWNoy
        XJFGwVaylGePeoAa8XOtX7F7ND0Unzyv8/Srvb4QfhlDdOYsipnaeVh8V49u9cDRHITEn7uxfeY
        7Bf0c6ABrgjzK9A2rRlzZa/fB+N+Nx+jUXQ==
X-Received: by 2002:a25:d55:: with SMTP id 82mr63381123ybn.237.1637582177687;
        Mon, 22 Nov 2021 03:56:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4v7nHvjHw4tXoo9hAI0qi5kL2LxOEdMw96ANMXUe+FyXx/2+9lenLA07e+Lk4TXw6cCZkHfqDVCPgKCxnqi0=
X-Received: by 2002:a25:d55:: with SMTP id 82mr63381101ybn.237.1637582177480;
 Mon, 22 Nov 2021 03:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20211026115239.267449-1-omosnace@redhat.com>
In-Reply-To: <20211026115239.267449-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 22 Nov 2021 12:56:06 +0100
Message-ID: <CAFqZXNusb5FUnXYKFrjc1Rxh-M-2man4TCLUZR56mPtrkrdDhA@mail.gmail.com>
Subject: Re: [PATCH userspace v4 0/8] Parallel setfiles/restorecon
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 26, 2021 at 1:52 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This series adds basic support for parallel relabeling to the libselinux
> API and the setfiles/restorecon CLI tools. It turns out that doing the
> relabeling in parallel can significantly reduce the time even with a
> relatively simple approach.
>
> The first patch fixes a data race around match tracking in label_file.
> Second patch is a small cleanup found along the way. Patches 3-6 are
> small incremental changes that various functions more thread-safe.
> Patch 7 then completes the parallel relabeling implementation at
> libselinux level and adds a new function to the API that allows to make
> use of it. Finally, patch 8 adds parallel relabeling support to the
> setfiles/restorecon tools.
>
> The relevant man pages are also updated to reflect the new
> functionality.
>
> The patch descriptions contain more details, namely the last patch has
> also some benchmark numbers.
>
> Changes v3->v4:
> - add a patch to fix a pre-existing data race in is_context_customizable()
>
> Changes v2->v3:
> - add a patch to fix a pre-existing data race in label_file
> - wait for threads to complete using pthread_join(3) to prevent thread leaks
>
> Changes v1->v2:
> - make selinux_log() synchronized instead of introducing selinux_log_sync()
> - fix -Wcomma warning
> - update the swig files as well
> - bump new symbol version to LIBSELINUX_3.3 (this may need further update
>   depending on when this gets merged)
>
> Ondrej Mosnacek (8):
>   label_file: fix a data race
>   selinux_restorecon: simplify fl_head allocation by using calloc()
>   selinux_restorecon: protect file_spec list with a mutex
>   libselinux: make selinux_log() thread-safe
>   libselinux: make is_context_customizable() thread-safe
>   selinux_restorecon: add a global mutex to synchronize progress output
>   selinux_restorecon: introduce selinux_restorecon_parallel(3)
>   setfiles/restorecon: support parallel relabeling

A friendly reminder that these patches could use a review/ack :)

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

