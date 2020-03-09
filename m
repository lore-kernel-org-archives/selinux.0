Return-Path: <SRS0=v7Ke=42=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37012C10F27
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 12:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9D220866
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 12:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYYyJzEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgCIMDc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:03:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29568 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726215AbgCIMDc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 08:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583755411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqweAHD5lFSc/0aJv8GqZm54Ywvjuj0Dfv29CjEjbeU=;
        b=NYYyJzEqMUVuAIp8j9flDYG8QHyX5neXnkx1IEqAlbYaDwmmWtha8dpbot5vMcYgd4zF8t
        WCNrqZV1vjebd3hZZyjfWKVi2BjE/bV9u6LWSNyY1+Yoj+oAf93jbccW0eEM/+EgsAgygy
        r5xmvCw5cicN6cVyxwQcPE4VUUGcsR4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-SiWfHdFlPeG5p1hifjsYJQ-1; Mon, 09 Mar 2020 08:03:30 -0400
X-MC-Unique: SiWfHdFlPeG5p1hifjsYJQ-1
Received: by mail-ot1-f70.google.com with SMTP id t19so6436480otp.2
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2020 05:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqweAHD5lFSc/0aJv8GqZm54Ywvjuj0Dfv29CjEjbeU=;
        b=R36owuBBU3Gb04ZdinmV49uP2RUSC520pfmtsfoyxXBTVAjowItk+XWQtO7apQXIXq
         CeaCeknaGuxE/W6ZaON21SY9e529DmDEWj0zwsGDnk+hyfCSMxcbKJisRtujLt7P6/mL
         POqISfeceGP+oOoNJaH3OXzQt86DDnb12piidn17qldnSRwTM9gtQltG3ySH7vfNUOn9
         JqEEM5j3Q9Tj1phVyOxWCgsnQph1h5rO9lfvlTMhWfrIKsx6G8ymMI1Xe0GGVAx2YaOZ
         wSPKr0D4aaOTlddYJUuVDfkAIgxZOwtQA5gmrJRU1BKt+9QwRR7KVJ9hPsVNaVti5fwa
         gujQ==
X-Gm-Message-State: ANhLgQ32NcRSqLQQAohilQBnEpnKKec29odtUpReXvdqiBV+fqOev8by
        R6JDtS5iQWBoSZFqKFRQBGLdqswQZlszcZI1btJAJ4TdyfNLlz/3p8u98nEoOsHK0fxZt1m3kRD
        nL3pttE6fTqqE95+UMKTziZin6DK1jRMJQg==
X-Received: by 2002:a05:6830:1081:: with SMTP id y1mr12286258oto.367.1583755408854;
        Mon, 09 Mar 2020 05:03:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtBZ80arDKlvPFsoqlP+4wUm4hMK4EZ24RICZl7o3M7b/icpk93AL9UgyBdpJgI9TlRBkY5Mz+SIacklaOVEJc=
X-Received: by 2002:a05:6830:1081:: with SMTP id y1mr12286236oto.367.1583755408545;
 Mon, 09 Mar 2020 05:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200304212811.18242-1-jwcart2@gmail.com>
In-Reply-To: <20200304212811.18242-1-jwcart2@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 9 Mar 2020 13:03:17 +0100
Message-ID: <CAFqZXNu-oovsELRzzDU9nb4r50azdztOVetW7ohFY1kK2Xr8+g@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Check if name is a macro parameter first
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 10:28 PM James Carter <jwcart2@gmail.com> wrote:
> Type transition file names are stored in a symbol table. Before the
> name is added, the symbol table is searched to see if the name had
> already been inserted. If it has, then the already existing datum is
> returned. If it has not, then the name is added if either the
> typetransition rule does not occur in a macro or the name is not one
> of the macro parameters.
>
> Checking for a previous insertion before checking if the name is a
> macro parameter can cause a macro parameter to be treated as the
> actual name if a previous type transition file name is the same as
> the parameter.
>
> Now check the name to see if it a macro paramter before checking for
> its existence in the symbol table.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_resolve_ast.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 87575860..daf873be 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -76,14 +76,6 @@ static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key,
>         enum cil_sym_index sym_index;
>         struct cil_symtab_datum *datum = NULL;
>
> -       cil_flavor_to_symtab_index(CIL_NAME, &sym_index);
> -       symtab = &((struct cil_root *)db->ast->root->data)->symtab[sym_index];
> -
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum != NULL) {
> -               return (struct cil_name *)datum;
> -       }
> -
>         if (parent->flavor == CIL_CALL) {
>                 struct cil_call *call = parent->data;
>                 macro = call->macro;
> @@ -99,6 +91,14 @@ static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key,
>                 }
>         }
>
> +       cil_flavor_to_symtab_index(CIL_NAME, &sym_index);
> +       symtab = &((struct cil_root *)db->ast->root->data)->symtab[sym_index];
> +
> +       cil_symtab_get_datum(symtab, key, &datum);
> +       if (datum != NULL) {
> +               return (struct cil_name *)datum;
> +       }
> +
>         cil_name_init(&name);
>         cil_symtab_insert(symtab, key, (struct cil_symtab_datum *)name, ast_node);
>         cil_list_append(db->names, CIL_NAME, name);
> --
> 2.17.1
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

