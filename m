Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27880C5DF60
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 20:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED272067B
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 20:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A55lxXZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfKGUGr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:06:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34621 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKGUGr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 15:06:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id 139so3696457ljf.1
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2019 12:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVq2s31BYTTuEERgcILZOgxkm5EurQXMSzwHPSZAxW0=;
        b=A55lxXZj7kaaxs9Ju+bvSeem7iwivS22VOVgSy3qQ/99ST00wCU2nEqQPVRRczrHcS
         /4ZVQqWcXI6bvST82Y8gVNdwGLIvSFMdhuGl2xK0X1zRr0CP6Spx8HAjg17qD2JcsNBb
         tFMepM7CYGJuLVM36Z8DCpPnvuRLKIZwkZCeQ3zppyV22MB0YEVyqzyEOGx4RB5CZhxq
         LhVpdCPv0dk5NYdyfLUeXbqlLiIujKOJJnKqtm6u/MbUCiKS1+jt7OVdwSPA6S2u0ZgG
         wneAKHX2okcY1/nYzo57oSjZoLg+vQsCeBr5aDFmsrE3mC5sNNHIRYZJIauMBT8HLG9k
         eX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVq2s31BYTTuEERgcILZOgxkm5EurQXMSzwHPSZAxW0=;
        b=bfpdkK9wTIVa+cqEKt37OOFDBvqrCS1+qNGlJ27T/a72189E5on6qY3WFMUY7dfUcI
         tiGOpMC0s7mqBaWynW6rqjhOD0fytPVMy6ZScH7hKicrC1NeYEs0X6P0YXz4sT8p7SgJ
         ICJ8Of1KCep9n7g1uxulOXsvp/P0M39Wt5ggoIhgXd6YHLBu6ZryTiucJZx912LAkUgi
         m7cbvBC5nEH4JiB8sBFr9qKVluxgRhw1Cn6e+QCBzT3gzOZnYF5eKVWAnMFk2Efu8ZOs
         wQvLW/4jxoNDwAANGOPKowvIWhYdhFa9qb53sv1UWFDHKIY8teY36tsTY5Dg5ROS4Oo3
         uyQQ==
X-Gm-Message-State: APjAAAVUstAXMHuvktS6EbGnH9ABSzujGK0S619vuVTbBaPr///mi73P
        oV/BCT5SMUGVgE5uZzJxJtCLoMpschRlMCY4M+PaYA==
X-Google-Smtp-Source: APXvYqzIi1uUqSyNo34nSDP8sAR0H+YnoIpDN5LfxdGOgy6sEDQnFF/1mF8HWtjzltb+V3Fo2kS5Ee1yZaxbIMYk3X0=
X-Received: by 2002:a2e:2419:: with SMTP id k25mr3835894ljk.59.1573157205046;
 Thu, 07 Nov 2019 12:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20191107101743.203699-1-jeffv@google.com> <CAFqZXNvn4tTgNcQ3-fFE5QN7dS93h2VNznZ-D=3m2gZ26di9hA@mail.gmail.com>
 <20191107164430.GA13483@willie-the-truck> <CAFqZXNuCugt05+4nejHYvkAGrW+WMmwsRQv8pjKEhKxdBMDVew@mail.gmail.com>
In-Reply-To: <CAFqZXNuCugt05+4nejHYvkAGrW+WMmwsRQv8pjKEhKxdBMDVew@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Thu, 7 Nov 2019 21:06:33 +0100
Message-ID: <CABXk95AMYEayjt_1v_hv-bft2V=9q4xMSWuMbAOmTOvFj+SC0A@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: sidtab: reverse lookup hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> > If you use the existing _rcu accessors you will get correctly enforced
> > dependency ordering on the reader side and correctly placed release
> > ordering on the updater side. I don't think that's a big overkill, and
> > you can use the RCU accessors to achieve the lockless traversal.
>
> OK, but you don't need the read_lock()/unlock(), rcu_head field in the
> entries, and kfree_rcu(), right?

Hmm... I can get rid of rcu_head/kfree_rcu in any case because we never
remove items during normal use so we don't require the "rcu grace period".
>
> >
> > hlist_add() is not safe against a concurrent traversal because the
> > WRITE_ONCE() provides no memory ordering guarantees, allowing the readers
> > to see an uninitialised node.
>
> Right, so we would need a new function that does smp_store_release() instead.
>
> >
> > How exactly would list_for_each_entry_lockless() and hlist_add_something()
> > differ from the RCU variants, assuming they're implemented correctly?
>
> Looking at the implementation of rcu_dereference() and
> rcu_assign_pointer(), they would probably be practically the same,
> except the rcu_read_lock_held() check in rcu_dereference(). That and
> they would clearly communicate that they are not doing actual RCU, but
> just allow lockless traversal of an add-only hlist.

>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
