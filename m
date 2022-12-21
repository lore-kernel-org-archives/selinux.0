Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDE2C4332F
	for <selinux@archiver.kernel.org>; Wed, 21 Dec 2022 02:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiLUCx4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Dec 2022 21:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLUCxy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Dec 2022 21:53:54 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8C1DA65
        for <selinux@vger.kernel.org>; Tue, 20 Dec 2022 18:53:53 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id h26so13550505vsr.5
        for <selinux@vger.kernel.org>; Tue, 20 Dec 2022 18:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEAHT7KEjPcV5Z+OUfwSQTx33StJi1iVRm4oAA3SUUY=;
        b=JEm0LW033AQ7vXHuDiijkjdwnv4uxwMlK+QFnBP01WCZP4mbE/mqwabZgVTI0dy+6n
         8JaAeBr37Zj4xn4IzU3CWzHDfXEDUVwgc3fClhUisL9JJ4M2ImuSHVK89P6WprdaFiQo
         R4Nlc9As9ETTH2YNYeRGNncMmlfMFOWcBdhqLBdMkpJ5k+lDe7IEhIi5F3Z//nh0XzJZ
         wLvYaU0X8kx9b92RvS4SgOTm7VQpF7s/hRON7NFNHybWNe9OY0mkYvpkMaee30gy0cF0
         oglYLU3qRPldH29nFl/9QdyO55ulA/FarLCo5Q1c476bgfw8IS92Ia8deipxqPI/PiYH
         Nsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEAHT7KEjPcV5Z+OUfwSQTx33StJi1iVRm4oAA3SUUY=;
        b=jr87ydb9Uw+RcdlbaS3N0rtOMnOyJVFUXyQndUHX5tayBh1DnF6pjAYazytefinOkR
         cwBxwRpA9oB//5eo/V1tp8NeoK78eoNVvCB6uyo919t+nOpB2hX4Ffm5ZsKvN1FKAH+2
         pVJt10hXOZUPxB8FPYaqetFFmKX7A94iYsg9I8m8vF2yz1yym8CFPW/tD7TU9M8u8n+A
         c9irjyIlKNpu8UNASgPt6sEhZ39NyJvNF1Q5N5bHpxbNtkDJetJGN7RZNKEvIEGw+tkG
         2vi7LE/T5UxNWj3GiuN7tkz5LvIgsp2jX52aSo8W8vO5X7Whn2rU31TvH3r9zZX8F/mM
         HNSQ==
X-Gm-Message-State: AFqh2kqMzkJofslKBLMV3KcGppN9ibcffteVn3YguM49sYlMJIxsjPdG
        /8EMpGa+I7Ym5Md6X5C5TBaCuP2yifTYG1rGENaiHodWYDXePmxk
X-Google-Smtp-Source: AMrXdXvCFzpYQ5sKvcssoegMCftB9d+BTLaJ/0b5ex4mLeoN//QzlHKt4OAfYkN+vJ1XwB88vpERPQXrEQPF/CgVV6M=
X-Received: by 2002:a67:6cc4:0:b0:3b3:10b1:8e22 with SMTP id
 h187-20020a676cc4000000b003b310b18e22mr24611vsc.50.1671591232566; Tue, 20 Dec
 2022 18:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20221219085336.391225-1-inseob@google.com> <CAJ2a_Det=myaFheMGMcAXK4cbs3cV5toyNW459coDRZiCGWcbA@mail.gmail.com>
