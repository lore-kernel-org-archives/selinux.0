Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77412C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 19:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E562206DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 19:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvi9uNLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGITqs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgGITqr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 15:46:47 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B4C08C5CE
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 12:46:47 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d4so2564041otk.2
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23j5LOule23uXLZsKw21KN4c7ol+Cdiozfc+djsOnxU=;
        b=bvi9uNLeWLfnZ8zNKuZ59m68B8JgOCiQ7gak987DhuUOrya14HzYXJ/omZrSqCtmzv
         iyVHUg+NsROcknEdRAGhRf9cgHwI/1NVmDMVLXs3GdfAy2wGSSp7HwkAlc8CXWzt5A92
         +w/v0GJcM82qEQ8fge6eZjvO9KCLOBVyFErnhPrjzJZyJdX7tw+gPYrXbib1zvO3+ETe
         1sJCjUx+Qfv4aj33qbzHQp4T59p68vqQ7749F6bmNo55VVAnYpOZhhGsvrCRbrLkdWAK
         0sbE+dFnoXTsc/vHLnY0PFJJAU1odhhIfJXL3qSNPgot4CadfGwg2XQM485U4bVXOu8V
         vJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23j5LOule23uXLZsKw21KN4c7ol+Cdiozfc+djsOnxU=;
        b=prySY/JluTCEQ+YmFB/O7KmWIrbmNH6184DS0PsFEFH5zntuASreazYP0vExYrcEuA
         aJ6axlYYMzPYG12NuOEaNbFHZAgUM1wvf6e3pFHVoNGWLigG/JW0gF2eKaD8/Xkfy90d
         QErXybDA/rcARtj6CWd9Ws2KOcBpIXsV34dlhxQkThIA+Puk+W3rgmfQZtpqb6BuN8zp
         ls5YeCmDpAqm7ZpDCPX8/qkLJUNBEvGPOs7ARg6rpJ5bhNagdeaxJBhyJwZjayuoLsJJ
         HP5rU/347l5GS7FkuP7BkF2auKN25HltkXE0RwUrABYoj8xJpRXtcyXZRidifnKT03BX
         d9Iw==
X-Gm-Message-State: AOAM5318PtRTxXRFdmGDR4m/IyOCf2ZvYKjopLacRt6M9PdNH35DaN9r
        NOmiBpR3iBtbxdb67UDgQCZl38DJVY3fh1+7ZxRrmw==
X-Google-Smtp-Source: ABdhPJzERm5zQQnwshNo3aUOrlYlwdbJIFeduK1w8r4nf6BQspeCapM83sUfpXhXLIV4Eo4ArtRuNn6pP1p/m8eGuXw=
X-Received: by 2002:a9d:6e14:: with SMTP id e20mr42247834otr.89.1594324007008;
 Thu, 09 Jul 2020 12:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200709191952.435970-1-omosnace@redhat.com> <20200709191952.435970-2-omosnace@redhat.com>
In-Reply-To: <20200709191952.435970-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 9 Jul 2020 15:46:35 -0400
Message-ID: <CAEjxPJ7j4f=kfda4oK_6mwS49u54Cnxs9Uf=Dd=EB_uFSSnsUA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] selinux: prepare for inlining of hashtab functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 3:20 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Refactor searching and inserting into hashtabs to pave the way for
> converting hashtab_search() and hashtab_insert() to inline functions in
> the next patch. This will avoid indirect calls and allow the compiler to
> better optimize individual callers, leading to a significant performance
> improvement.
>
> In order to avoid the indirect calls, the key hashing and comparison
> callbacks need to be extracted from the hashtab struct and passed
> directly to hashtab_search()/_insert() by the callers so that the
> callback address is always known at compile time. The kernel's
> rhashtable library (<linux/rhashtable*.h>) does the same thing.
>
> This of course makes the hashtab functions slightly easier to misuse by
> passing a wrong callback set, but unfortunately there is no better way
> to implement a hash table that is both generic and efficient in C. This
> patch tries to somewhat mitigate this by only calling the hashtab
> functions in the same file where the corresponding callbacks are
> defined (wrapping them into more specialized functions as needed).
>
> Note that this patch doesn't bring any benefit without also moving the
> definitions of hashtab_search() and -_insert() to the header file, which
> is done in a follow-up patch for easier review of the hashtab.c changes
> in this patch.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
