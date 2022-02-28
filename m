Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA4BC433EF
	for <selinux@archiver.kernel.org>; Mon, 28 Feb 2022 21:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiB1VZK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiB1VZJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Feb 2022 16:25:09 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E612019F
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 13:24:29 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so10570726oti.5
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbQQZ4/IGZ1JTWHHJYCIULantrdpZkgeUWy6N9pXy14=;
        b=nHt60MHpCiL8o4GRDoa5qOe9IjUxt1eyK3I8fOYTNP6aZ9LeWz9HoYwZ42GknpjuBr
         xn6hDa1l4IgfCBfI7qSh0JaKRUPb/3jBYE8uraWqWHPTZi2JSPU76J3d6f330TMy3l4w
         qw9yehN9G03BkNffkop4hTPAHcFkPR8v8aiubZ2JdGs16045qtzwa0piS+SzQmWlw7WT
         W3SiNrgF+rX0IIIWjVz+TCSEqkER8tgacNXv6zOJLFC9VKD1OtQnWanK2o2SwczAfGya
         KdINN5kZ16owqxAtRYnapdanTahYZ1o6XZTKQJunRprmyaSIsM5sv8hd95i5nbI/4V/D
         XVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbQQZ4/IGZ1JTWHHJYCIULantrdpZkgeUWy6N9pXy14=;
        b=hC5MLWJWhnMLnk+0meTUU3KDJqiRffsCfLt9V0fHRf5qSeBI0OwmRWQgTqQrWQmFLM
         +ZrUU1JTqaJEOJXC/90Xqlc7u5xHb9+1S8tURK8RkC/8jh64Pcy4+6jCWFzBjuYWKmxF
         /nDMmiUFMa7ZXEqEcCCLBoj0tjRjGemzNu17UyruvOLLzB59Ek2zXw7nHGUXztQDvrpD
         sjKRgJVzSvpGenEB+pjOgyV3msbxOWfyuSDC5LqDc2P3wqqFctWPRxCtXgfz7vtHoTHi
         GHDfp3oxjDZ9O76OE1aDLtEAYAMW+mRn81jF5NmT5U++4araOM8Fy/NDOArO+8MryS+g
         wGdw==
X-Gm-Message-State: AOAM5314XLdxo2A7oJwDIQvIAhv/wsyuVkX687DNYxrOpVwafKiUeJCt
        kNTdaj8FQV7iTNYWVsedquD7XXI5i0LN9AOEHlg=
X-Google-Smtp-Source: ABdhPJzLLvRF/Tyzz4P1uk4A64bfPkxtmXTNQqSCQmwDLRZjaYU8XjY0QxjuLC9364zwgGd/SWKlI4k2yg7yyyzVKio=
X-Received: by 2002:a9d:6c8:0:b0:5ad:5a1e:f79d with SMTP id
 66-20020a9d06c8000000b005ad5a1ef79dmr10396485otx.154.1646083468548; Mon, 28
 Feb 2022 13:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20220217124923.1193874-1-vmojzis@redhat.com>
