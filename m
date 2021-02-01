Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46D8C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E8264EA2
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhBAOHa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232604AbhBAOHJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 09:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612188342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0nLpsOR/cdlWTg6CV9uQS/0uPR76+j2ZaZfg9clk+8=;
        b=TBEYIPZ/IhaeLv5I1i8963Sus9mStoU4njyTkYt5RX9WVkbA+tKBuPAwKOpBHPCQFCQBqm
        UyntVOsuDE4mEUaw2iJjUeWZ/RnlYOEgZvICKVdX8WLSoup2kdj1TnJgN+7gM0Yc20D0w9
        KqGzn59ghM5qicquKIeROBnIrrcT2Gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-fJV2RxFOM-SqGFajFcNpAg-1; Mon, 01 Feb 2021 09:05:40 -0500
X-MC-Unique: fJV2RxFOM-SqGFajFcNpAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B7D410054FF;
        Mon,  1 Feb 2021 14:05:39 +0000 (UTC)
Received: from localhost (unknown [10.40.192.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DACF62461;
        Mon,  1 Feb 2021 14:05:38 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH v2 2/2] setfiles: drop ABORT_ON_ERRORS and related code
In-Reply-To: <CAJfZ7=my52AG+zYMjXJFoxAAHsnJTcs8Y+crbcQ==rT2cWZ-Dg@mail.gmail.com>
References: <20210113210948.217575-1-plautrba@redhat.com>
 <20210113210948.217575-2-plautrba@redhat.com> <875z3do0yh.fsf@redhat.com>
 <CAJfZ7=my52AG+zYMjXJFoxAAHsnJTcs8Y+crbcQ==rT2cWZ-Dg@mail.gmail.com>
Date:   Mon, 01 Feb 2021 15:05:37 +0100
Message-ID: <87pn1jsx1q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Sun, Jan 31, 2021 at 11:39 AM Petr Lautrbach <plautrba@redhat.com> wro=
te:
>>
>> Petr Lautrbach <plautrba@redhat.com> writes:
>>
>> > `setfiles -d` doesn't have any impact on number of errors before it
>> > aborts. It always aborts on first invalid context in spec file.
>> >
>> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> > ---
>> >  policycoreutils/setfiles/Makefile      |  3 ---
>> >  policycoreutils/setfiles/ru/setfiles.8 |  2 +-
>> >  policycoreutils/setfiles/setfiles.8    |  3 +--
>> >  policycoreutils/setfiles/setfiles.c    | 18 ------------------
>> >  4 files changed, 2 insertions(+), 24 deletions(-)
>> >
>> > diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfi=
les/Makefile
>> > index bc5a8db789a5..a3bbbe116b7f 100644
>> > --- a/policycoreutils/setfiles/Makefile
>> > +++ b/policycoreutils/setfiles/Makefile
>> > @@ -5,8 +5,6 @@ SBINDIR ?=3D /sbin
>> >  MANDIR =3D $(PREFIX)/share/man
>> >  AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
>> >
>> > -ABORT_ON_ERRORS=3D$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c=
 | awk -S '{ print $$3 }')
