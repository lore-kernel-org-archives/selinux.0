Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5C5C4CECC
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC8C206D4
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPuO9qno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgD0UbW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0UbV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:31:21 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FEBC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:31:21 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u11so20477773iow.4
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0DbLJhabyrmNl13QF0NgP9GjILi+nwo4Mf2ETi5V2xo=;
        b=IPuO9qno5xvAWgP86Q/PBVHwmEF86+kyH/hWCQvygQXfg1jm6a3eicZMt7Bc+69slB
         LqXjHrrVWTQPrg6qYBq7t55XROqGEebcPoOC9R5k0d+EIQRdC0DixHEYBX8cBNSjtydS
         2yoFhDcJXHP1cVTdsQLKpoUyx7ui0N3vWIHb5HqCCkvRubRkwIJnqCNbKdJ4TS8x8wOi
         eaTTVlQGGB0koCE1VGbFH0LpH3VMRkx+eKXfcIRICmfVtTraaG2EEIO3M7VlifSBhDn3
         H/5grisxXS5eDpZJo1c6xrMcBaovzXcj+KXslW1sc6j2ZqAMizkBj6uWPopzYgScBb8Y
         STkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0DbLJhabyrmNl13QF0NgP9GjILi+nwo4Mf2ETi5V2xo=;
        b=tqCaM4hvcGJ3/QhWJCSJ8vTmZeLqtQe10eiI7sjjw19Ofm+Bs00nQMBD0njUM7pqxw
         uVy+thew7R66XdCx+ala1tclmBo+DnrqnQhPHUbce6QcZig7Q9vs6wlaJVPG7I4S0cXH
         HaDtsrSO+9DdaPIYBzYyqm/2KnJOxQo9kNy8CaBeXeSQhr4rsif/6gh/bm71KzJXwz66
         CulFUoibyz94OE4J2IB0FgzWbNAarnzU7JYmsqCs37IlQzsXPrzHGEvALkbtT3Ghk4Ls
         5Q27e46LnBcIJF22Uv8fFg4G7iqqzsXdOQ+3TA2dJi4YzttwrpfauMcsdpIkGMKh0Lxd
         acsA==
X-Gm-Message-State: AGi0PuZ8rKTyJdo621zc3hoVgUt6SFPQwDrJu0gE2kX0LbXQDlNQ+3Jz
        KkpXnIrfVL/XI/fVMmDZGOj48d44ZwTDfzh7PAg=
X-Google-Smtp-Source: APiQypLmuBEVqruVAQo8CpEEuWNlRX/sBKH021OfeY2kZzeNpV7Kz8iQsDF1HCIoG+F5pR+aPtJW1zZO92frHc7D3GM=
X-Received: by 2002:a6b:b258:: with SMTP id b85mr22592301iof.141.1588019480410;
 Mon, 27 Apr 2020 13:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200420114650.19093-1-cgzones@googlemail.com>
 <CAJfZ7=ky1rwB3jDMEdXjqSL=Vctut_2Cc6gsj475Et_nLo7B4A@mail.gmail.com> <CAJ2a_Deu8VTHQCpc_k1Nn__Kh+oL2NV3CUp3-t4rd9CkeLr9Pw@mail.gmail.com>
In-Reply-To: <CAJ2a_Deu8VTHQCpc_k1Nn__Kh+oL2NV3CUp3-t4rd9CkeLr9Pw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 27 Apr 2020 15:31:09 -0500
Message-ID: <CAFftDdpVfjkmpGtcU-3sF2nKsckdGEHaLFjD6TAAsZTp8nTmiQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: mark security_context_t typedef as deprecated
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 27, 2020 at 3:10 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Am So., 26. Apr. 2020 um 20:14 Uhr schrieb Nicolas Iooss
> <nicolas.iooss@m4x.org>:
> >
> > On Mon, Apr 20, 2020 at 1:47 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Follow-up of: 9eb9c9327563014ad6a807814e7975424642d5b9 ("Get rid of s=
ecurity_context_t and fix const declarations.")
> > >
> > > Use a wrapper macro, because swig does not accept typedef attributes.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> >
> > If nobody raises an objection, I will merge the patch tomorrow.
>
> Maybe this should be delayed after the deprecation patch series from
> William Roberts to match the same style;
> e.g. this patch uses a helper macro.
>
> I'll prepare an updated patch.

I was just about to look at this and suggest the same thing. I didn't
put a macro like this in selinux.h for the simple
reason that I didn't want to make it something considered public API.
I avoided if SWIG, since its really
a gnuc extension that most compilers support, and its inline with the
other extensions that get buy the
SWIG build.

I would nack it for those two reasons.

I just sent V4 of the series, so hopefully that one sticks. If you
wan't you can update the style now and resubmit. As we can merge
it in parallel to my series (there is no hard dependency), so you
don't have to wait for my series to land.