In-Reply-To: <20220217124923.1193874-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Feb 2022 16:24:17 -0500
Message-ID: <CAP+JOzTumQ3V6UQQmz5-0yL9b-LBrt--GCJN3B3qoV=8NqwPqQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: allow spaces in user/group names
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 17, 2022 at 2:17 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> "semanage login -a" accepts whitespaces in user/group name
> (e.g. users/groups from Active Directory), which may lead to issues down
> the line since libsemanage doesn't expect whitespaces in
> /var/lib/selinux/targeted/active/seusers and other config files.
>
> Fixes:
>   Artificial but simple reproducer
>   # groupadd server_admins
>   # sed -i "s/^server_admins/server admins/" /etc/group
>   # semanage login -a -s staff_u %server\ admins
>   # semanage login -l  (or "semodule -B")
>   libsemanage.parse_assert_ch: expected character ':', but found 'a' (/var/lib/selinux/targeted/active/seusers: 6):
>   %server admins:staff_u:s0-s0:c0.c1023 (No such file or directory).
>   libsemanage.seuser_parse: could not parse seuser record (No such file or directory).
>   libsemanage.dbase_file_cache: could not cache file database (No such file or directory).
>   libsemanage.enter_ro: could not enter read-only section (No such file or directory).
>   FileNotFoundError: [Errno 2] No such file or directory
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/booleans_file.c    |  2 +-
>  libsemanage/src/fcontexts_file.c   |  6 +++---
>  libsemanage/src/ibendports_file.c  |  4 ++--
>  libsemanage/src/ibpkeys_file.c     |  4 ++--
>  libsemanage/src/interfaces_file.c  |  6 +++---
>  libsemanage/src/nodes_file.c       |  8 ++++----
>  libsemanage/src/parse_utils.c      |  6 +++---
>  libsemanage/src/parse_utils.h      | 11 +++++------
>  libsemanage/src/ports_file.c       |  4 ++--
>  libsemanage/src/seusers_file.c     |  6 +++---
>  libsemanage/src/users_base_file.c  |  7 +++----
>  libsemanage/src/users_extra_file.c |  4 ++--
>  12 files changed, 33 insertions(+), 35 deletions(-)
>
> diff --git a/libsemanage/src/booleans_file.c b/libsemanage/src/booleans_file.c
> index f79d0b44..6d600bbc 100644
> --- a/libsemanage/src/booleans_file.c
> +++ b/libsemanage/src/booleans_file.c
> @@ -48,7 +48,7 @@ static int bool_parse(semanage_handle_t * handle,
>                 goto last;
>
>         /* Extract name */
> -       if (parse_fetch_string(handle, info, &str, '=') < 0)
> +       if (parse_fetch_string(handle, info, &str, '=', 0) < 0)
>                 goto err;
>
>         if (semanage_bool_set_name(handle, boolean, str) < 0)
> diff --git a/libsemanage/src/fcontexts_file.c b/libsemanage/src/fcontexts_file.c
> index 04cd365a..f3579410 100644
> --- a/libsemanage/src/fcontexts_file.c
> +++ b/libsemanage/src/fcontexts_file.c
> @@ -90,7 +90,7 @@ static int fcontext_parse(semanage_handle_t * handle,
>                 goto last;
>
>         /* Regexp */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_fcontext_set_expr(handle, fcontext, str) < 0)
>                 goto err;
> @@ -100,7 +100,7 @@ static int fcontext_parse(semanage_handle_t * handle,
>         /* Type */
>         if (parse_assert_space(handle, info) < 0)
>                 goto err;
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (!strcasecmp(str, "-s"))
>                 semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_SOCK);
> @@ -124,7 +124,7 @@ static int fcontext_parse(semanage_handle_t * handle,
>         /* Context */
>         if (parse_assert_space(handle, info) < 0)
>                 goto err;
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>
>        process_context:
> diff --git a/libsemanage/src/ibendports_file.c b/libsemanage/src/ibendports_file.c
> index bafa8c1d..2fa2a67c 100644
> --- a/libsemanage/src/ibendports_file.c
> +++ b/libsemanage/src/ibendports_file.c
> @@ -75,7 +75,7 @@ static int ibendport_parse(semanage_handle_t *handle,
>                 goto err;
>
>         /* IB Device Name */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_ibendport_set_ibdev_name(handle, ibendport, str) < 0)
>                 goto err;
> @@ -92,7 +92,7 @@ static int ibendport_parse(semanage_handle_t *handle,
>         /* context */
>         if (parse_assert_space(handle, info) < 0)
>                 goto err;
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_context_from_string(handle, str, &con) < 0) {
>                 ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
> diff --git a/libsemanage/src/ibpkeys_file.c b/libsemanage/src/ibpkeys_file.c
> index 929bc31e..edde69f0 100644
> --- a/libsemanage/src/ibpkeys_file.c
> +++ b/libsemanage/src/ibpkeys_file.c
> @@ -80,7 +80,7 @@ static int ibpkey_parse(semanage_handle_t *handle,
>                 goto err;
>
>         /* Subnet Prefix */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_ibpkey_set_subnet_prefix(handle, ibpkey, str) < 0)
>                 goto err;
> @@ -115,7 +115,7 @@ static int ibpkey_parse(semanage_handle_t *handle,
>                 semanage_ibpkey_set_pkey(ibpkey, low);
>         }
>         /* Pkey context */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_context_from_string(handle, str, &con) < 0) {
>                 ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
> diff --git a/libsemanage/src/interfaces_file.c b/libsemanage/src/interfaces_file.c
> index c19c8f94..244f0ae5 100644
> --- a/libsemanage/src/interfaces_file.c
> +++ b/libsemanage/src/interfaces_file.c
> @@ -72,7 +72,7 @@ static int iface_parse(semanage_handle_t * handle,
>                 goto err;
>
>         /* Name */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_iface_set_name(handle, iface, str) < 0)
>                 goto err;
> @@ -82,7 +82,7 @@ static int iface_parse(semanage_handle_t * handle,
>         /* Interface context */
>         if (parse_assert_space(handle, info) < 0)
>                 goto err;
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_context_from_string(handle, str, &con) < 0) {
>                 ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
> @@ -106,7 +106,7 @@ static int iface_parse(semanage_handle_t * handle,
>         /* Message context */
>         if (parse_assert_space(handle, info) < 0)
>                 goto err;
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_context_from_string(handle, str, &con) < 0) {
>                 ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
> diff --git a/libsemanage/src/nodes_file.c b/libsemanage/src/nodes_file.c
> index c3647f2a..2d2b7fe0 100644
> --- a/libsemanage/src/nodes_file.c
> +++ b/libsemanage/src/nodes_file.c
> @@ -77,7 +77,7 @@ static int node_parse(semanage_handle_t * handle,
>                 goto err;
>
>         /* Protocol */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (!strcasecmp(str, "ipv4"))
>                 proto = SEMANAGE_PROTO_IP4;
> @@ -96,7 +96,7 @@ static int node_parse(semanage_handle_t * handle,
>         /* Address */
>         if (parse_assert_space(handle, info) < 0)
>                 goto err;
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_node_set_addr(handle, node, proto, str) < 0)
>                 goto err;
> @@ -106,7 +106,7 @@ static int node_parse(semanage_handle_t * handle,
>         str = NULL;
>
>         /* Netmask */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_node_set_mask(handle, node, proto, str) < 0)
>                 goto err;
> @@ -116,7 +116,7 @@ static int node_parse(semanage_handle_t * handle,
>         str = NULL;
>
>         /* Port context */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_context_from_string(handle, str, &con) < 0) {
>                 ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
> diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
> index 4fb54fc3..918dee43 100644
> --- a/libsemanage/src/parse_utils.c
> +++ b/libsemanage/src/parse_utils.c
> @@ -239,7 +239,7 @@ int parse_fetch_int(semanage_handle_t * handle,
>         char *test = NULL;
>         int value = 0;
>
> -       if (parse_fetch_string(handle, info, &str, delim) < 0)
> +       if (parse_fetch_string(handle, info, &str, delim, 0) < 0)
>                 goto err;
>
>         if (!isdigit((int)*str)) {
> @@ -267,7 +267,7 @@ int parse_fetch_int(semanage_handle_t * handle,
>  }
>
>  int parse_fetch_string(semanage_handle_t * handle,
> -                      parse_info_t * info, char **str, char delim)
> +                      parse_info_t * info, char **str, char delim, int allow_spaces)
>  {
>
>         char *start = info->ptr;
> @@ -277,7 +277,7 @@ int parse_fetch_string(semanage_handle_t * handle,
>         if (parse_assert_noeof(handle, info) < 0)
>                 goto err;
>
> -       while (*(info->ptr) && !isspace(*(info->ptr)) &&
> +       while (*(info->ptr) && (allow_spaces || !isspace(*(info->ptr))) &&
>                (*(info->ptr) != delim)) {
>                 info->ptr++;
>                 len++;
> diff --git a/libsemanage/src/parse_utils.h b/libsemanage/src/parse_utils.h
> index 0f334860..3e44aca1 100644
> --- a/libsemanage/src/parse_utils.h
> +++ b/libsemanage/src/parse_utils.h
> @@ -71,12 +71,11 @@ extern int parse_optional_str(parse_info_t * info, const char *str);
>  int parse_fetch_int(semanage_handle_t * hgandle,
>                     parse_info_t * info, int *num, char delim);
>
> -/* Extract the next string (delimited by
> - * whitespace), and move the read pointer past it.
> - * Stop of the optional character delim is encountered,
> - * or if whitespace/eof is encountered. Fail if the
> - * string is of length 0. */
> +/* Extract the next string and move the read pointer past it.
> + * Stop if the optional character delim (or eof) is encountered,
> + * or if whitespace is encountered and allow_spaces is 0.
> + * Fail if the string is of length 0. */
>  extern int parse_fetch_string(semanage_handle_t * handle,
> -                             parse_info_t * info, char **str_ptr, char delim);
> +                             parse_info_t * info, char **str_ptr, char delim, int allow_spaces);
>
>  #endif
> diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
> index ade4102f..1356021a 100644
> --- a/libsemanage/src/ports_file.c
> +++ b/libsemanage/src/ports_file.c
> @@ -77,7 +77,7 @@ static int port_parse(semanage_handle_t * handle,
>                 goto err;
>
>         /* Protocol */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (!strcasecmp(str, "tcp"))
>                 semanage_port_set_proto(port, SEMANAGE_PROTO_TCP);
> @@ -123,7 +123,7 @@ static int port_parse(semanage_handle_t * handle,
>                 semanage_port_set_port(port, low);
>
>         /* Port context */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_context_from_string(handle, str, &con) < 0) {
>                 ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
> diff --git a/libsemanage/src/seusers_file.c b/libsemanage/src/seusers_file.c
> index 910bedf4..21b970ac 100644
> --- a/libsemanage/src/seusers_file.c
> +++ b/libsemanage/src/seusers_file.c
> @@ -53,7 +53,7 @@ static int seuser_parse(semanage_handle_t * handle,
>                 goto last;
>
>         /* Extract name */
> -       if (parse_fetch_string(handle, info, &str, ':') < 0)
> +       if (parse_fetch_string(handle, info, &str, ':', 1) < 0)
>                 goto err;
>         if (semanage_seuser_set_name(handle, seuser, str) < 0)
>                 goto err;
> @@ -68,7 +68,7 @@ static int seuser_parse(semanage_handle_t * handle,
>                 goto err;
>
>         /* Extract sename */
> -       if (parse_fetch_string(handle, info, &str, ':') < 0)
> +       if (parse_fetch_string(handle, info, &str, ':', 1) < 0)
>                 goto err;
>         if (semanage_seuser_set_sename(handle, seuser, str) < 0)
>                 goto err;
> @@ -83,7 +83,7 @@ static int seuser_parse(semanage_handle_t * handle,
>                 goto err;
>
>         /* NOTE: does not allow spaces/multiline */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>
>         if (semanage_seuser_set_mlsrange(handle, seuser, str) < 0)
> diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_base_file.c
> index 0f0a8fdb..a0f8cd7e 100644
> --- a/libsemanage/src/users_base_file.c
> +++ b/libsemanage/src/users_base_file.c
> @@ -83,7 +83,7 @@ static int user_base_parse(semanage_handle_t * handle,
>                 goto err;
>
>         /* Parse user name */
> -       if (parse_fetch_string(handle, info, &name_str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &name_str, ' ', 0) < 0)
>                 goto err;
>
>         if (semanage_user_base_set_name(handle, user, name_str) < 0) {
> @@ -150,7 +150,7 @@ static int user_base_parse(semanage_handle_t * handle,
>                 goto err;
>
>         /* NOTE: does not allow spaces/multiline */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_user_base_set_mlslevel(handle, user, str) < 0)
>                 goto err;
> @@ -165,8 +165,7 @@ static int user_base_parse(semanage_handle_t * handle,
>         if (parse_assert_space(handle, info) < 0)
>                 goto err;
>
> -       /* NOTE: does not allow spaces/multiline */
> -       if (parse_fetch_string(handle, info, &str, ';') < 0)
> +       if (parse_fetch_string(handle, info, &str, ';', 1) < 0)
>                 goto err;
>         if (semanage_user_base_set_mlsrange(handle, user, str) < 0)
>                 goto err;
> diff --git a/libsemanage/src/users_extra_file.c b/libsemanage/src/users_extra_file.c
> index 8f2bebd6..7aa9df3c 100644
> --- a/libsemanage/src/users_extra_file.c
> +++ b/libsemanage/src/users_extra_file.c
> @@ -57,7 +57,7 @@ static int user_extra_parse(semanage_handle_t * handle,
>                 goto err;
>
>         /* Extract name */
> -       if (parse_fetch_string(handle, info, &str, ' ') < 0)
> +       if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
>                 goto err;
>         if (semanage_user_extra_set_name(handle, user_extra, str) < 0)
>                 goto err;
> @@ -73,7 +73,7 @@ static int user_extra_parse(semanage_handle_t * handle,
>                 goto err;
>
>         /* Extract prefix */
> -       if (parse_fetch_string(handle, info, &str, ';') < 0)
> +       if (parse_fetch_string(handle, info, &str, ';', 1) < 0)
>                 goto err;
>         if (semanage_user_extra_set_prefix(handle, user_extra, str) < 0)
>                 goto err;
> --
> 2.30.2
>
