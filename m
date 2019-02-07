Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCA4C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F9021721
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfBGVVp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:21:45 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:45627 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGVVp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 16:21:45 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0C3A95612AB
        for <selinux@vger.kernel.org>; Thu,  7 Feb 2019 22:21:42 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id s5so2380961oth.7
        for <selinux@vger.kernel.org>; Thu, 07 Feb 2019 13:21:41 -0800 (PST)
X-Gm-Message-State: AHQUAuZSKIciC+7OG3Z6DKJzuOHEOyPNmZtpBL7NERe2uOHuJdQlNN6h
        s9lidogDWyld9CTbDtZDyLNPbaGiooLSQGw6Ad0=
X-Google-Smtp-Source: AHgI3IbW8wnvcTfxVzQGKXqWWup1A7eecBwMmmpIvFhRonWbkYr9r17beSIRcE55URwXwwojIlFfW54+4r9m3+baPQU=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr9947115oth.338.1549574501144;
 Thu, 07 Feb 2019 13:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20190206194156.24804-1-plautrba@redhat.com>
In-Reply-To: <20190206194156.24804-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 7 Feb 2019 22:21:29 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nzFtrLJNE2UhS67ecN2nPy3JACt26Pqmov4fnnOHp3qA@mail.gmail.com>
Message-ID: <CAJfZ7=nzFtrLJNE2UhS67ecN2nPy3JACt26Pqmov4fnnOHp3qA@mail.gmail.com>
Subject: Re: [PATCH] gui: Make all polgen button labels translatable
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Vit Mojzis <vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb  7 22:21:42 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 6, 2019 at 8:42 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From: Vit Mojzis <vmojzis@redhat.com>
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  gui/polgen.ui | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/gui/polgen.ui b/gui/polgen.ui
> index aa4c70af..6a8c0672 100644
> --- a/gui/polgen.ui
> +++ b/gui/polgen.ui
> @@ -1975,7 +1975,7 @@ Tab</property>
>                                        <object class="GtkLabel" id="label17">
>                                          <property name="visible">True</property>
>                                          <property name="can_focus">False</property>
> -                                        <property name="label">Add File</property>
> +                                        <property name="label" translatable="yes">Add File</property>
>                                          <property name="use_underline">True</property>
>                                        </object>
>                                        <packing>
> @@ -2028,7 +2028,7 @@ Tab</property>
>                                        <object class="GtkLabel" id="label16">
>                                          <property name="visible">True</property>
>                                          <property name="can_focus">False</property>
> -                                        <property name="label">Add Directory</property>
> +                                        <property name="label" translatable="yes">Add Directory</property>
>                                          <property name="use_underline">True</property>
>                                        </object>
>                                        <packing>
> @@ -2176,7 +2176,7 @@ Tab</property>
>                                        <object class="GtkLabel" id="label3">
>                                          <property name="visible">True</property>
>                                          <property name="can_focus">False</property>
> -                                        <property name="label">Add Boolean</property>
> +                                        <property name="label" translatable="yes">Add Boolean</property>
>                                          <property name="use_underline">True</property>
>                                        </object>
>                                        <packing>
> --
> 2.20.1
>

