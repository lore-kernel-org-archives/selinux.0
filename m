Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D4BC2BA19
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 17:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9632063A
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 17:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbgDMRMr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:12:47 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53940 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgDMRMr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 13:12:47 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 91B075606AD
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 19:12:44 +0200 (CEST)
Received: by mail-oi1-f169.google.com with SMTP id j16so7952234oih.10
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 10:12:44 -0700 (PDT)
X-Gm-Message-State: AGi0PubibU6OT9KzqiK2gBkwU1bHqX5SjjZN72loJGoykaXtZo+X/ceQ
        woq0t/sfBK4OwS7bZvMUx6T9UOG8O4cZl8rSPTs=
X-Google-Smtp-Source: APiQypLWKdsshyMSYThkZ8HDFpoQ2kTgpn3yVrdZkhwkvXigXVx7KisOuWDseJZYh7ynlgkrS1YlON3vkHZVJvZl1Jo=
X-Received: by 2002:aca:57d6:: with SMTP id l205mr11874764oib.20.1586797963493;
 Mon, 13 Apr 2020 10:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdrJcmNoU6cJ56HRGeg-R6T3bfcxU1zU5xBEmMtxnHNgfw@mail.gmail.com>
 <20200413130359.25372-1-william.c.roberts@intel.com>
In-Reply-To: <20200413130359.25372-1-william.c.roberts@intel.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 13 Apr 2020 19:12:32 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=ktqADheuwoZ0_o9o2zh89gYu6-FWkmGSmSniqGksY5+w@mail.gmail.com>
Message-ID: <CAJfZ7=ktqADheuwoZ0_o9o2zh89gYu6-FWkmGSmSniqGksY5+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsemanage: fix linker script symbol versions
To:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Cc:     William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Apr 13 19:12:44 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 13, 2020 at 3:04 PM <bill.c.roberts@gmail.com> wrote:
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

I tested this patch, compared the symbols of libsemanage.so and
everything looked good.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

