Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F403C433F5
	for <selinux@archiver.kernel.org>; Wed,  4 May 2022 11:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347697AbiEDLTD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 May 2022 07:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348003AbiEDLTC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 May 2022 07:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DD1A2BE7
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651662926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfsp1KPatFeHo0O2sckSuiB1M4vvItv5MiLeuFPqA3I=;
        b=g5vPrioyyhf160Tqkm5iHv4qIXKoLhCSmDo62U6W0tvfFjVHnmRNmhxl2yrpjfmHwOcHl6
        /pGbszrd0DHeraNfc6/ujOQsAcxaEoQV+mxTj5OSXRJ3RBah0LxkXx4zEIBYA706PzFwVY
        tTjS8OUku066AwVu9iTq8zzZAcLNrp4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-tf1TZ6-QNfONKW0H_P2O-w-1; Wed, 04 May 2022 07:15:25 -0400
X-MC-Unique: tf1TZ6-QNfONKW0H_P2O-w-1
Received: by mail-yb1-f197.google.com with SMTP id b6-20020a5b0b46000000b006457d921729so818258ybr.23
        for <selinux@vger.kernel.org>; Wed, 04 May 2022 04:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tfsp1KPatFeHo0O2sckSuiB1M4vvItv5MiLeuFPqA3I=;
        b=flR316EVKVdH5a2qQ8mlmBY3iLbCWomRIVFPl57Uz8+lIjxQsEB3odrdjgaKMvLoT4
         HsNYuvODJEWf20jNXU1PDI/ylDakn5qzskIJwFk8QcbCScVIOWiTMLCeg2qXVV6+nZ5R
         koMkDeV3YJnyh9IgI5Kp+g2la/d9AN2kiCbHQPc8Zdjsxg78hF/zToLdW7mswmu34xSx
         LSzHnydMuKUWrDHsjuqJTn0EDz7mgFVPVBD3t1/QQpqqIYAo8IYMpbRvv5YNdac4FR+p
         Eugg7kO/8Y8iunWR2A7BJRgv1SRiP6bGGBcFZSLMHchA6ISswv7RXtVsp52/fQfbkNE6
         ICZw==
X-Gm-Message-State: AOAM533NfO5F4nnHvA+xEMyP63mcbE2C8EmwZnqMIFcZU09RnjXhjH2m
        ASGl53HF5excyG/4NLunc0T2Ry+W36iV9doqWqwd43pnH0/EYUC/yFiaSfOPra7oL+gxAJO/hPy
        x0aDPCzx6anbziWd3ZevsTpBIttP77OV+iw==
X-Received: by 2002:a0d:e64e:0:b0:2f4:ddb9:b108 with SMTP id p75-20020a0de64e000000b002f4ddb9b108mr18263216ywe.245.1651662924461;
        Wed, 04 May 2022 04:15:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPWZsdNNOxGl9heDP9tVxbML+jdZGoOf2N93ydJMqIk5mk3Qh8ubgiapXK/U/JOPoOlb0OWV2vdN52+JaqdSo=
X-Received: by 2002:a0d:e64e:0:b0:2f4:ddb9:b108 with SMTP id
 p75-20020a0de64e000000b002f4ddb9b108mr18263202ywe.245.1651662924232; Wed, 04
 May 2022 04:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-4-cgzones@googlemail.com> <CAKwvOdkNZ3W9amcQKHOEfQLbdWC=4VDtrBdbOVHtWruipQnyKg@mail.gmail.com>
 <CAJ2a_DcY3=jz_zBQ7QZ_gycsvL1mn=TxKaWqWr3gGLhEAXTcQA@mail.gmail.com> <CAJ2a_De2o7+v2v4QDnXNB=q9N6J84iMz8QMe6vK7ojvxVhfqqQ@mail.gmail.com>
In-Reply-To: <CAJ2a_De2o7+v2v4QDnXNB=q9N6J84iMz8QMe6vK7ojvxVhfqqQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 May 2022 13:15:12 +0200
Message-ID: <CAFqZXNvgByrTLbGMRz20Kcu1473YMLmxGeQev53qM7jNSSYFbQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: drop unnecessary NULL check
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 2, 2022 at 3:43 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 8 Mar 2022 at 17:09, Christian G=C3=B6ttsche <cgzones@googlemail.=
com> wrote:
> >
> > On Fri, 18 Feb 2022 at 18:31, Nick Desaulniers <ndesaulniers@google.com=
> wrote:
> > >
> > > On Thu, Feb 17, 2022 at 6:22 AM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Commit e3489f8974e1 ("selinux: kill selinux_sb_get_mnt_opts()")
> > > > introduced a NULL check on the context after a successful call to
> > > > security_sid_to_context().  This is on the one hand redundant after
> > > > checking for success and on the other hand insufficient on an actua=
l
> > > > NULL pointer, since the context is passed to seq_escape() leading t=
o a
> > > > call of strlen() on it.
> > > >
> > > > Reported by Clang analyzer:
> > > >
> > > >     In file included from security/selinux/hooks.c:28:
> > > >     In file included from ./include/linux/tracehook.h:50:
> > > >     In file included from ./include/linux/memcontrol.h:13:
> > > >     In file included from ./include/linux/cgroup.h:18:
> > > >     ./include/linux/seq_file.h:136:25: warning: Null pointer passed=
 as 1st argument to string length function [unix.cstring.NullArg]
