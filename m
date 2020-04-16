Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4206C2BA2B
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 20:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DB32076D
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 20:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4RzJRfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgDPU0R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:26:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727925AbgDPU0Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 16:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587068775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYY3M6oazH06YD8lWfqX1B+1sToM9V5UW/8YKEQOIgI=;
        b=g4RzJRfhWrCdR4C1sXKjfhlcFySbLe8QfCxbIaZkH9J9CN5bpQ9af0U3eInTX967qkkCVV
        xp5+BI838lt0toR8JUJibNXjQ+PsdmNEloizTjXkbKGmWRTbNiE5NMA42BEnQNlPE1JFc+
        EPs6m8MEUo9O/LgjCWw1yU8MsbANXKs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-qfjvBdpxMcmldhTsFcXtEQ-1; Thu, 16 Apr 2020 16:26:13 -0400
X-MC-Unique: qfjvBdpxMcmldhTsFcXtEQ-1
Received: by mail-oi1-f199.google.com with SMTP id x2so88785oif.18
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 13:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYY3M6oazH06YD8lWfqX1B+1sToM9V5UW/8YKEQOIgI=;
        b=NV51otcWaeuFVIxAwCbqlnOsULu5iUTFRTUmg4D08NRz79ReVa7+TlgvapuCv4hMKp
         FdOPuY0hh06kySM2rcsNAApsGmePewAJnhO0hErwBjSq0FCMmE8aLcGsmz11/XkZRjsD
         LWyW5AK9yytDM84FGDg0W2yWIGjG1/nqz74rW2RHnm4UkWivGR+LpdI7eRXbNMOvF/7d
         4a+hZTaxa3H6gq4AguXzgVTqmocDXjdHpEQlw9yceyyMFOuK503hn79ZD58/0uX71TOi
         P1hX2w3BrRpFMLSEgUgB9txAtklM6es1g8e9lyAA16kbunJpeJ1V+P47Cyf5qGQwTJCI
         B6Qw==
X-Gm-Message-State: AGi0Pubju02zD+0j5C9mxWz7uX2CZW/lKPsm0MYYB2iEtoZ+jG8hbZie
        V3sMcGFTO8aAxpgKoG6wdhHwoSv3+TGt0Uu5MddfTS8kQ3WgvMlkT3N9h/FvgA3ui98lD6qJTBU
        CDU6CZtiQ10flCY7ZM0VPEXTi3H2A9P5Vxw==
X-Received: by 2002:aca:488a:: with SMTP id v132mr4244293oia.166.1587068771934;
        Thu, 16 Apr 2020 13:26:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypJBEffm/qpz2MX4XIZ2JgHs8Wmb0+FkYWs59gVMJDAhRZrQvhYBRaXMi2BawMuOX/WYev627USyF0SpcxyVPPM=
X-Received: by 2002:aca:488a:: with SMTP id v132mr4244280oia.166.1587068771527;
 Thu, 16 Apr 2020 13:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200416124110.541408-1-omosnace@redhat.com> <20200416124110.541408-2-omosnace@redhat.com>
In-Reply-To: <20200416124110.541408-2-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Apr 2020 22:26:00 +0200
Message-ID: <CAFqZXNuAnSVPuskEQHhon3OERThO-s3xT+1PHD_e-u+LtPHgdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: hash context structure directly
To:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 2:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Always hashing the string representation is inefficient. Just hash the
> contents of the structure directly (using jhash). If the context is
> invalid (str & len are set), then hash the string as before, otherwise
> hash the structured data. Any context that is valid under the given
> policy should always be structured, and also any context that is invalid
> should be never structured, so the hashes should always match for the
> same context. The fact that context_cmp() also follows this logic
> further reinforces this assumption.
>
> Since the context hashing function is now faster (about 10 times), this
> patch decreases the overhead of security_transition_sid(), which is
> called from many hooks.
>
> The jhash function seemed as a good choice, since it is used as the
> default hashing algorithm in rhashtable.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/Makefile      |  2 +-
>  security/selinux/ss/context.c  | 24 +++++++++++++++++++++++
>  security/selinux/ss/context.h  |  6 ++++--
>  security/selinux/ss/ebitmap.c  | 14 ++++++++++++++
>  security/selinux/ss/ebitmap.h  |  1 +
>  security/selinux/ss/mls.h      | 11 +++++++++++
>  security/selinux/ss/policydb.c |  7 ++-----
>  security/selinux/ss/services.c | 35 ++++------------------------------
>  security/selinux/ss/services.h |  3 ---
>  9 files changed, 61 insertions(+), 42 deletions(-)
>  create mode 100644 security/selinux/ss/context.c
>
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index 0c77ede1cc11..4d8e0e8adf0b 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -8,7 +8,7 @@ obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
>  selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
>              netnode.o netport.o status.o \
>              ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
> -            ss/policydb.o ss/services.o ss/conditional.o ss/mls.o
> +            ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
>
>  selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
>
> diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
> new file mode 100644
> index 000000000000..cc0895dc7b0f
> --- /dev/null
> +++ b/security/selinux/ss/context.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Implementations of the security context functions.
> + *
> + * Author: Ondrej Mosnacek <omosnacek@gmail.com>
> + * Copyright (C) 2018 Red Hat, Inc.

*facepalm* I just realized I forgot to update the year... again. I'll
fix it along with the added comment.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

