Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FD3C4332F
	for <selinux@archiver.kernel.org>; Wed, 21 Dec 2022 14:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLUOTR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Dec 2022 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUOTP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Dec 2022 09:19:15 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A837F1836D
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 06:19:14 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id 128so14807968vsz.12
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 06:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmg0VYTQpLIEvtvgmzTWXCUqEsBD6TbYW7tLDrsYBlM=;
        b=KnD4EHUAg3xmmE41+tS6F+VGjpINS2RSTmmHgsxUisJAmVfVlN+KMNiTT5CrZm6PIt
         npqrFXTiNK7KmHmiQhm7GhViLW6nIoMPVe5g5bDnHNQRxn9Z3Nr8Dexz5J4EuTKlsTWE
         SdXSMfRj2aUBC78PtKn7VFxrzqa1bxNlK04+WvJn2Xaux+1C9XB9HQsCfZKEDnzMisQe
         oc8cwT/QZP3d//wPE+AQXKoOQoDSHe/8tWrQx30uQ6ODFI2X3876XYmXT8PXbHNOcAIB
         fVZBkDw+RgPhkX/LnSWTNHRN6tiMl4ftw5WeB7BelYnbq3X7li+SwcmYOHqr/ynEw6tl
         b+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmg0VYTQpLIEvtvgmzTWXCUqEsBD6TbYW7tLDrsYBlM=;
        b=LSWysiiLgdBl812p53IvjSqudGmsoCy52pUBppTN9O3BfZpVctFfrCzGIwVswJPPvA
         5VbeUqQz7GuU4GjE1Q/4EVmlFi88hYc3AnghWfUY1FcHJoOVRcb3p8Hd+BfnazXijA5A
         vUTsy+qaZF33N4kxhCk5vvOq935sz14IsEyu0ATwYaxCY+dhrWztrzCo9wjeZKtyaMcZ
         eIAKE1fma2wTILEz2nK9iIPO9tO/qOJiYoOc6xuvIq02U01Xi97zPp6ZvlEYMgVHQ3lR
         Y9dTthfJyKixs8hyJLnWkXqRM5BB2jOlnnkaWGb6JxVBPYTQTnhTFojYqwmZLfkl6Jki
         FRHA==
X-Gm-Message-State: AFqh2kojOazu9S0yuPgte2HprxDBPpRw0vkZ+Z0cBl6Kt0uiJyEl/CE1
        I9N+6Mc2R3UoNMO6g+uZWgMVhdJri6UGTgxG6OsMVqdm+RaiYA==
X-Google-Smtp-Source: AMrXdXuy2OLZu5MwnYWj5Vdziju0ht21L9GjELirLyIoYi0mktGJ5UgiouhRx/v/wYx0mscC2SDpxCc1+CrFWjOEJoQ=
X-Received: by 2002:a67:b912:0:b0:3b1:29d1:3485 with SMTP id
 q18-20020a67b912000000b003b129d13485mr263865vsn.20.1671632353499; Wed, 21 Dec
 2022 06:19:13 -0800 (PST)
MIME-Version: 1.0
References: <20221219085336.391225-1-inseob@google.com> <CAJ2a_Det=myaFheMGMcAXK4cbs3cV5toyNW459coDRZiCGWcbA@mail.gmail.com>
 <CA+QFDK=b4gR+Hz3XqQxaP8gPPixq1ppSOyNYpNaDw4Y8O0k+Xw@mail.gmail.com>
