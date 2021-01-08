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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0ECC433DB
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123F623A9B
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbhAHTcJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbhAHTcJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 14:32:09 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B3EC061380
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 11:31:29 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j12so10731269ota.7
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 11:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7tvswjNTHDLonxMreMe3dNcvasYdY8wDq9+iEtOlbs=;
        b=MLQENEwZbp24V8Ilopnt2xUYAVyFMnaOjx6St7HrQAJHCifekhHgfXUfWyZ5frVOcQ
         hMdPjJjhoEnL25ZQNEcngp/401++KanVB2ms3QA5O/8CTiHZM1juJJ1YBQUoC5gDg/X9
         QyiKk3W+qhINFY1S6eInBS1bmIJhFXF7kdZ60ihQKjh0cUYpb7MQJOzj6LneICESW8nP
         l38L52uKCjoOVwIQEKN+g6gNqgKxjbaxpEAOBlD1MTy9TZj10keV5/vSGC2IuGchS7AM
         7BAQbBYgF1lBgr8PzQsfCb0iGBDHlJhQLcNTmwblRchhr3B0p5Ply6r3J9TRWQL2VEDE
         l13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7tvswjNTHDLonxMreMe3dNcvasYdY8wDq9+iEtOlbs=;
        b=NTdD/vqPaGQDk4pcg3SZvsJelw4k6XIZFwChgbugMZoQ63Ts72mEVcv0Ry/laiYKYm
         Umlr3+AFYS8dBXy+5N2p8pLm0STFHFZpYo7bxotF45BEoRCIiCRHvhEYwtuTo7bjzl7h
         ygZHYyQ6a3nH1TjWi2xesMe5Cp2oObj7AighWdKpYVzxYr3+WJJO+WPbB5qGmKKldF4r
         H3mXE8pvAuSyIOCjbQuCKTZ25SOhJkBnwP52ijrCIyrY4cfWkr877jPbY0I/m8ru3Yj/
         evZPBlVkEsiskZmHhbbT0/ZI5izJLiGKoQ1dDBR9VSO4KBFFP/8+KTQiW/MZb/kk9e7y
         HhXA==
X-Gm-Message-State: AOAM531GbzofisuoD7mv4dYkjKOqzKzxwr9pZgUWLm2ZhSV4rhDzrCgt
        BbdfBlPLwR+XfyrNJJeZ7x0CTnljoI64EOS/TOE=
X-Google-Smtp-Source: ABdhPJwsPW5XydHm9yozltgtWR6pavlguE03CDXT+Z2L/CbPkbGn3B/HaI836h44qPzJRAHVRpGprLcsaJdovHP9prg=
X-Received: by 2002:a9d:27a7:: with SMTP id c36mr3658617otb.59.1610134288549;
 Fri, 08 Jan 2021 11:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20210106081319.379572-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210106081319.379572-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 8 Jan 2021 14:35:51 -0500
Message-ID: <CAP+JOzQ_UcpR-LHaed+DAAhAL9VeCpg9aG=DEo+y4s-cwvMb5g@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: fix NULL pointer dereference when
 parsing an improper integer
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 3:13 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a NULL pointer dereference when the CIL compiler tries to
> compile a policy with an invalid integer:
>
>     $ echo '(ioportcon(2())n)' > tmp.cil
>     $ secilc tmp.cil
>     Segmentation fault (core dumped)
>
> This is because strtol() is called with a NULL pointer, in
> cil_fill_integer().
>
> Fix this by checking that int_node->data is not NULL. While at it, use
> strtoul() instead of strtol() to parse an unsigned integer.
>
> When using "val > UINT32_MAX" with "unsigned long val;", it is expected
> that some compilers emit a warning when the size of "unsigned long" is
> 32 bits. In theory gcc could be such a compiler (with warning
> -Wtype-limits, which is included in -Wextra). Nevertheless this is
> currently broken, according to
> https://gcc.gnu.org/pipermail/gcc-help/2021-January/139755.html and
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89126 (this bug was
> opened in January 2019).
>
> In order to prevent this warning from appearing, introduce some
> preprocessor macros around the bound check.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28456
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_build_ast.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index be10d61b1314..02481558ad11 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5570,19 +5570,27 @@ int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base
>  {
>         int rc = SEPOL_ERR;
>         char *endptr = NULL;
> -       int val;
> +       unsigned long val;
>
> -       if (int_node == NULL || integer == NULL) {
> +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
>                 goto exit;
>         }
>
>         errno = 0;
> -       val = strtol(int_node->data, &endptr, base);
> +       val = strtoul(int_node->data, &endptr, base);
>         if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
>                 rc = SEPOL_ERR;
>                 goto exit;
>         }
>
> +       /* Ensure that the value fits a 32-bit integer without triggering -Wtype-limits */
> +#if ULONG_MAX > UINT32_MAX
> +       if (val > UINT32_MAX) {
> +               rc = SEPOL_ERR;
> +               goto exit;
> +       }
> +#endif
> +
>         *integer = val;
>
>         return SEPOL_OK;
> @@ -5598,7 +5606,7 @@ int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int ba
>         char *endptr = NULL;
>         uint64_t val;
>
> -       if (int_node == NULL || integer == NULL) {
> +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
>                 goto exit;
>         }
>
> --
> 2.30.0
>