In-Reply-To: <CAJ2a_Det=myaFheMGMcAXK4cbs3cV5toyNW459coDRZiCGWcbA@mail.gmail.com>
From:   Inseob Kim <inseob@google.com>
Date:   Wed, 21 Dec 2022 11:53:41 +0900
Message-ID: <CA+QFDK=b4gR+Hz3XqQxaP8gPPixq1ppSOyNYpNaDw4Y8O0k+Xw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Workaround for heap overhead of pcre
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 21, 2022 at 12:02 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 19 Dec 2022 at 09:53, Inseob Kim <inseob@google.com> wrote:
> >
> > pcre's behavior is changed so that pcre2_match always allocates heap fo=
r
> > match_data, rather than stack, regardless of size. The heap isn't freed
> > until explicitly calling pcre2_match_data_free. This new behavior may
> > result in heap overhead, which may increase the peak memory usage about
> > a few megabytes. It's because regex_match is first called for regex_dat=
a
> > objects, and then regex_data objects are freed at once.
>
> This approach trades peak memory usage for temporary allocations,
> which effects runtime performance.  On modern systems memory is most
> of the time not a scarce resource.
>
> Some examples:
>
> # selabel_lookup -b file -k /etc/shadow -t file [heaptrack]
>
> ## current
>
> total runtime: 0.07s.
> calls to allocation functions: 28420 (406000/s)
> temporary memory allocations: 16 (228/s)
> peak heap memory consumption: 10.09M
> peak RSS (including heaptrack overhead): 21.27M
> total memory leaked: 1.02K
>
> ## proposed
>
> total runtime: 0.06s.
> calls to allocation functions: 23430 (366093/s)
> temporary memory allocations: 675 (10546/s)
> peak heap memory consumption: 9.48M
> peak RSS (including heaptrack overhead): 18.59M
> total memory leaked: 1.02K
>
> # restorecon -vRn /etc [heaptrack]
>
> ## current
>
> total runtime: 0.14s.
> calls to allocation functions: 33873 (236874/s)
> temporary memory allocations: 1877 (13125/s)
> peak heap memory consumption: 10.09M
> peak RSS (including heaptrack overhead): 21.58M
> total memory leaked: 1.90K
>
> ## proposed
>
> total runtime: 0.27s.
> calls to allocation functions: 378762 (1423917/s)
> temporary memory allocations: 351487 (1321379/s)
> peak heap memory consumption: 9.48M
> peak RSS (including heaptrack overhead): 20.99M
> total memory leaked: 1.90K
>
>
> # restorecon -vRn /usr [hyperfine]
>
> ## current
>
> restorecon -vRn /usr
> Benchmark 1: ~/destdir/sbin/restorecon -vRn /usr
>   Time (mean =C2=B1 =CF=83):     24.419 s =C2=B1  0.661 s    [User: 23.48=
0 s, System: 0.922 s]
>   Range (min =E2=80=A6 max):   23.399 s =E2=80=A6 25.495 s    10 runs
>
> ## proposed
>
> restorecon -vRn /usr
> Benchmark 1: ~/destdir/sbin/restorecon -vRn /usr
>   Time (mean =C2=B1 =CF=83):     28.628 s =C2=B1  0.968 s    [User: 27.68=
8 s, System: 0.927 s]
>   Range (min =E2=80=A6 max):   27.674 s =E2=80=A6 30.798 s    10 runs
>
>
> So I would argue the performance impact for applications (like
> setfiles, restorecon) or daemon (like systemd, udev) is more critical
> than the 500K per application.

I observed about 3~4MB increase on Android device. Which pcre2 version
are you using? Does it include
https://github.com/PCRE2Project/pcre2/commit/d90fb238#diff-15ec3f4ed916f52c=
810daf305702985dda6d8d45e7ce22e2f309c95bd6ef32b7R74
?

And if this is difficult to apply, how about adding a new flag e.g.
AGGRESSIVE_FREE_AFTER_REGEX_MATCH ?

>
> > To workaround it, free and reallocate match_data whenever we call
> > regex_match. It's fine because libselinux currently doesn't use
> > match_data, but use only the return value.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
> > ---
> >  libselinux/src/regex.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> > index 149a7973..2df282f1 100644
> > --- a/libselinux/src/regex.c
> > +++ b/libselinux/src/regex.c
> > @@ -213,10 +213,20 @@ void regex_data_free(struct regex_data *regex)
> >  int regex_match(struct regex_data *regex, char const *subject, int par=
tial)
> >  {
> >         int rc;
> > +       pcre2_match_data *new_match_data;
> >         __pthread_mutex_lock(&regex->match_mutex);
> > +       new_match_data =3D pcre2_match_data_create_from_pattern(
> > +           regex->regex, NULL);
>
> Should be checked for failure (cause pcre2_match() expects a non-NULL
> match_data, which would be passed the second time).
>
> Also with this change the member match_data of the struct regex_data
> becomes obsolete and should be removed.

Thanks, this makes sense.

>
> >         rc =3D pcre2_match(
> >             regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0=
,
> >             partial ? PCRE2_PARTIAL_SOFT : 0, regex->match_data, NULL);
> > +       // pcre2_match allocates heap and it won't be freed until
> > +       // pcre2_match_data_free, resulting in heap overhead.
> > +       // Reallocate match_data to prevent such overhead, whenever pos=
sible.
> > +       if (new_match_data) {
> > +               pcre2_match_data_free(regex->match_data);
> > +               regex->match_data =3D new_match_data;
> > +       }
> >         __pthread_mutex_unlock(&regex->match_mutex);
> >         if (rc > 0)
> >                 return REGEX_MATCH;
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >



--=20
Inseob Kim | Software Engineer | inseob@google.com
