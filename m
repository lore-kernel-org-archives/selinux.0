Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEEFC4338F
	for <selinux@archiver.kernel.org>; Fri, 30 Jul 2021 14:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C7360F9B
	for <selinux@archiver.kernel.org>; Fri, 30 Jul 2021 14:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbhG3OZA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbhG3OYz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jul 2021 10:24:55 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F13C0613C1
        for <selinux@vger.kernel.org>; Fri, 30 Jul 2021 07:23:39 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so9656020otu.8
        for <selinux@vger.kernel.org>; Fri, 30 Jul 2021 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PobYTNHdMVgnq1YyQAcCzoe6Bg45UnNqtBchnuyp3+w=;
        b=D/OsQZqVycu85Sdv89w09aNVimeaEOwLoQn1Qo/rVs7j/qdv0aLASnEik0TiBhSxy7
         LX5cCAFzeDV+BC5rTME70FBOlf2MaP9//bWRZopMwZHRyeljA0/3AvqQZXegTzY2rdJi
         CBn0sCneyucYQFpxSu6YKOF10VCc2JzHqwmHbMOf6uONVyGwXotNHfbcD2fP4/c9PmoR
         NmAtvdPULnYRzFLq77aENLTe0dGH/9wKF7fKSU9T3+AVV4WB6jh07nm9rSYV7Nz3P+ue
         gdabtInpFzTRO6F3LuqO7WmMmoBAHeqotnQftozoUv0wW7biR3x6Gyr0qcjfj4XoI7O1
         qBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PobYTNHdMVgnq1YyQAcCzoe6Bg45UnNqtBchnuyp3+w=;
        b=maMZgETE9onhZe0nteWc06xosFrbxyPQ2bE/smvAiwaVAFiBdLPcISwDMAMjP+q6lu
         NX1WlN90gIAAaBpmayUIdQVzswS8RhUYswRWw3XBrxvlk/pgXShyBmOr/VJ+i38itoSW
         /ou0Pya0q0l+Y6lwV98fmfQc4y0iQDKSDemi3LunaQeGLI7fw7QgUNgSS0PziQLUL3vA
         Jrs/GqEobYKNIdRF3Wb9xax90o3iYPs5okhg0NWmcJOoHqPJrjNmQcJbJO/WriQETI30
         m1WCCzMaJ1hbvcmDxe5Wii2xxyNfJTocsi8rPnVdouqX1PgM6GfRPRPVeZRI4ta5li2e
         Dv4Q==
X-Gm-Message-State: AOAM532+OkltroSMgCn/Zst9a9JW/teTFf+y7BT5pyqP+CKeKyWFsjNn
        d0TRZ0+ygR59liXS8Aba9Pist4O7fuB7LjVz+IQ=
X-Google-Smtp-Source: ABdhPJxRHCOF95Qe4cVwoUpvgrEmIDrmn08MIJnIfaeLEZxHMaEmgKRULahXPaWOPj0F/AhtXoItYC10HaIYAMQ3Fx8=
X-Received: by 2002:a05:6830:2452:: with SMTP id x18mr2210845otr.196.1627655019146;
 Fri, 30 Jul 2021 07:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210730115256.411543-1-plautrba@redhat.com>
In-Reply-To: <20210730115256.411543-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 30 Jul 2021 10:23:28 -0400
Message-ID: <CAP+JOzRuApPnmSHZbap_fpa_Wh_N_crUVmY7gJKFq1PcadoS0Q@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: Fix COPY_PASTE_ERROR (CWE-398)
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 30, 2021 at 7:55 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Fixes:
>     Error: COPY_PASTE_ERROR (CWE-398): [#def3]
>     selinux/python/sepolicy/sepolicy/__init__.py:1032: original: ""_key_t"" looks like the original copy.
>     selinux/python/sepolicy/sepolicy/__init__.py:1035: copy_paste_error: ""_key_t"" looks like a copy-paste error.
>     selinux/python/sepolicy/sepolicy/__init__.py:1035: remediation: Should it say ""_secret_t"" instead?
>     # 1033|
>     # 1034|       if f.endswith("_secret_t"):
>     # 1035|->         return txt + "treat the files as %s secret data." % prettyprint(f, "_key_t")
>     # 1036|
>     # 1037|       if f.endswith("_ra_t"):
>
>     Error: COPY_PASTE_ERROR (CWE-398): [#def4]
>     selinux/python/sepolicy/sepolicy/__init__.py:1065: original: ""_tmp_t"" looks like the original copy.
>     selinux/python/sepolicy/sepolicy/__init__.py:1067: copy_paste_error: ""_tmp_t"" looks like a copy-paste error.
>     selinux/python/sepolicy/sepolicy/__init__.py:1067: remediation: Should it say ""_etc_t"" instead?
>     # 1065|           return txt + "store %s temporary files in the /tmp directories." % prettyprint(f, "_tmp_t")
>     # 1066|       if f.endswith("_etc_t"):
>     # 1067|->         return txt + "store %s files in the /etc directories." % prettyprint(f, "_tmp_t")
>     # 1068|       if f.endswith("_home_t"):
>     # 1069|           return txt + "store %s files in the users home directory." % prettyprint(f, "_home_t")
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index df773a6b314e..6b6160a449df 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -1039,7 +1039,7 @@ def get_description(f, markup=markup):
>          return txt + "treat the files as %s key data." % prettyprint(f, "_key_t")
>
>      if f.endswith("_secret_t"):
> -        return txt + "treat the files as %s secret data." % prettyprint(f, "_key_t")
> +        return txt + "treat the files as %s secret data." % prettyprint(f, "_secret_t")
>
>      if f.endswith("_ra_t"):
>          return txt + "treat the files as %s read/append content." % prettyprint(f, "_ra_t")
> @@ -1071,7 +1071,7 @@ def get_description(f, markup=markup):
>      if f.endswith("_tmp_t"):
>          return txt + "store %s temporary files in the /tmp directories." % prettyprint(f, "_tmp_t")
>      if f.endswith("_etc_t"):
> -        return txt + "store %s files in the /etc directories." % prettyprint(f, "_tmp_t")
> +        return txt + "store %s files in the /etc directories." % prettyprint(f, "_etc_t")
>      if f.endswith("_home_t"):
>          return txt + "store %s files in the users home directory." % prettyprint(f, "_home_t")
>      if f.endswith("_tmpfs_t"):
> --
> 2.32.0
>