>> > -
>> >  CFLAGS ?=3D -g -Werror -Wall -W
>> >  override LDLIBS +=3D -lselinux -lsepol
>> >
>> > @@ -26,7 +24,6 @@ restorecon_xattr: restorecon_xattr.o restore.o
>> >
>> >  man:
>> >       @cp -af setfiles.8 setfiles.8.man
>> > -     @sed -i "s/ABORT_ON_ERRORS/$(ABORT_ON_ERRORS)/g" setfiles.8.man
>> >
>> >  install: all
>> >       [ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/=
man8
>> > diff --git a/policycoreutils/setfiles/ru/setfiles.8 b/policycoreutils/=
setfiles/ru/setfiles.8
>> > index 27815a3f1eee..910101452625 100644
>> > --- a/policycoreutils/setfiles/ru/setfiles.8
>> > +++ b/policycoreutils/setfiles/ru/setfiles.8
>> > @@ -47,7 +47,7 @@ setfiles \- =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=
=B2=D0=B8=D1=82=D1=8C SELinux-=D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D1=8B =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81
>> >  =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=8C =D0=B4=D0=B5=
=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D1=81=D1=
=82=D1=8C =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82=D0=BE=D0=B2 =D0=
=BE=D1=82=D0=BD=D0=BE=D1=81=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =D1=
=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 =D0=B4=D0=B2=D0=BE=D0=
=B8=D1=87=D0=BD=D0=BE=D0=B9 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=
=B8.
>> >  .TP
>> >  .B \-d
>> > -=D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C, =D0=BA=D0=B0=D0=BA=
=D0=B0=D1=8F =D1=81=D0=BF=D0=B5=D1=86=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=86=
=D0=B8=D1=8F =D1=81=D0=BE=D0=BE=D1=82=D0=B2=D0=B5=D1=82=D1=81=D1=82=D0=B2=
=D1=83=D0=B5=D1=82 =D0=BA=D0=B0=D0=B6=D0=B4=D0=BE=D0=BC=D1=83 =D0=B8=D0=B7 =
=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 (=D0=BD=D0=B5 =D0=BF=D1=80=D0=B5=D0=BA=
=D1=80=D0=B0=D1=89=D0=B0=D1=82=D1=8C =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=
=D0=BA=D1=83 =D0=BF=D0=BE=D1=81=D0=BB=D0=B5 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=
=D0=B5=D0=BD=D0=B8=D1=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BE=D0=BA ABORT_ON_ERRO=
RS).
>> > +=D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C, =D0=BA=D0=B0=D0=BA=
=D0=B0=D1=8F =D1=81=D0=BF=D0=B5=D1=86=D0=B8=D1=84=D0=B8=D0=BA=D0=B0=D1=86=
=D0=B8=D1=8F =D1=81=D0=BE=D0=BE=D1=82=D0=B2=D0=B5=D1=82=D1=81=D1=82=D0=B2=
=D1=83=D0=B5=D1=82 =D0=BA=D0=B0=D0=B6=D0=B4=D0=BE=D0=BC=D1=83 =D0=B8=D0=B7 =
=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2.
>> >  .TP
>> >  .BI \-e \ directory
>> >  =D0=B8=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=BA=D0=B0=
=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 (=D1=87=D1=82=D0=BE=D0=B1=D1=8B =D0=B8=D1=81=
=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B1=D0=BE=D0=BB=D0=B5=D0=B5 =
=D0=BE=D0=B4=D0=BD=D0=BE=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=
=D0=B3=D0=B0, =D1=8D=D1=82=D0=BE=D1=82 =D0=BF=D0=B0=D1=80=D0=B0=D0=BC=D0=B5=
=D1=82=D1=80 =D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =
=D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =
=D1=81=D0=BE=D0=BE=D1=82=D0=B2=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=
=89=D0=B5=D0=B5 =D0=BA=D0=BE=D0=BB=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=
=BE =D1=80=D0=B0=D0=B7).
>> > diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/set=
files/setfiles.8
>> > index e328a5628682..4d28bc9a95c1 100644
>> > --- a/policycoreutils/setfiles/setfiles.8
>> > +++ b/policycoreutils/setfiles/setfiles.8
>> > @@ -57,8 +57,7 @@ option will force a replacement of the entire contex=
t.
>> >  check the validity of the contexts against the specified binary polic=
y.
>> >  .TP
>> >  .B \-d
>> > -show what specification matched each file (do not abort validation
>> > -after ABORT_ON_ERRORS errors).
>> > +show what specification matched each file.
>> >  .TP
>> >  .BI \-e \ directory
>> >  directory to exclude (repeat option for more than one directory).
>> > diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/set=
files/setfiles.c
>> > index 10692d6d94a0..92616571ef2a 100644
>> > --- a/policycoreutils/setfiles/setfiles.c
>> > +++ b/policycoreutils/setfiles/setfiles.c
>> > @@ -23,14 +23,6 @@ static int nerr;
>> >
>> >  #define STAT_BLOCK_SIZE 1
>> >
>> > -/* setfiles will abort its operation after reaching the
>> > - * following number of errors (e.g. invalid contexts),
>> > - * unless it is used in "debug" mode (-d option).
>> > - */
>> > -#ifndef ABORT_ON_ERRORS
>> > -#define ABORT_ON_ERRORS      10
>> > -#endif
>> > -
>> >  #define SETFILES "setfiles"
>> >  #define RESTORECON "restorecon"
>> >  static int iamrestorecon;
>> > @@ -56,15 +48,6 @@ static __attribute__((__noreturn__)) void usage(con=
st char *const name)
>> >       exit(-1);
>> >  }
>> >
>> > -void inc_err(void)
>> > -{
>> > -     nerr++;
>> > -     if (nerr > ABORT_ON_ERRORS - 1 && !r_opts.debug) {
>> > -             fprintf(stderr, "Exiting after %d errors.\n", ABORT_ON_E=
RRORS);
>> > -             exit(-1);
>> > -     }
>> > -}
>> > -
>> >  void set_rootpath(const char *arg)
>> >  {
>> >       if (strlen(arg) =3D=3D 1 && strncmp(arg, "/", 1) =3D=3D 0) {
>> > @@ -97,7 +80,6 @@ int canoncon(char **contextp)
>> >               *contextp =3D tmpcon;
>> >       } else if (errno !=3D ENOENT) {
>> >               rc =3D -1;
>> > -             inc_err();
>> >       }
>> >
>> >       return rc;
>> > --
>> > 2.30.0
>>
>>
>> If there's no objection I'd like to merge both patches before Wednesday
>> so they'll part of rc2.
>
> I took a look and both patches look good to me. Nevertheless
> policycoreutils/setfiles/setfiles.c stil contains a "static int nerr;"
> which becomes unused, after this patch. This variable should probably
> be dropped, for example with:
>
> diff --git a/policycoreutils/setfiles/setfiles.c
> b/policycoreutils/setfiles/setfiles.c
> index 92616571ef2a..f018d161aa9e 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -19,7 +19,6 @@ static int warn_no_match;
>  static int null_terminated;
>  static int request_digest;
>  static struct restore_opts r_opts;
> -static int nerr;
>
>  #define STAT_BLOCK_SIZE 1
>
> @@ -161,7 +160,6 @@ int main(int argc, char **argv)
>   warn_no_match =3D 0;
>   request_digest =3D 0;
>   policyfile =3D NULL;
> - nerr =3D 0;
>
>   r_opts.abort_on_error =3D 0;
>   r_opts.progname =3D strdup(argv[0]);
> @@ -427,9 +425,6 @@ int main(int argc, char **argv)
>   r_opts.selabel_opt_digest =3D (request_digest ? (char *)1 : NULL);
>   r_opts.selabel_opt_path =3D altpath;
>
> - if (nerr)
> - exit(-1);
> -
>   restore_init(&r_opts);
>
>   if (use_input_file) {
>
> This clean-up could be done after you merged the patches. So:
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>


Merged.


> Thanks!
> Nicolas

