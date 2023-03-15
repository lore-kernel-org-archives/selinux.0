Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3506BC61DA4
	for <selinux@archiver.kernel.org>; Wed, 15 Mar 2023 18:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjCOSFl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjCOSFk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Mar 2023 14:05:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE3722031
        for <selinux@vger.kernel.org>; Wed, 15 Mar 2023 11:05:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a2so20971659plm.4
        for <selinux@vger.kernel.org>; Wed, 15 Mar 2023 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678903538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0ixwjGOVVtT3byzs73Pp7tdQ1uzeelP+N+n7LPpe+M=;
        b=C5mdcgulQMYy0GlDAIA3/efR+8d4qiY75L+V6USFq4uPN3OMiNyHDQ1h3c+8YkFEta
         yQH8XnAmZ10lLtiQ5Sx3F/7uF9HmHyTIcG96loJc41Bz9AFghxO1aF2lVOOeJaJfBaqo
         pp1rIR6qGEvP0YDAYd1wlLeyFpM1FN+PNsm02c6lqSUCumVE/0tirI4uU9ye8Qf++iY4
         hcBOQ1eGITlcy5jo1CgLEBhjcoa4WIobFOKgJBLEbq/AuLVLSz/6rBiv4sIzVXtIOTOW
         kDXRwEKbS+vuQFe8m2ifJip3NEv0OpZ9uwP6dncQgUq8WGQfsvBmO/40jIEDfzbYDf6l
         Sf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678903538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0ixwjGOVVtT3byzs73Pp7tdQ1uzeelP+N+n7LPpe+M=;
        b=D75Q0NU7P3a8SLhpiRReGoIXDkj3TRrHsREz+xLEC6Rocs3RggGJGQ8C9h7ZYky5/k
         LdFoy3CJPSLnhVDapBb+50eVqNYDJgfAqBvgPedWo8CNySEgzuQLVKqxNLVcB+tETxyS
         pe73lwGVBWjKSBxHIK2kPoN3zh0rN7OXf3sSeP/Kmssuzq5DdP2XMYlz/RgDMsQQ8ycn
         Hy+pxpWzVuYo1nfzS9L9wQ4TqwgSSmYL7QZXygIadXULXoC6AoQOdmyylfAkny+JFIdY
         pavIS1vvLdh5+AZVenXBc8G27XoHNbB1qcaMiY2EqFezJZ/CiOLHwyaSDUD4/39AiINk
         Phkg==
X-Gm-Message-State: AO0yUKUpaoR4VmFNpGbIybXJJguAZzzyR7idqna1EJgVuajVIjiPkUyE
        bk0TkLA6t0ojOSyEk78qGW6/ZiErI/ypM9iSekY=
X-Google-Smtp-Source: AK7set9gsILcTHhBzTkz2V5KK/2ejOchnIK7rg+l7gT5TB4FEHfrm5RNPROHeHDYlvoVUSRiaDAdNoo+Oxvr0trKa50=
X-Received: by 2002:a17:90b:354c:b0:23d:20c:2065 with SMTP id
 lt12-20020a17090b354c00b0023d020c2065mr278105pjb.1.1678903538458; Wed, 15 Mar
 2023 11:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230314125734.19896-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ77njhXPvEZ6-3WKVQtLtNXJw69NOGSoNktf7STgKjTQ@mail.gmail.com>
 <CAEjxPJ7ZVnGzWFfj051POA+gO2cVY_6vPgyNzPBFo=wr909xYQ@mail.gmail.com> <CAHk-=whuMkkCFrZQ_U8W8Z=3iDKV=jv9PUJg6D0fqMtQ=gTqRQ@mail.gmail.com>
In-Reply-To: <CAHk-=whuMkkCFrZQ_U8W8Z=3iDKV=jv9PUJg6D0fqMtQ=gTqRQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 15 Mar 2023 14:05:27 -0400
Message-ID: <CAEjxPJ7dn4-5_N6ibkeyo7L-AD=gyJDBXmJKG_AjtUVcJeyX4w@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: cache access vector decisions in the
 inode security blob
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 15, 2023 at 1:37=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Mar 15, 2023 at 5:33=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > We are already taking the isec->lock (or otherwise have exclusive
> > access to a newly initialized isec) in all the places where we are
> > updating the isec->avd and isec->avdsid. The issue is not the updates
> > but rather the reads in inode_has_perm() and
> > selinux_inode_permission().
>
> Right.
>
> And that is always going to be unordered, in the sense that you will
> get "one or the other" value whether you have strict locking or not.
>
> So even with a spinlock around the actual low-level selinux data reads
> and writes, there is only "data consistency", not any actual
> *ordering*. The pathname lookup itself is simply not ordered (and
> cannot in any sane model be ordered) wrt somebody else coming in and
> changing any selinux rules.
>
> So I don't think this is even worth worrying about. There is no
> ordering, because no ordering can possibly exist.
>
> The only thing that can matter is consistency: any *individual*
> security decision should either get the old rules or the new rules
> (never a mix of the two), but either of those is fine - and as you
> traverse a whole pathname and do multiple different security decisions
> for each path component (and for the final open), you *will* get a
> mixture of old and new if the rules are updated concurrently.
>
> I don't think this is a problem, and I don't even think it's fixable
> (sure, in theory, we could do some big sequence number lock or
> similar, but no way do we actually want to do that for path lookup in
> reality).

So my primary concern is wrt consistency of the (isec->task_sid,
isec->avdsid, isec->avd) triple. In particular, if we have two or more
tasks with different SIDs accessing the same inode, then
selinux_file_open() is going to update those values on each open(),
and inode_has_perm() and selinux_inode_permission() may see
inconsistent states with a mixture of the old and new SID pair and
access vectors that will result in permission being incorrectly
allowed or denied. I'm not sure how to safely prevent this in a manner
that doesn't impose too much overhead on inode_has_perm() and
selinux_inode_permission().
