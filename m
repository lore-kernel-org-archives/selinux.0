Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4EFC282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 07:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9282081B
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 07:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfBEHS4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:18:56 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:50546 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEHSz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 02:18:55 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B424D5611EC
        for <selinux@vger.kernel.org>; Tue,  5 Feb 2019 08:18:52 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id s13so4155188otq.4
        for <selinux@vger.kernel.org>; Mon, 04 Feb 2019 23:18:52 -0800 (PST)
X-Gm-Message-State: AHQUAuZW1++nVNhYatYgd9fhxs2NA7w86GZeapL77yAhi5+mlYr7eDAL
        80kUKxnSjLCIW4VU58D9mo3Tyx8adOS5clJ7VKw=
X-Google-Smtp-Source: AHgI3IakMy3VM305KvfC/u+Ir6E5c3LBx3BNecvpHI/jjwqRLFUySeeD6T1T7qlUM/IF4f3hF5bFNnV9FE8qXyQsCN4=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr1697638otj.301.1549351131828;
 Mon, 04 Feb 2019 23:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20190131194824.4944-1-plautrba@redhat.com> <CAJfZ7=kF0quUm_KAJqxw+u5KyYoOveaVMXBOTxevgOu41VWRPA@mail.gmail.com>
In-Reply-To: <CAJfZ7=kF0quUm_KAJqxw+u5KyYoOveaVMXBOTxevgOu41VWRPA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 5 Feb 2019 08:18:40 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==w6nOjoMxaoE2W6iWS520p2tpvfL--g211fsj+v8WNnA@mail.gmail.com>
Message-ID: <CAJfZ7==w6nOjoMxaoE2W6iWS520p2tpvfL--g211fsj+v8WNnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: set an appropriate errno in booleans.c
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb  5 08:18:53 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 11:02 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jan 31, 2019 at 8:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Fixes:
> > $ mkdir booleans
> > $ sudo mount --bind ./booleans /sys/fs/selinux/booleans
> > $ sudo getsebool -a
> > getsebool:  Unable to get boolean names:  Success
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged. Thanks
Nicolas

> > ---
> >  libselinux/src/booleans.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> > index b3ea3623..a6d46fea 100644
> > --- a/libselinux/src/booleans.c
> > +++ b/libselinux/src/booleans.c
> > @@ -55,6 +55,7 @@ int security_get_boolean_names(char ***names, int *len)
> >         snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BOOL_DIR);
> >         *len = scandir(path, &namelist, &filename_select, alphasort);
> >         if (*len <= 0) {
> > +               errno = ENOENT;
> >                 return -1;
> >         }
> >
> > --
> > 2.20.1
> >

