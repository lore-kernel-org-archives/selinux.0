Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88218C76186
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 22:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C67206E0
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 22:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ar6EMpcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfG2Wsg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:48:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36696 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfG2Wsg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 18:48:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so60187907ljj.3
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YR87D5S9oS3TRPu+y8TEqySNNjblp8yHiF4ZHHtKWSE=;
        b=Ar6EMpcqOYK5WWTJWAksdb89Mv2paN4jlx8GWEG3HxFBk4R5mluYkkPk9f8rKrGeae
         VKFVOR+QCUu/hifKPFGbcj+6Ig0DJqEm1RWsECV3l0KlIdXDGchfF80afTa/qtxgVBu0
         sPNXekj2FYKIM1zLg9kZ6QV7jaoIIVIeqRvO5oITbrtN2MGUIiEaeIFx1Gi1K77gUR36
         oQ4BPkAevX0Bq5JbR+ezt/0B/IxsVqd3n0MPvDJg0y5wIQngeF1b9GG+6i1NwltyYU+L
         tpGWOkroy3C6hRAPBFdj3z3LQpkLrzC1C3NHKdN85HuwCcRBLD7m8z9wYwjj8woJv7JX
         eLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YR87D5S9oS3TRPu+y8TEqySNNjblp8yHiF4ZHHtKWSE=;
        b=jzcotoxdauaCOdr4cUlOKJpc53WcMggZ0S1uz00v+cUiajeDANSr7RrO6203gXU0QA
         rsdUqTdn1rR8ELW5w6TfcRmGQM7zEbe0DeN32WS8JQu3Ul2bVqHIPnhF6ciRJo/rRhiZ
         FChXj2pIuZ4pPmimBnqB86UQe7SW7DVKV/GKV4JnU3r54OB+8GnAGABGe5iTD2AyL9hq
         XAFeBTxVeNhuftzidkMCGH6qVzn+2miZJmOFa/kdXEGOCMKHZL7qjpSJ6kQUwZKZX/Ph
         dY+d7z0te3OzlQ4VKu8kv/SviX2DDlviSZTJZFTChmOLNxiJZ8od/9SKg5AlYkpxUlCD
         iR4Q==
X-Gm-Message-State: APjAAAUCGblWWajcXYK/Ncr9CHod/lAuIx87E9MaO2wyO4z0lfwYpKAF
        d7VntX4qGhqoBFr2bBqUeMQfh2NOdXs5b2FXoQ==
X-Google-Smtp-Source: APXvYqzVD/S2jyxOYzipcE01qKaNzI7soWXxcfxdgJ3Pk/iGbZdnJuhfgXH722LT9qakWBO5blPEC+9uoF93wC+NCsk=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr3082264ljj.0.1564440514208;
 Mon, 29 Jul 2019 15:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190729084117.18677-1-omosnace@redhat.com> <20190729084117.18677-2-omosnace@redhat.com>
In-Reply-To: <20190729084117.18677-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Jul 2019 18:48:23 -0400
Message-ID: <CAHC9VhSRvfGJjBfxkNc2kdwbN5UZP6LSJbyYuBa+OE8YJ1-weg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: policydb - fix memory leak in policydb_init()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 29, 2019 at 4:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since roles_init() adds some entries to the role hash table, we need to
> destroy also its keys/values on error, otherwise we get a memory leak in
> the error path.
>
> To avoid a forward declaration and maintain a sane layout, move all the
> destroy stuff above policydb_init. No changes are made to the moved code
> in this patch. Note that this triggers some pre-existing checkpatch.pl
> warnings - these will be fixed in follow-up patches.
>
> Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 976 +++++++++++++++++----------------
>  1 file changed, 489 insertions(+), 487 deletions(-)

Hmmm, that is one ugly patch isn't it?  If I saw this diff I'm not
sure I would have suggested what I did, or rather I would have
suggested something slightly different.

When I ran my quick test when I was looking at your v1 patch, I only
moved perm_destroy() through ocontext_destroy(), leaving out
policydb_destroy(), and the diff was much more cleaner[*] (diffstat
below, includes the actual fix too).  Could you try that and see if it
cleans up your patch?

  security/selinux/ss/policydb.c |  378 +++++++++++++++++-----------------
  1 file changed, 190 insertions(+), 188 deletions(-)

[*] In this case "cleaner" simply means that the moved lines were not
interleaved with existing code (just a big block of adds at the top,
the fix in the middle, and a big block of removals at the bottom).

-- 
paul moore
www.paul-moore.com
