Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5C5C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C747C2078D
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d98dF0U4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHSP5R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHSP5O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 11:57:14 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C786AC061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 08:57:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id x24so19446711otp.3
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Cwyf5r/3z8HhVwGHYHhOW1PnzfSbJl55NsmWBCEBC4=;
        b=d98dF0U4yorztZyZ6LUS/ow2cV6fzTOOWzNn6MRhOcmhEs+njUEUeUfKKOFr23matL
         9BK6fotfoOlCQxou5MzVihq9GN0G6UavDvJLKrgX+c1mvV3txYPCdaH0+3gmgOJ+sl+p
         bzW+WLXxuArbhLLjwQobbTlsP1paQOuTwXUVlL1la6aJ8rglHrjSz2MDHAB0aZKVBuol
         Heair450gLZJHqhiSumBHrAYRNoZqLwwYNErWVu6zcmaQbgPI8aJ4HX8Krs5q3JL2yaV
         aX2P0pou455n3+UtDr7ESGwpBi1J2o5UJceb+pWJ6WNpt36mfo9BWTgC8Jnsgg/Xg1f4
         AWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Cwyf5r/3z8HhVwGHYHhOW1PnzfSbJl55NsmWBCEBC4=;
        b=M5pa1PQBViq/Er1KgcmqXOiZ+6S7TbE4FVQ8NWkX7GUgpIu87cI4UTP9rInsPyY7YV
         SM+gBWys+EUVYtX8Ej1EEwa7gkBVY+n9lJ+Qh4AxZDxJpkAmCqzYTjP3hkHUgUlNLhgv
         yrLI5+57AIvEy8W6u6MICs/0vIe4oikPvyYLawxly1WX5tgMlVEIULHQIf8KSvOE1Tjr
         K5SSgX2BA+ohj5Zig3v/vKOoogizlfk8meqvECxFoOy211+de+1VTibGTo0xRrjc08ii
         c7IoPUh+GY5pWd1I6nM5mSm4TekI8S44YVvY+++/UJ75tnqMhvCrT4SGv3SgePdF14JM
         f/vQ==
X-Gm-Message-State: AOAM530AUhzsLU4iCcRDpID3/MtdpWRYlnuhQW+LAW2LYBErmei/zMxE
        pZ7IG+FqmA/37O0BbJNXeLwnX1zPk3ean7fwHFyPmmOqfmQHSA==
X-Google-Smtp-Source: ABdhPJzWo081HNqbwblp8BUMfvAbYOLLSjBeFvlUuFVnfjr8H1YdZl/MB813wcIswGG7GcpYqDhyjVxZt9Me7lAPZhw=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr19023999otn.162.1597852632105;
 Wed, 19 Aug 2020 08:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200819155355.45740-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200819155355.45740-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 19 Aug 2020 11:57:01 -0400
Message-ID: <CAEjxPJ74WvDxz2OCoSXp3SZYcggk4htAZ+nmTohwMAaNkGaHBw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] selinux: convert policy read-write lock to RCU
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 11:54 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Convert the policy read-write lock to RCU.  This is significantly
> simplified by the earlier work to encapsulate the policy data
> structures and refactor the policy load and boolean setting logic.
> Move the latest_granting sequence number into the selinux_policy
> structure so that it can be updated atomically with the policy.
> Since removing the policy rwlock and moving latest_granting reduces
> the selinux_ss structure to nothing more than a wrapper around the
> selinux_policy pointer, get rid of the extra layer of indirection.
>
> At present this change merely passes a hardcoded 1 to
> rcu_dereference_check() in the cases where we know we do not need to
> take rcu_read_lock(), with the preceding comment explaining why.
> Alternatively we could pass fsi->mutex down from selinuxfs and
> apply a lockdep check on it instead.
>
> Based in part on earlier attempts to convert the policy rwlock
> to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].
>
> [1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
> [2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 passes the selinux_policy pointer down to lower level functions
> after the initial rcu_dereference() so that we never dereference it
> twice on the same code path.  It also corrects a missing rcu_deference()
> and gets rid of some unnecessary cases of rcu_read_lock()/unlock().
> Remaining open questions include whether I should change selinuxfs
> to pass down fsi->mutex so that we can use it in a lockdep check
> for rcu_dereference_check() and whether the sidtab live convert is
> safe after this change.

I forgot to mention: v3 is relative to
https://patchwork.kernel.org/patch/11724203/ on top of the selinux
next branch.
