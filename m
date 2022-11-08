Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE780C4332F
	for <selinux@archiver.kernel.org>; Tue,  8 Nov 2022 19:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKHTOa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKHTOa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Nov 2022 14:14:30 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9836E1CFDB
        for <selinux@vger.kernel.org>; Tue,  8 Nov 2022 11:14:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b9so22553341ljr.5
        for <selinux@vger.kernel.org>; Tue, 08 Nov 2022 11:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUL7BFMKtZbloqvtE+xmPMhgfQM9hOL1xlBNOC17uKo=;
        b=VY4nA4ze/8UcBNW54QJ9uVJlf7+sPmkJOAm2sQMWLiP/ahFHkMghQW2RxVz/yoTuUB
         O+tdn3hTVkgJFCBPAZUI2Aaq4xZDzErCwKyzz0aFzzaBrBSJ+ey01IKKa4Fj5OEtNLLT
         YG63mEdYxZIG6eoeDtHcStxhzStfqToqnjXsrktwyN/MOSsfINaR/HhboeOlWz3tcdL9
         upDwfwEWjN+fM9ommF0pvQqMPd5tWok2WlCknNN97huntjHaND46HuvrA6h7ePFlT3pW
         Lm/o93AujKHvRjnqItmJGHgLfdWTdgHxZt2eTVqobJ48SZuEQoiyWMxA+pg2UhPaEMc0
         51RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUL7BFMKtZbloqvtE+xmPMhgfQM9hOL1xlBNOC17uKo=;
        b=jSDt+qp3gKj4jPvPJpbE1OwCx5K/Ss0NRLMLDHBVPuShEn6KKcfs+ovzxdcBvBcdvM
         Hfhl2XoLb0KKKjPkib8o487IbrHINPGyCuiUS5exyuiFmgorKiYZM4DObTflTw41RjZ0
         HfhO7QVzrlgAaBAUcxNtgO2i56BJTm7uaGe1zbNGoepsMIGjs/ajtePCJsbLynPSIki/
         tULUXMu48H50HSoKd/0uUFSGl6e2z+BY7RNv7Khb4dB/XvhaYb4e5+8XTNdfDdbW8tuB
         v565bBhlSrdNHTf9v1wxVM6r3FwekQihskQhI412RWbBXLXd1GVhob6v4Zx905EKxuQc
         Jd+w==
X-Gm-Message-State: ACrzQf00mMFAk0tnVSJzxa9Aqos27T5gICppajE5AXO726TxPzG9Telv
        AkuGly1Zea+rJ+elAuB9l/7wsRd1Zjl0521o1mw=
X-Google-Smtp-Source: AMsMyM4gaLo7tXJ302fWrWcNCLPNhssFl4BYTHsNbb9ETBbcYauOjkh/NHA46JRjO+JTi9chTVccJEQECm05+a4Hh1A=
X-Received: by 2002:a2e:904b:0:b0:277:a9d:9355 with SMTP id
 n11-20020a2e904b000000b002770a9d9355mr6690596ljg.102.1667934866833; Tue, 08
 Nov 2022 11:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20221024091354.2253669-1-tweek@google.com> <CAP+JOzS-H8qL3PU_N0-4ZViXNd1RQdBYM4qprdhxZ2sMu818-g@mail.gmail.com>
 <CAJ2a_DecgGVC4Z3bJuXndtN5Fd7nhPMdVVX9wbQ1PVJzm3iakQ@mail.gmail.com> <CA+zpnLcixWDYJ9=jUhHBJ4Ca3nhagLYe74JnDKvwpUzyCiQTPg@mail.gmail.com>
In-Reply-To: <CA+zpnLcixWDYJ9=jUhHBJ4Ca3nhagLYe74JnDKvwpUzyCiQTPg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 8 Nov 2022 14:14:15 -0500
Message-ID: <CAP+JOzR50YZ+C_L4k-ng0Cj4i-xhO+1zk=6NhSFRMyLAt=ehcw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: ignore invalid class name lookup
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 7, 2022 at 10:56 PM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>
> On Sat, Nov 5, 2022 at 8:21 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Fri, 4 Nov 2022 at 22:03, James Carter <jwcart2@gmail.com> wrote:
> > >
> > > On Mon, Oct 24, 2022 at 5:14 AM Thi=C3=A9baud Weksteen <tweek@google.=
com> wrote:
> > > >
> > > > selinux_check_access relies on string_to_security_class to resolve =
the
> > > > class index from its char* argument. There is no input validation d=
one
> > > > on the string provided. It is possible to supply an argument contai=
ning
> > > > trailing backslashes (i.e., "sock_file//////") so that the paths bu=
ilt
> >
> > Two other interfaces might also be affected by path traversing inputs:
> >
> > - getseuser(3) via the username parameter
> > - bool_open(), called by security_get_boolean_pending(3),
> > security_get_boolean_active(3) and security_set_boolean(3) , via the
> > name parameter
> >
> > >
> > > I am having trouble reproducing this. Using backslashes causes an
> > > error when looking up the "%s/class/%s/index" path.
> > > Using forward slashes just works. Valgrind does not report any memory
> > > leaks in either case and I don't see the same permission file being
> > > referenced multiple times.
>
> Apologies, it should read "forward slashes" and not "backward
> slashes". The exact argument is "sock_file" followed by 4051 forward
> slashes. With that length, the index file and perms directory will
> open successfully (both paths are 4089 bytes long, assuming
> /sys/fs/selinux for selinuxfs). When reading the watch_with_perm
> entry, the "_with_perm" will be dropped and the "watch" permission
> will be read instead (the "_" character is the 4096th byte). On
> Android, PATH_MAX is 4096.
>
> This was found by our fuzzer for the selinux_check_access function [1].
>
> Thanks
>
> [1] https://cs.android.com/android/platform/superproject/+/master:externa=
l/selinux/libselinux/fuzzers/selinux_check_access_fuzzer.cpp
>

Thanks for the clarification.
Jim

> > >
> > > I don't think that we need the regex solution.
> > >
> > > Thanks,
> > > Jim
> > >
> > >
> > > > in discover_class get truncated. The processing will then reference=
 the
> > > > same permission file multiple time (e.g., perms/watch_reads will be
> > > > truncated to perms/watch). This will leak the memory allocated when
> > > > strdup'ing the permission name. The discover_class_cache will end u=
p in
> > > > an invalid state (but not corrupted).
> > > >
> > > > Ensure that the class provided does not contain any path separator.
> > > >
> > > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > > ---
> > > >  libselinux/src/stringrep.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.=
c
> > > > index 2fe69f43..592410e5 100644
> > > > --- a/libselinux/src/stringrep.c
> > > > +++ b/libselinux/src/stringrep.c
> > > > @@ -63,6 +63,9 @@ static struct discover_class_node * discover_clas=
s(const char *s)
> > > >                 return NULL;
> > > >         }
> > > >
> > > > +       if (strchr(s, '/') !=3D NULL)
> > > > +               return NULL;
> > > > +
> > > >         /* allocate a node */
> > > >         node =3D malloc(sizeof(struct discover_class_node));
> > > >         if (node =3D=3D NULL)
> > > > --
> > > > 2.38.0.135.g90850a2211-goog
> > > >
