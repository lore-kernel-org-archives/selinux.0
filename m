Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F0C433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 20:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiDAUxG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 16:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbiDAUxF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 16:53:05 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC53E1C3931
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 13:51:15 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j83so3999521oih.6
        for <selinux@vger.kernel.org>; Fri, 01 Apr 2022 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qorudA9j0lKxSTvrd3wqb5JBjdQ2eisJgaS8c79W04k=;
        b=Ob2kYbNKMBnlNFfkKhfszGAZeLg6Zw+pZnpiFJ/KoaFf9Ag/EGYTyxgDNFihxze1Ja
         xtAc0QaB485TCGnSCZFQDBlK0DYgx7v8UJdTaqdspsfMB4z2zFPA08LRQetzeJSOGV0C
         D+LdHlN+q7wNgbnRdBnjDTZGKKvPSAMUZXE/S6oYrbeW7Jz0JHftIkym2uwx7kHfKI96
         5O8pHv4+VLtdfnBg1lyGgfo3rJZuKOkHnFhMohS3My7ggeglYPshZCxbHMciRPLHjikW
         IQuwQaQGt7+akxNpufZIpus5TQ0u9PCEa4mv3seuZARnvNCfpkFxkJkOL7taMr72WMb2
         Q0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qorudA9j0lKxSTvrd3wqb5JBjdQ2eisJgaS8c79W04k=;
        b=cGCnjJ68ckn6kwBEqEo4MNpN0rsi3iTS2VPsZWk77l0usl9PgtzT0HtxbBe35hXN93
         iH4HGQ0G6zEqE3MnwPCV0PV25v35POBsH3MKpIXFvTNVRvv3vcRA0YkO0i5nXY4vQTGT
         61w0QitIkVPN+g9cxrawC7umPoRrj9yURM32M6VMHArmsF1v/17PE5gQhky1tUAgxFiB
         KDXa4rWKVBQ5qFjxyUceBxFsOiO+VKPN9aBFInbwA+o/FpI17tegGqz5LioSwVoR3RwC
         LsVs/zq87PpCYJ/Lu3qg6kuUHexVpmQogMDagB/Z+kF4PmnilJqU5mmI7Hwvy1oANCSV
         yMTA==
X-Gm-Message-State: AOAM530YfzfpIW1Y1a6Ni28Qt+qeKvR6HCTEiGnY012YT9bxER/7U3Q1
        iy/hNsnq7FCArW5tEfH7qDxpOmd8mYJ5VzGXZ5rf3MTTFLc=
X-Google-Smtp-Source: ABdhPJyPJMy2Ag15GDZR5SEF0wCpTou9fiFv+KPo8sh+iyxYZPVMUkQSdCwtAlciU5rf2sIJl0RVNs5LLkG0JjBw1w4=
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id
 r11-20020a056808210b00b002d9a6d3b029mr5508004oiw.182.1648846275236; Fri, 01
 Apr 2022 13:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144752.31495-1-cgzones@googlemail.com> <20220331144752.31495-2-cgzones@googlemail.com>
In-Reply-To: <20220331144752.31495-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 1 Apr 2022 16:51:04 -0400
Message-ID: <CAP+JOzRYFWE=sL05iWJJSYxr+0bAXKBe=d9Kim1h4=jAZ85xZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] libsepol/cil: drop unused function cil_tree_error
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 31, 2022 at 2:47 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> It seems to be unused since its initial addition in 76ba6eaa
> ("Squashed 'libsepol/cil/' changes from 08520e9..28ad56e").
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_tree.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 525b60d4..6376c208 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -41,15 +41,6 @@
>  #include "cil_parser.h"
>  #include "cil_strpool.h"
>
> -__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void ci=
l_tree_error(const char* msg, ...)
> -{
> -       va_list ap;
> -       va_start(ap, msg);
> -       cil_vlog(CIL_ERR, msg, ap);
> -       va_end(ap);
> -       exit(1);
> -}
> -
>  struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node,=
 char **info_kind, uint32_t *hll_line, char **path)
>  {
>         int rc;
> --
> 2.35.1
>
