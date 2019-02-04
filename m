Return-Path: <SRS0=wOFf=QL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596E9C282CB
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 19:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357A920815
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 19:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfBDTXG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:23:06 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58867 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfBDTXA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Feb 2019 14:23:00 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 552D45646AE
        for <selinux@vger.kernel.org>; Mon,  4 Feb 2019 20:22:23 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id e12so1751674otl.5
        for <selinux@vger.kernel.org>; Mon, 04 Feb 2019 11:22:23 -0800 (PST)
X-Gm-Message-State: AHQUAuZ/VkIZiJ6VTct7MWFJhp5gj0G/bmVbBqPldFf+k1qX22SGjeTE
        PmRvsv14yQRPy6OFDddn9Ic0BiW1PLioR2/y1mg=
X-Google-Smtp-Source: AHgI3IYIjsFwCDPliXqjlF3RxxSwBp3R62vpaNW4MXXCq4KDOT/wNZIPo/0HCVcVtVMdf2Rd9lEp3DLp6ha+a4aXPJw=
X-Received: by 2002:a9d:6c44:: with SMTP id g4mr495952otq.368.1549308142421;
 Mon, 04 Feb 2019 11:22:22 -0800 (PST)
MIME-Version: 1.0
References: <20190131210753.11221-1-nicolas.iooss@m4x.org> <1878855653.53268021.1549293699681.JavaMail.zimbra@redhat.com>
In-Reply-To: <1878855653.53268021.1549293699681.JavaMail.zimbra@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 4 Feb 2019 20:22:11 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==QHq1YE6V-+TOJWyercdTVGH3DOK1ibR7QwLNebGqXZw@mail.gmail.com>
Message-ID: <CAJfZ7==QHq1YE6V-+TOJWyercdTVGH3DOK1ibR7QwLNebGqXZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Support flake8 version 3.7
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Feb  4 20:22:23 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 4, 2019 at 4:21 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> flake8 3.7.0, 3.7.1, 3.7.2 and 3.7.3 were released on 2019-01-29 and
> 2019-01-30 (cf. http://flake8.pycqa.org/en/latest/release-notes/3.7.0.html).
> These releases introduced new warnings, which broke building with
> Travis-CI (cf. https://travis-ci.org/fishilico/selinux/builds/487098420).
>
> Fix Travis-CI's builds by fixing the warnings that are now reported.
> The first two commits are related to coding style and the third one is
> a fix for an actual bug.
>
>
> Nicolas Iooss (3):
>   python: reindent lines that were over-indented
>   python: use == or != when comparing a variable with a string or a
>     integer
>   python/sepolicy: fix variable name
>
>  python/semanage/semanage                  | 118 ++++++------
>  python/sepolgen/src/sepolgen/output.py    |   6 +-
>  python/sepolgen/src/sepolgen/refparser.py |   2 +-
>  python/sepolgen/src/sepolgen/yacc.py      | 214 +++++++++++-----------
>  python/sepolicy/sepolicy/generate.py      |   4 +-
>  python/sepolicy/sepolicy/gui.py           |   2 +-
>  python/sepolicy/sepolicy/interface.py     |   8 +-
>  python/sepolicy/sepolicy/manpage.py       |   4 +-
>  8 files changed, 179 insertions(+), 179 deletions(-)
>
>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, merged.

Nicolas

