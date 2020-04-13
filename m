Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03404C2BA19
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 12:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9772073E
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 12:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN96I6sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgDMMtm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727797AbgDMMtl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Apr 2020 08:49:41 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2274C0A3BE2
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 05:49:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c17so4584279ilk.6
        for <selinux@vger.kernel.org>; Mon, 13 Apr 2020 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqGaPgdzOe7UpkzdLRqQEfeBOA4401aeUeRJtQldobA=;
        b=QN96I6sdBip5nCeI0jaLKI9DbnUJTbnJHgYJPJu7IX7tvDPaUHb4muglkuTbOYSGlB
         BhRBjmmLMjeCYO6v4Fe63sSfww8xGkQU9OxSvAfRxOENXmVVll0JUUjq+KAiSPK9MySN
         d7nE/0T2efMnTjAVHmw/L4LNwbXj8xj1580uSl5Ycky2Nxvkz3vsGfzLzcN4stsaPjfm
         o7nlLXbaHrvbv/HWCEdpgxogClyuYytXoh8He+GE5GFtwQ3vQnSRbMVUwEDMU92dc9J6
         P8XD6D+QadC68ZWafY5Xt/AbZKzGZtrZ12enq6gn3Jt8Od4omW6+vEV2MP01AjhpvwLI
         j2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqGaPgdzOe7UpkzdLRqQEfeBOA4401aeUeRJtQldobA=;
        b=UEs42TONk+NAG3FLoK1xz2oLdzGT275BDtE9LBNOkIlLrnVsIx9/kTMRB51Izrxeq0
         s5KvV0KmmC9BKtwyAHH3Z8/sqvMcJvxp4zqgoUOlcBkpFZTC26D+ZHkniAtr4pUAXRFc
         OWif/UwMlpeYn1ndAUJlSjsgkb0ldbSVtXYv9cbxeWKOjx2i+xzAed/y7lMNttDwJJMo
         E07JOzwwBx46qgUsBA7tfWT08W/HgaX8pE8jXFiGL3wLtDSQmc6O3L6P2bwru1mGL9cU
         vq+Vdc5pMqI+15fqEgZnYn1uyLHGFFC6QD8iTKIy8w0y59O7SIPGhX3lbwnAy2o02ozm
         7Itw==
X-Gm-Message-State: AGi0Pua7YidA1K5IiI7gjByJr76vY+vrD0zAQEHRsZC4tNSd8ZfKwyi4
        JqCr2ryQLEUwEwvWYpJIFK5/cp1vuddsbYJ+zI4=
X-Google-Smtp-Source: APiQypIPuKvJEG12jeIB/1CujSWgJP0gEdzGH5YNqebtqCFq+vn2MfOgTwnltrWusFyfqbxKd2P/IMommu4jfSMqwp4=
X-Received: by 2002:a92:9f5a:: with SMTP id u87mr1127891ili.174.1586782179060;
 Mon, 13 Apr 2020 05:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdohqX3vdg=VCSEu_1BQhOUv0ry0vRYtchAFecYZOPK-qQ@mail.gmail.com>
 <20200412170731.5432-1-william.c.roberts@intel.com> <CAFftDdqCda7bj5499td6s5Oukn7he4G=w63Uhj_rFjE3KB=BaA@mail.gmail.com>
 <CAJfZ7=mctWT0kjNRz=R=QAhwYNsnd4Umf_T-roA7PxgfdOBuNw@mail.gmail.com>
