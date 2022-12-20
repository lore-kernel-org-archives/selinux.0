Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B29AC4332F
	for <selinux@archiver.kernel.org>; Tue, 20 Dec 2022 15:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiLTPDC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiLTPCy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Dec 2022 10:02:54 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293B4301
        for <selinux@vger.kernel.org>; Tue, 20 Dec 2022 07:02:53 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id i5so1998319vkg.6
        for <selinux@vger.kernel.org>; Tue, 20 Dec 2022 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWJHW0WunIz9rQ+EZwK/jtbE4CsBUxWxNF39nZt4DV0=;
        b=I3c6m0C9X+nxQXG1Eiel54bZMsz0e5fD1BnuQn8tmGFGV7UZSzHzi6MQMhOLIvoL4s
         AGhjV86ThUBZZ5UuJRy0Vn3gsN4YswiQKp4LfLxrX1KydHKYT09rQaA2TJp8kB9o/ccl
         qdGJ10J287ssfplluFCbfIsDqTqtuR+4T28qm/veiwpojZrsJiGXFZq/4DtCjD9pmHNU
         hT5b6c5G9wB7EXsRuhZ8Wikdbs51tJJfSo7VEkbdwWvF7jo+pKseXzoq2vpQkC8GOUrl
         20jGoWXwTtShadfR5a136R02EZUtvEsLF7Z+YNh5vqYgHI2pdTDaHapNvd9gUc+/sf80
         yLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWJHW0WunIz9rQ+EZwK/jtbE4CsBUxWxNF39nZt4DV0=;
        b=ZLu4+eBEsPeYS1xyseBTybYuPuEPzxTzwshhf67RJ3MfQSrB7ebDFO9vnRsvBfmWE5
         Dq5z+mGpIgkubXAa0dMMd3R25vdm9gmTIEXUCv96WcNe3T69xa8nqNv+yvvmUb2PZ+/U
         2pyl0YwR5nOHQEVpWT68V5stAIp7ix6SBwJLnoK3dS83F11gGR/4fuRlSeNw6wTy4fGR
         rENHYjCQ/ugZ+YrjOtbm0r/ZyH+kBqfzNj1m3ajsSZvJeS4y3Qw0DCm90paBM/ym5erK
         /1HkmDgK8G2oZ9uASKAlZSvXA6XH3J7CUD6UCBQMiiAjUuOBiU2Vnc700VfQ4NG03/YG
         XBqA==
X-Gm-Message-State: AFqh2kqhI3Im37SNt3OgChbbysXpBcaoU+nYdzCK3d3XQ8ahv13AIZl1
        RnkGOHEZ2/5W86LN+ZwWkRVPtePvNHPHttIbjGo=
X-Google-Smtp-Source: AMrXdXsuKaeNipMxyCsPPinX6W+tCmG3CNDFzOBPgrX+dgdFyZb1MFeP1GLvAvZ3j31FhMZMQIzbOmQ2B7TgCtETpYE=
X-Received: by 2002:a1f:a882:0:b0:3d1:fbb0:9e97 with SMTP id
 r124-20020a1fa882000000b003d1fbb09e97mr967878vke.41.1671548572143; Tue, 20
 Dec 2022 07:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20221219085336.391225-1-inseob@google.com>
In-Reply-To: <20221219085336.391225-1-inseob@google.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 20 Dec 2022 16:02:40 +0100
Message-ID: <CAJ2a_Det=myaFheMGMcAXK4cbs3cV5toyNW459coDRZiCGWcbA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Workaround for heap overhead of pcre
To:     Inseob Kim <inseob@google.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 19 Dec 2022 at 09:53, Inseob Kim <inseob@google.com> wrote:
>
> pcre's behavior is changed so that pcre2_match always allocates heap for
> match_data, rather than stack, regardless of size. The heap isn't freed
> until explicitly calling pcre2_match_data_free. This new behavior may
> result in heap overhead, which may increase the peak memory usage about
> a few megabytes. It's because regex_match is first called for regex_data
> objects, and then regex_data objects are freed at once.

