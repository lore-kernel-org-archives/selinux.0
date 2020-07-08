Return-Path: <SRS0=sWNN=AT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0FBC433E0
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2668420786
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 13:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrzsWmfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgGHNiK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbgGHNiK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 09:38:10 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA51C061A0B
        for <selinux@vger.kernel.org>; Wed,  8 Jul 2020 06:38:09 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 18so36901198otv.6
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2020 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=In9HZ3QLspMAxmHMdYDhGse8qQZ8Heta1Fm1pyCLfwk=;
        b=XrzsWmfpQ5TJtFVW+fLU67gGeVSkNWTcNiS/5v+d8GcBA9QpbJjAWD2VUJJ/hqHK0D
         RI9RsgOO1h+w3p8ubnTzxVDAwq8BrLFxWrL0wdjHnyGma4X/BUCis3FK0nFbBANErunO
         F84bSYDMRsePS78+YvAiGN8wGYn2AKngkom5EskVDUedc5W96/ijhN/ovhy8MSSB+N3p
         Yoi9NFhTae3KvoWTATdBAVNZmknbKR274+GcYhv0dcok9Xj1yRGmZNyqK0RzUjTmHuvX
         bxs5MHrmWO7eoTkPL2eGOtn3Jd53BpMZ4JQ0tnv8hRGZqivoa2ZutXUprhVqr73dknJ8
         uq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=In9HZ3QLspMAxmHMdYDhGse8qQZ8Heta1Fm1pyCLfwk=;
        b=NIOQ4qwhmPSu4TDsbqOK3BkPB4DCuXX+ugTsFTJDX6bMTzGkuvlIHiPwzQr56h5h7X
         WIo6BZ/xjWVv29Sa577BKMfyO0WKf56anYqOEugYThX+SvQua1Sq83Z0oO2e6VN59QyT
         fciKwy8UC5Pn9D1Ebyr6hDn+UciMOCZlX8itAihjA5wsNDFoK880wWzr7c8YBUE5SPQw
         u8GM2LdkHQgguyk96y7t9I6dfYXRg0y+iNy2GN1nQjZ7Ui7KvdL07DGAfJZN/dENzMGI
         B0KfEthp6OLFBipJiaN6obmlNQN0bEXXg98osVHyhdM3SaXzGw28HF+ARNLnj/9IEfgk
         31wA==
X-Gm-Message-State: AOAM530rzW8VJLppTNQzfaPLyPZnVfx+OQua7nP16OEMPnACwTnEUscw
        0x92LarcFwbXfpDSbeJXVFjXTJ9M1gVLLGKHKV0=
X-Google-Smtp-Source: ABdhPJxZTQj1KV3A7k3Elz9+S5xbAcVzA9box7dhWQcD8qs4UP3jB6G0zgxpMtfJTu58ySSr0YzMgMy3BzvRkaLSd+s=
X-Received: by 2002:a9d:6e14:: with SMTP id e20mr36893773otr.89.1594215489340;
 Wed, 08 Jul 2020 06:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200708112447.292321-1-omosnace@redhat.com> <20200708112447.292321-3-omosnace@redhat.com>
In-Reply-To: <20200708112447.292321-3-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 8 Jul 2020 09:37:58 -0400
Message-ID: <CAEjxPJ6HptedbTxrSKi3sYk+7PZ7-JHiNqa9eti86+BWm=Z6pg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] selinux: prepare for inlining of hashtab functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 8, 2020 at 7:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
> ---

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 02b722c5c189d..ae78f66e85d29 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1888,7 +1920,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
>         otype = le32_to_cpu(buf[3]);
>
>         last = NULL;
> -       datum = hashtab_search(&p->filename_trans, &key);
> +       datum = hashtab_search(&p->filename_trans, &key, filenametr_key_params);

Why aren't you using the helper/wrapper function here?
