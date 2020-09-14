Return-Path: <SRS0=k17o=CX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B07DC43461
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CE720732
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 17:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADztEtTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgINRg5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgINM1S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Sep 2020 08:27:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD0C061A86
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 05:25:37 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w25so13428941otk.8
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UBtpKXBH35IF7NHFSsGpfl8gt/OV1J7x2pYqDLWIXg=;
        b=ADztEtTdGiMFZPlGOPO2iuQ0m08MvwIPDPUfuPZAOl3CzWEmB1blNMBHW6xhmvGANT
         q7TjJLef9ttOFEF17G4o2kWVg2TNBlLjfRWOZqC15u8/OL8oINpdgW0W/XdEu23W/qt2
         jJx/FsRUHaPyxKpSEKBmGV9uYwYsr+siQJMD59yBH9j3ubKOPoMFZmtNbMl4Os7c3nlp
         OPxoBa/2RPtxrLyfDZOIM6VhoaLUWkvN4zCZb7MWoin1UQxhHvFkSzwv23MC4CskfLr/
         Hj+bKVPROyedGnymJmfqHiVQ+F/Df6KysA8Ytc0WUNmHRq6UYxkx9L2UD8qbMT5ZUhby
         IE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UBtpKXBH35IF7NHFSsGpfl8gt/OV1J7x2pYqDLWIXg=;
        b=UkWtlFsYSdU3KTeSK42sOPkZiExZosEG4I1//WzeJ5CLW1ok8vK2TarzMFjOk5w7Re
         idsqGm6XwcrtNOB+5Xqj2cKlVhVj3d8joWwvgKdJ5UIcss2cvb+MvW2XDc1fgap2z2pS
         yE0RPnVy+fqyB+4KHkqf0qfCwwLC/uqiEhzxS9XfgQ4zLFQXjUOMQj0KkpcsRsf1dtKj
         LymCVY+LGqHyraWY/6jP3DGy47r+GJ/ULJafey9/2LgR34Jg/ZZ3Avpdl5USZ9AIkAnm
         itzFfx2B4a3frWwMirngINm4DohQa/LKhZtrbbhkIDjK0w4rINCOFnrGnljx06Am1+9D
         wRfA==
X-Gm-Message-State: AOAM531FKoCqf8eh9Xug5ROSFBw7S6SymvfmFl4c1WcekA5XEUtjAvyl
        LjMlPYr3sOKI8ydZHoAVP/mdwcSCj4MLqI/rvGg=
X-Google-Smtp-Source: ABdhPJxbHxaoms+To5mLYCE9X7j1HrLCs+9mO54NOGQsCtuahK7yFm6abMY6R0eTOs3EWXLL6YT6nih+IqlQkWuaQwo=
X-Received: by 2002:a9d:185:: with SMTP id e5mr9471583ote.135.1600086335456;
 Mon, 14 Sep 2020 05:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200909205702.282311-1-jwcart2@gmail.com> <CAEjxPJ6nTgnJhYoi8gwpRTsku50pMfqaDTg44fcZfCbfCoGfNQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6nTgnJhYoi8gwpRTsku50pMfqaDTg44fcZfCbfCoGfNQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 14 Sep 2020 08:25:24 -0400
Message-ID: <CAEjxPJ7Ntu85dczZtuSSekimCjrvLyQRVNVDUKvNsR2hJ0NMLA@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: Validate conditional expressions before
 adding to binary policy
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 10, 2020 at 8:37 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 9, 2020 at 4:58 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL was not correctly determining the depth of conditional expressions
> > which prevented it from giving an error when the max depth was exceeded.
> > This allowed invalid policy binaries to be created.
> >
> > Validate the conditional expression using the same logic that is used
> > when evaluating a conditional expression. This includes checking the
> > depth of the expression.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
