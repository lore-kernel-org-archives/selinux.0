Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEB3C4332F
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 21:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiKDVVb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKDVVa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 17:21:30 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4776250
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 14:21:29 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id e2so3179471vkd.13
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzo50sThJiifo+R80iYaku9FTSB2HvpwFknY+F0Nvd0=;
        b=kIA/JPNPawl6zXTu00IJydNEdUdMaN8Jz46ABfewLEZPNZ9rAi0L3hrJjerOpGN5+9
         4xXma1UBBQY6bLYNlZmK5gRIn79xHF7lob3CdmEpb9b5dBRjIpCzvFKPEs/2Ma3FNTWv
         KPTVnEgB1YCM99QvfyKwTVkKT9O/oxrgniKjQ4mwSYkZt+/HuAqgfQP3tm8/4T+btJb9
         /ZHWqWErzB4wH/9PxH6/YrEfMoj4ugTPKM/tUYHvkOUHmkTiBTcSQO266QfoNVaimWQN
         q3uesGq2qZSbVJq6nC7hRGieI3Cl1r5OHqQAYJ+aZ0HyK3Kjv0fuf5T/mDrvqR6N6Ib+
         AFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nzo50sThJiifo+R80iYaku9FTSB2HvpwFknY+F0Nvd0=;
        b=z5u2teN80HXqvhl/us7eKW3hI7d0ufAhbQa5GYD1hxmX5DsOGeO9cMCAmzo2GctDky
         /npqukx3bHDib/3ZhLy3cT6ne/7ufx/M9DEHV+WAfcG6INhAKweovX3HgPbqHOVHLIme
         X8zwgyw8UO+1geEUW2QQeWU0P2EXsNklO+2b86ZKTLiRF84UjvbMSO8wcOIbH5wPzOQ1
         19RfbT40w5nS2DnAUNcMoGILdnCjZ3pQ8d79R1RIJSktkkXRT+hEq/TvcplHoBvtY19/
         ar2WVOs6nWPdohe5Zc2acgX+0bzoK2kS0Zwgo3elX70gIEDRJSxM18lk5q88Fca2JRnQ
         QLOg==
X-Gm-Message-State: ACrzQf0mbpqtR/LDNQ1QV5eh9fMCsVXsWao/Sw9jRTi5SfAfDxXvT/qp
        kLA+SmZ5giZEuM7C/g/G1NlbnuDnMz5L6celS0Y=
X-Google-Smtp-Source: AMsMyM5pzti5cAb2BCyJYrnqnAdjV45BuPWJTVtypFrt2UmsByR6uQPJGeOwWyx4c3eE6C2wNWsTlQkvg7y9dMHQ3f4=
X-Received: by 2002:a1f:9c08:0:b0:3b7:6a89:4530 with SMTP id
 f8-20020a1f9c08000000b003b76a894530mr4598534vke.37.1667596888308; Fri, 04 Nov
 2022 14:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221024091354.2253669-1-tweek@google.com> <CAP+JOzS-H8qL3PU_N0-4ZViXNd1RQdBYM4qprdhxZ2sMu818-g@mail.gmail.com>
In-Reply-To: <CAP+JOzS-H8qL3PU_N0-4ZViXNd1RQdBYM4qprdhxZ2sMu818-g@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 4 Nov 2022 22:21:17 +0100
Message-ID: <CAJ2a_DecgGVC4Z3bJuXndtN5Fd7nhPMdVVX9wbQ1PVJzm3iakQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: ignore invalid class name lookup
To:     James Carter <jwcart2@gmail.com>
Cc:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 4 Nov 2022 at 22:03, James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Oct 24, 2022 at 5:14 AM Thi=C3=A9baud Weksteen <tweek@google.com>=
 wrote:
> >
> > selinux_check_access relies on string_to_security_class to resolve the
> > class index from its char* argument. There is no input validation done
> > on the string provided. It is possible to supply an argument containing
> > trailing backslashes (i.e., "sock_file//////") so that the paths built

Two other interfaces might also be affected by path traversing inputs:

- getseuser(3) via the username parameter
- bool_open(), called by security_get_boolean_pending(3),
security_get_boolean_active(3) and security_set_boolean(3) , via the
name parameter

>
> I am having trouble reproducing this. Using backslashes causes an
> error when looking up the "%s/class/%s/index" path.
> Using forward slashes just works. Valgrind does not report any memory
> leaks in either case and I don't see the same permission file being
> referenced multiple times.
>
> I don't think that we need the regex solution.
>
> Thanks,
> Jim
>
>
> > in discover_class get truncated. The processing will then reference the
> > same permission file multiple time (e.g., perms/watch_reads will be
> > truncated to perms/watch). This will leak the memory allocated when
> > strdup'ing the permission name. The discover_class_cache will end up in
> > an invalid state (but not corrupted).
> >
> > Ensure that the class provided does not contain any path separator.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> >  libselinux/src/stringrep.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> > index 2fe69f43..592410e5 100644
> > --- a/libselinux/src/stringrep.c
> > +++ b/libselinux/src/stringrep.c
> > @@ -63,6 +63,9 @@ static struct discover_class_node * discover_class(co=
nst char *s)
> >                 return NULL;
> >         }
> >
> > +       if (strchr(s, '/') !=3D NULL)
> > +               return NULL;
> > +
> >         /* allocate a node */
> >         node =3D malloc(sizeof(struct discover_class_node));
> >         if (node =3D=3D NULL)
> > --
> > 2.38.0.135.g90850a2211-goog
> >