In-Reply-To: <CA+QFDK=b4gR+Hz3XqQxaP8gPPixq1ppSOyNYpNaDw4Y8O0k+Xw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 21 Dec 2022 15:19:02 +0100
Message-ID: <CAJ2a_Dd5Cf0Bkbn-NPwkaqCX+BZcLvLfOv5v9UUrXY+cM+KMVg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Workaround for heap overhead of pcre
To:     Inseob Kim <inseob@google.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 21 Dec 2022 at 03:53, Inseob Kim <inseob@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 12:02 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Mon, 19 Dec 2022 at 09:53, Inseob Kim <inseob@google.com> wrote:
> > >
> > > pcre's behavior is changed so that pcre2_match always allocates heap =
for
> > > match_data, rather than stack, regardless of size. The heap isn't fre=
ed
> > > until explicitly calling pcre2_match_data_free. This new behavior may
> > > result in heap overhead, which may increase the peak memory usage abo=
ut
> > > a few megabytes. It's because regex_match is first called for regex_d=
ata
> > > objects, and then regex_data objects are freed at once.
> >
> > This approach trades peak memory usage for temporary allocations,
> > which effects runtime performance.  On modern systems memory is most
> > of the time not a scarce resource.
> >
> > Some examples:
> >
> > # selabel_lookup -b file -k /etc/shadow -t file [heaptrack]
> >
> > ## current
> >
> > total runtime: 0.07s.
> > calls to allocation functions: 28420 (406000/s)
> > temporary memory allocations: 16 (228/s)
> > peak heap memory consumption: 10.09M
> > peak RSS (including heaptrack overhead): 21.27M
> > total memory leaked: 1.02K
> >
> > ## proposed
> >
> > total runtime: 0.06s.
> > calls to allocation functions: 23430 (366093/s)
> > temporary memory allocations: 675 (10546/s)
> > peak heap memory consumption: 9.48M
> > peak RSS (including heaptrack overhead): 18.59M
> > total memory leaked: 1.02K
> >
> > # restorecon -vRn /etc [heaptrack]
> >
> > ## current
> >
> > total runtime: 0.14s.
> > calls to allocation functions: 33873 (236874/s)
> > temporary memory allocations: 1877 (13125/s)
> > peak heap memory consumption: 10.09M
> > peak RSS (including heaptrack overhead): 21.58M
> > total memory leaked: 1.90K
> >
> > ## proposed
> >
> > total runtime: 0.27s.
> > calls to allocation functions: 378762 (1423917/s)
> > temporary memory allocations: 351487 (1321379/s)
> > peak heap memory consumption: 9.48M
> > peak RSS (including heaptrack overhead): 20.99M
> > total memory leaked: 1.90K
> >
> >
> > # restorecon -vRn /usr [hyperfine]
> >
> > ## current
> >
> > restorecon -vRn /usr
> > Benchmark 1: ~/destdir/sbin/restorecon -vRn /usr
> >   Time (mean =C2=B1 =CF=83):     24.419 s =C2=B1  0.661 s    [User: 23.=
480 s, System: 0.922 s]
> >   Range (min =E2=80=A6 max):   23.399 s =E2=80=A6 25.495 s    10 runs
> >
> > ## proposed
> >
> > restorecon -vRn /usr
> > Benchmark 1: ~/destdir/sbin/restorecon -vRn /usr
> >   Time (mean =C2=B1 =CF=83):     28.628 s =C2=B1  0.968 s    [User: 27.=
688 s, System: 0.927 s]
> >   Range (min =E2=80=A6 max):   27.674 s =E2=80=A6 30.798 s    10 runs
> >
> >
> > So I would argue the performance impact for applications (like
> > setfiles, restorecon) or daemon (like systemd, udev) is more critical
> > than the 500K per application.
>
> I observed about 3~4MB increase on Android device. Which pcre2 version
> are you using? Does it include
> https://github.com/PCRE2Project/pcre2/commit/d90fb238#diff-15ec3f4ed916f5=
2c810daf305702985dda6d8d45e7ce22e2f309c95bd6ef32b7R74
> ?

Those measurements were done against pcre2 version 10.40.
Indeed with version 10.42 the peak memory usage of the current
implementation has grown and is reduced by this patch:


# selabel_lookup -b file -k /etc/shadow -t file [heaptrack]

## current

total runtime: 0.07s.
calls to allocation functions: 29080 (421449/s)
temporary memory allocations: 15 (217/s)
peak heap memory consumption: 22.72M
peak RSS (including heaptrack overhead): 18.68M
total memory leaked: 1.02K

