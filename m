Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DEFC433DF
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFF222264
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/WTJ59J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404998AbgJOR5V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404985AbgJOR5V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:57:21 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CDFC061755
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:57:20 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s81so3987485oie.13
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6krO6KZtpDh8rVVI51FjI/pySNqg82AOYJNBTW0JtY=;
        b=b/WTJ59JFz6C+Jv+o05F/KhpgDMzM7dWW3pIXlP4zPfAPgrdoKyONtupL+9dKcx6FQ
         yFVKfQYw8Kj7b1vtlFPve4WHU15vFXSpR6hlLit6rMHckSISr77pfwaa19oKm4WddR2l
         MjlIRRvJxwRitEmX2d1elI8v9Mz3CYO3KtTJtZ1tkqlujCIZuZburLO+32jj0s0jJ9wT
         3JwExYXBYAz040Q5GXNGqagDH0uJW5CawSJRD6I1veWQZOJ9mYxCx7+Ed3eoL3fa+sZT
         nVSgFWo5yF07L0fGEP+sMEP7KfFbn4dstq1Sg5qWkYXDw8T4HKbprpuU0EZa+bqC4aFL
         VVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6krO6KZtpDh8rVVI51FjI/pySNqg82AOYJNBTW0JtY=;
        b=cvpKhmEvaOOdbUID31I3p8yDwxf/cbtGxMEs61GsHwRF3n+pugr8p7VY+MS/s5qIsb
         ABOXLhXcrKTRiEhBA+wfSG9F5NgV0S2OaD/+P51Yau6862IyLMCHdSHTX75ftaDeaf8T
         2fS5nHxxIUtIJoRgJcZYKTcq9R5tV1t+wJ3wsQmgPJSEN9oOCOcIFZIQmYMcFl+mNnMS
         ojt3m++PMGH/nYIHrPfVU7BjiWHgAj8kxPe3OcNFC9FFTi4R53BBjfrUPJf6V4OMUomH
         g9WXhuhgYaOcmHLPNH/4ZDJ0EQxUl6n8J+s+9kX9oqk7yRGUDWjPNZk0ezrqhxG9V2b0
         A5IQ==
X-Gm-Message-State: AOAM530mbMsZ5mFASsQulpNHyE2ZsIsENRCfwOF5njWkrXT1COBFgVXK
        UwyefulFiIV7HN5ilpvCvl6mH+hdTJ76iDXOGrnInOe0mLw=
X-Google-Smtp-Source: ABdhPJzcpifs7diAexlBDoIEodi3CK7dQTBjuEpfjgvUjgDa00T7lr0PoIpiccO7FCnwKLiQRYeK9Mdp4dF72ICdNNI=
X-Received: by 2002:aca:aa94:: with SMTP id t142mr28908oie.16.1602784639936;
 Thu, 15 Oct 2020 10:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201009130052.52409-1-plautrba@redhat.com> <20201009130052.52409-5-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-5-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Oct 2020 13:57:09 -0400
