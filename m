Return-Path: <SRS0=FN9z=54=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D02CC38A29
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553FF206DA
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 18:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553FF206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgDLSsE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Apr 2020 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgDLSsE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Apr 2020 14:48:04 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5F2C0A3BF0
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 11:48:04 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5D58B561270
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 20:48:01 +0200 (CEST)
Received: by mail-ot1-f51.google.com with SMTP id n8so1712428otk.5
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 11:48:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuafPCQ+vcNghjjFEneF65Jg55EcVFqrzwxiORBT72y3iVH3kkTJ
        IQ6PA2lw7V6PcB9yqip46k0qHxo9SYrMl5F1/TQ=
X-Google-Smtp-Source: APiQypKd1Ey1caXgaGHR3/MTKaXYQQnhWaqBrOKnOTkspYtnK4mz5Al1cEFvpvEKH96CqR2J9gHc+0hrmhwVt+/rCL0=
X-Received: by 2002:a05:6830:60b:: with SMTP id w11mr10200734oti.96.1586717280243;
 Sun, 12 Apr 2020 11:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdohqX3vdg=VCSEu_1BQhOUv0ry0vRYtchAFecYZOPK-qQ@mail.gmail.com>
 <20200412170731.5432-1-william.c.roberts@intel.com> <CAFftDdqCda7bj5499td6s5Oukn7he4G=w63Uhj_rFjE3KB=BaA@mail.gmail.com>
In-Reply-To: <CAFftDdqCda7bj5499td6s5Oukn7he4G=w63Uhj_rFjE3KB=BaA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 12 Apr 2020 20:47:49 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mctWT0kjNRz=R=QAhwYNsnd4Umf_T-roA7PxgfdOBuNw@mail.gmail.com>
Message-ID: <CAJfZ7=mctWT0kjNRz=R=QAhwYNsnd4Umf_T-roA7PxgfdOBuNw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix linker script symbol versions
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 12 20:48:01 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 12, 2020 at 7:42 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Sun, Apr 12, 2020 at 12:07 PM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > In previous work to cleanup the exports and linker scripts, I introduced
> > a regression causing symbols to be named in both the 1.0 and 1.1
> > sections. This went un-noticed and was reported by
> > nicolas.iooss@m4x.org.
> >
> > In previous patched checked for correctness by:
>
> in previous patches...
>
> > This was checked by generating an old export map (from master):
> > nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
> >
> > Then creating a new one for this library after this patch is applied:
> > nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
> >
> > And diffing them:
> > diff old.map new.map
> >
> > However, this discards the version information. Nicolas points out a
> > better way, by using objdump so we can see the version information. A
> > better sequence of commands for checking is as follows:
> >
> > git checkout 1967477913f6e
> > objdump -T ./src/libsemanage.so | grep LIBSEMANAGE | cut -d' ' -f 8- | sed 's/^ //' > map.old
> >
> > git checkout origin/master
> > objdump -T ./src/libsemanage.so | grep LIBSEMANAGE | cut -d' ' -f 8- | sed 's/^ //' > map.new
> >
> > diff map.old map.new
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libsemanage/src/libsemanage.map | 30 +-----------------------------
> >  1 file changed, 1 insertion(+), 29 deletions(-)
> >
> > diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> > index ff5977b9f483..79aa8e693389 100644
> > --- a/libsemanage/src/libsemanage.map
> > +++ b/libsemanage/src/libsemanage.map
> > @@ -76,10 +76,7 @@ LIBSEMANAGE_1.0 {
> >      semanage_fcontext_set_con;
> >      semanage_fcontext_set_expr;
> >      semanage_fcontext_set_type;
> > -    semanage_get_default_priority;
> >      semanage_get_disable_dontaudit;
> > -    semanage_get_hll_compiler_path;
> > -    semanage_get_ignore_module_cache;
> >      semanage_get_preserve_tunables;
> >      semanage_handle_create;
> >      semanage_handle_destroy;
> > @@ -170,39 +167,17 @@ LIBSEMANAGE_1.0 {
> >      semanage_mls_enabled;
> >      semanage_module_disable;
> >      semanage_module_enable;
> > -    semanage_module_extract;
> >      semanage_module_get_enabled;
> > -    semanage_module_get_module_info;
> >      semanage_module_get_name;
> >      semanage_module_get_version;
> > -    semanage_module_info_create;
> >      semanage_module_info_datum_destroy;
> > -    semanage_module_info_destroy;
> > -    semanage_module_info_get_enabled;
> > -    semanage_module_info_get_lang_ext;
> > -    semanage_module_info_get_name;
> > -    semanage_module_info_get_priority;
> > -    semanage_module_info_set_enabled;
> > -    semanage_module_info_set_lang_ext;
> > -    semanage_module_info_set_name;
> > -    semanage_module_info_set_priority;
> >      semanage_module_install;
> >      semanage_module_install_base;
> >      semanage_module_install_base_file;
> >      semanage_module_install_file;
> > -    semanage_module_install_info;
> > -    semanage_module_key_create;
> > -    semanage_module_key_destroy;
> > -    semanage_module_key_get_name;
> > -    semanage_module_key_get_priority;
> > -    semanage_module_key_set_name;
> > -    semanage_module_key_set_priority;
> >      semanage_module_list;
> > -    semanage_module_list_all;
> >      semanage_module_list_nth;
> >      semanage_module_remove;
> > -    semanage_module_remove_key;
> > -    semanage_module_set_enabled;
> >      semanage_module_upgrade;
> >      semanage_module_upgrade_file;
> >      semanage_msg_get_channel;
> > @@ -276,14 +251,11 @@ LIBSEMANAGE_1.0 {
> >      semanage_select_store;
> >      semanage_set_check_contexts;
> >      semanage_set_create_store;
> > -    semanage_set_default_priority;
> >      semanage_set_disable_dontaudit;
> > -    semanage_set_ignore_module_cache;
> >      semanage_set_preserve_tunables;
> >      semanage_set_rebuild;
> >      semanage_set_reload;
> >      semanage_set_root;
> > -    semanage_set_store_root;
> >      semanage_seuser_clone;
> >      semanage_seuser_compare;
> >      semanage_seuser_compare2;
> > @@ -366,6 +338,7 @@ LIBSEMANAGE_1.1 {
> >      semanage_module_info_set_name;
> >      semanage_module_info_set_lang_ext;
> >      semanage_module_info_set_enabled;
> > +    semanage_module_install_info;
> >      semanage_module_key_create;
> >      semanage_module_key_destroy;
> >      semanage_module_key_get_priority;
> > @@ -376,7 +349,6 @@ LIBSEMANAGE_1.1 {
> >      semanage_module_list_all;
> >      semanage_module_get_enabled;
> >      semanage_module_set_enabled;
> > -    semanage_module_install_info;
>
> We don't need to move this.
>
> >      semanage_module_upgrade_info;
> >      semanage_module_remove_key;
> >      semanage_set_store_root;
> > --
> > 2.17.1
> >
>
> Ill aggregate feedback and send out a V2. This at least gets people up
> and running.

Thanks for your patch. I have tested it and it indeed fixed the issues
I had. I agree with your comments.

By the way, the .map file contains "semanage_module_upgrade_info" even
though there is no symbol with this name in libsemanage. Should this
line be removed? (in another patch)

Nicolas