> > > >             seq_escape_mem(m, src, strlen(src), flags, esc);
> > > >                                    ^~~~~~~~~~~
> > >
> > > I'm guessing there was more to this trace for this instance of this w=
arning?
> >
> > Yes, complete output appended at the end.
> >
> > >
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  security/selinux/hooks.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 1e69f88eb326..ac802b99d36c 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -1020,7 +1020,7 @@ static int show_sid(struct seq_file *m, u32 s=
id)
> > > >         rc =3D security_sid_to_context(&selinux_state, sid,
> > > >                                              &context, &len);
> > > >         if (!rc) {
> > >
> > > ^ perhaps changing this condition to:
> > >
> > > if (!rc && context) {
> > >
> > > It might be nice to retain the null ptr check should the semantics of
> > > security_sid_to_context ever change.
> >
> > If I read the implementation of security_sid_to_context() and its calle=
es
> > correctly it should never return 0 (success) and not have populated its=
 3
> > argument, unless the passed pointer was zero, which by passing the addr=
ess
> > of a stack variable - &context - is not the case).
> >
>
> Kindly ping;
> is my analysis correct that after
>
>     rc =3D security_sid_to_context(&selinux_state, sid,
>                                                   &context, &len);
>
> there is no possibility that rc is 0 AND context is NULL?

Yes, I think this patch is good. rc =3D=3D 0 means success, which in this
case means that a valid context string has been returned. Thus, there
is no point in checking for NULL, other than being super-defensive
about future changes to security_sid_to_context() messing something up
(if we did this everywhere, then there would be NULL checks all over
the place...).

>
> > >
> > > > -               bool has_comma =3D context && strchr(context, ',');
> > > > +               bool has_comma =3D strchr(context, ',');
> > > >
> > > >                 seq_putc(m, '=3D');
> > > >                 if (has_comma)
> > > > --
> > > > 2.35.1
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> >
> >
> > clang-tidy report:
> >
> > ./include/linux/seq_file.h:136:25: warning: Null pointer passed as 1st
> > argument to string length function
> > [clang-analyzer-unix.cstring.NullArg]
> >         seq_escape_mem(m, src, strlen(src), flags, esc);
> >                                ^
> > ./security/selinux/hooks.c:1041:6: note: Assuming the condition is fals=
e
> >         if (!(sbsec->flags & SE_SBINITIALIZED))
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1041:2: note: Taking false branch
> >         if (!(sbsec->flags & SE_SBINITIALIZED))
> >         ^
> > ./security/selinux/hooks.c:1044:6: note: Assuming the condition is fals=
e
> >         if (!selinux_initialized(&selinux_state))
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1044:2: note: Taking false branch
> >         if (!selinux_initialized(&selinux_state))
> >         ^
> > ./security/selinux/hooks.c:1047:6: note: Assuming the condition is true
> >         if (sbsec->flags & FSCONTEXT_MNT) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1047:2: note: Taking true branch
> >         if (sbsec->flags & FSCONTEXT_MNT) {
> >         ^
> > ./security/selinux/hooks.c:1050:8: note: Calling 'show_sid'
> >                 rc =3D show_sid(m, sbsec->sid);
> >                      ^~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1020:7: note: Value assigned to 'context'
> >         rc =3D security_sid_to_context(&selinux_state, sid,
> >              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./security/selinux/hooks.c:1022:6: note: Assuming 'rc' is 0
> >         if (!rc) {
> >             ^~~
> > ./security/selinux/hooks.c:1022:2: note: Taking true branch
> >         if (!rc) {
> >         ^
> > ./security/selinux/hooks.c:1023:20: note: Assuming 'context' is null
> >                 bool has_comma =3D context && strchr(context, ',');
> >                                  ^~~~~~~
> > ./security/selinux/hooks.c:1023:28: note: Left side of '&&' is false
> >                 bool has_comma =3D context && strchr(context, ',');
> >                                          ^
> > ./security/selinux/hooks.c:1026:7: note: 'has_comma' is false
> >                 if (has_comma)
> >                     ^~~~~~~~~
> > ./security/selinux/hooks.c:1026:3: note: Taking false branch
> >                 if (has_comma)
> >                 ^
> > ./security/selinux/hooks.c:1028:17: note: Passing null pointer value
> > via 2nd parameter 's'
> >                 seq_escape(m, context, "\"\n\\");
> >                               ^~~~~~~
> > ./security/selinux/hooks.c:1028:3: note: Calling 'seq_escape'
> >                 seq_escape(m, context, "\"\n\\");
> >                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ././include/linux/seq_file.h:152:20: note: Passing null pointer value
> > via 2nd parameter 'src'
> >         seq_escape_str(m, s, ESCAPE_OCTAL, esc);
> >                           ^
> > ././include/linux/seq_file.h:152:2: note: Calling 'seq_escape_str'
> >         seq_escape_str(m, s, ESCAPE_OCTAL, esc);
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ././include/linux/seq_file.h:136:25: note: Null pointer passed as 1st
> > argument to string length function
> >         seq_escape_mem(m, src, strlen(src), flags, esc);
> >                                ^      ~~~
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