Message-ID: <CAP+JOzQydk500LD57SsW-FgFsq8RysqKDpEduKukBpa0rzAFsA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] libsemanage: Remove legacy and duplicate symbols
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 9, 2020 at 9:48 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Versioned duplicate symbols cause problems for LTO. These symbols were
> introduced during the CIL integration several releases ago and were only
> consumed by other SELinux userspace components.
>
> Related: https://github.com/SELinuxProject/selinux/issues/245
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/include/semanage/modules.h |   2 +-
>  libsemanage/src/libsemanage.map        |   5 --
>  libsemanage/src/modules.c              | 100 +------------------------
>  libsemanage/src/modules.h              |   9 +--
>  libsemanage/src/semanageswig_python.i  |   2 -
>  5 files changed, 4 insertions(+), 114 deletions(-)
>
> diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
> index ac4039314857..b51f61f033d5 100644
> --- a/libsemanage/include/semanage/modules.h
> +++ b/libsemanage/include/semanage/modules.h
> @@ -33,7 +33,7 @@ typedef struct semanage_module_key semanage_module_key_t;
>   */
>
>  extern int semanage_module_install(semanage_handle_t *,
> -                                  char *module_data, size_t data_len, char *name, char *ext_lang);
> +                                  char *module_data, size_t data_len, const char *name, const char *ext_lang);
>  extern int semanage_module_install_file(semanage_handle_t *,
>                                         const char *module_name);
>  extern int semanage_module_remove(semanage_handle_t *, char *module_name);
> diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> index 1375a8ca0ea7..4bec06aaae27 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -167,18 +167,13 @@ LIBSEMANAGE_1.0 {
>      semanage_mls_enabled;
>      semanage_module_disable;
>      semanage_module_enable;
> -    semanage_module_get_enabled;
>      semanage_module_get_name;
>      semanage_module_get_version;
>      semanage_module_info_datum_destroy;
> -    semanage_module_install;
> -    semanage_module_install_base;
> -    semanage_module_install_base_file;
>      semanage_module_install_file;
>      semanage_module_list;
>      semanage_module_list_nth;
>      semanage_module_remove;
> -    semanage_module_upgrade;
>      semanage_module_upgrade_file;
>      semanage_msg_get_channel;
>      semanage_msg_get_fname;
> diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
> index 6d3eb60ae462..8b36801038df 100644
> --- a/libsemanage/src/modules.c
> +++ b/libsemanage/src/modules.c
> @@ -42,70 +42,7 @@
>  #include "modules.h"
>  #include "debug.h"
>
> -asm(".symver semanage_module_get_enabled_1_1,semanage_module_get_enabled@@LIBSEMANAGE_1.1");
> -asm(".symver semanage_module_get_enabled_1_0,semanage_module_get_enabled@LIBSEMANAGE_1.0");
> -asm(".symver semanage_module_install_pp,semanage_module_install@LIBSEMANAGE_1.0");
> -asm(".symver semanage_module_install_hll,semanage_module_install@@LIBSEMANAGE_1.1");
> -
> -/* Takes a module stored in 'module_data' and parses its headers.
> - * Sets reference variables 'module_name' to module's name and
> - * 'version' to module's version. The caller is responsible for
> - * free()ing 'module_name' and 'version'; they will be
> - * set to NULL upon entering this function.  Returns 0 on success, -1
> - * if out of memory, or -2 if data did not represent a module.
> - */
> -static int parse_module_headers(semanage_handle_t * sh, char *module_data,
> -                               size_t data_len, char **module_name, char **version)
> -{
> -       struct sepol_policy_file *pf;
> -       int file_type;
> -       *version = NULL;
> -
> -       if (sepol_policy_file_create(&pf)) {
> -               ERR(sh, "Out of memory!");
> -               return -1;
> -       }
> -       sepol_policy_file_set_mem(pf, module_data, data_len);
> -       sepol_policy_file_set_handle(pf, sh->sepolh);
> -       if (module_data == NULL ||
> -           data_len == 0 ||
> -           sepol_module_package_info(pf, &file_type, module_name, version) == -1) {
> -               sepol_policy_file_free(pf);
> -               ERR(sh, "Could not parse module data.");
> -               return -2;
> -       }
> -       sepol_policy_file_free(pf);
> -       if (file_type != SEPOL_POLICY_MOD) {
> -               ERR(sh, "Data did not represent a pp module. Please upgrade to the latest version of libsemanage to support hll modules.");
> -               return -2;
> -       }
> -
> -       return 0;
> -}
> -
> -/* This function is used to preserve ABI compatibility with
> - * versions of semodule using LIBSEMANAGE_1.0
> - */
> -int semanage_module_install_pp(semanage_handle_t * sh,
> -                           char *module_data, size_t data_len)
> -{
> -       char *name = NULL;
> -       char *version = NULL;
> -       int status;
> -
> -       if ((status = parse_module_headers(sh, module_data, data_len, &name, &version)) != 0) {
> -               goto cleanup;
> -       }
> -
> -       status = semanage_module_install_hll(sh, module_data, data_len, name, "pp");
> -
> -cleanup:
> -       free(name);
> -       free(version);
> -       return status;
> -}
> -
> -int semanage_module_install_hll(semanage_handle_t * sh,
> +int semanage_module_install(semanage_handle_t * sh,
>                             char *module_data, size_t data_len, const char *name, const char *ext_lang)
>  {
>         if (sh->funcs->install == NULL) {
> @@ -160,16 +97,6 @@ int semanage_module_extract(semanage_handle_t * sh,
>         return sh->funcs->extract(sh, modkey, extract_cil, mapped_data, data_len, modinfo);
>  }
>
> -/* Legacy function that remains to preserve ABI
> - * compatibility. Please use semanage_module_install instead.
> - */
> -int semanage_module_upgrade(semanage_handle_t * sh,
> -                           char *module_data, size_t data_len)
> -{
> -       return semanage_module_install_pp(sh, module_data, data_len);
> -
> -}
> -
>  /* Legacy function that remains to preserve ABI
>   * compatibility. Please use semanage_module_install_file instead.
>   */
> @@ -179,24 +106,6 @@ int semanage_module_upgrade_file(semanage_handle_t * sh,
>         return semanage_module_install_file(sh, module_name);
>  }
>
> -/* Legacy function that remains to preserve ABI
> - * compatibility. Please use semanage_module_install instead.
> - */
> -int semanage_module_install_base(semanage_handle_t * sh,
> -                                char *module_data, size_t data_len)
> -{
> -       return semanage_module_install_pp(sh, module_data, data_len);
> -}
> -
> -/* Legacy function that remains to preserve ABI
> - * compatibility. Please use semanage_module_install_file instead.
> - */
> -int semanage_module_install_base_file(semanage_handle_t * sh,
> -                                const char *module_name)
> -{
> -       return semanage_module_install_file(sh, module_name);
> -}
> -
>  int semanage_module_remove(semanage_handle_t * sh, char *module_name)
>  {
>         if (sh->funcs->remove == NULL) {
> @@ -780,7 +689,7 @@ int semanage_module_key_set_priority(semanage_handle_t *sh,
>  }
>
>
> -int semanage_module_get_enabled_1_1(semanage_handle_t *sh,
> +int semanage_module_get_enabled(semanage_handle_t *sh,
>                                 const semanage_module_key_t *modkey,
>                                 int *enabled)
>  {
> @@ -800,11 +709,6 @@ int semanage_module_get_enabled_1_1(semanage_handle_t *sh,
>         return sh->funcs->get_enabled(sh, modkey, enabled);
>  }
>
> -int semanage_module_get_enabled_1_0(semanage_module_info_t *modinfo)
> -{
> -       return modinfo->enabled;
> -}
> -
>  int semanage_module_set_enabled(semanage_handle_t *sh,
>                                 const semanage_module_key_t *modkey,
>                                 int enabled)
> diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
> index 2d3576fb15df..64d4a157f5ca 100644
> --- a/libsemanage/src/modules.h
> +++ b/libsemanage/src/modules.h
> @@ -26,16 +26,9 @@
>
>  #include "semanage/modules.h"
>
> -int semanage_module_install_pp(semanage_handle_t * sh,
> -                           char *module_data, size_t data_len);
> -int semanage_module_install_hll(semanage_handle_t * sh,
> -                           char *module_data, size_t data_len, const char *name, const char *ext_lang);
> -int semanage_module_upgrade(semanage_handle_t * sh,
> -                           char *module_data, size_t data_len);
> +
>  int semanage_module_upgrade_file(semanage_handle_t * sh,
>                                  const char *module_name);
> -int semanage_module_install_base(semanage_handle_t * sh,
> -                                char *module_data, size_t data_len);
>  int semanage_module_install_base_file(semanage_handle_t * sh,
>                                  const char *module_name);
>
> diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/semanageswig_python.i
> index 8dd79fc24213..5f0113966962 100644
> --- a/libsemanage/src/semanageswig_python.i
> +++ b/libsemanage/src/semanageswig_python.i
> @@ -30,8 +30,6 @@
>  %}
>
>  %include "stdint.i"
> -%ignore semanage_module_install_pp;
> -%ignore semanage_module_install_hll;
>
>  %wrapper %{
>
> --
> 2.28.0
>
