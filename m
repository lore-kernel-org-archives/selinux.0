Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA27EC07E96
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67706101D
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhGMUCv convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:02:51 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47743 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbhGMUCv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 16:02:51 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 53E85564774
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 21:59:59 +0200 (CEST)
Received: by mail-il1-f172.google.com with SMTP id o8so13616928ilf.4
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 12:59:59 -0700 (PDT)
X-Gm-Message-State: AOAM530i6mQG+3QO//BZ1/eFEv9kVqM+lwDZggOnqEOLH716cxKZHTiu
        Zyz/UQjKWXocHcSkDl1qMt5soys1mDDh5anLAYQ=
X-Google-Smtp-Source: ABdhPJxBRsd7WZScPeIwtj5U/PIgnfE13n8gK7X9tsmXhIlh3abR0eUJd0N9mDezOTFUxz+sOz4tm/0V9IQ/tEe7bb0=
X-Received: by 2002:a92:260f:: with SMTP id n15mr3999527ile.143.1626206398478;
 Tue, 13 Jul 2021 12:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-14-cgzones@googlemail.com>
 <20210701180707.120172-1-cgzones@googlemail.com> <CAJfZ7==-in9CtKJwagwFV3btKt2KqfLQQ9v2Tu75VdN18cYOJA@mail.gmail.com>
In-Reply-To: <CAJfZ7==-in9CtKJwagwFV3btKt2KqfLQQ9v2Tu75VdN18cYOJA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 21:59:47 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=k-cBU3D72aWZ2k2FgMvxqpNMv5gvC=i+UNowW5StXikA@mail.gmail.com>
Message-ID: <CAJfZ7=k-cBU3D72aWZ2k2FgMvxqpNMv5gvC=i+UNowW5StXikA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libsepol: assure string NUL-termination of ibdev_name
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 21:59:59 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 9:35 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jul 1, 2021 at 8:07 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > Clang complains:
> >
> >     ibendport_record.c: In function ‘sepol_ibendport_get_ibdev_name’:
> >     ibendport_record.c:169:2: error: ‘strncpy’ specified bound 64 equals destination size [-Werror=stringop-truncation]
> >       169 |  strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
> >           |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     ibendport_record.c: In function ‘sepol_ibendport_set_ibdev_name’:
> >     ibendport_record.c:189:2: error: ‘strncpy’ specified bound 64 equals destination size [-Werror=stringop-truncation]
> >       189 |  strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
> >           |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > strncpy(3) does not NUL-terminate the destination if the source is of
> > the same length or longer then the specified size.
> > The source of these copies are retrieved from
> > sepol_ibendport_alloc_ibdev_name(), which allocates a fixed amount of
> > IB_DEVICE_NAME_MAX bytes.
> > Reduce the size to copy by 1 of all memory regions allocated by
> > sepol_ibendport_alloc_ibdev_name().
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks,
> Nicolas

Merged.
Thanks!
Nicolas

> > ---
> > v2:
> >   - use at all affected places as pointed out by James Carter
> >
> >  libsepol/src/ibendport_record.c | 8 ++++----
> >  libsepol/src/ibendports.c       | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
> > index adf67161..1eb50914 100644
> > --- a/libsepol/src/ibendport_record.c
> > +++ b/libsepol/src/ibendport_record.c
> > @@ -62,7 +62,7 @@ int sepol_ibendport_key_create(sepol_handle_t *handle,
> >         if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_key->ibdev_name) < 0)
> >                 goto err;
> >
> > -       strncpy(tmp_key->ibdev_name, ibdev_name, IB_DEVICE_NAME_MAX);
> > +       strncpy(tmp_key->ibdev_name, ibdev_name, IB_DEVICE_NAME_MAX - 1);
> >         tmp_key->port = port;
> >
> >         *key_ptr = tmp_key;
> > @@ -166,7 +166,7 @@ int sepol_ibendport_get_ibdev_name(sepol_handle_t *handle,
> >         if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_ibdev_name) < 0)
> >                 goto err;
> >
> > -       strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
> > +       strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX - 1);
> >         *ibdev_name = tmp_ibdev_name;
> >         return STATUS_SUCCESS;
> >
> > @@ -186,7 +186,7 @@ int sepol_ibendport_set_ibdev_name(sepol_handle_t *handle,
> >         if (sepol_ibendport_alloc_ibdev_name(handle, &tmp) < 0)
> >                 goto err;
> >
> > -       strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
> > +       strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX - 1);
> >         free(ibendport->ibdev_name);
> >         ibendport->ibdev_name = tmp;
> >         return STATUS_SUCCESS;
> > @@ -230,7 +230,7 @@ int sepol_ibendport_clone(sepol_handle_t *handle,
> >         if (sepol_ibendport_alloc_ibdev_name(handle, &new_ibendport->ibdev_name) < 0)
> >                 goto omem;
> >
> > -       strncpy(new_ibendport->ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
> > +       strncpy(new_ibendport->ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX - 1);
> >         new_ibendport->port = ibendport->port;
> >
> >         if (ibendport->con &&
> > diff --git a/libsepol/src/ibendports.c b/libsepol/src/ibendports.c
> > index 6d56c9a1..ee5cb193 100644
> > --- a/libsepol/src/ibendports.c
> > +++ b/libsepol/src/ibendports.c
> > @@ -34,7 +34,7 @@ static int ibendport_from_record(sepol_handle_t *handle,
> >                                            &ibdev_name) < 0)
> >                 goto err;
> >
> > -       strncpy(tmp_ibendport->u.ibendport.dev_name, ibdev_name, IB_DEVICE_NAME_MAX);
> > +       strncpy(tmp_ibendport->u.ibendport.dev_name, ibdev_name, IB_DEVICE_NAME_MAX - 1);
> >
> >         free(ibdev_name);
> >         ibdev_name = NULL;
> > --
> > 2.32.0
> >

