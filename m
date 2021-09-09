Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781FAC433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E22D61100
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 17:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbhIIR1L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbhIIR1K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Sep 2021 13:27:10 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CEC061756
        for <selinux@vger.kernel.org>; Thu,  9 Sep 2021 10:26:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bd1so3456400oib.5
        for <selinux@vger.kernel.org>; Thu, 09 Sep 2021 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JThQpdFivh6YUTs/nmFUO5SUw/JD1hD+M8MYO6hyTIU=;
        b=RD5Rwoyp6qCEdGuN2Yim/xZqrklTcRikJj8zE8wOKY8N4SAxfXHpWpDYlEkJ0RRezH
         fVEYu+h7kLztELFnzM9LniPFdFHyx1eU/fo4sPoQmqE7ZbHyPz8/IPQwf8Q36y2qwFvZ
         C6WINKtXlIxBYtsMLF0WanNX64n+2u2WeOFUCCyuTqW1Gew0D/LNLpS0qGY+jiurKwg1
         QiVuKG3I5kAieLyRU8+o5e+hjrGNCiEZe6UTRACIy8BOalbmkf/YkbLJn/byIAUvBpXB
         rf+FzcZAiBmGlac5J5vnOjKH+aFfm5bTii2UhFkETLpAiwJgBtKvnkdiCwOzoa3M1Kx1
         wTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JThQpdFivh6YUTs/nmFUO5SUw/JD1hD+M8MYO6hyTIU=;
        b=kfqYIBUc4ZX0AV3mRDE48AMDhemf1mbv5qpCVYBl3NMM1bcrNPIMIUkQ5gxdgKwg0B
         ZEd9V+vMpaCSMg1gzophmS+/RTMkOejEYlBC4V5qDE+ZjMGKxiE6UoUPzCrOytu3B4q2
         P4Iz/LNDWTX2KGj7rObTAe5kP7FRFntdG1nHcU64YbrjM4M3YJNjw4wMpRZpZL3E0Vbl
         rngB3FcW+WfyaataveeKv+SpJt4k3hyTFWmOTPh0nVWtahn0aDdlcWp8/LWD7FqfVYs6
         SdacimOpfGs5Ky3ObDe449ZEeVLTt2nlodszJu6BmCDVNDBA8WqA6xlB225Xofyp/t8I
         LKKg==
X-Gm-Message-State: AOAM531JidjUpXhsA2zoZLp+EQJx5zwCd0tWc1Sc6mLpRPjYAob0bvKN
        scWpOpDvxUQvd+19pc/ijDAqSr0ymlKpItWwjrk=
X-Google-Smtp-Source: ABdhPJytI1y64j09nitsE7V5fM2ZUlaMqgQLqkURVV1FqMuL6SO7joaj0H6wZ8H/z1B92dkzuK5i2ocgh/GyybQHRe4=
X-Received: by 2002:aca:f189:: with SMTP id p131mr814180oih.128.1631208360317;
 Thu, 09 Sep 2021 10:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210909164441.354970-1-plautrba@redhat.com>
In-Reply-To: <20210909164441.354970-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Sep 2021 13:25:49 -0400
Message-ID: <CAP+JOzSPPvutC=U_zMpd_=VVLvmAcTkiGQ8Q99G_vscLPSazgQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix detected RESOURCE_LEAK (CWE-772)
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 9, 2021 at 12:45 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> libsepol/cil/src/cil_binary.c:4823: alloc_arg: "bounds_check_type" allocates memory that is stored into "bad".
> libsepol/cil/src/cil_binary.c:4840: var_assign: Assigning: "cur" = "bad".
> libsepol/cil/src/cil_binary.c:4844: noescape: Resource "cur" is not freed or pointed-to in "cil_avrule_from_sepol".
> libsepol/cil/src/cil_binary.c:4847: leaked_storage: Variable "cur" going out of scope leaks the storage it points to.
> libsepol/cil/src/cil_binary.c:4847: leaked_storage: Variable "bad" going out of scope leaks the storage it points to.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 43c37fc24686..4a80cb562424 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4842,6 +4842,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>                                 rc = cil_avrule_from_sepol(pdb, cur, &target, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
>                                 if (rc != SEPOL_OK) {
>                                         cil_log(CIL_ERR, "Failed to convert sepol avrule to CIL\n");
> +                                       bounds_destroy_bad(bad);
>                                         goto exit;
>                                 }
>                                 __cil_print_rule("  ", "allow", &target);
> --
> 2.32.0
>
