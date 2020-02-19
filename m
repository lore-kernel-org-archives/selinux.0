Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8E1C34052
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F2A24654
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2oeRq00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgBSPdd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:33:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23769 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726821AbgBSPdc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 10:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582126412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gwlMnxOi2uo2xe05E+YBtcFDLypBKWCwomNSVs1+HI=;
        b=G2oeRq00777Hi6YHpRfKbAMDExMN0XOmG7WfPg5NHlyOw6BNRlwYt69Mufy6ybDJHoGPHy
        bKY8IknOa283wl8OZ16C5V9Uz18Qcu2dSCgaFk5651C7A56yTfMhWkl8G9zs545o300BYB
        db30pjms1RWMigdS7ExdU6lSQXjVRj4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-xLwEV8lcMqeLlJlkgcp1kg-1; Wed, 19 Feb 2020 10:33:29 -0500
X-MC-Unique: xLwEV8lcMqeLlJlkgcp1kg-1
Received: by mail-ot1-f72.google.com with SMTP id n22so347733otr.23
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 07:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8gwlMnxOi2uo2xe05E+YBtcFDLypBKWCwomNSVs1+HI=;
        b=oIYoJqjiNhZkwAuJFCrZHm7nIVSvsirUQZ80JB+LJQQiSDANSceTTpj+W2jz/ewhUB
         bKJHsKsc9reKbLuDfRlToVtIW2fZbJ4AGWa9Mhe3bq6oQeT1C4aE6QeWhgnuko9PTjHG
         dTbkpOi6H2SDle/M9hPNkPBkJKDXCkdmImOjNE+9ClWTbTEXVeSKFSyyXfFm0VNV0U6P
         y9icvacsgqjsyRW9X5TY17jnPOcbAkBIacM+fBxLgVCVRXYTm8AbEocMMB1m9KQioUJk
         FOn2mnze9eX3itm+mEiiEzvgDCqdef3xapJQoqroeY3B9oibvMkBHVVBEJt9oRdXkXjZ
         eWbA==
X-Gm-Message-State: APjAAAUdiBa8+rJhYed3/JUdh9YLMjE9VoTnQHeCNivD8/+fk1eRDmjw
        rPdKGHdPntEXVVVlhHO8Q7T4Y/oPdAOcZyCwOLqTntGzzw454v5vT9IYdOxDxHeZ1jpJQsjK0yw
        kCluFgECt7sXWBcQdnw8/S8YH6N+Ruoz2bg==
X-Received: by 2002:aca:1108:: with SMTP id 8mr5023357oir.127.1582126408291;
        Wed, 19 Feb 2020 07:33:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdVomvvZMaZmMrWbe7SsGDipWW0dl6oH3hr8KWjzZ8/cnqtyRaUrCbrskZol9OHh6gVppa/Fa11Sz/MHhu59s=
X-Received: by 2002:aca:1108:: with SMTP id 8mr5023345oir.127.1582126408008;
 Wed, 19 Feb 2020 07:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20200219134522.230822-1-omosnace@redhat.com> <20200219134522.230822-3-omosnace@redhat.com>
In-Reply-To: <20200219134522.230822-3-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Feb 2020 16:33:17 +0100
Message-ID: <CAFqZXNsFRCnc5g1+hgv48XE0kgfpX=kXrAenTXAyWqoxY+OxwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: grow hashtab dynamically
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 19, 2020 at 2:45 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Detect when the hashtab's load factor gets too high and try to grow it
> and rehash it in such case. If the reallocation fails, just keep the
> hashtab at its current size, since this is not a fatal error (it will
> just be slower).
>
> This speeds up semodule -BN on Fedora from ~8.9s to ~7.2s (1.7 seconds
> saved).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libsepol/src/hashtab.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> index 9590b359..fe9c55b8 100644
> --- a/libsepol/src/hashtab.c
> +++ b/libsepol/src/hashtab.c
> @@ -63,6 +63,46 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
>         return p;
>  }
>
> +static void hashtab_check_resize(hashtab_t h)
> +{
> +       unsigned int hvalue, i, old_size, new_size = h->size;
> +       hashtab_ptr_t *new_htable, *dst, cur, next, tmp;
> +
> +       while (new_size <= h->nel && new_size * 2 != 0)
> +               new_size *= 2;
> +
> +       if (h->size == new_size)
> +               return;
> +
> +       new_htable = calloc(new_size, sizeof(*new_htable));
> +       if (!new_htable)
> +               return;
> +
> +       old_size = h->size;
> +       h->size = new_size;
> +
> +       /* Move all elements to the new htable */
> +       for (i = 0; i < old_size; i++) {
> +               cur = h->htable[i];
> +               while (cur != NULL) {
> +                       next = cur->next;
> +
> +                       hvalue = h->hash_value(h, cur->key);
> +                       dst = &new_htable[hvalue];
> +                       while (*dst && h->keycmp(h, cur->key, (*dst)->key) > 0)
> +                               dst = &(*dst)->next;
> +
> +                       tmp = *dst;
> +                       *dst = cur;
> +                       cur->next = tmp;

I just realized that I can get rid of one assignment and the 'tmp' variable:
https://github.com/WOnder93/selinux/commit/a43e718d20b30603e1a8cd428c8d8b656a672153

Let me respin the patch...

> +
> +                       cur = next;
> +               }
> +       }
> +       free(h->htable);
> +       h->htable = new_htable;
> +}
> +
>  int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
>  {
>         int hvalue;
> @@ -71,6 +111,8 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
>         if (!h)
>                 return SEPOL_ENOMEM;
>
> +       hashtab_check_resize(h);
> +
>         hvalue = h->hash_value(h, key);
>         prev = NULL;
>         cur = h->htable[hvalue];
> --
> 2.24.1
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

