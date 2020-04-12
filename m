Return-Path: <SRS0=FN9z=54=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816B0C2BA2B
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 17:42:55 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E29C206E9
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 17:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIE+2Q8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E29C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgDLRmy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgDLRmx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Apr 2020 13:42:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DEDC0A3BF5
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 10:42:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h6so7168813iok.11
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yps9nvIpG2BDXvwBKFXDLYlWAmm5m8e5lJl7O+LORNc=;
        b=MIE+2Q8rKYw59K0sZ01qMy7wSTq+Dd8ZxB4p7jPqJnziIIwzcEBtGOaSABy3Nfvter
         N3oQm+d6XFr8aScCQxp4BZQVfnhfuuk/m4rblEIo9fz/xd6Khl7aI9Us8xJA4nZIlbY/
         zYEfGgZAQHWIRQSo1yu39i8mLwtCYQQTt5W1Ux2WHeZsFl/QU6I12IvZDOxnDjFFtZGj
         XS086NCjghRuW8Z2IyICUv8roWd++AmniqDvYH06GmkjxiarYmvErlnhy3eqiR7+gGjn
         xxci9Mx03qMHkGEnVG6j9sLnT3tr9+PY+JnsJVdw/Fm9AFX8RNQbOhsjlWWrtytq8N1f
         3mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yps9nvIpG2BDXvwBKFXDLYlWAmm5m8e5lJl7O+LORNc=;
        b=SatrjCi07fybYdD5hB86/7QEgGPUk+OSPnL7bSnZRsDvEEcCW1qbEIMTa5kdPuDVAv
         CeE0N/XWprU470gN2HPhBAPKELQu6+C9EdbpMGu85sKBmQUFLSOr9lZRYQoMpOnWPBqD
         hWk3SN6xHJPGyRBFyQZ07NUQ6J9W9W4EF90GQNrt+eWhpol+bq3IcHhOpbuuC1m6Ff57
         25/tdIxxYOUaxWCIWoNt2Otb6rXmnXjl3b4ST1z2x0pK4JfFVRDqT/ip1yLXqTdmns2N
         fKTJebqQyo9ZgKIIEU+7OqLiZ6Wq8N2f7bpKwZfltSv6HYFUwYBdrVeXbudPd4jXb4uL
         RQPg==
X-Gm-Message-State: AGi0PuaWTAlLF3QOxF6Y9ikvGuxWSikH9eNgIr6/vc3gkwMBBwvEhuGp
        vDHu2fm124s/sz0t49UhgtKoyCFeMl+unglXbOE=
X-Google-Smtp-Source: APiQypI1fFq4DsEKG2vl/C9bf4/HlfgGTLCrVE03kA2Fj+T/JhNWKUMfLLe6+nDbsrJgT7y1WtAKv8KA9rTf+2jIabg=
X-Received: by 2002:a02:cd03:: with SMTP id g3mr12324793jaq.61.1586713371474;
 Sun, 12 Apr 2020 10:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdohqX3vdg=VCSEu_1BQhOUv0ry0vRYtchAFecYZOPK-qQ@mail.gmail.com>
 <20200412170731.5432-1-william.c.roberts@intel.com>
In-Reply-To: <20200412170731.5432-1-william.c.roberts@intel.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 12 Apr 2020 12:42:40 -0500
Message-ID: <CAFftDdqCda7bj5499td6s5Oukn7he4G=w63Uhj_rFjE3KB=BaA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix linker script symbol versions
To:     "bill. c. roberts" <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 12, 2020 at 12:07 PM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> In previous work to cleanup the exports and linker scripts, I introduced
> a regression causing symbols to be named in both the 1.0 and 1.1
> sections. This went un-noticed and was reported by
> nicolas.iooss@m4x.org.
>
> In previous patched checked for correctness by:

in previous patches...

