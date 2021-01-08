Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C596C433DB
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AF423772
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 17:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbhAHR4o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 12:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAHR4o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 12:56:44 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E66C061380
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 09:56:03 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d20so10486808otl.3
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 09:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlgeB1EpU2+FMBvLf0GFpacT4VzSawSCqcfBsDeB0VI=;
        b=XgOfSOe75thPkyJ/xILdjixsZPoe72ApnWqArDXSIpsMpoFWGNReX/pmLsW6CPoC/6
         nEgW9Vi5hBu3Rlkh/7I1Yos/PcDIFNmAjMP1g03wLpXsbu6Izx+z3HdDZf3Sb9NZVA/6
         0YCYoFAbOhLSZCnvxZo8ya/b36SeauWUOdUorvMHHrNV6/tAWWgAfGtXQq8p4tCJJvoM
         I+AvkFkzflf855RYdwSR10KbZLCfkbBqRnMyBpVTMH8MSxMh3OKb2QaMo2O7+fHWjQDt
         +gFJQjsjq+PmhBFXgY//YtwlULAwxbyZFyx61yYBwG/2O7whM3CBw5yFLUMXX4oQALmq
         LpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlgeB1EpU2+FMBvLf0GFpacT4VzSawSCqcfBsDeB0VI=;
        b=FHKJT4fi1Rkob/kzclrte5j11O+qtLnM2MRN1dsnm3nHVZmpYoRPOZhDSDPlMF3PXk
         WP0ZEqrFt4dEJx3G0bq+6YaUeE0M/lv2Em5xhVsdT+0NllMg5ADNN1gOTWVVq7bt0cjB
         vmUa8zuNFfxo/WUviMJ4mYZCJZHPLdf3mSv94ZpeHLibxYmXZTEYEEjQ7yewBEAKVdw0
         /4iffziwbucjPDRSkEIIS0QHqajUmcgE4zE0yeQhBUj3MhMdMU3IfNYXAzzbAECqouZg
         7Sw5l6k5nY8ODlkm32QJwmDMdkxnhcIK3kNzuTr3QvNXWjGrP/o4t+GgeVKEhrUo1qmB
         Hhqw==
X-Gm-Message-State: AOAM532sKfl/p1GaLDcEMuHRncw0R4j9S5nAl8VSVbod8gVrp7B30OPA
        oLnY3zMJyNRbAlqIJ5h8PIkj28GgOBGXq+4R1tA=
X-Google-Smtp-Source: ABdhPJwrCpXJwQ77w36HcjeLcY+sCsyfNdT5dWwFkkDZBHag0zAF8X0ULkJgix604WyD4lWb7qL6moQqCy9nzVh9U0g=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr3331765otr.196.1610128563256;
 Fri, 08 Jan 2021 09:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20210106080836.344857-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210106080836.344857-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 8 Jan 2021 13:00:26 -0500
Message-ID: <CAP+JOzSenme0aRcuqpR9C=AkNvLiZF8=ApeDbxg5Y-9sw5_zXg@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: ensure that decls hold consistent symbols
 when loading a binary policy
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 3:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> While fuzzing /usr/libexec/hll/pp, a policy module was generated which
> made "key" be NULL in required_scopes_to_cil() when doing:
>
>     key = pdb->sym_val_to_name[sym][i];
>
> This was caused by using a decl->required.scope[sym] bitmap which was
> not consistent with the policy symbols.
>
> Ensure this consistency when loading a binary policy by introducing a
> new function which is called after policydb_index_others(), so that
> p->sym_val_to_name[sym] can be used to check whether a symbol exists, in
> a performent way (instead of searching the hash table
> p->symtab[sym].table).
>
> This issue has been found while fuzzing hll/pp with the American Fuzzy
> Lop.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
> This replaces patch "libsepol: ensure that hashtab_search is not called
> with a NULL key"
> (https://lore.kernel.org/selinux/CAP+JOzQcM03WUJ-Fg2LuLxzCGiagJnuyJozv7ed6f34vnKEKXA@mail.gmail.com/T/#m059ac9bc2bdb9e4c436ebe3cef03124de25f1f06)
>
>  libsepol/src/policydb.c | 48 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 6faaaa5895d0..f43d5c67463e 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1209,6 +1209,51 @@ int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
>         return 0;
>  }
>
> +/*
> + * Verify the consistency of declarations, after the symbols were indexed
> + */
> +int policydb_verify_decl_symbols(sepol_handle_t * handle, policydb_t * p)
> +{
> +       avrule_block_t *curblock;
> +       avrule_decl_t *decl;
> +       struct ebitmap_node *node;
> +       unsigned int i, sym;
> +
> +       for (curblock = p->global; curblock != NULL; curblock = curblock->next) {
> +               for (decl = curblock->branch_list; decl != NULL;
> +                    decl = decl->next) {
> +                       for (sym = 0; sym < SYM_NUM; sym++) {
> +                               ebitmap_for_each_positive_bit(&decl->declared.scope[sym], node, i) {
> +                                       if (i >= p->symtab[sym].nprim) {
> +                                               ERR(handle, "too large value for symbol in declared scope %u: %u >= %u",
> +                                                   decl->decl_id, i, p->symtab[sym].nprim);
> +                                               return -1;
> +                                       }
> +                                       if (p->sym_val_to_name[sym][i] == NULL) {
> +                                               ERR(handle, "invalid symbol %u in declared scope %u",
> +                                                   i, decl->decl_id);
> +                                               return -1;
> +                                       }
> +                               }
> +                               ebitmap_for_each_positive_bit(&decl->required.scope[sym], node, i) {
> +                                       if (i >= p->symtab[sym].nprim) {
> +                                               ERR(handle, "too large value for symbol in required scope %u: %u >= %u",
> +                                                   decl->decl_id, i, p->symtab[sym].nprim);
> +                                               return -1;
> +                                       }
> +                                       if (p->sym_val_to_name[sym][i] == NULL) {
> +                                               ERR(handle, "invalid symbol %u in required scope %u",
> +                                                   i, decl->decl_id);
> +                                               return -1;
> +                                       }
> +                               }
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * Define the other val_to_name and val_to_struct arrays
>   * in a policy database structure.
> @@ -4501,6 +4546,9 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>         if (policydb_index_others(fp->handle, p, verbose))
>                 goto bad;
>
> +       if (policydb_verify_decl_symbols(fp->handle, p))
> +               goto bad;
> +
>         if (ocontext_read(info, p, fp) == -1) {
>                 goto bad;
>         }
> --
> 2.30.0
>

This checks modular policy, but not kernel. I am working on a patch
(or patch set) to do more checking of the policy binary. I am glad you
did this patch though, because I would have completely forgot about
checking the parts for modular policies. I will incorporate your patch
in with what I am doing.

Thanks,
Jim
