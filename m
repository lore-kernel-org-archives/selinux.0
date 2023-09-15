Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B47EEAA7E
	for <selinux@archiver.kernel.org>; Fri, 15 Sep 2023 01:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjIOBKn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Sep 2023 21:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIOBKm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Sep 2023 21:10:42 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924D6E69
        for <selinux@vger.kernel.org>; Thu, 14 Sep 2023 18:10:38 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59bf1dde73fso12907337b3.3
        for <selinux@vger.kernel.org>; Thu, 14 Sep 2023 18:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694740238; x=1695345038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0gO3tloIHM27w5gesTjQt93WZ7csSLyjzUuPMxIYiY=;
        b=eqKL1B/EyDGw0JnSpkLXedXp6F/RvTPUXUkj7IQ3EDHFgO4XGlReGwGdkpep24yc8P
         iNt4TCZxFlnJl/GuL2eOwzCbUD8oUu4i8D4qVkgjEMCrr6MwLdT+PH4f5V3IcNJOFW9V
         lRe4q6Zaoz3ss8nusnKkBF4U12+n2iULTNm9SWbY0YqRbrqb7os0mUjFFrLhA6xG01ci
         xOLh7tQGIIm2g5KxkRZeHCAluCaSKfN/qDgJwbETPPULjgqoEjQwhLgcUgSeDKxjePxh
         u++6UDc/6WbM/9YBw+S+Dx3YPJM9rDVQuHnhkDgol0Nmjj5w4s3HgcijL61oo5MISXa8
         oi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694740238; x=1695345038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0gO3tloIHM27w5gesTjQt93WZ7csSLyjzUuPMxIYiY=;
        b=sW31OhHCJg+UVqwt1M8RFjsyLtlNk5JZDJ9kWOqIlVXwCXVA9Fv0YGs6J1tpU/0OXR
         OhzkS8VqPiVUhU1sYf/u0gs93J18t5ybOHWSvT1jHk5eMeNq2efnzkpXY2qSUtZnVx7y
         ope1ED3PXsdCsT927ZdMK08hpeqiKvsfubyeTJ0n7l1JL12cfuE9tmh7PUsqBPqI7UGa
         gLDs3Q2ZhS3dioNXaJSUjX2SixzNzOeiHnaBBtLg7EvkRCxSYGcA3iJ9KUlBeDlOxr4V
         qUJQkfBeeE/mQiWswiEpvfMfO98EFsTRLIBDLIimZ/zIj4HVe9M1ZTn/3PaVl+rRNPkV
         dcig==
X-Gm-Message-State: AOJu0YzoWvPosvz0d3aaL2fftumUTRT+vBHOQk+Ha+Z7y4jePTrv4E5V
        hH+T8H/Wb2DeRWuL8IauBeEGqWHxjUags9vFHc7H
X-Google-Smtp-Source: AGHT+IEjvMHTdI2xkBWxBKS4NgCCWkG2MnRQqXqmb6cKJmgteKTVwMPqxhDc/75zofnD0kp2wXrYBjHPRiI1hkAdDfg=
X-Received: by 2002:a0d:efc6:0:b0:595:be7:a38 with SMTP id y189-20020a0defc6000000b005950be70a38mr282431ywe.49.1694740237729;
 Thu, 14 Sep 2023 18:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230906154611.31762-2-jsatterfield.linux@gmail.com>
 <e55fa937809c138e4b474c8ed55d2fdc.paul@paul-moore.com> <CALMFces6EfJLJXpi9JO-rFa-s1CZiayERgGW7ggzN1MJmF275w@mail.gmail.com>
