Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D3DC433E3
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47FF20772
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoERKXE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgFCOuU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:50:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725986AbgFCOuT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 10:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591195815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKKY9UH7ZifudGhiYZ0QJvd+ZOjEfivIHjJDkKQ9lio=;
        b=aoERKXE7pAYf6ChLj/XxSkXT74R0bqv9j0MxeYJoy6z2jHtV37W8+19FLFERSyPm16IptB
        H1kZXqrulN+J3tCdDZ6Gt8GI7XzABNZQcjIEAv5es7AzQvEq4J3qLIvqy3BYpFeZOqYWhV
        Z9UJMAhRw26ojR/b/b7d9Dl5AbUA5kc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-736GEI4kM3urDBqoQ94ZPg-1; Wed, 03 Jun 2020 10:50:14 -0400
X-MC-Unique: 736GEI4kM3urDBqoQ94ZPg-1
Received: by mail-oo1-f70.google.com with SMTP id o21so1667540ooo.19
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2020 07:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKKY9UH7ZifudGhiYZ0QJvd+ZOjEfivIHjJDkKQ9lio=;
        b=m0yd8hZIgAbA6pwNf8/Qz2HuIlC/q93HeZSmZFzogqpljTSKZmJ0rI5K7Nlxky6a/9
         7p3KBvLYU48aiXXVYnJ368DP17eFo/WAwxlHYFGZCsNkg0D4sAPuc/s39ibdEyo8HKKs
         ytl2hZGyB0b5TIxMbI3wlx/lggJ7FaGO6WANtzFOjvAxi94nD+YkSsMixzO2EfWwx5Ff
         AFaXScVQqzeUR/fwmtmKhRXmggQ44VhDippW6BuVP5cBIIWIXOiwuSLlmF64+pKQKemV
         tiuYOOGwMM0c/dzB+LjiSs71H90pCvEHxwmrCNuBcT7GIXyN9jdXlidK7UtMzz4XGAlO
         a7XA==
X-Gm-Message-State: AOAM531W3hlXF/GkWnZklsPdNnkg+a5/RuAxc25j6WQNLTVVRK+eK3pI
        tcsl2LzSCwjG2enUsemm3EHDnhHTtAPAKIeJ0bGemeZd5FEz1zOR0uZ0Iu547u8yPrz75MWudAU
        +XeFIVx5Y7SLXsaw7B8kohJdXg2Mz3Vn80Q==
X-Received: by 2002:a9d:1727:: with SMTP id i39mr214422ota.367.1591195813560;
        Wed, 03 Jun 2020 07:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDgiv7RzKYXOL38mTM1Q4XV+9XIyc/CYadzzBrJriRnMC+Z3BPiUoL9vJosc8AQBwMmgcgca0OX7k/Tw5yCnQ=
X-Received: by 2002:a9d:1727:: with SMTP id i39mr214401ota.367.1591195813275;
 Wed, 03 Jun 2020 07:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200603110048.19293-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200603110048.19293-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 3 Jun 2020 16:50:01 +0200
Message-ID: <CAFqZXNvLJudp0hydL5j6y1LmtcN9kNmLQ8f7eAC5+867tFYyQw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Review and rework sctp tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Richard,

On Wed, Jun 3, 2020 at 1:01 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> The main changes have been to sctp_asconf_params_client.c and
> sctp_asconf_params_server.c to make them more reliable for running the
> client and server on different systems.
>
> Updated common code in sctp_common.c
>
> Removed obsolete code that was used to test permissions that never made it
> to the final commit.
>
> Also reviewed and updated tests to check policy rules for denying
> access to all possible net/sctp kernel hooks as described in the kernel
> Documentation/security/SCTP.rst

This looks promising, but would it be possible to split the patch into
a series of smaller changes? It is hard to review such a large patch
that changes a lot of things at once...

>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  policy/test_sctp.te                    |  98 ++++--
>  tests/sctp/.gitignore                  |   3 -
>  tests/sctp/Makefile                    |   2 +-
>  tests/sctp/sctp_asconf_params_client.c | 320 ++++++++-----------
>  tests/sctp/sctp_asconf_params_server.c | 269 +++++++++-------
>  tests/sctp/sctp_client.c               |   4 +-
>  tests/sctp/sctp_common.c               | 189 ++++++++++-
>  tests/sctp/sctp_common.h               |  12 +-
>  tests/sctp/sctp_connectx.c             |  33 +-
>  tests/sctp/sctp_peeloff_server.c       |  42 +--
>  tests/sctp/sctp_server.c               |   4 +-
>  tests/sctp/sctp_set_params.c           | 205 ------------
>  tests/sctp/sctp_set_peer_addr.c        | 415 -------------------------
>  tests/sctp/sctp_set_pri_addr.c         | 135 --------
>  tests/sctp/test                        |  95 +++++-
>  15 files changed, 688 insertions(+), 1138 deletions(-)
>  delete mode 100644 tests/sctp/sctp_set_params.c
>  delete mode 100644 tests/sctp/sctp_set_peer_addr.c
>  delete mode 100644 tests/sctp/sctp_set_pri_addr.c
>
> diff --git a/policy/test_sctp.te b/policy/test_sctp.te
> index 3b16db1..380e442 100644
> --- a/policy/test_sctp.te
> +++ b/policy/test_sctp.te
> @@ -60,6 +60,12 @@ corenet_sctp_bind_all_nodes(test_sctp_server_t)
>  corenet_inout_generic_node(test_sctp_server_t)
>  corenet_inout_generic_if(test_sctp_server_t)
>
> +# Don't allow ports < 1024
> +# neverallow test_sctp_server_t self:capability net_bind_service
> +# neverallow test_sctp_server_t reserved_port_t:sctp_socket name_bind;
> +dontaudit test_sctp_server_t self:netlink_route_socket { create getattr bind };
> +dontaudit test_sctp_server_t self:udp_socket { getattr connect };

Could you clarify what these dontaudit rules are for?

That's the only thing that caught my eye after a quick glance. I'm
still hoping you will be able to split up the patch into more
digestible chunks, so I'm not going to look at it deeper just yet. If
that proves impossible or too difficult, I'll try to review the patch
as-is, but please understand that it may take a long time then...

Thanks,

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