## proposed

total runtime: 0.06s.
calls to allocation functions: 24090 (376406/s)
temporary memory allocations: 675 (10546/s)
peak heap memory consumption: 9.48M
peak RSS (including heaptrack overhead): 22.15M
total memory leaked: 1.02K


# restorecon -vRn /etc [heaptrack]

## current

total runtime: 0.13s.
calls to allocation functions: 34720 (259104/s)
temporary memory allocations: 1872 (13970/s)
peak heap memory consumption: 26.66M
peak RSS (including heaptrack overhead): 25.59M
total memory leaked: 1.90K

## proposed

total runtime: 0.43s.
calls to allocation functions: 729301 (1692113/s)
temporary memory allocations: 351486 (815512/s)
peak heap memory consumption: 9.48M
peak RSS (including heaptrack overhead): 20.98M
total memory leaked: 1.90K


# restorecon -vRn /usr [hyperfine]

## current

Benchmark 1: ~/destdir/sbin/restorecon -vRn /usr
  Time (mean =C2=B1 =CF=83):     31.053 s =C2=B1  1.491 s    [User: 29.926 =
s, System: 1.105 s]
  Range (min =E2=80=A6 max):   28.817 s =E2=80=A6 33.679 s    10 runs

## proposed

Benchmark 1: ~/destdir/sbin/restorecon -vRn /usr
  Time (mean =C2=B1 =CF=83):     37.829 s =C2=B1  0.416 s    [User: 36.935 =
s, System: 0.875 s]
  Range (min =E2=80=A6 max):   37.205 s =E2=80=A6 38.764 s    10 runs


>
> And if this is difficult to apply, how about adding a new flag e.g.
> AGGRESSIVE_FREE_AFTER_REGEX_MATCH ?
>
> >
> > > To workaround it, free and reallocate match_data whenever we call
> > > regex_match. It's fine because libselinux currently doesn't use
> > > match_data, but use only the return value.
> > >
> > > Signed-off-by: Inseob Kim <inseob@google.com>
> > > ---
> > >  libselinux/src/regex.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> > > index 149a7973..2df282f1 100644
> > > --- a/libselinux/src/regex.c
> > > +++ b/libselinux/src/regex.c
> > > @@ -213,10 +213,20 @@ void regex_data_free(struct regex_data *regex)
> > >  int regex_match(struct regex_data *regex, char const *subject, int p=
artial)
> > >  {
> > >         int rc;
> > > +       pcre2_match_data *new_match_data;
> > >         __pthread_mutex_lock(&regex->match_mutex);
> > > +       new_match_data =3D pcre2_match_data_create_from_pattern(
> > > +           regex->regex, NULL);
> >
> > Should be checked for failure (cause pcre2_match() expects a non-NULL
> > match_data, which would be passed the second time).
> >
> > Also with this change the member match_data of the struct regex_data
> > becomes obsolete and should be removed.
>
> Thanks, this makes sense.
>
> >
> > >         rc =3D pcre2_match(
> > >             regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED,=
 0,
> > >             partial ? PCRE2_PARTIAL_SOFT : 0, regex->match_data, NULL=
);
> > > +       // pcre2_match allocates heap and it won't be freed until
> > > +       // pcre2_match_data_free, resulting in heap overhead.
> > > +       // Reallocate match_data to prevent such overhead, whenever p=
ossible.
> > > +       if (new_match_data) {
> > > +               pcre2_match_data_free(regex->match_data);
> > > +               regex->match_data =3D new_match_data;
> > > +       }
> > >         __pthread_mutex_unlock(&regex->match_mutex);
> > >         if (rc > 0)
> > >                 return REGEX_MATCH;
> > > --
> > > 2.39.0.314.g84b9a713c41-goog
> > >
>
>
>
> --
> Inseob Kim | Software Engineer | inseob@google.com
