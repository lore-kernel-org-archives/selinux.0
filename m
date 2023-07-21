Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EFFEB64DD
	for <selinux@archiver.kernel.org>; Fri, 21 Jul 2023 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGUROG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGUROG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jul 2023 13:14:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC88730C1
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 10:14:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2674d0e10c4so1037214a91.3
        for <selinux@vger.kernel.org>; Fri, 21 Jul 2023 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689959642; x=1690564442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ede+UnbZKpUpUjas0G3p53ypbwG4apo9yeC++QVOsyg=;
        b=l4TNEsLKl7DHirhuWWMiq2beXM/VgdoFh01Dg4ll/F8ChDB2Ne8dC9oy8o9vfZ9LlH
         DgAAjkIE4LoDk1LW0BGwD445SlvDur+n5WF3oPGObOnuQ5c9yrM7Rf+wcUyKJRJMEyyk
         vf+qWBpuvxsSoIYdra2xOMnRx8sn9PMyWmJy9DOA/WG+imvFeOvaG6m9O2O/pf0AtCKu
         j5daPbfCtKAB3pNdjlC9p68A+vBPGc0Xu3CGvhWxdrrn33TKvR+31V5IzTfhZdkacay7
         RhOwlSQ9iY8bzx1fQyFhipbt/9uYiwoE68Vl+sN73Es4ShUdSxPJri04CzEU9q/LCAsU
         H5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689959642; x=1690564442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ede+UnbZKpUpUjas0G3p53ypbwG4apo9yeC++QVOsyg=;
        b=ZnUpguVVs4hoYlpcUTrfhVl14hudI4JSQvh1FATlqD2zBJOihVXeAGMgtxRX+fZtOR
         KDXemFyZN9JirbkVTBnFLj2Z+Y863uxqn8LJNkLUAZrE3IWI/68nJpD9isB0hiF+V+4F
         aUmrEPPPbadDk0+A2FZQHcCoPQOlSBx14eu06KLmIkZiI9kct+4qfGivj0XB0F3CJuBS
         DiPBHky9qYfr1V63rxRYpQF53vjGzsWIrxoMkouHuFhNpN6J+eANjWpgArNTLf4ISyJV
         PDx2q0Tr5GLS539fNx0LqPQR5i39E7ZnT5WKHY0+5OLP/Na2F34SgoGP+qVoiXdvUqFG
         Gc/g==
X-Gm-Message-State: ABy/qLalLFxk9VRE+kheJDY4Hqqjyy+67m+T0Mr+JsH55Xzik6bPUkzw
        jDhXIoTyW9hXbrSPeqQjj/NBaqDTcXnsTtvM3/F1NxW9/5g=
X-Google-Smtp-Source: APBJJlG61LKKU5tvMtVO7BZO9CSfRJQcMC304p+kV7uEh4NdAIvtTk7zh0MLLjPHwbvRZ5phzwEQnwjXWKSynsIvU1Y=
X-Received: by 2002:a17:90a:72c3:b0:262:c8dc:5ab0 with SMTP id
 l3-20020a17090a72c300b00262c8dc5ab0mr1794638pjk.39.1689959642095; Fri, 21 Jul
 2023 10:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230121180318.11853-1-carenas@gmail.com> <20230123014047.84911-1-carenas@gmail.com>
 <20230123014047.84911-3-carenas@gmail.com> <20230322042518.GA34052@sol.localdomain>
In-Reply-To: <20230322042518.GA34052@sol.localdomain>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 21 Jul 2023 13:13:50 -0400
Message-ID: <CAEjxPJ6_wP1mLkPqFmon3OMQ9DRjvLjs6bZXBF1WutX3t8qCKw@mail.gmail.com>
Subject: Re: [PATCH 2/3] libselinux: improve performance with pcre matches
To:     Eric Biggers <ebiggers@kernel.org>, inseob@google.com
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 22, 2023 at 12:39=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> Hi Carlo,
>
> On Mon, Jan 23, 2023 at 01:40:46AM +0000, Carlo Marcelo Arenas Bel=C3=B3n=
 wrote:
