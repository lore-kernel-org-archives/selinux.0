Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9893C2BB86
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A0E2075E
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 13:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJwon5JU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgDMNEs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727954AbgDMNEq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 09:04:46 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B0C0A3BDC
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:04:46 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b12so9200869ion.8
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 06:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJdtXZA0k/h5NS+VipeeMyj1tMS5tN5iLsShjv9eoAo=;
        b=RJwon5JUH0aOiio4oDC/GhdhpD70KP9YYn8VWfqOaiemO4OCI/zSNvrC5LBb69XR4Z
         6HFHrFMzBXTi+4xQ7IzRfLJIrhFk3of6zY9AUAzV0DcXIoBZjmT+poLPtMpJSa7H0mPQ
         WetjLzaaz0MBeSKIH9wS2HzIJA5a1iupZdK2UiCCJQJCLvspz4xBkcml66SEdrBMhxyz
         B6AHaJMP9SNrmEh8mMGFA0l8wjPlk+s221DGLwVv84xK/JMcH3wsHPNs/a58xJtn3NI5
         VytNw9NRbEBIlI46COkZr44g42POGdYhmXlfTxuJne/soNzvsdGnbKAew8sOwh12i9tQ
         ZoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJdtXZA0k/h5NS+VipeeMyj1tMS5tN5iLsShjv9eoAo=;
        b=b5QDwh382dXlt2w5GHBOUgzfu7ARwsRU7KzoYsMxTv0CyCzr6J5nUji6DjCHedfCjn
         W2k+gDh9FDSeNMhNttVzxSwMbLHNiovn/d92xzf+AET3AGAgFeOJxPqZfJH7+my9N9DB
         B5ZdZ5leymibR61Ao7tBTVJWQpRij0g+oqkNlZftJReANMHO7FpW51Vq/26GDCOPk2UN
         YFSwwytfwjZdCEmxCDuKDUVUh0NVmq0Pm8xP1/HodRGWNXesiC/d2b53Eji5QfKmzta7
         ZwJIc5OvA1NUUF78BL/C9kVzGZJxCe1OHz9u7bo0AbczGhaa5r8xp2COwGjHvRdmxPlV
         9KCg==
X-Gm-Message-State: AGi0PubkTZWdPNKEoUkPDlhcz4Uk+SskXtMvwYIIKtQYkJHccVqEzFL8
        Mv6A0heo9AV3+IcJiCidqBSYAA6frfj9rMY31Wv3O6rf
X-Google-Smtp-Source: APiQypIrQYddNEqSJqitn/R/4q3WJUrtfD7NYDp/dewbAFlxw5kkQ3tCDtpU6YVUZq5KuFQeiMvPVQQld/ODUcfCUdw=
X-Received: by 2002:a05:6638:11d1:: with SMTP id g17mr16116631jas.116.1586783085801;
 Mon, 13 Apr 2020 06:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdrJcmNoU6cJ56HRGeg-R6T3bfcxU1zU5xBEmMtxnHNgfw@mail.gmail.com>
 <20200413130248.25296-1-william.c.roberts@intel.com>
In-Reply-To: <20200413130248.25296-1-william.c.roberts@intel.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 13 Apr 2020 08:04:34 -0500
Message-ID: <CAFftDdqZ4BOcZh01pbB+XhOAFAxG1w8XRnJc9BF8Qz8oi6q=2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: fix linker script symbol versions
To:     "bill. c. roberts" <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 13, 2020 at 8:03 AM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> In previous work to cleanup the exports and linker scripts, I introduced
> a regression causing symbols to be named in both the 1.0 and 1.1
> sections. This went un-noticed and was reported by
> nicolas.iooss@m4x.org.
>
> Previous patches checked for correctness by:
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
>  libsemanage/src/libsemanage.map | 28 ----------------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> index ff5977b9f483..8ba2746deaa2 100644
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
> --
> 2.17.1
>
Ignore this, it's missing the v2 declaration....