This approach trades peak memory usage for temporary allocations,
which effects runtime performance.  On modern systems memory is most
of the time not a scarce resource.

Some examples:

# selabel_lookup -b file -k /etc/shadow -t file [heaptrack]

## current

total runtime: 0.07s.
calls to allocation functions: 28420 (406000/s)
temporary memory allocations: 16 (228/s)
peak heap memory consumption: 10.09M
peak RSS (including heaptrack overhead): 21.27M
total memory leaked: 1.02K

## proposed

total runtime: 0.06s.
calls to allocation functions: 23430 (366093/s)
temporary memory allocations: 675 (10546/s)
peak heap memory consumption: 9.48M
peak RSS (including heaptrack overhead): 18.59M
total memory leaked: 1.02K

# restorecon -vRn /etc [heaptrack]

## current

total runtime: 0.14s.
calls to allocation functions: 33873 (236874/s)
temporary memory allocations: 1877 (13125/s)
peak heap memory consumption: 10.09M
peak RSS (including heaptrack overhead): 21.58M
total memory leaked: 1.90K

## proposed

total runtime: 0.27s.
calls to allocation functions: 378762 (1423917/s)
temporary memory allocations: 351487 (1321379/s)
peak heap memory consumption: 9.48M
peak RSS (including heaptrack overhead): 20.99M
total memory leaked: 1.90K


# restorecon -vRn /usr [hyperfine]

## current

restorecon -vRn /usr
Benchmark 1: ~/destdir/sbin/restorecon -vRn /usr
  Time (mean =C2=B1 =CF=83):     24.419 s =C2=B1  0.661 s    [User: 23.480 =
s, System: 0.922 s]
  Range (min =E2=80=A6 max):   23.399 s =E2=80=A6 25.495 s    10 runs

## proposed

restorecon -vRn /usr
Benchmark 1: ~/destdir/sbin/restorecon -vRn /usr
  Time (mean =C2=B1 =CF=83):     28.628 s =C2=B1  0.968 s    [User: 27.688 =
s, System: 0.927 s]
  Range (min =E2=80=A6 max):   27.674 s =E2=80=A6 30.798 s    10 runs


So I would argue the performance impact for applications (like
setfiles, restorecon) or daemon (like systemd, udev) is more critical
than the 500K per application.

> To workaround it, free and reallocate match_data whenever we call
> regex_match. It's fine because libselinux currently doesn't use
> match_data, but use only the return value.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
> ---
>  libselinux/src/regex.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 149a7973..2df282f1 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -213,10 +213,20 @@ void regex_data_free(struct regex_data *regex)
>  int regex_match(struct regex_data *regex, char const *subject, int parti=
al)
>  {
>         int rc;
> +       pcre2_match_data *new_match_data;
>         __pthread_mutex_lock(&regex->match_mutex);
> +       new_match_data =3D pcre2_match_data_create_from_pattern(
> +           regex->regex, NULL);

Should be checked for failure (cause pcre2_match() expects a non-NULL
match_data, which would be passed the second time).

Also with this change the member match_data of the struct regex_data
becomes obsolete and should be removed.

>         rc =3D pcre2_match(
>             regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0,
>             partial ? PCRE2_PARTIAL_SOFT : 0, regex->match_data, NULL);
> +       // pcre2_match allocates heap and it won't be freed until
> +       // pcre2_match_data_free, resulting in heap overhead.
> +       // Reallocate match_data to prevent such overhead, whenever possi=
ble.
> +       if (new_match_data) {
> +               pcre2_match_data_free(regex->match_data);
> +               regex->match_data =3D new_match_data;
> +       }
>         __pthread_mutex_unlock(&regex->match_mutex);
>         if (rc > 0)
>                 return REGEX_MATCH;
> --
> 2.39.0.314.g84b9a713c41-goog
>
