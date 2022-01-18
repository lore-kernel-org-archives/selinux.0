Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15BCC433F5
	for <selinux@archiver.kernel.org>; Tue, 18 Jan 2022 16:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbiARQQd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbiARQPy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jan 2022 11:15:54 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D23CC061574
        for <selinux@vger.kernel.org>; Tue, 18 Jan 2022 08:15:42 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x31-20020a056830245f00b00599111c8b20so11391994otr.7
        for <selinux@vger.kernel.org>; Tue, 18 Jan 2022 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F23S+yzYJmyNKgOs64UAmOEjmwhvvSJbnSLcbSrMrKc=;
        b=Gxbf9vBxx6lffmGPUI4yqhHsxV1LXlzgG0PTujp03Y2DaNQXZdzYtUQHqXcQDEVIzP
         qalLi34A6z0eP+lJ+n6tus+hM19B/t4ELMNyYj5p+GTyJR3QOUjOm9enE2H3BLMFi7fh
         tvnmLlSHAyuSUYSAIqFwlpbx+Y7JL6GFue1aAob3PYdOIH+1MqWPpIO6B9t9MF/xVTpx
         t8SH4uKKtVXjZK5cI5fBxoNaA+sk0BbPJCnAxEyhICOOlZ6RBbPhw2pBvZhYnGBzRmrx
         kwVbSdWbKUBnLo1DYLwXiGLDbU32FKtmU8FETJMByTlJ0+/EYP6HdiPE+QAsMyT0VIUi
         vuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F23S+yzYJmyNKgOs64UAmOEjmwhvvSJbnSLcbSrMrKc=;
        b=uzGe9sLSfUnnnEaxfW9QdYYLNN2Gsbqo1kEW0NKkPevIl9iy+65Lt9X6jOmPHfJnKY
         vYhLcoxJOX1ZUKWWw2wg0gxjKp6FkyE7/EE/2v7cm20dFf7h0EOfi3ZmI+kO/X3Xf8nz
         MeOcxqpiBoyQSvx6uXOpF8F/TOGH7o7xq3frTGWJctLYqDdoMfZJtyJhg24+uzpBL88Q
         JU52NeR+6m8S+9N6fxNIpm4jekpnKyC6WqjKWsf6Jy4AEpEVpEiMdOdqZIWOFAycPXBb
         /ohujuNn8rgjbN1BO0EXQVKiVMjO/ZM+GLU4FMvDQ2Y0OXCQWH1CWmoYueOyIwh59l0m
         9iaA==
X-Gm-Message-State: AOAM533wPAkbzCI9Qgpfpd/dYNH+ZV4Ha5Sa65zWeBg9SSobRlsVt08x
        1kuc+NOpG0LbuRJb51nWSsKRyRvBTrHeasCzaTJpnMHY
X-Google-Smtp-Source: ABdhPJzkfyrOVYZE3A7RdZ/qV5fV0vRvlzAdoHkDx9vAtVE+ldg58UOPVTUYgGiAkcQ05G6B+cp4iTbodPN3TTRsDBI=
X-Received: by 2002:a9d:4106:: with SMTP id o6mr14271201ote.139.1642522541535;
 Tue, 18 Jan 2022 08:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20220106204336.147180-1-cgzones@googlemail.com> <CAP+JOzSvJR+Lueox=OC9c398cvLJT3CRC=mzQ=SdxkjPVrhkmg@mail.gmail.com>
In-Reply-To: <CAP+JOzSvJR+Lueox=OC9c398cvLJT3CRC=mzQ=SdxkjPVrhkmg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 18 Jan 2022 11:15:30 -0500
Message-ID: <CAP+JOzR=uc-LLgaupgEN52rbUMM3hYGLwDWAPd9YRtAT6JKvRg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check for saturated class name length
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 12, 2022 at 10:28 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Jan 7, 2022 at 1:58 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Check the from the polciy read length value to guard allocations.
> >
> > In the fuzzer build the value will also be bounded to avoid oom reports=
.
> >
> >     =3D=3D143646=3D=3DERROR: AddressSanitizer: allocator is out of memo=
ry trying to allocate 0xd60000000 bytes
> >         #0 0x4dac18 in __interceptor_calloc (./out/binpolicy-fuzzer+0x4=
dac18)
> >         #1 0x55d388 in scope_index_read ./libsepol/src/policydb.c:3945:=
7
> >         #2 0x550097 in avrule_decl_read ./libsepol/src/policydb.c:3984:=
6
> >         #3 0x550097 in avrule_block_read ./libsepol/src/policydb.c:4044=
:8
> >         #4 0x54b3ac in policydb_read ./libsepol/src/policydb.c:4456:7
> >         #5 0x518fd9 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy=
-fuzzer.c:35:6
> >         #6 0x43f623 in fuzzer::Fuzzer::ExecuteCallback(unsigned char co=
nst*, unsigned long) (./out/binpolicy-fuzzer+0x43f623)
> >         #7 0x42910f in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*,=
 unsigned long) (./out/binpolicy-fuzzer+0x42910f)
> >         #8 0x42ee76 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsi=
gned char const*, unsigned long)) (./out/binpolicy-fuzzer+0x42ee76)
> >         #9 0x458ff2 in main (./out/binpolicy-fuzzer+0x458ff2)
> >         #10 0x7fd37b7931c9 in __libc_start_call_main csu/../sysdeps/npt=
l/libc_start_call_main.h:58:16
> >
> > Found by oss-fuzz (#42909)
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Jim

> > ---
> >  libsepol/src/policydb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 79aba3af..562e044e 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -3937,7 +3937,7 @@ static int scope_index_read(scope_index_t * scope=
_index,
> >         if (rc < 0)
> >                 return -1;
> >         scope_index->class_perms_len =3D le32_to_cpu(buf[0]);
> > -       if (scope_index->class_perms_len =3D=3D 0) {
> > +       if (zero_or_saturated(scope_index->class_perms_len)) {
> >                 scope_index->class_perms_map =3D NULL;
> >                 return 0;
> >         }
> > --
> > 2.34.1
> >