> This was checked by generating an old export map (from master):
> nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
>
> Then creating a new one for this library after this patch is applied:
> nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
>
> And diffing them:
> diff old.map new.map
>
> However, this discards the version information. Nicolas points out a
> better way, by using objdump so we can see the version information. A
> better sequence of commands for checking is as follows:
>
> git checkout 1967477913f6e
> objdump -T ./src/libsemanage.so | grep LIBSEMANAGE | cut -d' ' -f 8- | sed 's/^ //' > map.old
>
> git checkout origin/master
> objdump -T ./src/libsemanage.so | grep LIBSEMANAGE | cut -d' ' -f 8- | sed 's/^ //' > map.new
>
> diff map.old map.new
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsemanage/src/libsemanage.map | 30 +-----------------------------
>  1 file changed, 1 insertion(+), 29 deletions(-)
>
> diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> index ff5977b9f483..79aa8e693389 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -76,10 +76,7 @@ LIBSEMANAGE_1.0 {
>      semanage_fcontext_set_con;
>      semanage_fcontext_set_expr;
>      semanage_fcontext_set_type;
> -    semanage_get_default_priority;
>      semanage_get_disable_dontaudit;
> -    semanage_get_hll_compiler_path;
> -    semanage_get_ignore_module_cache;
>      semanage_get_preserve_tunables;
>      semanage_handle_create;
>      semanage_handle_destroy;
> @@ -170,39 +167,17 @@ LIBSEMANAGE_1.0 {
>      semanage_mls_enabled;
>      semanage_module_disable;
>      semanage_module_enable;
> -    semanage_module_extract;
>      semanage_module_get_enabled;
> -    semanage_module_get_module_info;
>      semanage_module_get_name;
>      semanage_module_get_version;
> -    semanage_module_info_create;
>      semanage_module_info_datum_destroy;
> -    semanage_module_info_destroy;
> -    semanage_module_info_get_enabled;
> -    semanage_module_info_get_lang_ext;
> -    semanage_module_info_get_name;
> -    semanage_module_info_get_priority;
> -    semanage_module_info_set_enabled;
> -    semanage_module_info_set_lang_ext;
> -    semanage_module_info_set_name;
> -    semanage_module_info_set_priority;
>      semanage_module_install;
>      semanage_module_install_base;
>      semanage_module_install_base_file;
>      semanage_module_install_file;
> -    semanage_module_install_info;
> -    semanage_module_key_create;
> -    semanage_module_key_destroy;
> -    semanage_module_key_get_name;
> -    semanage_module_key_get_priority;
> -    semanage_module_key_set_name;
> -    semanage_module_key_set_priority;
>      semanage_module_list;
> -    semanage_module_list_all;
>      semanage_module_list_nth;
>      semanage_module_remove;
> -    semanage_module_remove_key;
> -    semanage_module_set_enabled;
>      semanage_module_upgrade;
>      semanage_module_upgrade_file;
>      semanage_msg_get_channel;
> @@ -276,14 +251,11 @@ LIBSEMANAGE_1.0 {
>      semanage_select_store;
>      semanage_set_check_contexts;
>      semanage_set_create_store;
> -    semanage_set_default_priority;
>      semanage_set_disable_dontaudit;
> -    semanage_set_ignore_module_cache;
>      semanage_set_preserve_tunables;
>      semanage_set_rebuild;
>      semanage_set_reload;
>      semanage_set_root;
> -    semanage_set_store_root;
>      semanage_seuser_clone;
>      semanage_seuser_compare;
>      semanage_seuser_compare2;
> @@ -366,6 +338,7 @@ LIBSEMANAGE_1.1 {
>      semanage_module_info_set_name;
>      semanage_module_info_set_lang_ext;
>      semanage_module_info_set_enabled;
> +    semanage_module_install_info;
>      semanage_module_key_create;
>      semanage_module_key_destroy;
>      semanage_module_key_get_priority;
> @@ -376,7 +349,6 @@ LIBSEMANAGE_1.1 {
>      semanage_module_list_all;
>      semanage_module_get_enabled;
>      semanage_module_set_enabled;
> -    semanage_module_install_info;

We don't need to move this.

>      semanage_module_upgrade_info;
>      semanage_module_remove_key;
>      semanage_set_store_root;
> --
> 2.17.1
>

Ill aggregate feedback and send out a V2. This at least gets people up
and running.
