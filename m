Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA09C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB2C20643
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 14:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENO5U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 10:57:20 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:35366 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgENO5U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 10:57:20 -0400
Received: by mail-qt1-f181.google.com with SMTP id z18so274404qto.2
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 07:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIKnVcq/rWDKomhV7GbW4WeNxGXy74M2mAD/jTa8g6o=;
        b=t4VVt7RqkOzpuLs0FNXnJujMOdCD9UTx/dwVU8vz5ZU7oN4MZwfIGSIiN50/i4ud77
         zKw8q2TiiYBknWHo73isYHApxc+1KZaAPkU/yef816uPYmSfdLfWduiuVHCnHNavh8P7
         cOHvx1WjFUtvxRqSdPgC8tQ9wTMHJzfWQy2fFOolJsaXeUzjmku5b2QVUtQ8dNutAZ9q
         JfEyp27O2cYE6s+Ffjn46RPJzsj5wbcfGJBjmKGJ+LAFjW0ICyYU63CO7gzy9cy5Lqtr
         FHhUoOSpKZVUm+k//iRQIkpdifhu02w2quOXpU3+12grUS7WaDk72Ns1n+mvOuCQnF2J
         mQ7A==
X-Gm-Message-State: AOAM530bHICL8LSPkO2uu5i1Ddn/5bE9q9Rze61WtjhDACtgMnPEqX71
        gRqyt1u8W/KEftNNWstU1+rU0mbjGA9o2W+TG9o0wbOvCyQ=
X-Google-Smtp-Source: ABdhPJzvlBxe8ZBUOgcBhnnJIDAZ5OUXNqx3OBzcbc5f2kTEMVVzT03jN9v59M39v5zN1nexja6r+dcDm9Gy9In2rR4=
X-Received: by 2002:ac8:6891:: with SMTP id m17mr3039456qtq.41.1589468238086;
 Thu, 14 May 2020 07:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6P2QQRFBmUdjpz0GudUxyACjveCWg0yyGzz_6_5YnUQ4fLBQ@mail.gmail.com>
 <CAMN686H5K6Ohzd297giboVoD=Jud+k9tRvvCtJJZ8jvNmv_=HA@mail.gmail.com>
 <CAO6P2QS78aTzCvMHgUWmgmkVjEN9v0Wq0Lgys2puL6eRW+CLjg@mail.gmail.com> <CAEjxPJ4ePzeuhiRdLndM3U7sybjG8QUO8xhd5RuFNH-YB8NB1w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ePzeuhiRdLndM3U7sybjG8QUO8xhd5RuFNH-YB8NB1w@mail.gmail.com>
From:   Paul Tagliamonte <paultag@debian.org>
Date:   Thu, 14 May 2020 10:57:07 -0400
Message-ID: <CAO6P2QS0ze4e7qRfZBkemZTaM9QQUwUwhNs2bG4gfTkenwcsiA@mail.gmail.com>
Subject: Re: Configuring MLS with a daemon operating at multiple sensitivities
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> Was computing the MLS label the only part you needed?  With respect to
> having the daemon run in the same label as the peer (or the label
> derived from the intersection of the peer and the daemon), you may
> wish to have a look at mod_selinux for Apache and/or the old xinetd
> LABELED option, although neither of those would have included the new
> glblub support so you'll have to integrate that yourself.

Ah, really helpful pointers, thank you very much!

> Or your daemon can just use setcon(3) directly if allowed by policy.

My assumption was that I can use the greatest lower bound, and then
preform a `setexeccon` and `exec` to transition to the new security
context provided I can pass the open fd according to policy (for
now -- at least until I can find a better way to restrict a thread -- I'll
do some reading in mod_selinux / xinetd). Is this the case, or am
I going to wind up in a world of hurt?

The use-case here is to allow an RPC server to listen to network
traffic, and when properly authenticated, raise the sensitivity level
and category as required, both so the RPC server can logically
handle access controls (not shocked the crunchy folks hit this first)
as well as a system level protection in case there's a slip up and
the server attempts to read a secure file (less urgent but still
very nice to have!).

I'm very much still learning the MLS ropes here, so if someone
sees me hurtling to the edge of a cliff, do let me know!


-- 
:wq
