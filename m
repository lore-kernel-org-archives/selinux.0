Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD8C41513
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjHNNp7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjHNNp2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC0F1BD
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692020685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SczesfHczHq+jSNYtmatlFP5yS/bqjLJtzAFpeyRyIY=;
        b=MSDyotBOynTRqLSgiXmyZxQW4NL07FyMax+lgNlg5HC0Q+QHXlRJIgGuXE77JrQPPtdK3R
        xgKDO/Zvwwp+hDaHURgCGg3BhtAjOhdDa5eqFPnV2erH4Jh02XT6wtnKM5Q2fdYcDPb3Nv
        PL5IKpe5IBW3XdXRFXFe1GS8pBJH/MA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-qR9BrprkMXawvjBhyOIhqw-1; Mon, 14 Aug 2023 09:44:43 -0400
X-MC-Unique: qR9BrprkMXawvjBhyOIhqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75680833952;
        Mon, 14 Aug 2023 13:44:43 +0000 (UTC)
Received: from localhost (unknown [10.45.226.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16A6C1121314;
        Mon, 14 Aug 2023 13:44:42 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 12/12] semodule-utils: Remove the Russian translations
In-Reply-To: <CAP+JOzRgv7nmyXEC9=CftWoYjcJLg9Wzssz7efwEBb8yXsxniQ@mail.gmail.com>
References: <20230809163059.97671-1-jwcart2@gmail.com>
 <20230809163059.97671-12-jwcart2@gmail.com> <87350mc6v2.fsf@redhat.com>
 <CAP+JOzSxQL9dqB7MXfCJKyc4Q4nsNTnxhC4ChnqctSXSqRRapA@mail.gmail.com>
 <CAP+JOzRgv7nmyXEC9=CftWoYjcJLg9Wzssz7efwEBb8yXsxniQ@mail.gmail.com>
Date:   Mon, 14 Aug 2023 15:44:42 +0200
Message-ID: <87wmxxbuwl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Mon, Aug 14, 2023 at 8:46=E2=80=AFAM James Carter <jwcart2@gmail.com> =
wrote:
>>
>> On Mon, Aug 14, 2023 at 5:26=E2=80=AFAM Petr Lautrbach <plautrba@redhat.=
com> wrote:
>> >
>> > James Carter <jwcart2@gmail.com> writes:
>> >
>> > > The Russian translations have not been maintained and are out of
>> > > date, so remove them.
>> > >
>> > > Suggested-by: Petr Lautrbach <plautrba@redhat.com>
>> > > Signed-off-by: James Carter <jwcart2@gmail.com>
>> >
>> > Based on https://github.com/SELinuxProject/selinux/pull/405
>> >
>> > For all 12:
>> >
>> > Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>> >
>> > Note that Makefile's still contain:
>> >
>> > ```
>> > LINGUAS ?=3D ru
>> > ...
>> > install: all
>> > ...
>> >     for lang in $(LINGUAS) ; do \
>> >                 if [ -e $${lang} ] ; then \
>> >                         mkdir -p $(DESTDIR)$(MANDIR)/$${lang}/man5 ; \
>> >                         mkdir -p $(DESTDIR)$(MANDIR)/$${lang}/man8 ; \
>> >                         install -m 644 $${lang}/*.5 $(DESTDIR)$(MANDIR=
)/$${lang}/man5/ ; \
>> >                         install -m 644 $${lang}/*.8 $(DESTDIR)$(MANDIR=
)/$${lang}/man8/ ; \
>> >                 fi ; \
>> >         done
>> > ```
>> >
>> > I'd simply drop 'ru' from LINGUAS in order to make it possible to use
>> > original ru pages extracted from other source and setting LINGUAS in t=
he
>> > build environment, e.g.:
>> >
>> > ```
>> > --- a/checkpolicy/Makefile
>> > +++ b/checkpolicy/Makefile
>> > @@ -1,7 +1,7 @@
>> >  #
>> >  # Makefile for building the checkpolicy program
>> >  #
>> > -LINGUAS ?=3D ru
>> > +LINGUAS ?=3D
>
> Won't it be better to just remove the whole line?
> Jim

I was thinking about better discoverability. The code is hidden in
install, but the empty variable shows that there's this possibility.=20


>
>> >  PREFIX ?=3D /usr
>> >  BINDIR ?=3D $(PREFIX)/bin
>> >  MANDIR ?=3D $(PREFIX)/share/man
>> > ```
>> >
>>
>> I didn't think of the Makefiles.
>> I'll send a patch to make the change you recommend above to all of the
>> Makefiles.
>>
>> Thanks,
>> Jim
>>
>>
>> >
>> > > ---
>> > >  .../semodule_expand/ru/semodule_expand.8      | 31 ------------
>> > >  .../semodule_link/ru/semodule_link.8          | 32 -------------
>> > >  .../semodule_package/ru/semodule_package.8    | 48 ----------------=
---
>> > >  .../semodule_package/ru/semodule_unpackage.8  | 24 ----------
>> > >  4 files changed, 135 deletions(-)
>> > >  delete mode 100644 semodule-utils/semodule_expand/ru/semodule_expan=
d.8
>> > >  delete mode 100644 semodule-utils/semodule_link/ru/semodule_link.8
>> > >  delete mode 100644 semodule-utils/semodule_package/ru/semodule_pack=
age.8
>> > >  delete mode 100644 semodule-utils/semodule_package/ru/semodule_unpa=
ckage.8
>> > >
>> > > diff --git a/semodule-utils/semodule_expand/ru/semodule_expand.8 b/s=
emodule-utils/semodule_expand/ru/semodule_expand.8
>> > > deleted file mode 100644
>> > > index 28b381af..00000000
>> > > --- a/semodule-utils/semodule_expand/ru/semodule_expand.8
>> > > +++ /dev/null
>> > > @@ -1,31 +0,0 @@
>> > > -.TH SEMODULE_EXPAND "8" "=D0=BD=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005"=
 "Security Enhanced Linux"
>> > > -.SH =D0=98=D0=9C=D0=AF
>> > > -semodule_expand \- =D1=80=D0=B0=D1=81=D1=88=D0=B8=D1=80=D0=B8=D1=82=
=D1=8C =D0=BF=D0=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =
=D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
>> > > -
>> > > -.SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
>> > > -.B semodule_expand [-V ] [ -a ] [ -c [version]] basemodpkg outputfi=
le
>> > > -.br
>> > > -.SH =D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95
>> > > -.PP
>> > > -semodule_expand - =D1=83=D1=82=D0=B8=D0=BB=D0=B8=D1=82=D0=B0 =D1=80=
=D0=B0=D0=B7=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =
=D1=80=D1=83=D1=87=D0=BD=D0=BE=D0=B3=D0=BE =D1=80=D0=B0=D1=81=D1=88=D0=B8=
=D1=80=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=B1=
=D0=B0=D0=B7=D0=BE=D0=B2=D0=BE=D0=B3=D0=BE =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=
=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=B2 =D0=B4=D0=B2=
=D0=BE=D0=B8=D1=87=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BF=D0=BE=
=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D1=8F=D0=B4=D1=80=D0=B0.
>> > > -=D0=AD=D1=82=D0=BE =D1=81=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=BE=
 =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D0=BD=D0=B5=
=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=BC =D0=B4=D0=BB=D1=8F =
=D0=BD=D0=BE=D1=80=D0=BC=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D1=80=D0=B0=
=D0=B1=D0=BE=D1=82=D1=8B SELinux. =D0=9E=D0=B1=D1=8B=D1=87=D0=BD=D0=BE =D1=
=82=D0=B0=D0=BA=D0=BE=D0=B5 =D1=80=D0=B0=D1=81=D1=88=D0=B8=D1=80=D0=B5=D0=
=BD=D0=B8=D0=B5 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D0=B5=D1=82=D1=
=81=D1=8F libsemanage =D0=B2=D0=BD=D1=83=D1=82=D1=80=D0=B5=D0=BD=D0=BD=D0=
=B8=D0=BC =D0=BE=D0=B1=D1=80=D0=B0=D0=B7=D0=BE=D0=BC =D0=B2 =D0=BE=D1=82=D0=
=B2=D0=B5=D1=82 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=8B sem=
odule. =D0=9F=D0=B0=D0=BA=D0=B5=D1=82=D1=8B =D0=B1=D0=B0=D0=B7=D0=BE=D0=B2=
=D1=8B=D1=85 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=
=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D1=81=D0=BE=
=D0=B7=D0=B4=D0=B0=D0=B2=D0=B0=D1=82=D1=8C =D0=BD=D0=B5=D0=BF=D0=BE=D1=81=
=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=B5=D0=BD=D0=BD=D0=BE =D1=81 =D0=BF=
=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E semodule_package =D0=B8=D0=BB=D0=B8 se=
module_link (=D0=BF=D1=80=D0=B8 =D1=81=D0=B2=D1=8F=D0=B7=D1=8B=D0=B2=D0=B0=
=D0=BD=D0=B8=D0=B8 =D0=BD=D0=B0=D0=B1=D0=BE=D1=80=D0=B0 =D0=BF=D0=B0=D0=BA=
=D0=B5=D1=82=D0=BE=D0=B2 =D0=B2 =D0=BE=D0=B4=D0=B8=D0=BD =D0=BF=D0=B0=D0=BA=
=D0=B5=D1=82).
>> > > -
>> > > -.SH "=D0=9F=D0=90=D0=A0=D0=90=D0=9C=D0=95=D0=A2=D0=A0=D0=AB"
>> > > -.TP
>> > > -.B \-V
>> > > -=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D1=8E
>> > > -.TP
>> > > -.B \-c [version]
>> > > -=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=
=D0=B8=D0=BA=D0=B8, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=83=D1=8E =D1=81=D0=BB=
=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C
>> > > -.TP
>> > > -.B \-a
>> > > -=D0=9D=D0=B5 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D1=8F=D1=82=D1=8C=
 =D1=83=D1=82=D0=B2=D0=B5=D1=80=D0=B6=D0=B4=D0=B5=D0=BD=D0=B8=D1=8F. =D0=9F=
=D1=80=D0=B8 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=
=D0=BD=D0=B8=D0=B8 =D1=8D=D1=82=D0=BE=D0=B3=D0=BE =D0=BF=D0=B0=D1=80=D0=B0=
=D0=BC=D0=B5=D1=82=D1=80=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=
=D0=B0 =D0=BD=D0=B5 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=BF=D1=80=D0=BE=D0=B2=
=D0=B5=D1=80=D1=8F=D1=82=D1=8C =D0=B7=D0=B0=D0=BF=D1=80=D0=B5=D1=89=D0=B0=
=D1=8E=D1=89=D0=B8=D0=B5 =D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=B0 (nevera=
llow).
>> > > -
>> > > -.SH =D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=
=D0=9A=D0=96=D0=95
>> > > -.B checkmodule(8), semodule_package(8), semodule(8), semodule_link(=
8)
>> > > -(8),
>> > > -.SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
>> > > -.nf
>> > > -=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0=
 =D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=
=D1=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Wal=
sh <dwalsh@redhat.com>.
>> > > -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=
=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Karl MacMilla=
n <kmacmillan@tresys.com>, Joshua Brindle <jbrindle@tresys.com>.
>> > > -=D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=
=83=D1=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=
=BF=D0=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=
=B8=D0=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@=
basealt.ru>.
>> > > diff --git a/semodule-utils/semodule_link/ru/semodule_link.8 b/semod=
ule-utils/semodule_link/ru/semodule_link.8
>> > > deleted file mode 100644
>> > > index 4a8f414e..00000000
>> > > --- a/semodule-utils/semodule_link/ru/semodule_link.8
>> > > +++ /dev/null
>> > > @@ -1,32 +0,0 @@
>> > > -.TH SEMODULE_LINK "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "=
Security Enhanced Linux"
>> > > -.SH =D0=98=D0=9C=D0=AF
>> > > -semodule_link \- =D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=
=D0=BC=D0=B5=D1=81=D1=82=D0=B5 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D1=8B =D0=BC=
=D0=BE=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=
=D0=BA=D0=B8 SELinux
>> > > -
>> > > -.SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
>> > > -.B semodule_link [-Vv] [-o outfile] basemodpkg modpkg1 [modpkg2]...
>> > > -.br
>> > > -.SH =D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95
>> > > -.PP
>> > > -semodule_link - =D1=83=D1=82=D0=B8=D0=BB=D0=B8=D1=82=D0=B0 =D1=80=
=D0=B0=D0=B7=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =
=D1=80=D1=83=D1=87=D0=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=B2=D1=8F=D0=B7=D1=8B=
=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B0=D0=B1=D0=BE=D1=80=D0=B0 =D0=BF=
=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B5=
=D0=B9 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux =D0=B2 =D0=
=BE=D0=B4=D0=B8=D0=BD =D0=BF=D0=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=
=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8.
>> > > -=D0=AD=D1=82=D0=BE =D1=81=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=BE=
 =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D0=BD=D0=B5=
=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=BC =D0=B4=D0=BB=D1=8F =
=D0=BD=D0=BE=D1=80=D0=BC=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D1=80=D0=B0=
=D0=B1=D0=BE=D1=82=D1=8B SELinux. =D0=9E=D0=B1=D1=8B=D1=87=D0=BD=D0=BE =D1=
=82=D0=B0=D0=BA=D0=BE=D0=B5 =D1=81=D0=B2=D1=8F=D0=B7=D1=8B=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B5 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D0=B5=D1=82=D1=
=81=D1=8F libsemanage =D0=B2=D0=BD=D1=83=D1=82=D1=80=D0=B5=D0=BD=D0=BD=D0=
=B8=D0=BC =D0=BE=D0=B1=D1=80=D0=B0=D0=B7=D0=BE=D0=BC =D0=B2 =D0=BE=D1=82=D0=
=B2=D0=B5=D1=82 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=8B sem=
odule. =D0=9F=D0=B0=D0=BA=D0=B5=D1=82=D1=8B =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=
=D0=B5=D0=B9 =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=8E=D1=82=D1=81=D1=8F =D1=81 =
=D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E semodule_package.
>> > > -
>> > > -.SH "=D0=9F=D0=90=D0=A0=D0=90=D0=9C=D0=95=D0=A2=D0=A0=D0=AB"
>> > > -.TP
>> > > -.B \-V
>> > > -=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D1=8E
>> > > -.TP
>> > > -.B \-v
>> > > -=D0=9F=D0=BE=D0=B4=D1=80=D0=BE=D0=B1=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=
=D0=B6=D0=B8=D0=BC
>> > > -.TP
>> > > -.B \-o <output file>
>> > > -=D0=A1=D0=B2=D1=8F=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9 =D0=BF=D0=B0=
=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=
=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8, =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=
=D0=BD=D1=8B=D0=B9 =D1=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E =D1=8D=
=D1=82=D0=BE=D0=B3=D0=BE =D1=81=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=B0
>> > > -
>> > > -
>> > > -.SH =D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=
=D0=9A=D0=96=D0=95
>> > > -.B checkmodule(8), semodule_package(8), semodule(8), semodule_expan=
d(8)
>> > > -(8),
>> > > -.SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
>> > > -.nf
>> > > -=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0=
 =D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=
=D1=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Wal=
sh <dwalsh@redhat.com>.
>> > > -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=
=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Karl MacMilla=
n <kmacmillan@tresys.com>.
>> > > -=D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=
=83=D1=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=
=BF=D0=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=
=B8=D0=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@=
basealt.ru>.
>> > > diff --git a/semodule-utils/semodule_package/ru/semodule_package.8 b=
/semodule-utils/semodule_package/ru/semodule_package.8
>> > > deleted file mode 100644
>> > > index 3f4b16a9..00000000
>> > > --- a/semodule-utils/semodule_package/ru/semodule_package.8
>> > > +++ /dev/null
>> > > @@ -1,48 +0,0 @@
>> > > -.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005=
" "Security Enhanced Linux"
>> > > -.SH =D0=98=D0=9C=D0=AF
>> > > -semodule_package \- =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=
=BF=D0=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=
=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
>> > > -
>> > > -.SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
>> > > -.B semodule_package \-o <output file> \-m <module> [\-f <file conte=
xts>]
>> > > -.br
>> > > -.SH =D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95
>> > > -.PP
>> > > -semodule_package - =D1=83=D1=82=D0=B8=D0=BB=D0=B8=D1=82=D0=B0, =D0=
=BA=D0=BE=D1=82=D0=BE=D1=80=D0=B0=D1=8F =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D1=83=D0=B5=D1=82=D1=81=D1=8F =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D0=
=B7=D0=B4=D0=B0=D0=BD=D0=B8=D1=8F =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=
=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=
=BA=D0=B8 SELinux =D0=B8=D0=B7 =D0=B4=D0=B2=D0=BE=D0=B8=D1=87=D0=BD=D0=BE=
=D0=B3=D0=BE =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=
=D1=82=D0=B8=D0=BA=D0=B8 =D0=B8 (=D0=BD=D0=B5=D0=BE=D0=B1=D1=8F=D0=B7=D0=B0=
=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE) =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D1=85 =
=D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85, =D1=82=D0=B0=D0=BA=D0=B8=D1=85 =D0=BA=
=D0=B0=D0=BA =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82=D1=8B =D1=84=
=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2. =D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 =
semodule_package =D1=83=D0=BF=D0=B0=D0=BA=D0=BE=D0=B2=D1=8B=D0=B2=D0=B0=D0=
=B5=D1=82 =D0=B4=D0=B2=D0=BE=D0=B8=D1=87=D0=BD=D1=8B=D0=B5 =D0=BC=D0=BE=D0=
=B4=D1=83=D0=BB=D0=B8 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8, =D1=
=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D1=81 =D0=BF=D0=BE=D0=
=BC=D0=BE=D1=89=D1=8C=D1=8E checkmodule. =D0=9F=D0=B0=D0=BA=D0=B5=D1=82 =D0=
=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8, =D1=81=D0=BE=D0=B7=D0=B4=D0=
=B0=D0=BD=D0=BD=D1=8B=D0=B9 =D1=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=
=8E semodule_package, =D0=B7=D0=B0=D1=82=D0=B5=D0=BC =D0=BC=D0=BE=D0=B6=D0=
=BD=D0=BE =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D1=
=87=D0=B5=D1=80=D0=B5=D0=B7 semodule.
>> > > -
>> > > -.SH =D0=9F=D0=A0=D0=98=D0=9C=D0=95=D0=A0
>> > > -.nf
>> > > -# =D0=A1=D0=BE=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=BF=D0=B0=D0=BA=D0=
=B5=D1=82 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=B4=D0=BB=D1=
=8F =D0=B1=D0=B0=D0=B7=D0=BE=D0=B2=D0=BE=D0=B3=D0=BE =D0=BC=D0=BE=D0=B4=D1=
=83=D0=BB=D1=8F.
>> > > -$ semodule_package \-o base.pp \-m base.mod \-f file_contexts
>> > > -# =D0=A1=D0=BE=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=BF=D0=B0=D0=BA=D0=
=B5=D1=82 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=B4=D0=BB=D1=
=8F =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F httpd.
>> > > -$ semodule_package \-o httpd.pp \-m httpd.mod \-f httpd.fc
>> > > -# =D0=A1=D0=BE=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=BF=D0=B0=D0=BA=D0=
=B5=D1=82 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=B4=D0=BB=D1=
=8F =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D1=85 =D0=BF=D1=80=D0=
=B0=D0=B2=D0=B8=D0=BB =D0=BF=D1=80=D0=B8=D0=BD=D1=83=D0=B4=D0=B8=D1=82=D0=
=B5=D0=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D1=80=D0=B8=D1=81=D0=B2=D0=
=BE=D0=B5=D0=BD=D0=B8=D1=8F =D1=82=D0=B8=D0=BF=D0=BE=D0=B2, =D0=BD=D0=B5 =
=D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=B0=D1=8F =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=
=D0=BA=D1=81=D1=82=D1=8B =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2.
>> > > -$ semodule_package \-o local.pp \-m local.mod
>> > > -.fi
>> > > -
>> > > -.SH "=D0=9F=D0=90=D0=A0=D0=90=D0=9C=D0=95=D0=A2=D0=A0=D0=AB"
>> > > -.TP
>> > > -.B \-o \-\-outfile <output file>
>> > > -=D0=A4=D0=B0=D0=B9=D0=BB =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=
=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=
=BA=D0=B8, =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9 =D1=8D=D1=
=82=D0=B8=D0=BC =D1=81=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=BE=D0=BC.
>> > > -.TP
>> > > -.B  \-s \-\-seuser <seuser file>
>> > > -=D0=A4=D0=B0=D0=B9=D0=BB seuser, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=
=8B=D0=B9 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B2=D0=BA=D0=BB=D1=
=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82.
>> > > -.TP
>> > > -.B  \-u \-\-user_extra <user extra file>
>> > > -=D0=A4=D0=B0=D0=B9=D0=BB user_extra, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=
=D1=8B=D0=B9 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B2=D0=BA=D0=BB=
=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82.
>> > > -.TP
>> > > -.B  \-m \-\-module <Module file>
>> > > -=D0=A4=D0=B0=D0=B9=D0=BB =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=
=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8, =D0=BA=D0=BE=D1=82=D0=BE=D1=
=80=D1=8B=D0=B9 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B2=D0=BA=D0=
=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82.
>> > > -.TP
>> > > -.B  \-f \-\-fc <File context file>
>> > > -=D0=A4=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=
=D1=82=D0=BE=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=B4=D0=BB=D1=8F =
=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F (=D0=BD=D0=B5=D0=BE=D0=B1=D1=8F=D0=B7=
=D0=B0=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE).
>> > > -.TP
>> > > -.B  \-n \-\-nc <netfilter context file>
>> > > -=D0=A4=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=
=D1=82=D0=B0 netfilter, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=D0=B9 =D1=81=
=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=
=D1=82=D1=8C =D0=B2 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82.
>> > > -
>> > > -.SH =D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=
=D0=9A=D0=96=D0=95
>> > > -.B checkmodule(8), semodule(8), semodule_unpackage(8)
>> > > -.SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
>> > > -.nf
>> > > -=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0=
 =D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=
=D1=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Wal=
sh <dwalsh@redhat.com>.
>> > > -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=
=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Karl MacMilla=
n <kmacmillan@tresys.com>.
>> > > -=D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=
=83=D1=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=
=BF=D0=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=
=B8=D0=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@=
basealt.ru>.
>> > > diff --git a/semodule-utils/semodule_package/ru/semodule_unpackage.8=
 b/semodule-utils/semodule_package/ru/semodule_unpackage.8
>> > > deleted file mode 100644
>> > > index 057ae3d7..00000000
>> > > --- a/semodule-utils/semodule_package/ru/semodule_unpackage.8
>> > > +++ /dev/null
>> > > @@ -1,24 +0,0 @@
>> > > -.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005=
" "Security Enhanced Linux"
>> > > -.SH =D0=98=D0=9C=D0=AF
>> > > -semodule_unpackage \- =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =
=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8C =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=
=D0=BA=D0=B8 =D0=B8 =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=
=D0=BA=D1=81=D1=82=D0=BE=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=B8=
=D0=B7 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=
=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
>> > > -
>> > > -.SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
>> > > -.B semodule_unpackage ppfile modfile [fcfile]
>> > > -.br
>> > > -.SH =D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95
>> > > -.PP
>> > > -semodule_unpackage - =D1=83=D1=82=D0=B8=D0=BB=D0=B8=D1=82=D0=B0, =
=D0=BA=D0=BE=D1=82=D0=BE=D1=80=D0=B0=D1=8F =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=
=D1=8C=D0=B7=D1=83=D0=B5=D1=82=D1=81=D1=8F =D0=B4=D0=BB=D1=8F =D0=B8=D0=B7=
=D0=B2=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=
=D0=B0 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=
=D0=B8=D0=BA=D0=B8 SELinux =D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=BA=D0=
=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82=D0=BE=D0=B2 =D1=84=D0=B0=D0=B9=D0=
=BB=D0=BE=D0=B2 =D0=B8=D0=B7 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=BF=D0=
=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux.
>> > > -
>> > > -.SH =D0=9F=D0=A0=D0=98=D0=9C=D0=95=D0=A0
>> > > -.nf
>> > > -# =D0=98=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =D1=84=D0=B0=D0=B9=D0=
=BB =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F httpd =D0=B8=D0=B7 =D0=BF=D0=B0=D0=
=BA=D0=B5=D1=82=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 http=
d.
>> > > -$ semodule_unpackage httpd.pp httpd.mod httpd.fc
>> > > -.fi
>> > > -
>> > > -.SH =D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=
=D0=9A=D0=96=D0=95
>> > > -.B semodule_package(8)
>> > > -.SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
>> > > -.nf
>> > > -=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0=
 =D1=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=
=D1=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Wal=
sh <dwalsh@redhat.com>.
>> > > -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=
=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Small=
ey <stephen.smalley.work@gmail.com>.
>> > > -=D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=
=83=D1=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=
=BF=D0=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=
=B8=D0=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@=
basealt.ru>.
>> > > --
>> > > 2.41.0
>> >

