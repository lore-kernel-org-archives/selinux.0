Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD7C433EF
	for <selinux@archiver.kernel.org>; Thu, 20 Jan 2022 21:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347507AbiATVwS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jan 2022 16:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiATVwP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jan 2022 16:52:15 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F96C061574
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 13:52:15 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso9343609otr.6
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 13:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lZt6PmWGKkHxdphKOXjGXj5wybkKA0fGTMfsc+rybI=;
        b=YEe9Jgkfk0SoxSXzKeZLqtqbBcLCehHcMA3v06/olxVhEvZ2k/b9emdynHpmYHNHHE
         8PgZEv4MC2ZpYUZQnTXJ2R3Ga9lHvfzaIooTW2UBpJ+5dJDDvvgGL0vxecbfGYummvB/
         PKyuT1XbDhhjAHjD8L67ACkCm0DJCMyCCLnuBYtKXwClPEGgAgTyD4c1vVtdnGWGtL2F
         Vsz/J+jyliWGxjB3yOaLWulocrXGCLYEuotk51OZo9P/dWOGgt7NS5fp9WxEEzA/zjFE
         o58NY32DM52srXmthrwUDCNbuCnwhAj5rXKMnD8g/MjVan5WFf4zS+BZE9N+lLJcoGp2
         yGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lZt6PmWGKkHxdphKOXjGXj5wybkKA0fGTMfsc+rybI=;
        b=He13YZKDZODFH2wEG3CqUM8C8hV+QM3NdkDdn7hCNYx0hr2Bv+spkdZ0ZR7t1XGnvm
         Vm0BAWjJ5bxpA+OmKZigiqaPDnzJBrfP6NUazMQJ8Un4LP0xl8QNE4QsDy8XPUNe7BWF
         OU79dr6c1KMt1g1kAi48S34L0HQbMbJZfmLKZ7zfsgkgmF7C10ELHBM9ou6MVhJBJqI6
         cSaFtVisAKiUtnAxmWAFWCBNDkxNF1DhXam+s1bvWzSeKlNaW/+7BUXNYhxaoTIncnc/
         4mC5lCC3qoPINjwDOkrZUjWpujYukRIyy5uYRMdrxYlJ3PPCCKcUs6lrYqxFby37MhRO
         db8g==
X-Gm-Message-State: AOAM531ovv4XaAIn8fXGClOMbAG3HyohO2cBiXAD+Bm4fziKDtxw8Y3H
        VjlDByureuuEG8+b9gVgSfTabKVawj+oF8u8pP5dMhB2
X-Google-Smtp-Source: ABdhPJy5lwqPVNDZCx6iS3cvvTPgEYGsZ06WXMyfvgLMmGA919m67U+QPtFB3kgUQMyFd0GTNE7lbsSfwDYUduiCjBc=
X-Received: by 2002:a9d:639a:: with SMTP id w26mr601466otk.139.1642715534385;
 Thu, 20 Jan 2022 13:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20220113143935.195125-1-omosnace@redhat.com> <20220113143935.195125-3-omosnace@redhat.com>
In-Reply-To: <20220113143935.195125-3-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 20 Jan 2022 16:52:03 -0500
Message-ID: <CAP+JOzSnr2xrZ=2_B2XVVtvb4fiz4dW1JBEhDfKZrjwbjzEA4w@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 2/5] semodule,libsemanage: move module
 hashing into libsemanage
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 13, 2022 at 6:36 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The main goal of this move is to have the SHA-256 implementation under
> libsemanage, since upcoming patches will make use of SHA-256 for a
> different (but similar) purpose in libsemanage. Having the hashing code
> in libsemanage will reduce code duplication and allow for easier hash
> algorithm upgrade in the future.
>
> Note that libselinux currently also contains a hash function
> implementation (for yet another different purpose). This patch doesn't
> make any effort to address that duplicity yet.
>
> The changes here are only refactoring, no functional change is done
> here. A new libsemanage API function semanage_module_compute_checksum()
> is provided and semodule is made to use it for implementing its
> hash_module_data() function.
>
> Note that the API function also returns a string representation of the
> hash algorithm used, which is currently unused by semodule. The intent
> is to avoid ambiguity and potential collisions when the algorithm is
> potentially changed in the future. I could add the hash algorithm to the
> semodule output, but doing so might break tools parsing the exisiting
> format. (RFC: Should I change it anyway?)
>

So that it would be a part of the hash string returned by
hash_module_data() in semodule.c?

I would want to hear from people who use the hashes before I would
want to change anything.

Thanks,
Jim


> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libsemanage/include/semanage/modules.h        | 25 +++++++++
>  libsemanage/src/libsemanage.map               |  4 ++
>  libsemanage/src/modules.c                     | 36 +++++++++++++
>  .../src/semanageswig_python_exception.i       |  8 +++
>  .../semodule => libsemanage/src}/sha256.c     |  0
>  .../semodule => libsemanage/src}/sha256.h     |  0
>  policycoreutils/semodule/Makefile             |  2 +-
>  policycoreutils/semodule/semodule.c           | 51 +++++++------------
>  8 files changed, 92 insertions(+), 34 deletions(-)
>  rename {policycoreutils/semodule => libsemanage/src}/sha256.c (100%)
>  rename {policycoreutils/semodule => libsemanage/src}/sha256.h (100%)
>
> diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
> index b51f61f0..1332654d 100644
> --- a/libsemanage/include/semanage/modules.h
> +++ b/libsemanage/include/semanage/modules.h
> @@ -282,4 +282,29 @@ extern int semanage_module_get_enabled(semanage_handle_t *sh,
>                                        const semanage_module_key_t *modkey,
>                                        int *enabled);
>
> +/* Compute checksum for @modkey module contents. On success, @checksum_type
> + * will point to a string containing the checksum type (i.e. the checksum
> + * algorithm), @checksum will point to a buffer containig the checksum as

Typo: containing, not containig

> + * binary data, and @checksum_len will point to the size of the checksum.
> + * The semantics of @cil are the same as for extract_cil in
> + * semanage_module_extract().
> + *
> + * The caller is responsible to free the buffer returned in @checksum (using
> + * free(3)). The string returned via @checksum_type must NOT be freed by the
> + * caller.
> + *
> + * Two checksums are considered equal when both @checksum_type and the
> + * checksum itself are equal. Most versions of libsemanage should return
> + * the same @checksum_type, although it may change occasionally when
> + * libsemanage switches to a different algorithm.
> + *
> + * Returns 0 on success and -1 on error.
> + */
> +extern int semanage_module_compute_checksum(semanage_handle_t *sh,
> +                                           semanage_module_key_t *modkey,
> +                                           int cil,
> +                                           const char **checksum_type,
> +                                           void **checksum,
> +                                           size_t *checksum_len);
> +
>  #endif
> diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> index 3ea7b60f..00259fc8 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -345,3 +345,7 @@ LIBSEMANAGE_1.1 {
>      semanage_module_remove_key;
>      semanage_set_store_root;
>  } LIBSEMANAGE_1.0;
> +
> +LIBSEMANAGE_3.4 {
> +    semanage_module_compute_checksum;
> +} LIBSEMANAGE_1.1;
> diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
> index c98df4dd..72c5ed2c 100644
> --- a/libsemanage/src/modules.c
> +++ b/libsemanage/src/modules.c
> @@ -35,11 +35,13 @@
>  #include <fcntl.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/mman.h>
>  #include <errno.h>
>  #include <ctype.h>
>
>  #include "handle.h"
>  #include "modules.h"
> +#include "sha256.h"
>  #include "debug.h"
>
>  int semanage_module_install(semanage_handle_t * sh,
> @@ -976,3 +978,37 @@ int semanage_module_remove_key(semanage_handle_t *sh,
>         return sh->funcs->remove_key(sh, modkey);
>  }
>
> +int semanage_module_compute_checksum(semanage_handle_t *sh,
> +                                    semanage_module_key_t *modkey,
> +                                    int cil, const char **checksum_type,
> +                                    void **checksum, size_t *checksum_len)
> +{
> +       semanage_module_info_t *extract_info = NULL;
> +       Sha256Context context;
> +       SHA256_HASH sha256_hash;
> +       void *data;
> +       size_t data_len = 0;
> +       int result;
> +
> +       result = semanage_module_extract(sh, modkey, cil, &data, &data_len, &extract_info);
> +       if (result != 0)
> +               return -1;
> +
> +       semanage_module_info_destroy(sh, extract_info);
> +       free(extract_info);
> +
> +       Sha256Initialise(&context);
> +       Sha256Update(&context, data, data_len);
> +       Sha256Finalise(&context, &sha256_hash);
> +
> +       munmap(data, data_len);
> +
> +       *checksum = malloc(SHA256_HASH_SIZE);
> +       if (!*checksum)
> +               return -1;
> +
> +       memcpy(*checksum, sha256_hash.bytes, SHA256_HASH_SIZE);
> +       *checksum_len = SHA256_HASH_SIZE;
> +       *checksum_type = "sha256";
> +       return 0;
> +}
> diff --git a/libsemanage/src/semanageswig_python_exception.i b/libsemanage/src/semanageswig_python_exception.i
> index 372ec948..0df8bbc3 100644
> --- a/libsemanage/src/semanageswig_python_exception.i
> +++ b/libsemanage/src/semanageswig_python_exception.i
> @@ -351,6 +351,14 @@
>    }
>  }
>
> +%exception semanage_module_compute_checksum {
> +  $action
> +  if (result < 0) {
> +     PyErr_SetFromErrno(PyExc_OSError);
> +     SWIG_fail;
> +  }
> +}
> +
>  %exception semanage_msg_get_level {
>    $action
>    if (result < 0) {
> diff --git a/policycoreutils/semodule/sha256.c b/libsemanage/src/sha256.c
> similarity index 100%
> rename from policycoreutils/semodule/sha256.c
> rename to libsemanage/src/sha256.c
> diff --git a/policycoreutils/semodule/sha256.h b/libsemanage/src/sha256.h
> similarity index 100%
> rename from policycoreutils/semodule/sha256.h
> rename to libsemanage/src/sha256.h
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
> index 9875ac38..73801e48 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
>
>  CFLAGS ?= -Werror -Wall -W
>  override LDLIBS += -lsepol -lselinux -lsemanage
> -SEMODULE_OBJS = semodule.o sha256.o
> +SEMODULE_OBJS = semodule.o
>
>  all: semodule genhomedircon
>
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index 94a9d131..a5b71fc4 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -25,8 +25,6 @@
>  #include <sepol/cil/cil.h>
>  #include <semanage/modules.h>
>
> -#include "sha256.h"
> -
>  enum client_modes {
>         NO_MODE, INSTALL_M, REMOVE_M, EXTRACT_M, CIL_M, HLL_M,
>         LIST_M, RELOAD, PRIORITY_M, ENABLE_M, DISABLE_M
> @@ -348,60 +346,47 @@ static void parse_command_line(int argc, char **argv)
>
>  /* Get module checksum */
>  static char *hash_module_data(const char *module_name, const int prio) {
> -       semanage_module_info_t *extract_info = NULL;
>         semanage_module_key_t *modkey = NULL;
> -       Sha256Context context;
> -       uint8_t sha256_hash[SHA256_HASH_SIZE];
> -       char *sha256_buf = NULL;
> -       void *data;
> -       size_t data_len = 0, i;
> +       const char *checksum_type;
> +       char *hash_str = NULL;
> +       void *hash = NULL;
> +       size_t hash_len = 0, i;
>         int result;
>
>         result = semanage_module_key_create(sh, &modkey);
>         if (result != 0) {
> -               goto cleanup_extract;
> +               goto cleanup;
>         }
>
>         result = semanage_module_key_set_name(sh, modkey, module_name);
>         if (result != 0) {
> -               goto cleanup_extract;
> +               goto cleanup;
>         }
>
>         result = semanage_module_key_set_priority(sh, modkey, prio);
>         if (result != 0) {
> -               goto cleanup_extract;
> +               goto cleanup;
>         }
>
> -       result = semanage_module_extract(sh, modkey, 1, &data, &data_len,
> -                                                                        &extract_info);
> +       result = semanage_module_compute_checksum(sh, modkey, 1, &checksum_type,
> +                                                 &hash, &hash_len);
>         if (result != 0) {
> -               goto cleanup_extract;
> +               goto cleanup;
>         }
>
> -       Sha256Initialise(&context);
> -       Sha256Update(&context, data, data_len);
> -
> -       Sha256Finalise(&context, (SHA256_HASH *)sha256_hash);
> -
> -       sha256_buf = calloc(1, SHA256_HASH_SIZE * 2 + 1);
> -
> -       if (sha256_buf == NULL)
> -               goto cleanup_extract;
> +       hash_str = calloc(1, hash_len * 2 + 1);
> +       if (!hash_str)
> +               goto cleanup;
>
> -       for (i = 0; i < SHA256_HASH_SIZE; i++) {
> -               sprintf((&sha256_buf[i * 2]), "%02x", sha256_hash[i]);
> +       for (i = 0; i < hash_len; i++) {
> +               sprintf(&hash_str[i * 2], "%02x", ((uint8_t *)hash)[i]);
>         }
> -       sha256_buf[i * 2] = 0;
>
> -cleanup_extract:
> -       if (data_len > 0) {
> -               munmap(data, data_len);
> -       }
> -       semanage_module_info_destroy(sh, extract_info);
> -       free(extract_info);
> +cleanup:
> +       free(hash);
>         semanage_module_key_destroy(sh, modkey);
>         free(modkey);
> -       return sha256_buf;
> +       return hash_str;
>  }
>
>  int main(int argc, char *argv[])
> --
> 2.34.1
>
