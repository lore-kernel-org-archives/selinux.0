Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA537C67871
	for <selinux@archiver.kernel.org>; Mon, 24 Oct 2022 20:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiJXUno (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiJXUnJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Oct 2022 16:43:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589792CF7
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 11:51:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so2280364pjk.2
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFlSURzg3gXFI7IalM5CGCkXtoe0k0nKwjPt/0IeY4w=;
        b=lhCxHPeFqBd+tfioRk11QjQ45VrFTFsWGqZQtQ7PU/lleepaZB4ajVZcCcGXnLJltp
         HTxXbQmwjqIjpN9ipWPeeIRHDf9omsyA8EeLv9+TfUUCOoYp7wWO3g2XhLM9Nh/10Pm2
         0IHAukCk+AaaMEvE/2M0wSGoBdjQ1xRbWuK02cNWmAoa+tGHjZDlcSlJe4trn2ojMmAA
         +/K88PWkALpXMdlJB8KcPItvs1oBUXgKyimFbanhydoievGztHmyr1baLqU0f+TVL3Eh
         mkQof/iJMFH7XFHOg4oeRwI///NHTkYLm1j/QFiJNAdwVttN/0BebzuHA0+wwU54Lbgc
         4DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFlSURzg3gXFI7IalM5CGCkXtoe0k0nKwjPt/0IeY4w=;
        b=Szya42hd4LanCBlXMdhPsyjafd640O3F2mw8au4hZCpdThMiKz+ENehsdrUm85cpL8
         UxOU1rUznm/89rlsBkIiK23F06O0IHxcmndIXteLiBg/N8pZy9Yhp1YmKW5NG6guO3xB
         KeODkkVrAgcO7mh4qi/uZioCEOfq17i74H72rLs4x7cqyfNvT6qokI34ao4+Fd/kXkc2
         HXw82W2dJFA6BKqdgZQcTNLWjI1TGL34IhM3MFeRZM4IUa6GqaiiU3zPCzxXz85Z1rw8
         RCjkfV1132Bfi7rQaldqW9NyUqzNRVwD2VfnMN5arxlMLdfW+8oNkyNtDH0u7+yebrTk
         CyHg==
X-Gm-Message-State: ACrzQf1tSaw7wc3u5SZwqkiq1+15zK8cbXWzA95BvYZuRwuSpt2JIyLx
        A237oBKqHyxO9Tey4pV4cc8NYArmWcHBiaFsLbc=
X-Google-Smtp-Source: AMsMyM4h5WKd4rM9ApCqtKhH6oA25kC+5cql4pK2I4GLqZjZkGV1syn5aPgjmtc64PjGpq7j1jZfbsSrsqR4my2bfVc=
X-Received: by 2002:a17:902:d4c6:b0:186:850a:4f09 with SMTP id
 o6-20020a170902d4c600b00186850a4f09mr16084032plg.77.1666637439094; Mon, 24
 Oct 2022 11:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221011143623.208283-1-plautrba@redhat.com> <CAP+JOzScOYaEduuNYRNV_agtr-2=YqKhTLzwZnOE8NqM3TOPzg@mail.gmail.com>
In-Reply-To: <CAP+JOzScOYaEduuNYRNV_agtr-2=YqKhTLzwZnOE8NqM3TOPzg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 24 Oct 2022 14:50:28 -0400
Message-ID: <CAP+JOzTz3zkcggQkhRnd38K-U2Z4+1gi_0UEZU1QR1_CtBuX1A@mail.gmail.com>
Subject: Re: [PATCH] gui: Fix export file chooser dialog
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 17, 2022 at 5:06 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Oct 11, 2022 at 10:41 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > It wasn't possible to choose a directory in filechooser dialog using
> > double-click - the dialog returned the directory name instead of
> > listing the directory.
> >
> > Fixes:
> > Traceback (most recent call last):
> >   File "/usr/lib/python3.10/site-packages/sepolicy/gui.py", line 2593, in on_browse_select
> >     self.export_config(filename)
> >   File "/usr/lib/python3.10/site-packages/sepolicy/gui.py", line 2668, in export_config
> >     fd = open(filename, 'w')
> > IsADirectoryError: [Errno 21] Is a directory: '/root/Downloads'
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  python/sepolicy/sepolicy/sepolicy.glade | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
> > index 52407887fcfc..0724d6c8caa4 100644
> > --- a/python/sepolicy/sepolicy/sepolicy.glade
> > +++ b/python/sepolicy/sepolicy/sepolicy.glade
> > @@ -168,7 +168,6 @@
> >        <object class="GtkBox" id="filechooserdialog-vbox1">
> >          <property name="can_focus">False</property>
> >          <property name="orientation">vertical</property>
> > -        <signal name="button-press-event" handler="on_choose_file" swapped="no"/>
> >          <child internal-child="action_area">
> >            <object class="GtkButtonBox" id="filechooserdialog-action_area1">
> >              <property name="can_focus">False</property>
> > --
> > 2.37.3
> >
