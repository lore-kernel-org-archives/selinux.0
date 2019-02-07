Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C434DC282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C1021721
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfBGVTl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:19:41 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:34594 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfBGVTl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 16:19:41 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DDC10561268
        for <selinux@vger.kernel.org>; Thu,  7 Feb 2019 22:19:36 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id 81so2437467otj.2
        for <selinux@vger.kernel.org>; Thu, 07 Feb 2019 13:19:36 -0800 (PST)
X-Gm-Message-State: AHQUAubVOtlvMYuIA0wbLf14FuzlxtgU3MgKksSRfwVhv4BPnvtTYlzL
        M2zMJG8TkpWI5WVw+RtfMpY9vEgEMwhEvqAFffU=
X-Google-Smtp-Source: AHgI3IbeEIJnaSw9RvqD4dBVip1YP7MWawe+Ka91eqetEqPo77pzSufLrqbIoqn8cJNS0H5yIUuVH1d4JfQvu33qX7k=
X-Received: by 2002:a9d:60cf:: with SMTP id b15mr9522014otk.144.1549574375494;
 Thu, 07 Feb 2019 13:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20190206194529.24952-1-plautrba@redhat.com>
In-Reply-To: <20190206194529.24952-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 7 Feb 2019 22:19:24 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nBvZHQ6Uq4GXK=0mxf1iBt8TQEVCkOZd4mNoW4OV7NSg@mail.gmail.com>
Message-ID: <CAJfZ7=nBvZHQ6Uq4GXK=0mxf1iBt8TQEVCkOZd4mNoW4OV7NSg@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: genhomedircon - improve handling large groups
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb  7 22:19:37 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 6, 2019 at 8:45 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> getgrnam_r() uses a preallocated buffer to store a structure containing
> the broken-out fields of the record in the group database. The size of
> this buffer is usually sysconf(_SC_GETGR_R_SIZE_MAX) == 1024 and it is
> not enough for groups with a large number of users.  In these cases,
> getgrnam_r() returns -1 and sets errno to ERANGE and the caller can
> retry with a larger buffer.
>
> Fixes:
> $ semanage login -a -s user_u -r s0-s0:c1.c2 '%largegroup'
> libsemanage.semanage_direct_commit: semanage_genhomedircon returned error code -1. (Numerical result out of range).
> OSError: Numerical result out of range
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsemanage/src/genhomedircon.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 591941fb..ac376671 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -1077,10 +1077,20 @@ static int get_group_users(genhomedircon_settings_t * s,
>
>         const char *grname = selogin + 1;
>
> -       if (getgrnam_r(grname, &grstorage, grbuf,
> -                       (size_t) grbuflen, &group) != 0) {
> -               goto cleanup;
> +       errno = 0;
> +       while (
> +               (retval = getgrnam_r(grname, &grstorage, grbuf, (size_t) grbuflen, &group)) != 0 &&
> +               errno == ERANGE
> +       ) {
> +               char *new_grbuf;
> +               grbuflen *= 2;
> +               new_grbuf = realloc(grbuf, grbuflen);
> +               if (new_grbuf == NULL)
> +                       goto cleanup;
> +               grbuf = new_grbuf;
>         }

Hello,
When reading this for loop, I am concerned about the case where the
member list exceeds 2Go on a system with a 32-bit CPU (where
sizeof(long) = 4). Even if it seems very unlikely, if this ever
happens, the loop will become infinite. Would you agree with adding
"&& grbuflen > 0" to the condition of the while statement?

Anyway, if you do not agree, this patch looks good to me.
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> +       if (retval == -1)
> +               goto cleanup;
>
>         if (group == NULL) {
>                 ERR(s->h_semanage, "Can't find group named %s\n", grname);
> --
> 2.20.1
>

