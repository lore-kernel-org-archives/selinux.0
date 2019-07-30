Return-Path: <SRS0=so3z=V3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648BBC433FF
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 12:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1092087F
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 12:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfG3MUa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:20:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36685 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfG3MU3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Jul 2019 08:20:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id r6so66039884oti.3
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2019 05:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Q6mS+DqBftR6sBALx1klKnbtH2VTxT6TbWgT1hLn5Y=;
        b=Abvbr+SUxHEmcXoZraZvPebRbKLHOD5hGs6o2sg0fU5/3XNPN7JS0DMozJdwCsWoA0
         G3rWr1kixC0CLUN0Ma7pKBUSO3xWCX/IcdF+lTLHC6nMSdDdZwHBxy9i909VTOtYXdD/
         wforNxZF1eHWAHyr9dt14fTpcMUf3gxs69PTiM33vTWt4viQtOkILDWwN/JKKTmKICVH
         XbrdW10kXOST2X2Dc1zGNP/hegjxKUwDNGfq2aG4npqgBVtNGU0efoTMTDIDIbEH1uub
         mQWqp8EXBeBOLhkICvhrJR508wkW903mE3srB/KmPEZb6+DDr1SX7apD+DydfvQfs6Du
         3v2A==
X-Gm-Message-State: APjAAAVvPIraTRArIud9WsqHrKT5A6c26hpY7+ssrZPnU3pqgfi5tAib
        mISLC/A3u5YQFEIG9R1L2nesJagAJHXv0anNK/qRBw==
X-Google-Smtp-Source: APXvYqwhSxwZKzgpS9dFxxDZGaikF2xa/M/NphBYOrOwPJ1h8rB/JgmgC6TNv/uV1jbKtGLaFRmYAgejVgutuGPF1oI=
X-Received: by 2002:a9d:4c17:: with SMTP id l23mr39727658otf.367.1564489228714;
 Tue, 30 Jul 2019 05:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190729084117.18677-1-omosnace@redhat.com> <20190729084117.18677-2-omosnace@redhat.com>
 <CAHC9VhSRvfGJjBfxkNc2kdwbN5UZP6LSJbyYuBa+OE8YJ1-weg@mail.gmail.com>
In-Reply-To: <CAHC9VhSRvfGJjBfxkNc2kdwbN5UZP6LSJbyYuBa+OE8YJ1-weg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 30 Jul 2019 14:20:17 +0200
Message-ID: <CAFqZXNsEH1H5=rLyn=SEay3od+=bdAGYW3_CKvNWBhjNsvHd6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: policydb - fix memory leak in policydb_init()
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 30, 2019 at 12:48 AM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Jul 29, 2019 at 4:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Since roles_init() adds some entries to the role hash table, we need to
> > destroy also its keys/values on error, otherwise we get a memory leak in
> > the error path.
> >
> > To avoid a forward declaration and maintain a sane layout, move all the
> > destroy stuff above policydb_init. No changes are made to the moved code
> > in this patch. Note that this triggers some pre-existing checkpatch.pl
> > warnings - these will be fixed in follow-up patches.
> >
> > Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/policydb.c | 976 +++++++++++++++++----------------
> >  1 file changed, 489 insertions(+), 487 deletions(-)
>
> Hmmm, that is one ugly patch isn't it?  If I saw this diff I'm not
> sure I would have suggested what I did, or rather I would have
> suggested something slightly different.
>
> When I ran my quick test when I was looking at your v1 patch, I only
> moved perm_destroy() through ocontext_destroy(), leaving out
> policydb_destroy(), and the diff was much more cleaner[*] (diffstat
> below, includes the actual fix too).  Could you try that and see if it
> cleans up your patch?

Yeah, excluding policydb_destroy() from the move is what's needed to
get a nice patch... Actually, what do you think about keeping the
bugfix patch as before (with the forward declaration) and then doing
the moving around in a separate patch (removing the forward
declaration)? Then we keep the patch with the actual fix small, but
still get a clean final result. It would also allow moving
policydb_destroy() up closer to the other destroy functions in another
separate patch (I tried it and both patches end up clean when the move
is split up like this). (I don't have a strong preference for this,
let me know what works best for you.)

>
>   security/selinux/ss/policydb.c |  378 +++++++++++++++++-----------------
>   1 file changed, 190 insertions(+), 188 deletions(-)
>
> [*] In this case "cleaner" simply means that the moved lines were not
> interleaved with existing code (just a big block of adds at the top,
> the fix in the middle, and a big block of removals at the bottom).
>
> --
> paul moore
> www.paul-moore.com

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
