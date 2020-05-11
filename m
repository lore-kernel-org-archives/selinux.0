Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B97C47255
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 12:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE75206F5
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 12:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtyZWTYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgEKMFP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 08:05:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgEKMFP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 08:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589198713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HyoK6AxOfd+dDdWtjT2QivfHjkQnEoKlHfTqDZt3lV0=;
        b=NtyZWTYzXp7Z02AxUXcpy7dUn+MNnBGVr1DHasD0l70f8VC7bPYqHdomrww2p8+3AtScWg
        hn+qG5H6CSKRlJFv30nTfmkDgjBs7L+Dkkj1EFNQMS1ssyywjzD0F2CmeAIT5jzfF9/EaB
        senwQUz2BeN8IEOaOWwM/r/30+h42tE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-1-tz1NykPO-ySTNI8ReDlg-1; Mon, 11 May 2020 08:05:12 -0400
X-MC-Unique: 1-tz1NykPO-ySTNI8ReDlg-1
Received: by mail-oo1-f72.google.com with SMTP id y1so740665oog.6
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 05:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyoK6AxOfd+dDdWtjT2QivfHjkQnEoKlHfTqDZt3lV0=;
        b=MPzza2WkBOeahO46fSuTwTxtIPx8WmNqS4x3c62vYP/9WuGZaDti3zv/TtFZ1uq7oa
         to4mDd6fisSMSdh7bSh+qVWIxKGW4XGzvk4Yr4clQChkNGsN3x9FGiKy7IXl6MVgEzVb
         RRVCnA64wUK0PF3LtBWFbwUj8DjyrTzfdul9TyovfJyGFKgE48iCWHp4CgTtTliIfZix
         fgsqpZwDhkXOQgqxr6wIUMcFu/JCHFbTeg3cugQv7Jp0HsAS4+yWK4QVWMZMelYetauz
         iren5GeUGzzlQMvWBGvYoCeS/6apq3TcJWaVCI8Ft/vZiTw1qPIm2HSBDA76IsSqZ4zG
         sFOw==
X-Gm-Message-State: AGi0PubMbx2yZxLacq5Hq1j5k4cvanU2I1vG1tPk13mq8WiIWyn9LiX9
        FRbNGrhJ5dIf7jYp0/0Bcry2iRMjhz8fm0N6/IXG60XCwXPVdSAboLqU1I7yiBEWN0W5t55XBdU
        BP5/pzy0BvqwRzhnURvXtYTq31N8LTcu6gQ==
X-Received: by 2002:aca:ed44:: with SMTP id l65mr19593922oih.127.1589198711127;
        Mon, 11 May 2020 05:05:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypKMvmQmFI2TCuvS8qph/qzQouHemjP5qSOxxsEcH4JBNavnVvJxv76afy8DZM30qyN/uE8JEI3USw5WfDuJXSw=
X-Received: by 2002:aca:ed44:: with SMTP id l65mr19593887oih.127.1589198710787;
 Mon, 11 May 2020 05:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200508193721.29283-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200508193721.29283-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 11 May 2020 14:04:59 +0200
Message-ID: <CAFqZXNt+MWnELtqZh9V2ZbOv+1+wUZ4jdCikG3LnPVYiYeBVuQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/filesystem: fix quotas_test
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 8, 2020 at 9:37 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> As per the man page, quotactl(2) expects to be passed a pointer to
> a 4-byte buffer for Q_GETFMT.  The kernel copies a single u32 value.
> On Ubuntu, this was detected as a stack smash when running the test.
> Fix the test program.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  tests/filesystem/quotas_test.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tests/filesystem/quotas_test.c b/tests/filesystem/quotas_test.c
> index 8359811..1424362 100644
> --- a/tests/filesystem/quotas_test.c
> +++ b/tests/filesystem/quotas_test.c
> @@ -33,7 +33,7 @@ int main(int argc, char *argv[])
>         int opt, result, qcmd, save_err, test_id = geteuid();
>         char *context, *src = NULL, *tgt = NULL;
>         bool verbose = false;
> -       char fmt_buf[2];
> +       unsigned int fmtval;

I wish we could use something like uint32_t here to make the size
explicit, but that's a C99 thing... OTOH the binder test code already
happily uses C99 stuff, so I'm not sure how to best handle this...
(Add -std=c99 to CFLAGS? Just use <stdint.h> and assume the compiler
has it? Avoid using C99 library features?)

>
>         while ((opt = getopt(argc, argv, "s:t:v")) != -1) {
>                 switch (opt) {
> @@ -77,7 +77,7 @@ int main(int argc, char *argv[])
>                         printf("User Quota - ON\n");
>
>                 qcmd = QCMD(Q_GETFMT, USRQUOTA);
> -               result = quotactl(qcmd, src, test_id, fmt_buf);
> +               result = quotactl(qcmd, src, test_id, (caddr_t)&fmtval);
>                 save_err = errno;
>                 if (result < 0) {
>                         fprintf(stderr, "quotactl(Q_GETFMT, USRQUOTA) Failed: %s\n",
> @@ -85,7 +85,7 @@ int main(int argc, char *argv[])
>                         return save_err;
>                 }
>                 if (verbose)
> -                       printf("User Format: 0x%x\n", fmt_buf[0]);
> +                       printf("User Format: 0x%x\n", fmtval);
>
>                 qcmd = QCMD(Q_QUOTAOFF, USRQUOTA);
>                 result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> @@ -113,7 +113,7 @@ int main(int argc, char *argv[])
>                         printf("Group Quota - ON\n");
>
>                 qcmd = QCMD(Q_GETFMT, GRPQUOTA);
> -               result = quotactl(qcmd, src, test_id, fmt_buf);
> +               result = quotactl(qcmd, src, test_id, (caddr_t)&fmtval);
>                 save_err = errno;
>                 if (result < 0) {
>                         fprintf(stderr, "quotactl(Q_GETFMT, GRPQUOTA) Failed: %s\n",
> @@ -121,7 +121,7 @@ int main(int argc, char *argv[])
>                         return save_err;
>                 }
>                 if (verbose)
> -                       printf("Group Format: 0x%x\n", fmt_buf[0]);
> +                       printf("Group Format: 0x%x\n", fmtval);
>
>                 qcmd = QCMD(Q_QUOTAOFF, GRPQUOTA);
>                 result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> --
> 2.23.1
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

