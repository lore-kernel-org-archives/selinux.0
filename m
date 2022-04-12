Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03989C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Apr 2022 18:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbiDLSFm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiDLSFl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Apr 2022 14:05:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F91D5A5A8
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:03:23 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso13942706otj.0
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5S2GcRfPuLyn3aqvmr32hgFcpjtuTOwApSsREul9b8A=;
        b=YT6pRwlnqpdz2MuR/ppmgwuMaqE6ew8wJPpLlF3/65W905QfWEnmqpSkxaP+hchh74
         hd1pRvaxoEbkFrfvRMfoMzXveNFrvI04edw4/pfk4MOQkp/pqRxRO5SWUBHOzSffbDgY
         cBPWz9wkKK9wCy7T7vHH21Sf3T5jRH04YVBKx2KLxAMiWcbqZ/DOs5wc2qeICAkz+Ep6
         ekQaHhQqK+iF2EW54ANHEELEiPhsR1Gds2TKhP7/pJ+a/XPksOUy0oegtWePv3Val7Em
         /hjQQfww876lGychZklVRHOKWazdD8VzZeuTG58lStBsRgcJSbAg/BR+Du672XQLaeRW
         qgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5S2GcRfPuLyn3aqvmr32hgFcpjtuTOwApSsREul9b8A=;
        b=hADDZhnYIooItEuYpsTDAFq00BgZMlex+9qXxulsx9fcIqHb0w/vejYhTBR4Pt0Cia
         V1tAYgFroyHHh8F53yUu1hPNFEiYFQMOPxU3UQwxZgVNb6ly9oxOGZoEIR/u41llAXCP
         QqetEYHV5tJtlBpFJ8uVtPyrrze4EN6630K8gDIHFddHYYGXmpnVFxvjb87WuSFpZYcl
         Elrc8SkZR8piVoHsW1tl/oZaIyEvtN5SCtvAQFHa/9nFUIjYnTlrUtvOcn/Ep+Q4J0On
         YCkLrXugMdPjJOlvldnV2Dc2hBZocGSzRweZ7j2bZCReF1q6JYJUaBO5H1Aek9cxEsNe
         hPUw==
X-Gm-Message-State: AOAM531a9MEvOcouMhmeZRlOROc41lLAVH1fDEbEQ9wFXu/nWGrcEOIC
        ocycojwKt8fMr0aC3DbYbmImWh/oXGzIB7KcMpg=
X-Google-Smtp-Source: ABdhPJy4x8d13PTOJTaqfIYf5IoyP8A+Tk6bX9APMhE8MR7NQnmGm0Fx/BbjfWJASKJdzk30IsIM+4txfis0xdeL278=
X-Received: by 2002:a9d:6a8a:0:b0:5e6:8b0d:ce5a with SMTP id
 l10-20020a9d6a8a000000b005e68b0dce5amr13645955otq.154.1649786602971; Tue, 12
 Apr 2022 11:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220405133958.52460-1-cgzones@googlemail.com> <878rsipk7n.fsf@redhat.com>
In-Reply-To: <878rsipk7n.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Apr 2022 14:03:12 -0400
Message-ID: <CAP+JOzQhAvgh3o9wfk-A8riLpsDFb0Q4GL5A_cnXUp4GRqkCKg@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: drop usage of egrep in fixfiles
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 6, 2022 at 11:29 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
> > egrep(1) is deprecated, use `grep -E`.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

Merged.
Thanks,
Jim

>
> > ---
> >  policycoreutils/scripts/fixfiles | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts=
/fixfiles
> > index 7df4303a..c72ca0eb 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> > @@ -45,9 +45,9 @@ FS=3D"`cat /proc/self/mounts | sort | uniq | awk '{pr=
int $2}'`"
> >  for i in $FS; do
> >       if [ `useseclabel` -ge 0 ]
> >       then
> > -             grep " $i " /proc/self/mounts | awk '{print $4}' | egrep =
--silent '(^|,)seclabel(,|$)' && echo $i
> > +             grep " $i " /proc/self/mounts | awk '{print $4}' | grep -=
E --silent '(^|,)seclabel(,|$)' && echo $i
> >       else
> > -             grep " $i " /proc/self/mounts | grep -v "context=3D" | eg=
rep --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo $i
> > +             grep " $i " /proc/self/mounts | grep -v "context=3D" | gr=
ep -E --silent '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo $i
> >       fi
> >  done
> >  }
> > @@ -55,14 +55,14 @@ done
> >  get_rw_labeled_mounts() {
> >  FS=3D`get_all_labeled_mounts | sort | uniq`
> >  for i in $FS; do
> > -     grep " $i " /proc/self/mounts | awk '{print $4}' | egrep --silent=
 '(^|,)rw(,|$)' && echo $i
> > +     grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --sile=
nt '(^|,)rw(,|$)' && echo $i
> >  done
> >  }
> >
> >  get_ro_labeled_mounts() {
> >  FS=3D`get_all_labeled_mounts | sort | uniq`
> >  for i in $FS; do
> > -     grep " $i " /proc/self/mounts | awk '{print $4}' | egrep --silent=
 '(^|,)ro(,|$)' && echo $i
> > +     grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --sile=
nt '(^|,)ro(,|$)' && echo $i
> >  done
> >  }
> >
> > @@ -176,7 +176,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
> >       sed -r -e 's,:s0, ,g' $FC | sort -u | \
> >       /usr/bin/diff -b ${PREFCTEMPFILE} - | \
> >           grep '^[<>]'|cut -c3-| grep ^/ | \
> > -         egrep -v '(^/home|^/root|^/tmp)' |\
> > +         grep -Ev '(^/home|^/root|^/tmp)' |\
> >       sed -r -e 's,[[:blank:]].*,,g' \
> >              -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
> >              -e 's|([/[:alnum:]])\?|{\1,}|g' \
> > --
> > 2.35.1
>
