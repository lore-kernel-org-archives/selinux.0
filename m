Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7D1C77B7A
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 14:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjFBOFG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBOFF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 10:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D059D
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685714656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXYIOOvYSe1YI8lWQDZRY9tXOOvn9cbIH3FHXm2zKYg=;
        b=DT1yN1r/IAbBUBAxi84fHPfFepMzUH3WQC+dkJJoEqEYP7RhPUPIJRBD5rKFePZ3ziSgA+
        ctNXvBJ6iXT1qTX9h0eesWIjrg1UJpXdpE5iH8av9xXM9rznzNWKhPiu5ZFxHTKOasQJiF
        qTVws+RUPYyJXYnfekRJQhRWb/ufsQ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-TaX7e6JpMcmC9L5xAVmY5w-1; Fri, 02 Jun 2023 10:04:13 -0400
X-MC-Unique: TaX7e6JpMcmC9L5xAVmY5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BBF1811E92;
        Fri,  2 Jun 2023 14:04:13 +0000 (UTC)
Received: from localhost (unknown [10.45.224.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDA2DC154D7;
        Fri,  2 Jun 2023 14:04:12 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH] Makefile: expand ~ in DESTDIR
In-Reply-To: <CAJ2a_Dd5tCrgoNQvhD+BZ7M7HSmGp026i2GooT6-ytq7WqYSZA@mail.gmail.com>
References: <20230531011548.1133249-1-yamato@redhat.com>
 <87o7lyjcim.fsf@redhat.com>
 <CAJ2a_Dd5tCrgoNQvhD+BZ7M7HSmGp026i2GooT6-ytq7WqYSZA@mail.gmail.com>
Date:   Fri, 02 Jun 2023 16:04:12 +0200
Message-ID: <87edmuj6zn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> On Fri, 2 Jun 2023 at 14:05, Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Masatake YAMATO <yamato@redhat.com> writes:
>>
>> > Though instructed as
>> >
>> >     DESTDIR=3D~/obj ./scripts/env_use_destdir make test
>
> Is that a valid use case of the script `env_use_destdir`?
> I thought the script is just for executing binaries depending on the
> shared libraries in DESTDIR (e.g. `DESTDIR=3D~/obj
> ./scripts/env_use_destdir seinfo`), not for make invocations.

`make` is just another binary to run in pre-set environment. Especially
for `make test` it is important to use PATH and LD_LIBRARY_PATH pointing
to the new built binaries.

I personally use `source ./scripts/env_use_destdir` also for manual
testing.

Petr



>> >
>> > in README.md, compiling policy_define.c was failed with following erro=
rs:
>> >
>> >     make[1]: Entering directory '/home/yamato/var/selinux/checkpolicy'
>> >     cc -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-sel=
f \
>> >        -Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototy=
pes \
>> >        -Wnull-dereference -Wpointer-arith -Wshadow -Wstrict-prototypes=
 \
>> >        -Wundef -Wunused -Wwrite-strings -fno-common -I~/obj/usr/includ=
e \
>> >        -o policy_define.o -c policy_define.c
>> >     policy_define.c: In function =E2=80=98define_te_avtab_xperms_helpe=
r=E2=80=99:
>> >     policy_define.c:2083:61: error: =E2=80=98RULE_NOTSELF=E2=80=99 und=
eclared (first use in this function); did you mean =E2=80=98RULE_SELF=E2=80=
=99?
>> >      2083 |                         avrule->flags |=3D (add ? RULE_SEL=
F : RULE_NOTSELF);
>> >         |                                                             =
^~~~~~~~~~~~
>> >         |                                                             =
RULE_SELF
>> >
>> > because cc cannot find the directory ~/obj/usr/include passed via -I o=
ption.
>> >
>> > cc doesn't expand "~".
>> >
>> > Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>>
>> It doesn't work when DESTDIR does not exist -  If no existing file name
>> matches a pattern, then that pattern is omitted from the output of the
>> wildcard function, see
>> https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html
>>
>>
>> Petr
>>
>> > ---
>> >  Makefile | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index 2ffba8e9..053c6d3d 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -26,11 +26,11 @@ else
>> >  endif
>> >
>> >  ifneq ($(DESTDIR),)
>> > -     LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
>> > +     LIBDIR ?=3D $(wildcard $(DESTDIR))$(PREFIX)/lib
>> >       LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
>> >
>> > -     CFLAGS +=3D -I$(DESTDIR)$(PREFIX)/include
>> > -     LDFLAGS +=3D -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
>> > +     CFLAGS +=3D -I$(wildcard $(DESTDIR))$(PREFIX)/include
>> > +     LDFLAGS +=3D -L$(wildcard $(DESTDIR))$(PREFIX)/lib -L$(LIBDIR)
>> >       export CFLAGS
>> >       export LDFLAGS
>> >       export LIBSEPOLA
>> > --
>> > 2.40.1
>>

