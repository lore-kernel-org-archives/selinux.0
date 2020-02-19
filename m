Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5388C34047
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4972064C
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 09:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfO0haJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgBSJal (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:30:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20515 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726210AbgBSJal (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 04:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582104639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FScEyXyL/Mzhvf6JPZh8jINtf5zNF4gyjoCcgARbt+0=;
        b=RfO0haJD471YiZNy5k4lRtZsTQPFmJH5kAvCH//1/38eOBC8RjLOREDvp9OTWSV/yMDgbY
        PVuXpRuUo4CKj0o2Dfn21RBBwckqunj6q7UvujHXHITnP27MCGivzADQHMhx+GKQCbA6Pn
        X27Qv4HadlXKqHxOiOOQ4U7Lu5IzYrU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-EK7w3rlONF2Jyo9FflKiDA-1; Wed, 19 Feb 2020 04:30:37 -0500
X-MC-Unique: EK7w3rlONF2Jyo9FflKiDA-1
Received: by mail-ot1-f71.google.com with SMTP id w17so14097003otp.13
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 01:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FScEyXyL/Mzhvf6JPZh8jINtf5zNF4gyjoCcgARbt+0=;
        b=lAtHrFCsIgqDFvysbi7hbs4I1Afs8EfOnY+4L9ZrwtNc56O7+gGqwLNH7/rxutzvd+
         7I2V8U8m700e6XzNdBWpEM0ac14nZWqRH7+E2M12vAAHDCWn4r/R3WTZcY2+dDuSsp0K
         nFiWGJoNM/Wk5OOy6ypebgGxyf+Cuw1YamIiEYw3WuRrOUB0b+F0xuot99XS6Tw7ic9u
         cAK19RGVCY4xG5BNUvV3bwSrCWG2emq+eTYlGegif96pS8xYPhbmog3ZQ1+va5rl5yJT
         PTXTVc598T0Q9qULAli02oBe2MzpvK7bCZ6ZdoM4wsTP6aaUX/Jw9PsQ2X6w9Q3XpmQb
         HM0g==
X-Gm-Message-State: APjAAAUOhVcxjNO/OxkDE4DkZAAYYEMGtq9UtQBBw5JUEHX1vhVz74zp
        IeeXeJvCx1KHZGYAuS+EuX4v24j4r9epxbIuIpITK9nXJkGwBwZGmjLKsAPmXVkoXm3gfx6SgbJ
        6vzH08QIFZCKRLV6xQMMbbBs22BvPp2REOQ==
X-Received: by 2002:aca:cd46:: with SMTP id d67mr4047074oig.156.1582104637057;
        Wed, 19 Feb 2020 01:30:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXlh/y7VOLVAtGBNtTmjo7zDJNVGfT3ezWEn4qrCQiWDPmw9EcQPBlLxy3QH5+T95slPsQPRxlgU8qoBY4OMw=
X-Received: by 2002:aca:cd46:: with SMTP id d67mr4047070oig.156.1582104636773;
 Wed, 19 Feb 2020 01:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20200217114943.67607-1-omosnace@redhat.com> <072c5073-3810-e2fd-ee54-fe8a5dc163df@tycho.nsa.gov>
 <CAFqZXNsm8TPp=60CLu6u2NH4oFBioXb_y1mLnVxvuWa=S9Qzfg@mail.gmail.com>
 <01b21144-1958-462f-b91b-e2d85a905e2e@tycho.nsa.gov> <9997ff23-c86a-51b6-8539-98a4c85edbde@tycho.nsa.gov>
In-Reply-To: <9997ff23-c86a-51b6-8539-98a4c85edbde@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Feb 2020 10:30:25 +0100
Message-ID: <CAFqZXNsJ-KvpYpPSk3dZwgB5V1qjW4K8fySYEommm1yq-Yp7hw@mail.gmail.com>
Subject: Re: [PATCH] selinux: reduce the use of hard-coded hash sizes
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 18, 2020 at 5:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/18/20 11:18 AM, Stephen Smalley wrote:
> > On 2/18/20 10:21 AM, Ondrej Mosnacek wrote:
> >> On Tue, Feb 18, 2020 at 3:59 PM Stephen Smalley <sds@tycho.nsa.gov>
> >> wrote:
> >>> On 2/17/20 6:49 AM, Ondrej Mosnacek wrote:
> >>>> Instead allocate hash tables with just the right size based on the
> >>>> actual number of elements (which is almost always known beforehand, we
> >>>> just need to defer the hashtab allocation to the right time). The only
> >>>> case when we don't know the size (with the current policy format) is
> >>>> the
> >>>> new filename transitions hashtable. Here I just left the existing
> >>>> value.
> >>>>
> >>>> After this patch, the time to load Fedora policy on x86_64 decreases
> >>>> from 950 ms to 220 ms. If the unconfined module is removed, it
> >>>> decreases
> >>>> from 870 ms to 170 ms. It is also likely that other operations are
> >>>> going
> >>>> to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> >>>> but I didn't try to quantify that.
> >>>>
> >>>> The memory usage increases a bit after this patch, but only by ~1-2 MB
> >>>> (it is hard to measure precisely). I believe it is a small price to pay
> >>>> for the increased performance.
> >>>>
> >>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >>>> ---
> >>>>    security/selinux/ss/hashtab.c  | 21 ++++++++++++--
> >>>>    security/selinux/ss/hashtab.h  |  2 +-
> >>>>    security/selinux/ss/policydb.c | 53
> >>>> +++++++++++++---------------------
> >>>>    security/selinux/ss/policydb.h |  2 --
> >>>>    4 files changed, 40 insertions(+), 38 deletions(-)
> >>>>
> >>>> diff --git a/security/selinux/ss/hashtab.c
> >>>> b/security/selinux/ss/hashtab.c
> >>>> index ebfdaa31ee32..554a91ef3f06 100644
> >>>> --- a/security/selinux/ss/hashtab.c
> >>>> +++ b/security/selinux/ss/hashtab.c
> >>>> @@ -27,6 +41,9 @@ struct hashtab *hashtab_create(u32
> >>>> (*hash_value)(struct hashtab *h, const void *
> >>>>        p->nel = 0;
> >>>>        p->hash_value = hash_value;
> >>>>        p->keycmp = keycmp;
> >>>> +     if (!size)
> >>>> +             return p;
> >>>> +
> >>>>        p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
> >>>>        if (!p->htable) {
> >>>>                kfree(p);
> >>>
> >>> Thanks, this looks promising.  However, I was wondering: if we end up
> >>> with size == 0 (e.g. policy happens to have an empty table), does the
> >>> rest of the hashtab_* code always correctly handle the fact that
> >>> ->htable could be NULL?  Doesn't look obviously safe to me on a quick
> >>> look.
> >>
> >> Hm... it seems I didn't think this through when I was trying to handle
> >> this case. I was rebasing this patch all over the place as I was
> >> working on other changes in parallel, so maybe I just lost the safety
> >> somewhere along the way... I think I will just clamp the minimum size
> >> to 1, as that seems both safer and simpler. The extra 8-byte
> >> allocation shouldn't cost much (there are only O(number of classes +
> >> commons) hash tables and these make no sense to have 0 entries).
> >
> > Hmm...on booting this kernel, I am seeing a number of calls to
> > hashtab_create() with nel_hint==0 leading to size == 0 and nothing is
> > obviously breaking, so maybe this is safe?
>
> I guess this happens for any class that doesn't define any of its own
> permissions (beyond the inherited common ones).  Probably could just add
> some simple checks to hashtab_* where absent to ensure we don't ever
> dereference ->htable if NULL.

Yeah, OK. I only needed to add a check to hashtab_insert() and
hashtab_search(), the rest will already do the sane thing as-is.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

