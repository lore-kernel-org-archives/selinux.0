Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1FBC6FD1F
	for <selinux@archiver.kernel.org>; Thu, 16 Mar 2023 21:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCPVJR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Mar 2023 17:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCPVJQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Mar 2023 17:09:16 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89785BAD0A
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 14:09:14 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e65so3523635ybh.10
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679000954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2pma/whzkMOxY1sj18+VkjwelXdEW4q6aRsnR3WPPY=;
        b=AYJlAHyjxfjo/hIUTnwAHTz+SRFKohL9AvfPzSR3Ce1Ikn7Eivngv/2++6Eo+lr7Oh
         3BPyrYABtoiIUs0DJianvttLZCDGyYwEgsPxrZX67CAWg4GWoAZ5sKzo/2GuC0qReqBW
         6GD+Q4OmzP3OuyXQfC3yOaMCtfk1dtBod0wWRjGVt+S7or8GNvsGhhgNzsdw7JT6XrZe
         etxR7+21ml6qsiv6kIA+hRgBRtpgnIdq8M+zRFxzY/rHbqYPVxOzPHSsUUaeRRniCV/M
         BtMB77xxd3PklCYbKP0EyBiRqWVQMoA4znVC0Tv1OEq+VzjD8R6W7vUD+60CZruAwvi2
         d3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679000954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2pma/whzkMOxY1sj18+VkjwelXdEW4q6aRsnR3WPPY=;
        b=bHVIoKzx/XntPtRqQKMs6uFcq5/yQ6aZxYVJVjyQ5LiX+UHFXE4gKaYXgOTbXIN3fs
         KPJx+7kBJW8TJ2avHdnBJzT+kbdZPmbLuAfJo0l6TZd8iTICaZmolTqqDzVSlHCa2Quf
         Rat4OKT2GoRCWYkqw8jk9qEdP5Rg+LI7z2vCe9mXe1gbyuHuUEXpyw0XW6hImat4Ak1/
         vsxqnGGzBpvlHuUm+apXAXAyJR0enKJnkWsiBmmB12B18dmWFSZUmWhIztyplhqXd/Ie
         q4HeOAPqZqXyGXtbq3SK/6kZVRk3bk37UkAvBd2+7GIsW+zhbhUxcS+g5rVjT4AVUl8H
         wGEQ==
X-Gm-Message-State: AO0yUKWm1b3j87t63o4tdSckOq/uiFmLtof6DUvk9H2pJygo9K0XymOC
        0JZzzIvfrGOYL+LxSfLH1vjzr6ApwPOKUzhbiqx4kIfcv6ewghA=
X-Google-Smtp-Source: AK7set9Qva5o7wMMeAKo3IHqxAqfJzhCBQH2KgkYsq92Cf3Pu0egusTJIk7Jm5JK+whMN2XgydfNFN9hzDIjJ3ACc7Q=
X-Received: by 2002:a05:6902:18d2:b0:b56:ec25:8e72 with SMTP id
 ck18-20020a05690218d200b00b56ec258e72mr3169598ybb.3.1679000953663; Thu, 16
 Mar 2023 14:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230314125734.19896-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ77njhXPvEZ6-3WKVQtLtNXJw69NOGSoNktf7STgKjTQ@mail.gmail.com>
 <CAEjxPJ7ZVnGzWFfj051POA+gO2cVY_6vPgyNzPBFo=wr909xYQ@mail.gmail.com>
 <CAHk-=whuMkkCFrZQ_U8W8Z=3iDKV=jv9PUJg6D0fqMtQ=gTqRQ@mail.gmail.com> <CAEjxPJ7dn4-5_N6ibkeyo7L-AD=gyJDBXmJKG_AjtUVcJeyX4w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7dn4-5_N6ibkeyo7L-AD=gyJDBXmJKG_AjtUVcJeyX4w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Mar 2023 17:09:02 -0400
Message-ID: <CAHC9VhSBrEPAg91EZv-0AJJOZOXONkzq-xWC3D_zdF3AL0T0qQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: cache access vector decisions in the
 inode security blob
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 15, 2023 at 2:05=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Mar 15, 2023 at 1:37=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Mar 15, 2023 at 5:33=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > We are already taking the isec->lock (or otherwise have exclusive
> > > access to a newly initialized isec) in all the places where we are
> > > updating the isec->avd and isec->avdsid. The issue is not the updates
> > > but rather the reads in inode_has_perm() and
> > > selinux_inode_permission().
> >
> > Right.
> >
> > And that is always going to be unordered, in the sense that you will
> > get "one or the other" value whether you have strict locking or not.
> >
> > So even with a spinlock around the actual low-level selinux data reads
> > and writes, there is only "data consistency", not any actual
> > *ordering*. The pathname lookup itself is simply not ordered (and
> > cannot in any sane model be ordered) wrt somebody else coming in and
> > changing any selinux rules.
> >
> > So I don't think this is even worth worrying about. There is no
> > ordering, because no ordering can possibly exist.
> >
> > The only thing that can matter is consistency: any *individual*
> > security decision should either get the old rules or the new rules
> > (never a mix of the two), but either of those is fine - and as you
> > traverse a whole pathname and do multiple different security decisions
> > for each path component (and for the final open), you *will* get a
> > mixture of old and new if the rules are updated concurrently.
> >
> > I don't think this is a problem, and I don't even think it's fixable
> > (sure, in theory, we could do some big sequence number lock or
> > similar, but no way do we actually want to do that for path lookup in
> > reality).
>
> So my primary concern is wrt consistency of the (isec->task_sid,
> isec->avdsid, isec->avd) triple.

Agreed.  FWIW, I thought you were looking for a different approach for
the writers in your original mail.  Considering the multiple cache
fields, and the consistency requirements, I think the only realistic
solution would be to wrap them in their own struct/pointer referenced
by the inode_security_struct and use RCU on the read side.  Different
readers would obviously have the potential for different views, but
the cached values would at least be consistent for any given reader.
The downside would be the allocations necessary when updating the
cache, which I'm guessing would wipe out any gains from the cache ...
but that's just a guess.

> In particular, if we have two or more
> tasks with different SIDs accessing the same inode, then
> selinux_file_open() is going to update those values on each open(),
> and inode_has_perm() and selinux_inode_permission() may see
> inconsistent states with a mixture of the old and new SID pair and
> access vectors that will result in permission being incorrectly
> allowed or denied. I'm not sure how to safely prevent this in a manner
> that doesn't impose too much overhead on inode_has_perm() and
> selinux_inode_permission().

--=20
paul-moore.com
