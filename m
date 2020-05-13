Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39751C433E0
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 19:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD0B2054F
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 19:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEITbDpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390391AbgEMTI0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387525AbgEMTI0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 15:08:26 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DFEC061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 12:08:26 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id b3so191991oob.0
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kWVCVxtdnSEmdVPaHQBWUjLItMaDLIAhx6RqFJmax0=;
        b=MEITbDpARz3UtQF2PbunNQ9yjyfq/aSKWo4qfQPEaHPz9zt8/+zoY7FvXthSEZ5nN+
         +s8IF99p0u5lNhyMD7vfbzJba0rgbR2XEY9Cdl0oEJvCiwAFj9CjUVmKI5b7l1vjjD5X
         uEKOG79/6zwEGgj05l/v0I0VFag97wJ+rZhohTJB1zguwobb3AblWWquw8ch9DS0hIf/
         l8QP1HEc3fdQf8h9Ep9iRs2GiqjaQAZo83MaFfM2wGspMajr/AWcSCeejgY7uZTSrI4k
         sSrT2T6Fr6XULtsd2tfQteSZoeTsqRXFpZf0KdY7C7LJD77vDUm7j/HT57L0q1XnMneY
         pn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kWVCVxtdnSEmdVPaHQBWUjLItMaDLIAhx6RqFJmax0=;
        b=PqTkDCwIEc1PiGou0QxMMS6Sum7XTqhxNYVEB8Z6c05HdvL68zcWzijEpTQzNC+AiD
         JyyVuGDBqaiiUIjMhZXWHz9GVPj0qPWWSxgql40u0JqDuDbeCHnHrszgz7DoXQIIom7k
         UpBCT3uRzmsSmouA7AFDTkfjLk5P3Q/F9JkVAGRTcDwBvN2p01kE2TMec9lPr2K3Mudx
         4Bs6O/lM9VYUW7EIwhc+5XLlRzhMxmGSubtfs5HOYUA1eYqNc7WjyThNgALwUD0dW9Yf
         14ZOts/qD7kq/Qt7n2b0NmPKoFjntABWaCkJrmAxXSyOpLSEG66kMkU5+v3JMPsBvlo5
         Q8gw==
X-Gm-Message-State: AOAM533/SHWterd1KsnqmTCIuFRshRQv3KpxXnVunhgQktTA24oncJ5z
        jlWRN06DZbpFp9Mqoe5sOi+S6P4KrNFWAhwqHYUuyw9o
X-Google-Smtp-Source: ABdhPJwfWsKMjzaEXfUu1h7tCCVaL6HrMl57SKGt6gk+6RlixX15a04ZJ8MIBnPISqOpU916PPr2RB71uZlPx1V2Lw4=
X-Received: by 2002:a4a:a2c4:: with SMTP id r4mr673686ool.71.1589396905412;
 Wed, 13 May 2020 12:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <5ebc4079.1c69fb81.c8782.38eb@mx.google.com> <CAJfZ7=mvfqdh_5KFff7itT3m3FPVnMpcG8_kn+U3EYOw8KebiA@mail.gmail.com>
In-Reply-To: <CAJfZ7=mvfqdh_5KFff7itT3m3FPVnMpcG8_kn+U3EYOw8KebiA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 13 May 2020 15:08:14 -0400
Message-ID: <CAEjxPJ6U4vx+OB8WD689Vki1jVLeBzOgfgMawhbsT-KCXVn-WQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fsync before rename
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 2:52 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, May 13, 2020 at 8:46 PM Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Prior to rename(2)'ing new files into place, fsync(2) them to ensure
> > the contents will be fully written prior to rename.  While we are here,
> > also fix checking of write(2) to detect short writes.  This code could
> > be more generally improved but keeping to the minimal changes required
> > to fix this bug.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/237
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  libsemanage/src/semanage_store.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> > index 859c0a22..3cac36d4 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -735,7 +735,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode)
> >         }
> >         umask(mask);
> >         while (retval == 0 && (amount_read = read(in, buf, sizeof(buf))) > 0) {
> > -               if (write(out, buf, amount_read) < 0) {
> > +               if (write(out, buf, amount_read) != amount_read) {
> >                         errsv = errno;
> >                         retval = -1;
> >                 }
>
> If I remember correctly, errno is not defined if a short write
> happens. If this is confirmed and if you want to keep the patch short,
> you could for example use errsv = EIO if write() returned a value
> different from -1 and from amount_read.

True.  It also occurred to me that this is too heavyweight given how
widely semanage_copy_file() is used within libsemanage; performing a
fsync(2) for every one of these file copies will be very expensive.
We only really care about it when copying the final files to
/etc/selinux, not for the copying under /var/lib/selinux IIUC.  So I
guess I need a bool argument or similar to semanage_copy_file() to
indicate when a fsync is required.  Even with this change, installing
the final SELinux policy files under /etc/selinux won't be fully
atomic; one can still end up with a mix of old and new (e.g. new
policy.32 with old file_contexts).  But that's out of scope for this
particular bug.
