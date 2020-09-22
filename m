Return-Path: <SRS0=6DiJ=C7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EFCC2D0E2
	for <selinux@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2B920756
	for <selinux@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp2rYJor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVMPr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbgIVMPr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Sep 2020 08:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600776946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MUMp0v7P3PoxkyWOL02ypnwnKbVxl2VDplgMdehXhG4=;
        b=Zp2rYJor5o10Q7AIJksgS2keAbyasKsF6EmGzVbQ3ep3FH1rFoyzihTupO+hUdKEaUCAto
        2w+YJXtHGA8hdH3YbsXHUzLobUqM5OMdw8gmnBj6bMkFsVUxtw/im+XXsM22+bVQKUdjw+
        WLLVJZw6q4VciAPTqm0pZlxs0gAV7ls=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-jn76K80qNIih7bZgN6UiXg-1; Tue, 22 Sep 2020 08:15:44 -0400
X-MC-Unique: jn76K80qNIih7bZgN6UiXg-1
Received: by mail-lj1-f199.google.com with SMTP id j4so4767663ljo.1
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2020 05:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUMp0v7P3PoxkyWOL02ypnwnKbVxl2VDplgMdehXhG4=;
        b=A+96N1Anj/DzS5FbyzvQz7ipL4pviNHnrpDtJDcfzicV53kdZggmr23LGLtebAnxKK
         ekWDcR0+59DgqSMdbZIO/bs3KqURRWh7o1VLMCm28/wHnbnXW6muLU+qs2Cm6Zbeec8Y
         gh418jfO9owBOaiOiMHG4mjSgG2w/q/k09n66e7jEjX53yRAFR+xwxf1v37pyXHaqkZ8
         1QuU3PVUVKeBzo2A1PeFosfUkc3X0vEOOfSR2nVI2XbrMGnaCXyYoaMIg0KIFpWr86ux
         +4aU+G8F3X2vmjihcVZJ4N9TT+QXYgthSHxXJg0E1bpd7v0f05o5oUiQxxUye3Xe7VZq
         l+ww==
X-Gm-Message-State: AOAM533nOAXliK1zlSNQovVaU2Fqt70XO2z0Z2cBdmu2iEcZyIuXrB1p
        MGVg6u6keFY7Xi0r4txY9Gt/hlWtEcbV2cVvkpYRD+b9j+LtrwWRsETwZ1Zfi4GfHL6WKPeK2wA
        R3CcgutqM2r7xpr8Y/WEhOtCLvndzr5CdQQ==
X-Received: by 2002:a05:651c:10d:: with SMTP id a13mr1338170ljb.217.1600776942573;
        Tue, 22 Sep 2020 05:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBaxCyRjB3ZXrUeN3eKjUogg75vZ299eIXO2RbIYtF1TW68BY7I5yUadh+k1PjU+MIU63RDXfkzUXeUmb3O5s=
X-Received: by 2002:a05:651c:10d:: with SMTP id a13mr1338161ljb.217.1600776942315;
 Tue, 22 Sep 2020 05:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200922085902.18315-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200922085902.18315-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 22 Sep 2020 14:15:31 +0200
Message-ID: <CAFqZXNuO4kxFSum5-XVfNY+v8L84OMHaFyrMqyB8quWpyvPvhA@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Update SCTP asconf client/server
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 22, 2020 at 10:59 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> The main changes have been to sctp_asconf_params_client.c and
> sctp_asconf_params_server.c to make them more reliable for running the
> client and server on different systems.
>
> Updated common code in sctp_common.c for sctp event handling and updated
> relevant programs to use handle_event()
>
> Removed obsolete code/policy.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes: Indent line, fix typo and increase timer to 3 secs as per
> Ondrej comments.
>
>  policy/test_sctp.te                    |  75 ++++-
>  tests/sctp/.gitignore                  |   1 -
>  tests/sctp/Makefile                    |   3 +-
>  tests/sctp/sctp_asconf_params_client.c | 322 ++++++++-----------
>  tests/sctp/sctp_asconf_params_server.c | 275 +++++++++-------
>  tests/sctp/sctp_common.c               | 189 ++++++++++-
>  tests/sctp/sctp_common.h               |  12 +-
>  tests/sctp/sctp_peeloff_server.c       |  42 +--
>  tests/sctp/sctp_server.c               |   4 +-
>  tests/sctp/sctp_set_peer_addr.c        | 415 -------------------------
>  tests/sctp/test                        |  70 ++++-
>  11 files changed, 623 insertions(+), 785 deletions(-)
>  delete mode 100644 tests/sctp/sctp_set_peer_addr.c

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