> > Since 30b3e9d2 (libselinux: Workaround for heap overhead of pcre,
> > 2023-01-12), performance of PCRE2 matches has been affected due to
> > excesive recreation of the match_data in an attempt to reduce memory
> > utilization; instead of a workaround, it would be better to address
> > the problem and maybe even improve performance in the process.
> >
> > The issue is that currently the structure that holds PCRE state has
> > both a pcre2_code (which is per pattern) and a pcre2_match_data (which
> > is per match), forcing us to add a mutex to prevent multiple matches to
> > step on each other.
> >
> > Lets remove the match_data and the mutex and instead allocate one once
> > in a thread independent way that could be used and reused, by extending
> > our pthread interface to not only store TLS variables but also retrieve
> > them, and then use one of those.
> >
> > Since we are not interested on the capture groups (if any) lets only
> > allocate 1 pair which is all that will be needed and change the logic
> > so that a return of 0 (which means the pattern matched but there were
> > not enough capture spots) is also considered a match.
> >
> > This will ensure that the memory use would be bound to the number of
> > concurrent matches instead of the number of patterns and therefore
> > reduce the impact that recent changes on the way that the frames used
> > for matching are allocated might had brough since 10.41 was released.
> >
> > For cases where threads are not available, just keep it working in slow
> > mode as done before the workaround was reverted.
> >
> > Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> > ---
> >  libselinux/src/regex.c            | 108 +++++++++++++++++-------------
> >  libselinux/src/selinux_internal.h |   4 ++
> >  2 files changed, 64 insertions(+), 48 deletions(-)
> >
>
> Thanks for writing this patch!  I notice it hasn't been applied upstream.=
  Is
> this still being worked on?
>
> A couple comments below:
>
> > +static void __attribute__((destructor)) match_data_thread_free(void *k=
ey)
> > +{
> > +     void *value;
> > +     pcre2_match_data *match_data;
> > +
> > +     if (match_data_key_initialized <=3D 0 || !match_data_initialized)
> > +             return;
> > +
> > +     value =3D __selinux_getspecific(match_data_key);
> > +     match_data =3D value ? value : key;
> > +
> > +     pcre2_match_data_free(match_data);
> > +
> > +     __pthread_mutex_lock(&key_mutex);
> > +     if (--match_data_key_initialized =3D=3D 1) {
> > +             __selinux_key_delete(match_data_key);
> > +             match_data_key_initialized =3D -1;
> > +     }
> > +     __pthread_mutex_unlock(&key_mutex);
> > +}
>
> This function is used as a pthread_key destructor.  But, it's also marked=
 with
> __attribute__((destructor)), making it a library-level destructor too.  T=
hat's
> confusing.  Is there a reason for that?  I would have expected these to b=
e two
> different functions.  The pthread_key destructor should call
> pcre2_match_data_free on the value passed as an argument, while the
> library-level destructor should delete match_data_key.
>
> >  int regex_match(struct regex_data *regex, char const *subject, int par=
tial)
> >  {
> >       int rc;
> > -     pcre2_match_data *match_data;
> > -     __pthread_mutex_lock(&regex->match_mutex);
> > +     bool slow;
> > +     pcre2_match_data *match_data =3D NULL;
> > +
> > +     if (match_data_key_initialized > 0) {
> > +             if (match_data_initialized =3D=3D 0) {
> > +                     match_data =3D pcre2_match_data_create(1, NULL);
> > +                     if (match_data) {
> > +                             match_data_initialized =3D 1;
> > +                             __selinux_setspecific(match_data_key,
> > +                                                     match_data);
> > +                             __pthread_mutex_lock(&key_mutex);
> > +                             match_data_key_initialized++;
> > +                             __pthread_mutex_unlock(&key_mutex);
> > +                     }
> > +             } else
> > +                     match_data =3D __selinux_getspecific(match_data_k=
ey);
> > +     }
>
> Since match_data_key_initialized is checked without holding key_mutex, ca=
n't the
> above code race with the below code in match_data_thread_free?
>
>         __pthread_mutex_lock(&key_mutex);
>         if (--match_data_key_initialized =3D=3D 1) {
>                 __selinux_key_delete(match_data_key);
>                 match_data_key_initialized =3D -1;
>         }
>         __pthread_mutex_unlock(&key_mutex);
>
> Perhaps deleting the pthread_key is just not something that should be don=
e at
> all?

This patch appears to have been applied to AOSP here:
https://android-review.googlesource.com/c/platform/external/selinux/+/24111=
94
but I didn't see any reply to Eric's comments above. Is this still
being worked on?
