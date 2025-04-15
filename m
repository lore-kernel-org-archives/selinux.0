Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205520B1E8
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727874; cv=none; b=cnkfpLbjdv/V1zGgXql1WLQU+swFbfXaAviQx0JgtEq/YbkK0GTDNYPCIqkhFoxQkyuCkLHS/STGxswpbvSyVZLD54zSLF89SJRp8Iy9c8DjuiYRH0IBcLmiMuaxU9YIYQKKzPAT4kPn46xW2ySMhSPHt8VaF0lU49Urn6gF8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727874; c=relaxed/simple;
	bh=rezBNV5llkUREm3AqqUYphdQtXnzBmt52Naw1x49tZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1p7q3uslssMK2++JTBzCk4A7e+cbKyXX5j7p4EChLBeczOyv80/7QO2U5pZ8Wod/Zp6ldt51+EgtRvdg+jT/LV6a4HEBP/V9IJE86bmGd94UpjNyoM+JicKaCIcqhqWnnVjuY/roroPtTN6h81vDt8d7RId5z6PkZpfCCSxFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QE+Ryy+b; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QE+Ryy+b"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70433283ba7so53734167b3.2
        for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744727871; x=1745332671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Td7E/fvaUNqMWR9+t5Whp1VhzlBE5X5v/LJX2A+BU00=;
        b=QE+Ryy+bsIJbm8uyz5IqK4jwC7cn/Hlnk6uy50zno8YNL+NLjIfzhqnMIpWGls8g2n
         de8vXfqW3Sm+enQvCDqcT2StEmX7IQ4/IZfCorpa6d9BLW2oyRLOBORwIYMZkOznGe6Q
         bEjKU/cnlMavaytuJaKVtE7AYufVsEuyjRp4ZkkA6gcE+HFITPmhdssKD1QcF1E0OBJQ
         9lipHDG09XkpjHcvsmfJ7ca/1ueM3vwxm9SfMMMOBqKlFEVvN2CM7P6yFP1oz5nit2k7
         PKsh1exnu6YkvvPUVPqw1PS63ARCxhEkNgCJMBQ3wXEAGKlQVOZpNRVwDqQpusJ0B7iR
         Y1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744727871; x=1745332671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Td7E/fvaUNqMWR9+t5Whp1VhzlBE5X5v/LJX2A+BU00=;
        b=sbqLUSwxJJQw5jH8CJwQ/Ns0TMEaz2VoG2NGfd/oxYf6JQ8HmUjw7hAEHh157fitev
         lWQ9poaQp2ejYf8Joqhk6s4NEIxTJ6iM2fuEKMGLWAd6/5cLD6oVgL+1Bq9bCyRbzhSd
         CV3sgTaHoBAL0wt6TehPPnU/a8jNCjOR2BrY30Nnm/C4Oz3wl/CcsPklPi6ANe3t5mH1
         KhxbwVFWx6wZ1I8Ryw8lTaeYQREWrVUsGoSYnCDPDETc7u9lC2eslqRoa+Fy6igfsujU
         YbHK5HrcJFXsb+bsrjHXb+/M1SD3iz3ZxyxE1sSFM7XW2Ur4grsxmNUJ7IFJqeTK0sW3
         dhcQ==
X-Gm-Message-State: AOJu0YwbH2KnwilWsVcw5hHzaRj/uflQJfT697ROO7z/fYIGufDAcRBh
	8rpMnuIdRQoGKGNXxtc8QrL4eJiXnHXXKBTjj7zKQG/IffuUp5O1smhammveQSbL0IGFXXB9IeN
	By+GYuaSMoEKC8AjgmybKNs+FTYIRr/7dEc0=
X-Gm-Gg: ASbGncuCTO1JdPxEQ43vLjy5b92ymFHvWQHQmH8dt6N/Ba6x/tGMSyZ1Nq2Y1lHBNPs
	h1lbGS6OohXUHJ9dpS/4OB7Q15V+wQSt2x6tYDNEuxyo34V2sGQpOfytMN8yrmU8V9AwOdcr8U1
	d+BBCtLddA508bWwTrPA+DMZk=
X-Google-Smtp-Source: AGHT+IH3UVkU6+Y0artW/2rRJxkFzE7qAqxh/mVDx7sqEV+mIHb6hq4rkS4v3/TjDlyIPwaSDUaG4wiaTAXr0yCxl9Y=
X-Received: by 2002:a05:690c:fc4:b0:703:b47a:72db with SMTP id
 00721157ae682-705599d3711mr264875467b3.15.1744727871141; Tue, 15 Apr 2025
 07:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411183532.42053-1-tristan.ross@midstall.com>
