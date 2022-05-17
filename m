Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0275AC433FE
	for <selinux@archiver.kernel.org>; Tue, 17 May 2022 12:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbiEQM0f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 08:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbiEQM0d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 08:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61F9ABF6D
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652790391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFIumYQX00kt85dX0qA+6qRhgINuJnwRx4MltJtWDgE=;
        b=b3CbmxQbUb1qypfuc8CiadYc1OQlYyLXt/eRPaJOiQ+0wLwVK53XutqnFe7NRS2ZJj+0HH
        iYP5jmEr/mp9ZcG9JBEG85eKuWJ7CH5lL3ACSvLop/N3zrfk1Dv3wMMIa2yuwqIxqqCgSn
        xGpHt8rrnQkMP5kW5DP/UrzE5z1WdSE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-ucP0E55yPZ2a0eEON0YiHg-1; Tue, 17 May 2022 08:26:27 -0400
X-MC-Unique: ucP0E55yPZ2a0eEON0YiHg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D47B800B21;
        Tue, 17 May 2022 12:26:27 +0000 (UTC)
Received: from localhost (unknown [10.40.194.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BA37492C14;
        Tue, 17 May 2022 12:26:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux/utils/getsebool: add options to display
 en-/disabled booleans
In-Reply-To: <CAJ2a_Df6L3sjTmVHKT7UVVBp9PxB_EJtygQ2gOwbjVopePq=8Q@mail.gmail.com>
References: <20220428172219.28520-1-cgzones@googlemail.com>
 <87levh8noj.fsf@redhat.com>
 <CAJ2a_Df6L3sjTmVHKT7UVVBp9PxB_EJtygQ2gOwbjVopePq=8Q@mail.gmail.com>
Date:   Tue, 17 May 2022 14:26:26 +0200
Message-ID: <87y1z073bh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> On Wed, 4 May 2022 at 14:52, Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>>
>> > Add command line options to getsebool(8) to display either all enabled
>> > or all disabled booleans.
>>
>> I'm curious what would you use this for?
>
> I tried to list all enabled booleans and `getsebool -a | grep on`
> listed also ones with 'on' in their name.
> Using `getsebool -a | grep on'` works however, so this patch is not essen=
tial.

I see.

>>
>> Another comment is bellow
>>
>>
>> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>> > ---
>> >  libselinux/man/man8/getsebool.8 |  8 +++++++-
>> >  libselinux/utils/getsebool.c    | 36 +++++++++++++++++++++++++++------
>> >  2 files changed, 37 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/libselinux/man/man8/getsebool.8 b/libselinux/man/man8/get=
sebool.8
>> > index d70bf1e4..d8356d36 100644
>> > --- a/libselinux/man/man8/getsebool.8
>> > +++ b/libselinux/man/man8/getsebool.8
>> > @@ -4,7 +4,7 @@ getsebool \- get SELinux boolean value(s)
>> >  .
>> >  .SH "SYNOPSIS"
>> >  .B getsebool
>> > -.RB [ \-a ]
>> > +.RB [ \-a | \-0 | \-1 ]
>> >  .RI [ boolean ]
>> >  .
>> >  .SH "DESCRIPTION"
>> > @@ -26,6 +26,12 @@ their pending values as desired and then committing=
 once.
>> >  .TP
>> >  .B \-a
>> >  Show all SELinux booleans.
>> > +.TP
>> > +.B \-0
>> > +Show all disabled SELinux booleans.
>> > +.TP
>> > +.B \-1
>> > +Show all enabled SELinux booleans.
>> >  .
>> >  .SH AUTHOR
>> >  This manual page was written by Dan Walsh <dwalsh@redhat.com>.
>> > diff --git a/libselinux/utils/getsebool.c b/libselinux/utils/getsebool=
.c
>> > index 36994536..7fb0b58b 100644
>> > --- a/libselinux/utils/getsebool.c
>> > +++ b/libselinux/utils/getsebool.c
>> > @@ -6,21 +6,31 @@
>> >  #include <string.h>
>> >  #include <selinux/selinux.h>
>> >
>> > +enum list_mode {
>> > +     SPECIFIED,
>> > +     ALL,
>> > +     DISABLED,
>> > +     ENABLED,
>> > +};
>> > +
>> >  static __attribute__ ((__noreturn__)) void usage(const char *progname)
>> >  {
>> > -     fprintf(stderr, "usage:  %s -a or %s boolean...\n", progname, pr=
ogname);
>> > +     fprintf(stderr, "usage:  %s [-a|-0|-1] or %s boolean...\n", prog=
name, progname);
>> >       exit(1);
>> >  }
>> >
>> >  int main(int argc, char **argv)
>> >  {
>> > -     int i, get_all =3D 0, rc =3D 0, active, pending, len =3D 0, opt;
>> > +     int i, rc =3D 0, active, pending, len =3D 0, opt;
>> > +     enum list_mode mode =3D SPECIFIED;
>> >       char **names =3D NULL;
>> >
>> > -     while ((opt =3D getopt(argc, argv, "a")) > 0) {
>> > +     while ((opt =3D getopt(argc, argv, "a01")) > 0) {
>> >               switch (opt) {
>> >               case 'a':
>> > -                     if (argc > 2)
>> > +             case '0':
>> > +             case '1':
>> > +                     if (argc > 2 || mode !=3D SPECIFIED)
>> >                               usage(argv[0]);
>> >                       if (is_selinux_enabled() <=3D 0) {
>> >                               fprintf(stderr, "%s:  SELinux is disable=
d\n",
>> > @@ -39,7 +49,17 @@ int main(int argc, char **argv)
>> >                               printf("No booleans\n");
>> >                               return 0;
>> >                       }
>> > -                     get_all =3D 1;
>> > +                     switch (opt) {
>> > +                     case 'a':
>> > +                             mode =3D ALL;
>> > +                             break;
>> > +                     case '0':
>> > +                             mode =3D DISABLED;
>> > +                             break;
>> > +                     case '1':
>> > +                             mode =3D ENABLED;
>> > +                             break;
>> > +                     }
>>
>> switch(opt) inside switch(opt) block looks strange for me. Would it make
>> sense to have just this switch to set mode and move the code from line
>> 35 around is_selinux_enabled() and security_get_boolean_names() after th=
e switch?
>>
>
> Yes, that would make sense; the change I made aimed for a minimal diff si=
ze.


Could you please change it?


>
>> Petr
>>
>>
>> >                       break;
>> >               default:
>> >                       usage(argv[0]);
>> > @@ -74,7 +94,7 @@ int main(int argc, char **argv)
>> >       for (i =3D 0; i < len; i++) {
>> >               active =3D security_get_boolean_active(names[i]);
>> >               if (active < 0) {
>> > -                     if (get_all && errno =3D=3D EACCES)
>> > +                     if (mode !=3D SPECIFIED && errno =3D=3D EACCES)
>> >                               continue;
>> >                       fprintf(stderr, "Error getting active value for =
%s\n",
>> >                               names[i]);
>> > @@ -88,6 +108,10 @@ int main(int argc, char **argv)
>> >                       rc =3D -1;
>> >                       goto out;
>> >               }
>> > +             if ((mode =3D=3D ENABLED  && active =3D=3D 0 && pending =
=3D=3D 0) ||
>> > +                 (mode =3D=3D DISABLED && active =3D=3D 1 && pending =
=3D=3D 1)) {
>> > +                     continue;
>> > +             }
>> >               char *alt_name =3D selinux_boolean_sub(names[i]);
>> >               if (! alt_name) {
>> >                       perror("Out of memory\n");
>> > --
>> > 2.36.0
>>

