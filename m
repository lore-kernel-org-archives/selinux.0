Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A17EC10DCE
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 13:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3707206E7
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 13:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtPV4MHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgCLN73 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:59:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36523 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgCLN73 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 09:59:29 -0400
Received: by mail-io1-f66.google.com with SMTP id d15so5760159iog.3
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ozs4kijNyGEf8dotXB1CVZ/uuXlPoDQuzIPrKEAsoOM=;
        b=rtPV4MHcxzNlGUbFzCLZRE8n2VbNLLzPqGCOx2ZhKd1FaXbtCSHHlrEb1ipHE370x0
         CHXH6HurAR0GFldJ8KoRTQmmY2ZbrQ0NP3/LkEY6O0pnK5EA12KgKqOYS0StExSLZ32a
         t8Eekn6M1CCQFEgXNQSiPwfLKAeX9Vi1CCTHwl5XFTJ+9kitseTJF8Bg0sVXjNSirJkA
         yIupfiLUcFPQuQzgHK1d2BLKrj+8cl431f0+VRr0KCi7YgaE6YmDiZs0g69rgEXkoS+g
         n20M94DqPgcQ2Gu26qyjlVR0Gq6iXBBaYM4jSOxT6L79bsSQrxojXmjbQ8pSBWCXu7WL
         txPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ozs4kijNyGEf8dotXB1CVZ/uuXlPoDQuzIPrKEAsoOM=;
        b=X0xD4rjP8sF2TWUhTEW0+Ig2h8EGW5Y70neiRiH+0TnD5zDnhH0cexmsp1G+dqvJme
         hUPIySIPl7c2bMmWgRNcbbMfVnantS7Fz7cdXM4vARYPWSeA71tLi5zk07pg45sdqZ43
         SS9mHYxbd+jlH4K0wo0Sk2+q4QG0+bfrcnBIgXV4GD1nBAFz3Zc0Xj2hTrkE6JKzD5PW
         qTwf+0SGQjRnq8DZpPfGT5BZQ1J0DSRMYf2qIKtltckvf3xHVO4fpI4+M8NhDZj+p1Xg
         M9wQw9KfeBQV5a7LNquI+88FsovBHjaaEMPHAM/0wgbkZRnQIxFxBWDjKi+SxYxJymPG
         r3bA==
X-Gm-Message-State: ANhLgQ14E7u9//sYT+Ud+0wEvNhQDQVc1GsONRhVVLAxgMc9acnXcvUy
        1JaPabLDRzheDT9oW4Q/OqOaTZb1zP9rRHiAmbM=
X-Google-Smtp-Source: ADFU+vsXL95JQQkS27z+w/XM4OnZeYo2GZkeMfYf5Om7PN6BLqU4Lqfiq8UCSYw3sv+WOu+WAA7UMs/47rAvXn3o3sc=
X-Received: by 2002:a5d:9708:: with SMTP id h8mr7763389iol.141.1584021568421;
 Thu, 12 Mar 2020 06:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com> <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 12 Mar 2020 08:59:16 -0500
Message-ID: <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I will fix the subject and add the Fixes: #165 to the commit when I
stage them if thats ok?

On Wed, Mar 11, 2020 at 1:53 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Mar 11, 2020 at 2:53 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Mar 10, 2020 at 5:09 PM <bill.c.roberts@gmail.com> wrote:
> > >
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > With the old hidden_def and hidden_proto DSO infrastructure removed,
> > > correctness of the map file becomes paramount, as it is what filters out
> > > public API. Because of this, the wild cards should not be used, as it
> > > lets some functions through that should not be made public API. Thus
> > > remove the wild cards, and sort the list.
> > >
> > > Additionally, verify that nothing changed in external symbols as well:
> > >
> > > This was checked by generating an old export map (from master):
> > > nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
> > >
> > > Then creating a new one for this library after this patch is applied:
> > > nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
> > >
> > > And diffing them:
> > > diff old.map new.map
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >
> > Other than the typo in the subject line,
> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> >
> > This should fix https://github.com/SELinuxProject/selinux/issues/204
>
> and https://github.com/SELinuxProject/selinux/issues/165