In-Reply-To: <CALMFces6EfJLJXpi9JO-rFa-s1CZiayERgGW7ggzN1MJmF275w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Sep 2023 21:10:26 -0400
Message-ID: <CAHC9VhSwCcPaBEx0xRip5MMfFnnfanc4Oi437Mg_hm9Ahzk9xQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: use arrays for avtab hashtable nodes
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 14, 2023 at 5:57=E2=80=AFPM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> On Tue, Sep 12, 2023 at 11:23=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Sep  6, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> > >
> > > The current avtab hashtable employs a separate chaining collision
> > > resolution strategy where each bucket/chain holds an ordered linked l=
ist
> > > of pointers to kmem_cache allocated avtab_node elements.
> > >
> > > On Fedora 38 (x86_64) using the default policy, avtab_node_cachep
> > > uses 573 slabs each containing 170 objects totaling 2,337,840 bytes.
> > > A call to kmem_cache_zalloc() is required for every single rule, whic=
h
> > > in the default policy is currently 96,730 and continually rising.
> > >
> > > When both sets of avtab_node (regular and cond.) are turned into arra=
ys
> > > with the hash table slot indexing into it rather than a pointer, then
> > > this results in only 2 additional kvcalloc() calls and the complete
> > > removal of the kmem_cache itself.
> > >
> > > The caching characteristics of iterating a single array are better du=
e
> > > to locality of reference. Running "perf stat -r 100 -d load_policy"
> > > has shown a runtime reduction of at least 10% on a Fedora 38 x86_64 V=
M
> > > with this single patch. Future patches focused on improving the hash
> > > table's collision resolution strategy and array layout (struct-of-arr=
ays
> > > vs. array-of-structs) may elicit even more caching and therefore runt=
ime
> > > performance improvements.
> > >
> > > On 64-bit machines, the memory usage of the hash table slots is cut i=
n
> > > half due to the use of u32 indices instead of memory pointers. Since
> > > ~65k hash slots are used between the regular and cond. tables with th=
e
> > > default Fedora 38 policy, this equates to around 256KB of memory save=
d.
> > >
> > > Notes:
> > >
> > > A couple helper functions avtab_get_chain() and avtab_get_node() are
> > > introduced to provide more standardized interfaces for use in functio=
ns
> > > that need to search through the hash table.
> > >
> > > NULL_NODE_IDX defines a sentinel value which helps determinine if a s=
pot
> > > in the hash table or the "next" member of an avtab_node are valid.
> > >
> > > This patch causes the cond. rules table to waste memory as the size
> > > requested for the kvcalloc() is the size of the regular rules table.
> > > These tables rarely, if ever, have the same number of rules in practi=
ce.
> > > The next patch addresses this shortcoming.
> >
> > Isn't the more important issue that of there being more conditional
> > rules than regular rules?  Yes, I'm sure this is very unlikely, but
> > given just this patch wouldn't this cause a problem?
> >
> > It is important to remember that even when combined in a patchset,
> > any given patch should not break the system.  A patch can depend on
> > prior patches in the patchset, but not upcoming patches.
> >
> > I've only looked very briefly at patch 2/3, but I suspect at the very
> > least you may need to squash patches 1/3 and 2/3 to ensure there is
> > no breakage.
> >
> > More comments below (all are in the context of patch 1/3, some may not
> > be relevant in the context of 1/3+2/3).
>
> I will squash the two in the next version.
>
> > > Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> > > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  security/selinux/ss/avtab.c       | 75 +++++++++++++++--------------=
--
> > >  security/selinux/ss/avtab.h       | 28 ++++++++++--
> > >  security/selinux/ss/conditional.c | 13 +++---
> > >  security/selinux/ss/services.c    | 20 +++++----
> > >  4 files changed, 81 insertions(+), 55 deletions(-)

...
                                              0, SLAB_PANIC, NULL);
> > > diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.=
h
> > > index 3c3904bf02b0..72708aed5fff 100644
> > > --- a/security/selinux/ss/avtab.h
> > > +++ b/security/selinux/ss/avtab.h
> > > @@ -77,16 +77,38 @@ struct avtab_datum {
> > >  struct avtab_node {
> > >       struct avtab_key key;
> > >       struct avtab_datum datum;
> > > -     struct avtab_node *next;
> > > +     u32 next;
> >
> > Given that one of the common avtab lookup operations is to simply walk
> > the list, using the next field, why not keep the next field as a
> > pointer?  Sure, you loose the 64-bit to 32-bit size reduction on 64-bit
> > systems (although I wonder if alignment issues rendered that moot), but
> > I would expect the walk to be quicker if you only needed to do a single
> > next pointer lookup as opposed to the array indexing.
> >
> > I may be missing something, but I believe this would also remove the
> > need for the NULL_NODE_IDX sentinel.
> >
>
> The conditional avtab is the reason an index was used instead of a
> pointer. Because it doesn't have the right hint when allocating the
> nodes array, we have to copy the nodes array into a smaller buffer
> after reading the rules (otherwise we waste about 1.7 MB of memory).
> The copy invalidates the pointers that each "next" refers to as they
> would be pointing to free'd memory instead of the new nodes array.
> However, I agree that the walk would be quicker with the direct
> pointer reference instead of the array index and with the way the
> struct alignment works, the index here doesn't save memory.
>
> An alternative I have prototyped is to use pointer math to calculate
> an offset from the original nodes array to where "next" is pointing to
> and add it from the new array to calculate the new "next" value. This
> changes "next" back to a pointer and gets rid of the indirection.
>
> I agree that the NULL_NODE_IDX sentinel is not very ergonomic, however
> it's at the cost of 256 KB of memory in relation to the htable slots.
> Mainly due to the difficulty of telling when a slot is empty with an
> index vs. a pointer. I could leave the htable slots as indexes, but it
> would still require some form of sentinel value to indicate the
> emptiness of a slot. What would you prefer?

In addition to other changes we've discussed, it looks like squashing
1/3 and 2/3 is going to change things quite a bit, so I'm going to
suggest you make the changes you're planning to make, including
squashing the two patches, and repost.  We can re-review the new
revision and pick up the discussion from there.

Does that sound okay?

--=20
paul-moore.com
