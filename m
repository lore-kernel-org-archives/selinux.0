Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBF2C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 09:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6E120746
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 09:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGNZMhUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEDJCB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 05:02:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36499 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEDJCA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 05:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588582919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A+ixx1MtY5IBvljeGpw13tiZDPcj3K294jZDZd8bK84=;
        b=QGNZMhUP+EHknHBSL808ON01RWdtRYxselssOoLdusL7B+c8Axr4nigBjcDSECaBhsAcwx
        Wa6LMqe83esoWwQP+Z8K83NEW97JRx1lsLdhQgFRfd09uVIC9LrHBEjIuwe3jjxgQSeMG6
        X5pvQmdJhfCBBg/kVCAv+5XOEITM1Zs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-kJg-ROGlOEquKJSxGwQEww-1; Mon, 04 May 2020 05:01:58 -0400
X-MC-Unique: kJg-ROGlOEquKJSxGwQEww-1
Received: by mail-oo1-f70.google.com with SMTP id t23so8323051oor.1
        for <selinux@vger.kernel.org>; Mon, 04 May 2020 02:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+ixx1MtY5IBvljeGpw13tiZDPcj3K294jZDZd8bK84=;
        b=VijYz6O5ghYOR4+ZEr8j7JjKPA9IMl4bDjzHLJVNq2XJ2tt+pc/AqKadiUpp52ZiUu
         FP/UsELJ2iAaliIYdiFR913xR19FTw9MmII6ZCSuH9v0boguW4t0R4K20fn60HngX2Qg
         9Wd8FJMusz+vcG5yN0E3IJuYAGsTmY5vnW4HgpHbXqzVJ+Oa+xST5UdtOysbfZGM8Hdy
         Uehex851fwPJoPjdQ2ddzUznb9nHexUP3yIdsyPklHSEOM87mJr8fMwH0BignlsQ/UNC
         rRApkgKp6AbElR+jLhp1Xgypj5T6pG1Qjglb95rhR1r1Pu5K0EZhCwfS3bsyO82p2zif
         /Mqg==
X-Gm-Message-State: AGi0PubXNzWqbYAj+xLKM8sRlNtKWVW5A4K9M9maExUJHGGxKbZikD6d
        dsh/BPMqsWRXhvd65a1GnBDNKUjyVk23VZ+oE9eQ2RRmsrFzfp5DX42MRFLJaJV77tDEfXPLPCe
        rJuvA9/UcpTPIEt0p4KtrVdqQSy5R/sIohA==
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr13928404otn.197.1588582917162;
        Mon, 04 May 2020 02:01:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypKjBM+8x9K5egAqhTcT5xWutPIZHPn00xr7Cx+otM6bBCxYceehSuWkXhnes9S91hmj/SYhWFilJxJhS8ux6z0=
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr13928380otn.197.1588582916906;
 Mon, 04 May 2020 02:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvk=UoVRdpk4m4byh-kKU5LUp08C52Nx-MkfcywZ+4rig@mail.gmail.com>
 <20200504084507.92526-1-rfilo@redhat.com>
In-Reply-To: <20200504084507.92526-1-rfilo@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 4 May 2020 11:01:45 +0200
Message-ID: <CAFqZXNs88P_VeYgO=9nOX1Z2vpPUVgHxTTqyk6Rj-peqhyN-bA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Add missing errno setup
To:     Richard Filo <rfilo@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 4, 2020 at 10:45 AM Richard Filo <rfilo@redhat.com> wrote:
> Errno is not set to ENOENT when lookup_all() doesn't find any match.
>
> fixes: https://src.fedoraproject.org/tests/selinux/issue/51
>
> Signed-off-by: Richard Filo <rfilo@redhat.com>
> ---
>  libselinux/src/label_file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 300625c2..113bb9b7 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -948,6 +948,8 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
>                         goto finish;
>                 }
>         }
> +       if (result && !result[0])
> +               errno = ENOENT;

Sorry for not spotting this earlier, but there is no need to check if
result != NULL, because it will always be non-NULL at this point. So
you should only do the second part of the check (!result[0]). The
check under the "finish" label needs to check both, because you can
get there also via the allocation-failed path, where "result" would be
NULL.

>
>  finish:
>         free(clean_key);
> --
> 2.25.2
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

