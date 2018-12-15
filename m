Return-Path: <SRS0=8Orh=OY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EBAC43387
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 09:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24FF2080F
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 09:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeLOJle (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:41:34 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:48568 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeLOJle (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Dec 2018 04:41:34 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D77CF560692
        for <selinux@vger.kernel.org>; Sat, 15 Dec 2018 10:41:30 +0100 (CET)
Received: by mail-oi1-f172.google.com with SMTP id j21so6554247oii.8
        for <selinux@vger.kernel.org>; Sat, 15 Dec 2018 01:41:30 -0800 (PST)
X-Gm-Message-State: AA+aEWYgZ0GL2j0PEG29YzqlzQBRsg0PlZbgmvc1hCgSxcfcLk3730N6
        dDkn9b4BNcjrF/1L7bYYYjMSI9TwSO+j2lPUg2Q=
X-Google-Smtp-Source: AFSGD/XMB+qNKfIL+I7Pr29N1r14P0u/TlzP4/l3a9EFDYT6IFpqinE3KVOVU7MWum8bAYtMBA623ygLey4TNQRxaHI=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr908043oig.232.1544866889804;
 Sat, 15 Dec 2018 01:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20181209153702.24905-1-nicolas.iooss@m4x.org> <pjdr2emde7t.fsf@redhat.com>
In-Reply-To: <pjdr2emde7t.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 15 Dec 2018 10:41:18 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==CAvV9PwoSY3oDWxpwPP58Xb3W+NHegKi7LE7fVFfbBA@mail.gmail.com>
Message-ID: <CAJfZ7==CAvV9PwoSY3oDWxpwPP58Xb3W+NHegKi7LE7fVFfbBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] python/semanage: do not show "None" levels when using
 a non-MLS policy
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Dec 15 10:41:31 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 12, 2018 at 3:14 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
> > When MLS is disabled, "semanage export" shows records such as:
> >
> >     login -a -s sysadm_u -r 'None' me
> >
> > Prevent "semanage export" from displaying None or empty strings in level
> > and categories arguments by checking them in all customized() methods.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, I have merged my patch.
Nicolas

