Return-Path: <SRS0=sjmt=CJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0CAC433E6
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD1720719
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPFLmvBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgHaOKH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgHaOKG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Aug 2020 10:10:06 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A416C061573
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:10:06 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e6so1069581oii.4
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kTDOwmTQcD7JQifDoFufgRpJcheuxcE6C63BB/Sw6cU=;
        b=rPFLmvBfZPXvHdHZyEv6bei1kIwJD5Ea+J4VlT3nd5rSErY0IQKp2pK8zkDmTrU1fo
         91ycy1+hAupCivAetIXLnpPD8V1WnESLmBaTw+FPpOyiwlY40laecMQ702bmq/u7tmQI
         IspbpN02dYfqT6iG1o7LiMnIy4h5+FkGh6Jc3U/r3Y1rfG/zVlDqu/bCFxCTi6uJRxR9
         0Oj2qhGMbEjhjt/Wt/cF1pp255jtNXcngicLwVgZj8wcS3rfgH7xNtGUVzfJR3R13ukS
         ihKwNJPw5sV5X5pWPkIdI2yBfW4pjsb/VbpW+V4mi3zTOLZvPRQvUt9lTXVF12Oco1pv
         QeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kTDOwmTQcD7JQifDoFufgRpJcheuxcE6C63BB/Sw6cU=;
        b=oLjd+q/CDW0jBJbQsIt+HvxdcLihIg1OvC33rPECB6DbkoioP0Bx6bOLWXcKNP5pfy
         QvGt1vsi0pGlmrEDa5SzRe20o5+pBwxMbrUil7+hJKPyniw+EC+zlzAlWo6jPQKfH533
         IRT8bgUkskbd7H2hx+261lzITUmFu+rsA1cVhY1wHtQmBNVC+9RlboKafTxBz4jESV0x
         1fpkZVb8TXBUuxRa7wH060spsfYU0zJd8xfSKLlNVfOKMo0w/r+4pcFGfGRdh3tEh/O4
         ixA8n7HQBSAbrz1CymnFHP+k/FDVVU9HHTXPauGKaT5g/nNcdpDChjOKRJBupMKsxru4
         +eIg==
X-Gm-Message-State: AOAM530mym/1tL9C2Te1YmaDvcjdfQTMLm5RGMlGn5b36ST0UeGjCC6g
        dDAuGwQRamxrG5j52Qo7W5VRqdIOLlJ0AZCuTjE=
X-Google-Smtp-Source: ABdhPJwuWdb4/M0OZPl+4CzIRPb+dpbfnLObjIv9FU+aSBz9ioSFBRIEf5Bljyw84H9D4/5nW5qFZmZ62lD+F9//A1I=
X-Received: by 2002:a54:4f9b:: with SMTP id g27mr857330oiy.140.1598883005168;
 Mon, 31 Aug 2020 07:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <829a4d86-b5b8-69e4-e1d5-dbdcb9c1401e@rosalinux.ru>
 <f2db2efd-1852-bcb9-c734-68d29b9f1880@schaufler-ca.com> <e8efae23-ac19-ce3d-4988-b3e304e4807b@rosalinux.ru>
In-Reply-To: <e8efae23-ac19-ce3d-4988-b3e304e4807b@rosalinux.ru>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 31 Aug 2020 10:09:54 -0400
Message-ID: <CAEjxPJ4NqV0OJrrfNO99qmcJOBjNy3osWOZxnuWUVQeur7VESA@mail.gmail.com>
Subject: Re: Hiding names of unreadable files
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>, survolog@yandex.ru,
        Vladimir Potapov <vladimir.potapov@rosalab.ru>,
        =?UTF-8?B?0JzQuNGF0LDQuNC7INCc0L7RgdC+0LvQvtCy?= 
        <m.mosolov@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Aug 29, 2020 at 7:30 PM Mikhail Novosyolov
<m.novosyolov@rosalinux.ru> wrote:
>
> 29.08.2020 19:42, Casey Schaufler =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On 8/29/2020 4:08 AM, Mikhail Novosyolov wrote:
> >> Hello everyone,
> >>
> >> We have been thinking on such problem: read access to a file may be re=
stricted with SELinux MCS/MLS, especially MLS/MCS.
> >> If a file with restricted access is inside a directory without restric=
ted access, its name is readable.
> >> Name of the file may be used to store some "secret" information.
> >> Some system directories, e.g. /var/tmp, are writable for multiple user=
s, and they may use it to exchange secret information,
> >> bypassing restrictions.
> >>
> >> Is there a way to restrict access to names of such files?
> > TL;DR - No
> >
> > This is probably the oldest active question in the history
> > of UNIX/Linux security. In the late 1980's it arose many times
> > in the process of system security evaluations. Because the
> > name of a file is data in the directory, and not an attribute
> > of the file in UNIX/Linux filesystems, access to it is controlled
> > by access to the directory.
> >
> > There was initially much crying and gnashing of teeth about this
> > in the evaluation community. Especially with regard to /tmp.
> > SELinux (and Smack, and B&L systems from the old days) have
> > explicit policies controlling how files can be created in
> > directories such that you can read the directory but not the
> > file attributes. While this can't prevent creating a file named
> > launch-the-missiles-at-noon, it provides accountability.
> Very interesting, thanks.But are there technical restrictions to implemen=
t hiding names of files?
> Let's assume that we will be OK with performance penalty of directory lis=
ting because of checking access rights to each file inside the directory.
> Were there any attempts to implement this?

We did it in DTOS, a predecessor to Flask which was a predecessor to
SELinux.  It had a per-file visible permission that controlled
visibility of the file name.  However, you then had various
complications, e.g. what if a process at another level tries to create
a file with the same name (create a new file with that name magically
extended with a label suffix that is hidden from userspace? deny it
thereby giving away its existence?), and there were still ways of
detecting the presence of hidden subdirectories/files (e.g. checking
the link count on the directory, checking the size of the directory,
looking for gaps in the offsets returned by getdents()).  I also seem
to recall someone proposing a LSM hook for filtering directories but
didn't see it on a quick glance at the linux-security-module archives
on lore (but those are unfortunately limited to the last few years).
