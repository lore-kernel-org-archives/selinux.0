Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B15C433EF
	for <selinux@archiver.kernel.org>; Wed,  5 Jan 2022 18:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbiAESZC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Jan 2022 13:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbiAESZA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Jan 2022 13:25:00 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401A4C061245
        for <selinux@vger.kernel.org>; Wed,  5 Jan 2022 10:25:00 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id x10so184671oix.6
        for <selinux@vger.kernel.org>; Wed, 05 Jan 2022 10:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AS3GYj85EyC72RSzY0k5t/tONASNqOd/dIqv7PpF28Y=;
        b=Mz96TRdPN1u6QxOaIJ+k5YEKKyuqlRBwBig1qSX4KlaZYYAaexcEegax3KQN6SWgnF
         Jz265v57qSDPPrlvlPFd/vUaJVZoNOdJJruxkLHuM+fj30dUp5H/K1nX7aE5fp9x9yaB
         XRq+xc702jHCgoO5iFa+ubhBi+z3AT5THLWaWBzLoe4px3ZnptK+n/atUpi37hla4CHr
         BWmT8cQ1xhk0O1msiSiPMEbGa/m1PzXGeLED5FdTjLpH9Y9HdEEhBCMYuFts283AGP8E
         uscT4laVJtVhJ3jVKygu5i4Y9c2c+k/miH3dTQMkDIdJqJFA/HFmJu/OsYS/1HCX/RUn
         VFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AS3GYj85EyC72RSzY0k5t/tONASNqOd/dIqv7PpF28Y=;
        b=1ksqCnM5jcOpLT4PMhTa1rE49cj9w8B47tSwESJQiezz3Wys5qvxlxcMTbTMX9W3uv
         nZ6v4BJMf/W+MLQjGf1lI73sCqfyWAwhKTdE+WWM//H3ldOk2BHSUaLgGh6KwwGx+vxb
         h9t37ZveUw2AsnqkBOZbaAIOtNCcsi651ZSrHqwQZgLtrXDBZRO40XHExYtmyj+cT+kd
         UtaLxxI/ZWTT+GljvIibgOCurOaFV17eMdnAX8YERJlf9CYdF+nXhIo595KFNIw3CFsp
         ixUHFe7HpMys2W1AJbg05IY03I98rYnzli929+MjLkKnbS1KHXf3QuKa0WZHwoZBN1xy
         lyhQ==
X-Gm-Message-State: AOAM531NWTd6xpfC9s8ERpqlGC/AmB41qzswGeAKOwpoBLubCKH2LPio
        GyyOECsIpCAF/KVuo/qY1qyKS3MR7PBFFmn9O9Q=
X-Google-Smtp-Source: ABdhPJyu68C1zVYiWQ85FXTMCZX5z4AoCo8c+MUQgBQ/5NAM8xkWY/O9+Reyr/kURSlTi+1Zg7M63Xfw96EpDxdUxVM=
X-Received: by 2002:a05:6808:e87:: with SMTP id k7mr3731082oil.16.1641407099689;
 Wed, 05 Jan 2022 10:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20211220180318.37453-1-cgzones@googlemail.com> <CAP+JOzRZRyzDH0vnmSdOqNcf=rxq5gYcwyMeWHqiWYUrXJpJTw@mail.gmail.com>
In-Reply-To: <CAP+JOzRZRyzDH0vnmSdOqNcf=rxq5gYcwyMeWHqiWYUrXJpJTw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 5 Jan 2022 13:24:48 -0500
Message-ID: <CAP+JOzT1n3W7h-uLaGwMNeCQ9-tip9iTQCsNPrqWXYxkQuRtdQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: bail out on snprintf failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 3, 2022 at 12:45 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Dec 20, 2021 at 3:16 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Do not continue with a negative return value once a string append
> > operation fails to avoid increasing the buffer length variable
> > `str_len`, potentially leading to an out-of-bounds write.
> >
> > Found by GitHub CodeQL.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index 9916cbee..38edcf8e 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -1456,6 +1456,12 @@ int cil_userprefixes_to_string(struct cil_db *db=
, char **out, size_t *size)
> >
> >                 buf_pos =3D snprintf(str_tmp, str_len, "user %s prefix =
%s;\n", user->datum.fqn,
> >                                                                        =
 userprefix->prefix_str);
> > +               if (buf_pos < 0) {
> > +                       free(str_tmp);
> > +                       *size =3D 0;
> > +                       *out =3D NULL;
> > +                       goto exit;
> > +               }
> >                 str_len -=3D buf_pos;
> >                 str_tmp +=3D buf_pos;
> >         }
> > --
> > 2.34.1
> >
