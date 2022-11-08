Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8465C433FE
	for <selinux@archiver.kernel.org>; Tue,  8 Nov 2022 03:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiKHD4W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Nov 2022 22:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiKHD4V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Nov 2022 22:56:21 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E385013FB1
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 19:56:19 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h206so10542157iof.10
        for <selinux@vger.kernel.org>; Mon, 07 Nov 2022 19:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7rKo2XuKdaCaLbdLhQ7d4dXMTieMP+N2tz8dUl5/XI=;
        b=RWYO5MU2o6f2bfTbm/cByN/j5rC12q/9cK9ULcTOKun+eaMC873EeovIaEU+5aqnFX
         2puY+Zm5pnSP02awcQsLyIg4si82qvpdEuiff6q/wT8V8T+D/Yc9G2WSQtm8FYxls6pN
         oD+oxCfT7ZikqOIyLOuJkl8I6xg/AT6B3+n86OQCCVQVOXnWZm8ReA08MuRzB0snFyO2
         k75XOfYKv6fQSJ213S3WS8ve+3i9Bytbkxb/0YFAPkm1vyyV6oR2+fKGFDZFKcqyLFwo
         yRWmTcxVyycZkGd2lG7wVCuQWIbmYflr6zHmyvWtTVuIajXFeBvEU2eHfbIcN7s1t8bW
         sEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7rKo2XuKdaCaLbdLhQ7d4dXMTieMP+N2tz8dUl5/XI=;
        b=WV3oOrB0MDhIH+0tpdmnlZp1EJ5+jX2IpzYxyDPJyY0sQFrtCBszEnIpZPCgkQEof8
         sYaA9AsAaZMJLsJ3Sc+xkk3aXkHYQ9jtqoMQNEYlhyQi3XB+kvY7ZxpOVjM+rKwjM5aw
         r10XiKne+Z1AXOAx1i/7UjASUsTivdANZ9wcvvxkHKC0ZWmyfnT+rZBfBRZtA6COS8pu
         nOI0LD6GnzdYf4L6N3WEsExptwmoI/02NAOLy3zreL5nO3KvXuWivvhWTbriOavU0YLN
         F4ucB0dORLrshuDLlrFPjxIxx4V7rqdeN5iVmbeJ6Enw853AaGCNrMkFOVYItfL5/gB3
         WlCQ==
X-Gm-Message-State: ACrzQf0nJgJTJZcC9xG596ItQI4KvMWa3SRCU+fp0OTH5PVQIddeNF4r
        XaxUOU0f/g2HlLsvGvTgt/XQLm/AkqiheAqdw5d0/w==
X-Google-Smtp-Source: AMsMyM7OdFTCvObzHdX2QBh5BWGaW45znf9Cv6Q61K1zgeYyKnJXvVqLrixqgkpUSALdmhS8jNK3eRbjQG02opyXNao=
X-Received: by 2002:a05:6602:3983:b0:6d2:da4f:929f with SMTP id
 bw3-20020a056602398300b006d2da4f929fmr709403iob.29.1667879779233; Mon, 07 Nov
 2022 19:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20221024091354.2253669-1-tweek@google.com> <CAP+JOzS-H8qL3PU_N0-4ZViXNd1RQdBYM4qprdhxZ2sMu818-g@mail.gmail.com>
 <CAJ2a_DecgGVC4Z3bJuXndtN5Fd7nhPMdVVX9wbQ1PVJzm3iakQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DecgGVC4Z3bJuXndtN5Fd7nhPMdVVX9wbQ1PVJzm3iakQ@mail.gmail.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Tue, 8 Nov 2022 14:56:03 +1100
Message-ID: <CA+zpnLcixWDYJ9=jUhHBJ4Ca3nhagLYe74JnDKvwpUzyCiQTPg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: ignore invalid class name lookup
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 5, 2022 at 8:21 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Fri, 4 Nov 2022 at 22:03, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Mon, Oct 24, 2022 at 5:14 AM Thi=C3=A9baud Weksteen <tweek@google.co=
m> wrote:
> > >
> > > selinux_check_access relies on string_to_security_class to resolve th=
e
> > > class index from its char* argument. There is no input validation don=
e
> > > on the string provided. It is possible to supply an argument containi=
ng
> > > trailing backslashes (i.e., "sock_file//////") so that the paths buil=
t
>
> Two other interfaces might also be affected by path traversing inputs:
>
> - getseuser(3) via the username parameter
> - bool_open(), called by security_get_boolean_pending(3),
> security_get_boolean_active(3) and security_set_boolean(3) , via the
> name parameter
>
> >
> > I am having trouble reproducing this. Using backslashes causes an
> > error when looking up the "%s/class/%s/index" path.
> > Using forward slashes just works. Valgrind does not report any memory
> > leaks in either case and I don't see the same permission file being
> > referenced multiple times.

Apologies, it should read "forward slashes" and not "backward
slashes". The exact argument is "sock_file" followed by 4051 forward
slashes. With that length, the index file and perms directory will
open successfully (both paths are 4089 bytes long, assuming
/sys/fs/selinux for selinuxfs). When reading the watch_with_perm
entry, the "_with_perm" will be dropped and the "watch" permission
will be read instead (the "_" character is the 4096th byte). On
Android, PATH_MAX is 4096.

This was found by our fuzzer for the selinux_check_access function [1].

Thanks

[1] https://cs.android.com/android/platform/superproject/+/master:external/=
selinux/libselinux/fuzzers/selinux_check_access_fuzzer.cpp

> >
> > I don't think that we need the regex solution.
> >
> > Thanks,
> > Jim
> >
> >
> > > in discover_class get truncated. The processing will then reference t=
he
> > > same permission file multiple time (e.g., perms/watch_reads will be
> > > truncated to perms/watch). This will leak the memory allocated when
> > > strdup'ing the permission name. The discover_class_cache will end up =
in
> > > an invalid state (but not corrupted).
> > >
> > > Ensure that the class provided does not contain any path separator.
> > >
> > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > ---
> > >  libselinux/src/stringrep.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> > > index 2fe69f43..592410e5 100644
> > > --- a/libselinux/src/stringrep.c
> > > +++ b/libselinux/src/stringrep.c
> > > @@ -63,6 +63,9 @@ static struct discover_class_node * discover_class(=
const char *s)
> > >                 return NULL;
> > >         }
> > >
> > > +       if (strchr(s, '/') !=3D NULL)
> > > +               return NULL;
> > > +
> > >         /* allocate a node */
> > >         node =3D malloc(sizeof(struct discover_class_node));
> > >         if (node =3D=3D NULL)
> > > --
> > > 2.38.0.135.g90850a2211-goog
> > >
