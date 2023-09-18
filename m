Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C1FCD13CF
	for <selinux@archiver.kernel.org>; Mon, 18 Sep 2023 00:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjIRANg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Sep 2023 20:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjIRANH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Sep 2023 20:13:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B585FE
        for <selinux@vger.kernel.org>; Sun, 17 Sep 2023 17:13:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ada6b0649fso521941966b.1
        for <selinux@vger.kernel.org>; Sun, 17 Sep 2023 17:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694995980; x=1695600780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BksuZLSA9RvI5bI4RvQ81tLyBXcqdxkDIj/HjHGUGWU=;
        b=DyirsJM5wkX5Gu3wHAYMOebEFfhoVlnY2Dqen93ZpLKKQ3mhXWQ+dcbbWqpL61J59i
         fsb+17FqCYTgrXPPnHN5L8kmfScftKZtx0J8qMAG8yj8uEY8qzaBuRwlrVA7wM+gWeKo
         UQEf+WObKUAv8fF7ObLCY9AUZgL3YRJ6HRLTo34uHIPN3vfZalIXUZFCVl6GeBsKG1l5
         oyIjHB2AcPSkMBewNzwYNRn6anq3vjuzcRk8875gY9iO5lOHF5/vNofbhCnZmnsLVLQ9
         mItOFFwDtahRPxAwaWCzUm3QDRAnTZEWzeyLgNzcrrSHSV1UFWc0GgPcho+NSp0h0WOh
         KTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694995980; x=1695600780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BksuZLSA9RvI5bI4RvQ81tLyBXcqdxkDIj/HjHGUGWU=;
        b=Yk7UB4HaTC9HFiAgbFe39b3jCsi3Z/x2znOgfspf46Ip10NDngjPXYl6lmdWNgVuLS
         DdF9qAWuXBfFbEheK6mMVO3dKnSnupU6qQsuraLQp5huyQdy+JdwEB7i/Iwg31+DDBn0
         LejKaWwtet89Z/J4hoHce0jdeNdClLaltngJ16sllxMqq6iB45EtlKDuC1IgyTUxFwmc
         3GdZZFTTFLl4TwS7rRyAxZMzO6UKcAkikWcxi8JCWfgtcRG1ILXPafYTRpYcEKvlSrZe
         PsZjWhKNClW1JeCKEyKF+UdGmW+eCnH0fYOpIosSA0lAzfY0cVElXCujbhr/Z4SDYsnF
         MtCA==
X-Gm-Message-State: AOJu0YxmrPgNhqobw/6diiss+ZwF4r72qeNnQnzd19Toga2wlu27JSy/
        0Kww3p8rrXe0Cuu6laPAFJ1etNhR5gdItKu1bMg=
X-Google-Smtp-Source: AGHT+IGkBWpw/6AEdnk260Ak3c5m5gmhP6FSZRHw7d1zzrSfeRU4vmerja+jG9G2aA0Ej2hL1tQ8UeCpwblQcpAaZoo=
X-Received: by 2002:a17:906:5a47:b0:9a5:d16b:6631 with SMTP id
 my7-20020a1709065a4700b009a5d16b6631mr6117878ejc.70.1694995979470; Sun, 17
 Sep 2023 17:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230906154611.31762-2-jsatterfield.linux@gmail.com>
 <e55fa937809c138e4b474c8ed55d2fdc.paul@paul-moore.com> <CALMFces6EfJLJXpi9JO-rFa-s1CZiayERgGW7ggzN1MJmF275w@mail.gmail.com>
 <CAHC9VhSwCcPaBEx0xRip5MMfFnnfanc4Oi437Mg_hm9Ahzk9xQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSwCcPaBEx0xRip5MMfFnnfanc4Oi437Mg_hm9Ahzk9xQ@mail.gmail.com>
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
Date:   Mon, 18 Sep 2023 00:12:54 +0000
Message-ID: <CALMFcetv8fweng6kU_7TJKRGyNzfF0mWBnbEE53mvi+CNkCiWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: use arrays for avtab hashtable nodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Yes, it does. I will post a new patch set next week.

Thanks for reviewing.

On Fri, Sep 15, 2023 at 1:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Sep 14, 2023 at 5:57=E2=80=AFPM Jacob Satterfield
> <jsatterfield.linux@gmail.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 11:23=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > On Sep  6, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrot=
e:
> > > >
> > > > The current avtab hashtable employs a separate chaining collision
> > > > resolution strategy where each bucket/chain holds an ordered linked=
 list
> > > > of pointers to kmem_cache allocated avtab_node elements.
> > > >
> > > > On Fedora 38 (x86_64) using the default policy, avtab_node_cachep
> > > > uses 573 slabs each containing 170 objects totaling 2,337,840 bytes=
.
> > > > A call to kmem_cache_zalloc() is required for every single rule, wh=
ich
> > > > in the default policy is currently 96,730 and continually rising.
> > > >
> > > > When both sets of avtab_node (regular and cond.) are turned into ar=
rays
> > > > with the hash table slot indexing into it rather than a pointer, th=
en
> > > > this results in only 2 additional kvcalloc() calls and the complete
> > > > removal of the kmem_cache itself.
> > > >
> > > > The caching characteristics of iterating a single array are better =
due
> > > > to locality of reference. Running "perf stat -r 100 -d load_policy"
> > > > has shown a runtime reduction of at least 10% on a Fedora 38 x86_64=
 VM
