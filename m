Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6424C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 11:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D2424684
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 11:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcibaHAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAWL7q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:59:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59412 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbgAWL7q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 06:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579780784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMYi0cQAaVsk6wwuLwzQrXocdRVZi8fyMFzRoe3fK+c=;
        b=FcibaHABPoEgEdYweLJ46WbY9gTJ+3Sule0Wz0YpZl3nIhChIpnlZS8vOZx8oN/91s9n4O
        wXX5c++DBeCCGyUVARK7nL+76HqGTv+TZb7ajVhaZxwgk9jyXtuWhzDNjwFgPkQ27pnMzA
        UyvHADDmQZNI32Q9X+5NUbBGLdCVeTA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-EFRaHlkbPTyqVrlD6C9uiw-1; Thu, 23 Jan 2020 06:59:41 -0500
X-MC-Unique: EFRaHlkbPTyqVrlD6C9uiw-1
Received: by mail-ot1-f69.google.com with SMTP id v2so1409310otq.2
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2020 03:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMYi0cQAaVsk6wwuLwzQrXocdRVZi8fyMFzRoe3fK+c=;
        b=AvIz+cNBvOcCaE5CYVc1WoGy4/uij494y729jStRnQoi0LI/scI65wdBrkdUMTLJYz
         i62mrXOCpvg+e3Pe7VcqSnkvKSr+/UooiVEi7yBI0ee5XdNWOiOfjGCg6cJuFGjiGl7O
         F4Xmhnx7h5rO7us8p7bJtqQth8BdtX431uqaClbjrg706xu6KK9J8KF54zObs61lnQko
         PE5RccvYj8BlwNyEuBAV+c/druB1JEiYXKBnZVoNL0qOWBlHxF4J/Z6RHbs/wi4hnYai
         IyGXRv/eb/d+lGLA0W6e0Rl6WYHyQkBn+nqY0sj3naOJzTC9ieZ0r7k+8lz5N3H0bovq
         sUng==
X-Gm-Message-State: APjAAAVLtVWdBVtLeXWSfnKV6CdIrN+GKWyh0S312Ht031ce7blyojmC
        3IP4yh/qVZ4RRRP3m9RqEdnbw58WM+JiBYrswolmnNdw9lSmhGTyrsRt+V01j+uusN/fS7LzuMn
        ElDuU7NYu/PC6iNFdlb3Y6oWj0JIr8bYlag==
X-Received: by 2002:aca:d15:: with SMTP id 21mr10492721oin.127.1579780779926;
        Thu, 23 Jan 2020 03:59:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMP2k7Olv1uxAVa0okKG4dyao4jetTrvuDX6G1nrZ38GP0sdRUdBkMGv5H5FeLfmPHPSiKAKPjHz034Ro7Ug0=
X-Received: by 2002:aca:d15:: with SMTP id 21mr10492714oin.127.1579780779704;
 Thu, 23 Jan 2020 03:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20200122154655.257233-1-omosnace@redhat.com> <20200122154655.257233-3-omosnace@redhat.com>
 <a730c6ee-c5b4-2eb2-60c8-a069a87ec0a4@tycho.nsa.gov>
In-Reply-To: <a730c6ee-c5b4-2eb2-60c8-a069a87ec0a4@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 23 Jan 2020 12:59:30 +0100
Message-ID: <CAFqZXNvPjZk549Yi00KqFjXesmxPD3-KbGdJUNu8rrYeoJrs0Q@mail.gmail.com>
Subject: Re: [Non-DoD Source] [PATCH userspace 2/4] libsepol: remove unused cil_mem_error_handler
To:     jwcart2 <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 22, 2020 at 7:54 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
> On 1/22/20 10:46 AM, Ondrej Mosnacek wrote:
> > It is declared in an internal header but never defined. Remove it.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   libsepol/cil/src/cil_mem.h     | 1 -
> >   libsepol/cil/src/cil_strpool.c | 2 --
> >   2 files changed, 3 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_mem.h b/libsepol/cil/src/cil_mem.h
> > index 902ce131..794f02a3 100644
> > --- a/libsepol/cil/src/cil_mem.h
> > +++ b/libsepol/cil/src/cil_mem.h
> > @@ -36,7 +36,6 @@ void *cil_calloc(size_t num_elements, size_t element_size);
> >   void *cil_realloc(void *ptr, size_t size);
> >   char *cil_strdup(const char *str);
> >   int cil_asprintf(char **strp, const char *fmt, ...);
> > -void (*cil_mem_error_handler)(void);
> >
> >   #endif /* CIL_MEM_H_ */
> >
> > diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
> > index 97d4c4b9..508541d6 100644
> > --- a/libsepol/cil/src/cil_strpool.c
> > +++ b/libsepol/cil/src/cil_strpool.c
> > @@ -80,7 +80,6 @@ char *cil_strpool_add(const char *str)
> >               int rc = hashtab_insert(cil_strpool_tab, (hashtab_key_t)strpool_ref->str, strpool_ref);
> >               if (rc != SEPOL_OK) {
> >                       pthread_mutex_unlock(&cil_strpool_mutex);
> > -                     (*cil_mem_error_handler)();
> >                       pthread_mutex_lock(&cil_strpool_mutex);
> >               }
> >       }
>
> I removed the cil_mem_error_handler stuff last Fall (see commit 4459d635). I
> guess that I must have missed these somehow.
>
> In the other places where I removed it, I replaced it with the inlined default
> hanlder which consisted of the following:
>
>    cil_log(CIL_ERR, "Failed to allocate memory\n");
>    exit(1);
>
> Since we are existing, the pthread_mutex_lock() call can be removed.

I see, thanks for pointing it out! I'm now quite embarrassed for not
noticing the needless lock-unlock sequence I left behind in this patch
:)

I will rework this patch to match commit 4459d635 in v2.

>
> > @@ -104,7 +103,6 @@ void cil_strpool_init(void)
> >               cil_strpool_tab = hashtab_create(cil_strpool_hash, cil_strpool_compare, CIL_STRPOOL_TABLE_SIZE);
> >               if (cil_strpool_tab == NULL) {
> >                       pthread_mutex_unlock(&cil_strpool_mutex);
> > -                     (*cil_mem_error_handler)();
> >                       return;
> >               }
> >       }
> >
>
> Same thing here, but now the return won't be needed.
>
> Thanks,
> Jim
>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