In-Reply-To: <20250411183532.42053-1-tristan.ross@midstall.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 15 Apr 2025 16:37:40 +0200
X-Gm-Features: ATxdqUFcHgCy8jS9oH9fxW5VvVrsNFYYoLwiYFhc2HtBD1nCJTUXJ-ffDZ4Ah2Y
Message-ID: <CAJ2a_DcSrGUFktCNhDBop_EtS-mO4Jgt8r6XMCq+DO-C4K_ZOA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: add restorecon config option
To: Tristan Ross <tristan.ross@midstall.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Apr 2025 at 20:35, Tristan Ross <tristan.ross@midstall.com> wrote:
>
> This flag allows for enabling or disabling automatic restorecon that
> semodule invokes. By default, we have it enabled to produce the same
> behavior as before. On NixOS, we need this as we're "baking" the module
> installation into a squashfs image and we cannot run restorecon inside
> the builder.
> ---
>  libsemanage/src/conf-parse.y     | 15 ++++++++++++++-
>  libsemanage/src/conf-scan.l      |  1 +
>  libsemanage/src/semanage_conf.h  |  1 +
>  libsemanage/src/semanage_store.c |  7 +++++--
>  4 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index e1fc9f4f..a44e4593 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -63,7 +63,7 @@ static int parse_errors;
>
>  %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY MULTIPLE_DECLS
>  %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
> -%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
> +%token BZIP_BLOCKSIZE BZIP_SMALL RESTORECON REMOVE_HLL
>  %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
>  %token PROG_PATH PROG_ARGS
>  %token <s> ARG
> @@ -97,6 +97,7 @@ single_opt:     module_store
>         |       bzip_blocksize
>         |       bzip_small
>         |       remove_hll
> +       |       restorecon

Maybe use a different name, e.g. (re)?label_store.
Cause otherwise it might get confused with a command override option
for restorecon(8).

>         |       optimize_policy
>         |       multiple_decls
>          ;
> @@ -291,6 +292,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
>         free($3);
>  }
>
> +restorecon:  RESTORECON'=' ARG {
> +       if (strcasecmp($3, "false") == 0) {
> +               current_conf->restorecon = 0;
> +       } else if (strcasecmp($3, "true") == 0) {
> +               current_conf->restorecon = 1;
> +       } else {
> +               yyerror("restorecon can only be 'true' or 'false'");
> +       }
> +       free($3);
> +}
> +
>  optimize_policy:  OPTIMIZE_POLICY '=' ARG {
>         if (strcasecmp($3, "false") == 0) {
>                 current_conf->optimize_policy = 0;
> @@ -400,6 +412,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
>         conf->bzip_small = 0;
>         conf->ignore_module_cache = 0;
>         conf->remove_hll = 0;
> +       conf->restorecon = 1;
>         conf->optimize_policy = 1;
>         conf->multiple_decls = 1;
>
> diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
> index 64433f7b..a180f01f 100644
> --- a/libsemanage/src/conf-scan.l
> +++ b/libsemanage/src/conf-scan.l
> @@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
>  bzip-blocksize return BZIP_BLOCKSIZE;
>  bzip-small     return BZIP_SMALL;
>  remove-hll     return REMOVE_HLL;
> +restorecon     return RESTORECON;
>  optimize-policy return OPTIMIZE_POLICY;
>  multiple-decls return MULTIPLE_DECLS;
>  "[load_policy]"   return LOAD_POLICY_START;
> diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
> index 5db08f0c..ef4534f8 100644
> --- a/libsemanage/src/semanage_conf.h
> +++ b/libsemanage/src/semanage_conf.h
> @@ -49,6 +49,7 @@ typedef struct semanage_conf {
>         int ignore_module_cache;
>         int optimize_policy;
>         int multiple_decls;
> +       int restorecon;
>         char *ignoredirs;       /* ";" separated of list for genhomedircon to ignore */
>         struct external_prog *load_policy;
>         struct external_prog *setfiles;
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index 307f27f9..dee8b5e7 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1823,8 +1823,11 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>
>        cleanup:
>         semanage_release_active_lock(sh);
> -       sehandle = selinux_restorecon_default_handle();
> -       selinux_restorecon_set_sehandle(sehandle);
> +
> +       if (sh->conf->restorecon) {
> +               sehandle = selinux_restorecon_default_handle();
> +               selinux_restorecon_set_sehandle(sehandle);
> +       }
>         return retval;
>  }
>
> --
> 2.47.2
>
>