> > > > with this single patch. Future patches focused on improving the has=
h
> > > > table's collision resolution strategy and array layout (struct-of-a=
rrays
> > > > vs. array-of-structs) may elicit even more caching and therefore ru=
ntime
> > > > performance improvements.
> > > >
> > > > On 64-bit machines, the memory usage of the hash table slots is cut=
 in
> > > > half due to the use of u32 indices instead of memory pointers. Sinc=
e
> > > > ~65k hash slots are used between the regular and cond. tables with =
the
> > > > default Fedora 38 policy, this equates to around 256KB of memory sa=
ved.
> > > >
> > > > Notes:
> > > >
> > > > A couple helper functions avtab_get_chain() and avtab_get_node() ar=
e
> > > > introduced to provide more standardized interfaces for use in funct=
ions
> > > > that need to search through the hash table.
> > > >
> > > > NULL_NODE_IDX defines a sentinel value which helps determinine if a=
 spot
> > > > in the hash table or the "next" member of an avtab_node are valid.
> > > >
> > > > This patch causes the cond. rules table to waste memory as the size
> > > > requested for the kvcalloc() is the size of the regular rules table=
.
> > > > These tables rarely, if ever, have the same number of rules in prac=
tice.
> > > > The next patch addresses this shortcoming.
> > >
> > > Isn't the more important issue that of there being more conditional
> > > rules than regular rules?  Yes, I'm sure this is very unlikely, but
> > > given just this patch wouldn't this cause a problem?
> > >
> > > It is important to remember that even when combined in a patchset,
> > > any given patch should not break the system.  A patch can depend on
> > > prior patches in the patchset, but not upcoming patches.
> > >
> > > I've only looked very briefly at patch 2/3, but I suspect at the very
> > > least you may need to squash patches 1/3 and 2/3 to ensure there is
> > > no breakage.
> > >
> > > More comments below (all are in the context of patch 1/3, some may no=
t
> > > be relevant in the context of 1/3+2/3).
> >
> > I will squash the two in the next version.
> >
> > > > Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> > > > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > >  security/selinux/ss/avtab.c       | 75 +++++++++++++++------------=
----
> > > >  security/selinux/ss/avtab.h       | 28 ++++++++++--
> > > >  security/selinux/ss/conditional.c | 13 +++---
> > > >  security/selinux/ss/services.c    | 20 +++++----
> > > >  4 files changed, 81 insertions(+), 55 deletions(-)
>
> ...
>                                               0, SLAB_PANIC, NULL);
> > > > diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avta=
b.h
> > > > index 3c3904bf02b0..72708aed5fff 100644
> > > > --- a/security/selinux/ss/avtab.h
> > > > +++ b/security/selinux/ss/avtab.h
> > > > @@ -77,16 +77,38 @@ struct avtab_datum {
> > > >  struct avtab_node {
> > > >       struct avtab_key key;
> > > >       struct avtab_datum datum;
> > > > -     struct avtab_node *next;
> > > > +     u32 next;
> > >
> > > Given that one of the common avtab lookup operations is to simply wal=
k
> > > the list, using the next field, why not keep the next field as a
> > > pointer?  Sure, you loose the 64-bit to 32-bit size reduction on 64-b=
it
> > > systems (although I wonder if alignment issues rendered that moot), b=
ut
> > > I would expect the walk to be quicker if you only needed to do a sing=
le
> > > next pointer lookup as opposed to the array indexing.
> > >
> > > I may be missing something, but I believe this would also remove the
> > > need for the NULL_NODE_IDX sentinel.
> > >
> >
> > The conditional avtab is the reason an index was used instead of a
> > pointer. Because it doesn't have the right hint when allocating the
> > nodes array, we have to copy the nodes array into a smaller buffer
> > after reading the rules (otherwise we waste about 1.7 MB of memory).
> > The copy invalidates the pointers that each "next" refers to as they
> > would be pointing to free'd memory instead of the new nodes array.
> > However, I agree that the walk would be quicker with the direct
> > pointer reference instead of the array index and with the way the
> > struct alignment works, the index here doesn't save memory.
> >
> > An alternative I have prototyped is to use pointer math to calculate
> > an offset from the original nodes array to where "next" is pointing to
> > and add it from the new array to calculate the new "next" value. This
> > changes "next" back to a pointer and gets rid of the indirection.
> >
> > I agree that the NULL_NODE_IDX sentinel is not very ergonomic, however
> > it's at the cost of 256 KB of memory in relation to the htable slots.
> > Mainly due to the difficulty of telling when a slot is empty with an
> > index vs. a pointer. I could leave the htable slots as indexes, but it
> > would still require some form of sentinel value to indicate the
> > emptiness of a slot. What would you prefer?
>
> In addition to other changes we've discussed, it looks like squashing
> 1/3 and 2/3 is going to change things quite a bit, so I'm going to
> suggest you make the changes you're planning to make, including
> squashing the two patches, and repost.  We can re-review the new
> revision and pick up the discussion from there.
>
> Does that sound okay?
>
> --
> paul-moore.com
