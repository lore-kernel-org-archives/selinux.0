Return-Path: <SRS0=gWJv=57=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D9C2BA19
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 15:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F344120767
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 15:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtP6UzrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389666AbgDOP3p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393476AbgDOP3n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 11:29:43 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE4C061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 08:29:42 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h6so17468380iok.11
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvX1R/0FuSl1JkKg/Fl+3oeGr21bfrTezTtLYU4UyvI=;
        b=jtP6UzrXASk2a87ZDFEV135LST2S/XLKuGX8k34Y53cYxE//4pLDN/NC+XKDY5O3EZ
         FMk+unhaht0S5Yn83mvWS5/JDHFP2n560VZW44m0P+MCBCV+Pv8cJnZH2Xs5sUfjPtmm
         fP/l8P60UWdVQ6aGj/ezXZtF+WJdsspr3SqjQcczZ4WiIFL9GH+ihZX1JIEca/lSMZ6S
         i9OsLJjnviR3glbE4UQagfeFaGMmweZx1Ags7kFNIzVAUfiFK1OIjlhV11VK+LYiQHt3
         8XbTtO0GqPTHBMzbPeQAa4u7NVQbWrK0RiS0RJLeHA14wh76/gm7Nv+KM9hw4364Ypth
         OmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvX1R/0FuSl1JkKg/Fl+3oeGr21bfrTezTtLYU4UyvI=;
        b=dCDUD0lG4pNwe1aUOac11CXLMS8vGGzJCTbbX2l8Dg0O9lYu5FUgFNYVyLcEWX5hGL
         jnHDODHzFef0yDgS72Za5fszg/Q1lGXMxH8KdwpNPINP/mt1Onkxo1YMUi7spHqbkD2n
         y2sY/ocp6N4yN/F1sgcaXJHHc3olvD+48ZD4AGdfWrJD/AH+pd9YCbq1As68bIpTUQWO
         +0JoCFMtjJGDOHOELQpsm+HXXOc3ixxscI+v5eZQJ8xJj+wet0ZYm4iwBTXG7BIm6jEP
         toWdu8N9bdoyBL8ni6tBI2oSKwgAMV3A536dOeY6vJKdsw6pzW5O+lrSF0VPeqghiEmL
         mxsg==
X-Gm-Message-State: AGi0PuYeo6e+RewgiWnukigLPfW0MfKMHwxVjax0mmBCI+6/ZIbXECEH
        W6aKdpZzeuCV0x8aFvc5ZSxyxgX88JUnkQ7dlGGGkoTMyxk=
X-Google-Smtp-Source: APiQypKjdfl1SYOqC+4sJNls2hHBHUOhkBPb2eVASB6BbK/aY0fLWmV5pme8RFB0g8o2N3gibiBn6xgPqJGhd78GXg0=
X-Received: by 2002:a5e:870f:: with SMTP id y15mr23126372ioj.88.1586964581298;
 Wed, 15 Apr 2020 08:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdrJcmNoU6cJ56HRGeg-R6T3bfcxU1zU5xBEmMtxnHNgfw@mail.gmail.com>
 <20200413130359.25372-1-william.c.roberts@intel.com> <CAJfZ7=ktqADheuwoZ0_o9o2zh89gYu6-FWkmGSmSniqGksY5+w@mail.gmail.com>
 <CAFftDdoa9wS9WsbFpGyOQ3igLcHp0ZcVcSqBOtEy+QUWB_xw1Q@mail.gmail.com>
In-Reply-To: <CAFftDdoa9wS9WsbFpGyOQ3igLcHp0ZcVcSqBOtEy+QUWB_xw1Q@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 15 Apr 2020 10:29:28 -0500
Message-ID: <CAFftDdqPQeY2Z6DQY1=Qjnk_esicbXVdgH-pnuauu8_ykGWAtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsemanage: fix linker script symbol versions
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 13, 2020 at 12:39 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Mon, Apr 13, 2020 at 12:12 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Mon, Apr 13, 2020 at 3:04 PM <bill.c.roberts@gmail.com> wrote:
> > >
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > In previous work to cleanup the exports and linker scripts, I introduced
> > > a regression causing symbols to be named in both the 1.0 and 1.1
> > > sections. This went un-noticed and was reported by
> > > nicolas.iooss@m4x.org.
> > >
> > > Previous patches checked for correctness by:
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
> > >  libsemanage/src/libsemanage.map | 28 ----------------------------
> > >  1 file changed, 28 deletions(-)
> > >
> > > diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> > > index ff5977b9f483..8ba2746deaa2 100644
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
> > > --
> >
> > I tested this patch, compared the symbols of libsemanage.so and
> > everything looked good.
> >
> > Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Staged:
> https://github.com/SELinuxProject/selinux/pull/219
Merged:
https://github.com/SELinuxProject/selinux/pull/219