In-Reply-To: <CAJfZ7=mctWT0kjNRz=R=QAhwYNsnd4Umf_T-roA7PxgfdOBuNw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 13 Apr 2020 07:49:28 -0500
Message-ID: <CAFftDdrJcmNoU6cJ56HRGeg-R6T3bfcxU1zU5xBEmMtxnHNgfw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix linker script symbol versions
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 12, 2020 at 1:48 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Sun, Apr 12, 2020 at 7:42 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Sun, Apr 12, 2020 at 12:07 PM <bill.c.roberts@gmail.com> wrote:
> > >
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > In previous work to cleanup the exports and linker scripts, I introduced
> > > a regression causing symbols to be named in both the 1.0 and 1.1
> > > sections. This went un-noticed and was reported by
> > > nicolas.iooss@m4x.org.
> > >
> > > In previous patched checked for correctness by:
> >
> > in previous patches...
> >
> > > This was checked by generating an old export map (from master):
> > > nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
> > >
> > > Then creating a new one for this library after this patch is applied:
> > > nm --defined-only -g ./src/libsemanage.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
> > >
> > > And diffing them:
> > > diff old.map new.map
> > >
> > > However, this discards the version information. Nicolas points out a
> > > better way, by using objdump so we can see the version information. A
> > > better sequence of commands for checking is as follows:
> > >
> > > git checkout 1967477913f6e
> > > objdump -T ./src/libsemanage.so | grep LIBSEMANAGE | cut -d' ' -f 8- | sed 's/^ //' > map.old
> > >
> > > git checkout origin/master
> > > objdump -T ./src/libsemanage.so | grep LIBSEMANAGE | cut -d' ' -f 8- | sed 's/^ //' > map.new
> > >
> > > diff map.old map.new
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > ---
> > >  libsemanage/src/libsemanage.map | 30 +-----------------------------
> > >  1 file changed, 1 insertion(+), 29 deletions(-)
> > >
> > > diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> > > index ff5977b9f483..79aa8e693389 100644
> > > --- a/libsemanage/src/libsemanage.map
> > > +++ b/libsemanage/src/libsemanage.map
> > > @@ -76,10 +76,7 @@ LIBSEMANAGE_1.0 {
> > >      semanage_fcontext_set_con;
> > >      semanage_fcontext_set_expr;
> > >      semanage_fcontext_set_type;
> > > -    semanage_get_default_priority;
> > >      semanage_get_disable_dontaudit;
> > > -    semanage_get_hll_compiler_path;
> > > -    semanage_get_ignore_module_cache;
> > >      semanage_get_preserve_tunables;
> > >      semanage_handle_create;
> > >      semanage_handle_destroy;
> > > @@ -170,39 +167,17 @@ LIBSEMANAGE_1.0 {
> > >      semanage_mls_enabled;
> > >      semanage_module_disable;
> > >      semanage_module_enable;
> > > -    semanage_module_extract;
> > >      semanage_module_get_enabled;
> > > -    semanage_module_get_module_info;
> > >      semanage_module_get_name;
> > >      semanage_module_get_version;
> > > -    semanage_module_info_create;
> > >      semanage_module_info_datum_destroy;
> > > -    semanage_module_info_destroy;
> > > -    semanage_module_info_get_enabled;
> > > -    semanage_module_info_get_lang_ext;
> > > -    semanage_module_info_get_name;
> > > -    semanage_module_info_get_priority;
> > > -    semanage_module_info_set_enabled;
> > > -    semanage_module_info_set_lang_ext;
> > > -    semanage_module_info_set_name;
> > > -    semanage_module_info_set_priority;
> > >      semanage_module_install;
> > >      semanage_module_install_base;
> > >      semanage_module_install_base_file;
> > >      semanage_module_install_file;
> > > -    semanage_module_install_info;
> > > -    semanage_module_key_create;
> > > -    semanage_module_key_destroy;
> > > -    semanage_module_key_get_name;
> > > -    semanage_module_key_get_priority;
> > > -    semanage_module_key_set_name;
> > > -    semanage_module_key_set_priority;
> > >      semanage_module_list;
> > > -    semanage_module_list_all;
> > >      semanage_module_list_nth;
> > >      semanage_module_remove;
> > > -    semanage_module_remove_key;
> > > -    semanage_module_set_enabled;
> > >      semanage_module_upgrade;
> > >      semanage_module_upgrade_file;
> > >      semanage_msg_get_channel;
> > > @@ -276,14 +251,11 @@ LIBSEMANAGE_1.0 {
> > >      semanage_select_store;
> > >      semanage_set_check_contexts;
> > >      semanage_set_create_store;
> > > -    semanage_set_default_priority;
> > >      semanage_set_disable_dontaudit;
> > > -    semanage_set_ignore_module_cache;
> > >      semanage_set_preserve_tunables;
> > >      semanage_set_rebuild;
> > >      semanage_set_reload;
> > >      semanage_set_root;
> > > -    semanage_set_store_root;
> > >      semanage_seuser_clone;
> > >      semanage_seuser_compare;
> > >      semanage_seuser_compare2;
> > > @@ -366,6 +338,7 @@ LIBSEMANAGE_1.1 {
> > >      semanage_module_info_set_name;
> > >      semanage_module_info_set_lang_ext;
> > >      semanage_module_info_set_enabled;
> > > +    semanage_module_install_info;
> > >      semanage_module_key_create;
> > >      semanage_module_key_destroy;
> > >      semanage_module_key_get_priority;
> > > @@ -376,7 +349,6 @@ LIBSEMANAGE_1.1 {
> > >      semanage_module_list_all;
> > >      semanage_module_get_enabled;
> > >      semanage_module_set_enabled;
> > > -    semanage_module_install_info;
> >
> > We don't need to move this.
> >
> > >      semanage_module_upgrade_info;
> > >      semanage_module_remove_key;
> > >      semanage_set_store_root;
> > > --
> > > 2.17.1
> > >
> >
> > Ill aggregate feedback and send out a V2. This at least gets people up
> > and running.
>
> Thanks for your patch. I have tested it and it indeed fixed the issues
> I had. I agree with your comments.
>
> By the way, the .map file contains "semanage_module_upgrade_info" even
> though there is no symbol with this name in libsemanage. Should this
> line be removed? (in another patch)

I see that, ill drop it as well.

>
> Nicolas
>
