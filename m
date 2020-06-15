Return-Path: <SRS0=CKju=74=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6425BC433E0
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4080420679
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 12:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpFEbjbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgFOMJI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:09:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54225 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728285AbgFOMJH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 08:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592222944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3C8DgK1H3aFbg2HcxL6K8eKwAZrwqKGRo2f/CZyHog=;
        b=PpFEbjbVwGoj2Ygm6+98howiUKSJw5LwaArkMenyrzukPrXMB/Me4SA2QW4xWQKUEVbBpD
        OU1Dt2wa6N/wCypjl5B25EnRnellD0W2+amOoYIj5jxs083dxlAQ5f+nuIq5x+Z0dYyi11
        M3AOm4fuMAjO5C6ZsH7NQSa6jeIuzeM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-f-6ONzJoP5OFPNSnCZ-JEQ-1; Mon, 15 Jun 2020 08:09:02 -0400
X-MC-Unique: f-6ONzJoP5OFPNSnCZ-JEQ-1
Received: by mail-lj1-f197.google.com with SMTP id d17so2492002ljo.6
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 05:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3C8DgK1H3aFbg2HcxL6K8eKwAZrwqKGRo2f/CZyHog=;
        b=kK0JjjZ3wZqy3UT8DfwsqQC4o52QdW58x0x4Jhp/GOcBWMazYdkASsWoJrxEPPhpG8
         n5o4t02hgi0HKF7p/RrlujrklAbHwITE9uwErhT+0dYO5/7WVQXzsEn1Dtv8cTqdPIaz
         f5U1+xUMc130NnlzeQf22ovEUYYQeyWMyjCM+dpDaP85S2LqG/OFdpm8JqYURvRF9RHm
         rZbf5dlTE69FNLSdVxrh1prrcsKjTiEqnZUpNIk5sonvIfDQabfKEYxP9p5aocWd7Q0f
         wF9deaq55dZF6bZdHrgGEEX7gRKjR5Ry4DEdStqAoNJzzpSJlq8yeBYoEKlaZ7DcIJzb
         sKVQ==
X-Gm-Message-State: AOAM530W8VKgNUMTtF4ejf6R6tWlA6210xsLgCW9Xg3kFkPCbF1JoT5v
        Ch60WWRBjnphDupz45m5QJoLjndC50EN/9O5I3qZaCbdUViMkoA1FfrsXdL0C7B4tnKa2DnK+GX
        vM+yAdMZNWIgKe+LwgL6cDW0/esYuxUUUWA==
X-Received: by 2002:a05:651c:30e:: with SMTP id a14mr13386289ljp.311.1592222940003;
        Mon, 15 Jun 2020 05:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNGYu24BbXT1Kj91jDeDvJeIW94A+kHQCmXnyHm9+YZSuxy7tMBYPhqOW5wlGWQfYGUdIf4TCLPk3qrQ78M50=
X-Received: by 2002:a05:651c:30e:: with SMTP id a14mr13386281ljp.311.1592222939742;
 Mon, 15 Jun 2020 05:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200515131222.7969-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200515131222.7969-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 15 Jun 2020 14:08:48 +0200
Message-ID: <CAFqZXNuv=J6aO6P5M2TqYa7nXpd8GC1+=-Oqz=5khioo2S7uzA@mail.gmail.com>
Subject: Re: [RFC PATCH V2] selinux-testsuite: Add check for key changes on watch_queue
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        David Howells <dhowells@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 3:12 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Kernel 5.? introduced the watch_queue service that allows watching for

(I will fix up 5.? to 5.8 when applying.)

> key changes. This requires key { view } permission, therefore check if
> allowed or not.
>
> Note that the keyctl_watch_key() function is not yet built into the
> keyutils library, therefore a syscall() is used.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> Tested on kernel.org 'linux-next: next-20200514'

I tested the patch on the latest Rawhide 5.8-rc1 kernel build and it
seems to work fine.

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

> V2 Changes:
> 1) The watch_queue changed from using /dev/watch_queue to pipe2(2), therefore
> update watchkey.c
> 2) Update policy to reflect the changes.
>
>  defconfig                 |  5 +++
>  policy/Makefile           |  2 +-
>  policy/test_watchkey.te   | 27 +++++++++++
>  tests/Makefile            |  4 ++
>  tests/watchkey/.gitignore |  1 +
>  tests/watchkey/Makefile   |  7 +++
>  tests/watchkey/test       | 29 ++++++++++++
>  tests/watchkey/watchkey.c | 94 +++++++++++++++++++++++++++++++++++++++
>  8 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 policy/test_watchkey.te
>  create mode 100644 tests/watchkey/.gitignore
>  create mode 100644 tests/watchkey/Makefile
>  create mode 100755 tests/watchkey/test
>  create mode 100644 tests/watchkey/watchkey.c
[...]
> diff --git a/tests/watchkey/watchkey.c b/tests/watchkey/watchkey.c
> new file mode 100644
> index 0000000..c7f3274
> --- /dev/null
> +++ b/tests/watchkey/watchkey.c
[...]
> +       fd = pipefd[0];
> +
> +       result = ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to set watch_queue size: %s\n",
> +                       strerror(errno));
> +               exit(-1);
> +       }
> +
> +       save_errno = 0;
> +       /* Requires key { view } */
> +       result = keyctl_watch_key(KEY_SPEC_PROCESS_KEYRING, fd,
> +                                 WATCH_TYPE_KEY_NOTIFY);
> +       if (result < 0) {
> +               save_errno = errno;
> +               fprintf(stderr, "Failed keyctl_watch_key(): %s\n",
> +                       strerror(errno));
> +               goto err;
> +       }
> +       if (verbose)
> +               printf("keyctl_watch_key() successful\n");
> +
> +err:
> +       close(fd);

Minor nit: we should actually close both pipefds here (the write end
(pipefd[1]) is unused, but according to strace, the kernel does return
a valid fd there, too). Also, there is one error path that just calls
exit(-1) instead of closing the descriptors. Anyway, since this is
just a test program and the kernel closes the fds at exit anyway, I'm
not going to hold up the patch because of it. Feel free to send a
separate patch if you'd like to clean it up.

> +       return save_errno;
> +}
> --
> 2.25.3
>


--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

