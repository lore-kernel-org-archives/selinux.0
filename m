Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67659ECAAD4
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 11:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiH3LQL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 07:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiH3LQK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 07:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C4F14EF
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661858163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYO3qwXFtHdbLH8D1H3rFuqW85sxfyMZPJEl8XwLH6U=;
        b=TWqzaesyBdrXKn4MwJKO0uJfUGTYHkfvDKLQMUFa61MyajiBlYGt7XjtuAroKZmp4lv8Q/
        DUwu79a77PaS4CMQCpHBsKcJm3bYbBdgo60e5rIL42t2CNaaVNlxnOqTNtM1kinkDM5i5v
        QPj8C8mQdG19k+XllnFlHl3/hooLHgM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-Yp9He_pZP2yaENlZKOQt4A-1; Tue, 30 Aug 2022 07:16:01 -0400
X-MC-Unique: Yp9He_pZP2yaENlZKOQt4A-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-33dd097f993so173370307b3.10
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 04:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MYO3qwXFtHdbLH8D1H3rFuqW85sxfyMZPJEl8XwLH6U=;
        b=WY+A5BoDcIPwKLBjnTza1nPeiC+n48QpAlIeoflx3D5evyFis4/Ylwa9kc8IknL8oj
         /LGRNNXCAjvbT9xvPFHfXpez7fsBGyrHG38bfc+ObyC5jiVYjNA1x3bGbYVJKK15bzWc
         sJSI8xRIfJbH5AnKUn9D/u2fCoWZ7D00mDBCoqu5JvbXOce0A0hjZLkIigAa4od37GNo
         zRind0hjSxwvggYRLXn4b0q/x5UKnTVxH/mPVZnC5cGWBA/vkep3XGP+PCP/eRePLhoO
         lzEw03M+PFljGFEwS7NaXD6unwkHLG7L+NeKvyyutHWq+PNgi5/gSyLNefrsbmh/uW/2
         xleA==
X-Gm-Message-State: ACgBeo079+eMtaNSWnc8q/+i8ub/49Xjpc+taDe4CU2iJsv/aOo0dyjz
        fcHrk24nIVf0JRhj0YUpGk2UiXEY8eJKHaFJtnHNdFUn2g7om6vpaISmq8g4JV/YE/1/Vmh2QOX
        LAC5DEuVEBIHYBEaAW/eyPUrvWEieqN1V3A==
X-Received: by 2002:a25:9bc7:0:b0:69a:ee03:25a4 with SMTP id w7-20020a259bc7000000b0069aee0325a4mr7530319ybo.445.1661858160974;
        Tue, 30 Aug 2022 04:16:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6qEQzrQwJ88OolowO3PbXc5/m//93/AHDsSVoSkFcMeLzFVlsiGxwuyWzW9gLKH8Zu7MNDoC6u7c3oYiq55OQ=
X-Received: by 2002:a25:9bc7:0:b0:69a:ee03:25a4 with SMTP id
 w7-20020a259bc7000000b0069aee0325a4mr7530309ybo.445.1661858160755; Tue, 30
 Aug 2022 04:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220826082948.30747-1-omosnace@redhat.com>
In-Reply-To: <20220826082948.30747-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 30 Aug 2022 13:15:49 +0200
Message-ID: <CAFqZXNvcko5gK=8cn4WUvO85Zt3+RY84ETX1=eGRstE9S0bx0g@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: remove more stray flag/temporary files
 with 'make clean'
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 26, 2022 at 10:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Building upon a similar cleanup being done in the binder test, remove
> any temporary files that may have been left behind by a failed or
> interrupted test run as part of 'make clean'.
>
> For now, skip doing this for the filesystem/fs_filesystem tests, as
> those can leave behind directories with mounts, which are harder to
> clean up reliably.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/bounds/Makefile            | 2 +-
>  tests/bpf/Makefile               | 2 +-
>  tests/capable_file/Makefile      | 2 +-
>  tests/entrypoint/Makefile        | 1 +
>  tests/execute_no_trans/Makefile  | 1 +
>  tests/fdreceive/Makefile         | 2 +-
>  tests/fdreceive/test             | 4 +++-
>  tests/file/Makefile              | 2 +-
>  tests/inet_socket/Makefile       | 2 +-
>  tests/inherit/Makefile           | 2 +-
>  tests/ioctl/Makefile             | 2 +-
>  tests/link/Makefile              | 1 +
>  tests/mac_admin/Makefile         | 1 +
>  tests/mkdir/Makefile             | 1 +
>  tests/mmap/Makefile              | 2 +-
>  tests/nnp_nosuid/Makefile        | 2 +-
>  tests/notify/Makefile            | 2 +-
>  tests/open/Makefile              | 2 +-
>  tests/ptrace/Makefile            | 2 +-
>  tests/readlink/Makefile          | 1 +
>  tests/relabel/Makefile           | 1 +
>  tests/rename/Makefile            | 1 +
>  tests/rxdir/Makefile             | 1 +
>  tests/sctp/Makefile              | 2 +-
>  tests/setattr/Makefile           | 1 +
>  tests/sigkill/Makefile           | 2 +-
>  tests/stat/Makefile              | 1 +
>  tests/task_getpgid/Makefile      | 2 +-
>  tests/task_getscheduler/Makefile | 2 +-
>  tests/task_getsid/Makefile       | 2 +-
>  tests/task_setnice/Makefile      | 1 +
>  tests/task_setscheduler/Makefile | 2 +-
>  tests/unix_socket/Makefile       | 2 +-
>  tests/vsock_socket/Makefile      | 2 +-
>  34 files changed, 36 insertions(+), 22 deletions(-)

Now applied as:
https://github.com/SELinuxProject/selinux-testsuite/commit/724807fba3c7a5946d50674961be8b9b2ec1535f

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

