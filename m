Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD9C433F5
	for <selinux@archiver.kernel.org>; Mon, 31 Jan 2022 12:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349744AbiAaMHE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jan 2022 07:07:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350341AbiAaMHD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jan 2022 07:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643630823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k+DYbhvcbUytWZeA8bcgfAsvYrRe7fudO+Mz41JEQpA=;
        b=IeGwq9hlBKwMIeFgLqLxBkcr+Z4x0NP1wTjpHiXSFasZvRZ2bAiCbi5jC1c0UmxaPZ9A8G
        jcHXMezU6Z0Et8P+N2EchPoS79Gc1qcbMBWd8I4+I8IXSzHhr9nB3SaNktbMAAtEjp/cqz
        GaxqeswLzo1P7pR+7fDoFx7y83E8ASI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-ceBYPjEeOAy_73XeApxUvw-1; Mon, 31 Jan 2022 07:07:02 -0500
X-MC-Unique: ceBYPjEeOAy_73XeApxUvw-1
Received: by mail-yb1-f199.google.com with SMTP id y4-20020a5b0f44000000b00611862e546dso26339003ybr.7
        for <selinux@vger.kernel.org>; Mon, 31 Jan 2022 04:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+DYbhvcbUytWZeA8bcgfAsvYrRe7fudO+Mz41JEQpA=;
        b=Jozmu7UB7XlSTVMT7WfwcbJmha3lOb4OG+WTFW7fcSPN7EuW6KNr1lG8DVdFIAiJfw
         idNeDfcLa17iGP/cl+dxTS7ECLKH/EuipGMrSztArqqfv+wmW9FgREB0rHkQvjF1Wos+
         Im+Ydn7eoW9OsXKhGC9wyfijjnP3b2+Xm3ZN/gvj/3yIBnFu3q65ewBdJUd77IXgHyMN
         txpucPVD2VDagPI2AasWT+feScU4my4OposLhJjnweQY6r2UZrG21v3ngqe81fdmW5o6
         zBPXJ6Qdp/I9AMdWkzt9BzaeAnFbvTmbkBO+T2xTEQWSA/w0XMobKluudPcbNadDqHFi
         gWzg==
X-Gm-Message-State: AOAM530E1bDOvUlXpvXujaWfwTknAmFDvMNABjWkwT6ZnUju6LPHKZGF
        bWFv0dX2yhnDi6a1EKgqFRCjIzEtfXe//Sr/iNci7gSEhmBv6cjDOHdZEuwyMdQN37Wsr1smYlN
        DhgnWKaAnYcVg6Qtd/EyId3rwVNuu5+ZbIg==
X-Received: by 2002:a25:d90a:: with SMTP id q10mr29679733ybg.253.1643630821345;
        Mon, 31 Jan 2022 04:07:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4XU5YfszLGQp4N9C+7Wcm6G7P3VJo0M1H3K29i4UnrahCCIj1CDSm3JxETTQm5Ow1SBCcgSEmb0cR2Dt3ZPQ=
X-Received: by 2002:a25:d90a:: with SMTP id q10mr29679717ybg.253.1643630821159;
 Mon, 31 Jan 2022 04:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20220128202858.96935-1-vbendel@redhat.com>
In-Reply-To: <20220128202858.96935-1-vbendel@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 31 Jan 2022 13:06:43 +0100
Message-ID: <CAFqZXNvG+-8FcEgcbKxmUeMznVp6NBAoPctN4EHCc3i-DZA8jQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] selinux: Fix and clean policydb->cond_list error paths
To:     vbendel@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 28, 2022 at 9:29 PM <vbendel@redhat.com> wrote:
> There are two users of policydb->cond_list: cond_read_list()
> and duplicate_policydb_cond_list(). If any of them gets an error,
> usually an -ENOMEM, the error-path-cleanup *_destroy() functions
> get called twice: firstly from these two and secondly from
> the caller functions' error paths.
>
> In case such -ENOMEM happens while assigning cond_node data, i.e.
> while ->cond_list_len is already non-zero, it leads to inappropriate
> dereferencing of policydb->cond_list[] data in the second called
> cond_list_destroy() from the caller functions' error paths, resulting
> with:
> - NULL pointer deref from cond_read_list();
> - use-after-free + double-free from duplicate_policydb_cond_list().
> (the cond_read_list() manages to set ->cond_list to NULL)
>
> Patch 1/3 simply makes the error behavior consistent by always setting
> ->cond_list to NULL.
>
> Patch 2/3 fixes the actual bug by resetting ->cond_list_len to 0,
> so any subsequent cond_list_destroy() calls would become noop.
>
> Patch 3/3 cleans up the duplicate *_destroy calls on these error paths,
> albeit it's a bit questionable and I'm looking for feedback on it:
> - on one hand the idea is that the caller functions call the *_destroy()
> bits anyway, hence removing duplicate efforts (which also fixes the bug,
> but I'd still prefer to apply patches 1 and 2 regardless);
> - on the other hand it's appropriate and more bug-proof for a function
> to clean everything it allocated on error.
> Hence I'm looking forward to seeing what approach the upstream would find
> more appropriate.
>
> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>

For the series (with or without the last patch):
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

