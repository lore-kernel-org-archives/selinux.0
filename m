Return-Path: <SRS0=uPJ/=PY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C2C43387
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 20:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E6D206C2
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 20:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbfAPUa4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:30:56 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58806 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbfAPUa4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Jan 2019 15:30:56 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D134656476F
        for <selinux@vger.kernel.org>; Wed, 16 Jan 2019 21:30:52 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id u16so8983174otk.8
        for <selinux@vger.kernel.org>; Wed, 16 Jan 2019 12:30:52 -0800 (PST)
X-Gm-Message-State: AJcUukcylCi0cxc2MO6DFfBqd5jCw/hlQCh7Qas9gP2fqfU3JiEbnFBE
        ui0/3kczlbPFtRu9hn03tHvJq8PR+XqZ5qvRM4c=
X-Google-Smtp-Source: ALg8bN702LbMswvNGnDajmUYmOCy5k0qiK9DWuGZbrbifvSxRPMgUO0UWP5vxvafxGh2SPU3mGFrrgQROwvu6cm84RQ=
X-Received: by 2002:a9d:2f66:: with SMTP id h93mr6990386otb.165.1547670651812;
 Wed, 16 Jan 2019 12:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20190113174425.27403-1-nicolas.iooss@m4x.org> <pjdfttvfx5n.fsf@redhat.com>
In-Reply-To: <pjdfttvfx5n.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 16 Jan 2019 21:30:40 +0100
X-Gmail-Original-Message-ID: <CAJfZ7===wx+QAXKCFLZ7Wg_E3ubR8pgRi5e3xoMA3+CSTq+PAQ@mail.gmail.com>
Message-ID: <CAJfZ7===wx+QAXKCFLZ7Wg_E3ubR8pgRi5e3xoMA3+CSTq+PAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] python/sepolicy: initialize mislabeled_files in __init__()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan 16 21:30:53 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 14, 2019 at 9:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
> > Using "sepolicy gui" sometimes leads to an exception when entering the
> > Files tab:
> >
> >     Traceback (most recent call last):
> >       File "python/sepolicy/sepolicy/gui.py", line 1345, in tab_change
> >         self.show_mislabeled_files_only.set_visible(self.mislabeled_files)
> >     AttributeError: 'SELinuxGui' object has no attribute 'mislabeled_files'
> >
> > Indeed, when application_selected() calls show_applications_page(), this
> > function calls tab_change(), which can use mislabeled_files in this
> > line:
> >
> >     self.show_mislabeled_files_only.set_visible(self.mislabeled_files)
> >
> > Make sure that mislabeled_files is initialized by defining it in
> > __init__(), in order to fix this error. Its value will be properly set
> > later, by calling several initializers, which is why the original
> > assignment to False is kept in:
> >
> >     self.mislabeled_files = False
> >     self.executable_files_initialize(app)
> >     self.network_initialize(app)
> >     self.writable_files_initialize(app)
> >     self.transitions_into_initialize(app)
> >     self.transitions_from_initialize(app)
> >     self.application_files_initialize(app)
> >     self.transitions_files_initialize(app)
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, merged.

Nicolas

> > ---
> >  python/sepolicy/sepolicy/gui.py | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> > index 9d413652f2ed..fde233ad98b1 100644
> > --- a/python/sepolicy/sepolicy/gui.py
> > +++ b/python/sepolicy/sepolicy/gui.py
> > @@ -149,6 +149,7 @@ class SELinuxGui():
> >          self.clear_entry = True
> >          self.files_add = False
> >          self.network_add = False
> > +        self.mislabeled_files = False
> >
> >          self.all_domains = []
> >          self.installed_list = []

