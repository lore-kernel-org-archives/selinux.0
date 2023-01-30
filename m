Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC4DC54EAA
	for <selinux@archiver.kernel.org>; Mon, 30 Jan 2023 18:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbjA3Sfs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbjA3Sfq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Jan 2023 13:35:46 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E8A277
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 10:35:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m2so34020035ejb.8
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 10:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2r7iSsMa+nt7a9aKSNJ0c0h9e7OIxigfLL9QA0zKv/E=;
        b=L3sQKgrQWC0n/PK3aoVRjxRhkmXOF0gyZC2Gl2vRv3jDoqzVk9f7+cj4KC7O+jMu6r
         BrNqhkPVedr15tF7NaAblXSp499dP/CUR6E4H+fb+3lNvhzGuAjK2ySPG9CQ57xK2z0G
         4zzK3Rookr1O89UbyCy+KmmRGw10q4ALaTg68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2r7iSsMa+nt7a9aKSNJ0c0h9e7OIxigfLL9QA0zKv/E=;
        b=1mHFRfD6LfKn9doq1rjd3dMFCYplnZvdyaVnY1bToaSv+yTd8NExqvl44ALFA4JFl9
         pNQRd1X79pjMKqbDw0xWt/MvELpERNeAZ6p9Wdo+sNKJ95nJBRZjJHixURSQvwPqPosm
         vOHtVdZsiMDrtBsWaqgpEjXeiUSSTjddwRyHifZbrHmz3EY7uD+gA/ja/mKQuL5eLadk
         cLaqiPXLAWHzYnCZky7B/pxy3BgZvvyWPrjvHGMs/A1/dhhnT0ArA7lkbUBr4tLyFX98
         XKh2Q7hkvVDMMaOyutJ6IOLd0PqzZJfdmBVfumIEsgfEDFtRD9axaRyMRrDwgJn1F8pz
         IVkQ==
X-Gm-Message-State: AFqh2kp4gDPJXP3SeyakPqSr53274GBr//lNyk5exUiIDlE0DsReAmnQ
        J8ehYiayHRM6kZ3KIUmDPP0jVTY8e9utEjhg0D0=
X-Google-Smtp-Source: AMrXdXvidIAfQxEC0JWyFuWiIWGDVvgwVYhbCgRlDJIVWO0IG1kpr2JPl8GYeHDb3nYClZG0VIq0IA==
X-Received: by 2002:a17:907:7e9c:b0:84d:363c:888b with SMTP id qb28-20020a1709077e9c00b0084d363c888bmr66341847ejc.58.1675103738539;
        Mon, 30 Jan 2023 10:35:38 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id v18-20020a1709064e9200b0084c7f96d023sm7291533eju.147.2023.01.30.10.35.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 10:35:38 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id ml19so10934324ejb.0
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 10:35:37 -0800 (PST)
X-Received: by 2002:a17:906:abd9:b0:87a:7098:ca09 with SMTP id
 kq25-20020a170906abd900b0087a7098ca09mr3146413ejb.78.1675103737664; Mon, 30
 Jan 2023 10:35:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whR4KSGqfEodXMwOMdQBt+V2HHMyz6+CobiydnZE+Vq9Q@mail.gmail.com>
 <CAHC9VhR1jRM2K0757sNYS8VvSUxRWOKUJ1unbsZm9LOEM3Up6Q@mail.gmail.com>
 <CAHk-=whLndwMFSF_OAWdqxXYXUev_H9YqEkXQ1_PKoPO8u=G2g@mail.gmail.com>
 <CAHC9VhRWz2N6ezZckSwtZvM3J75prdq7ckaoQgAO+ECz527qCw@mail.gmail.com> <CAHC9VhRgR2BV3v_1o3JGdBT80UxiMSGUcrLVG8Tj3JiKynZYNw@mail.gmail.com>
In-Reply-To: <CAHC9VhRgR2BV3v_1o3JGdBT80UxiMSGUcrLVG8Tj3JiKynZYNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Jan 2023 10:35:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHX5wpnFSOgWNgNxMk+xHA2Gbh+7_eiJjTPGqpJ1kxog@mail.gmail.com>
Message-ID: <CAHk-=wiHX5wpnFSOgWNgNxMk+xHA2Gbh+7_eiJjTPGqpJ1kxog@mail.gmail.com>
Subject: Re: Looking at profile data once again - avc lookup
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 30, 2023 at 9:47 AM Paul Moore <paul@paul-moore.com> wrote:
>
> I should add, do you have any particular test script you use?  If not,
> that's fine, I just cobble something together, but I figured if you
> had something already it would save me having to remember the details
> on the perf tools.

So I've done various things over the years, including just writing
special tools that do nothing but a recursive 'stat()' over and over
again over a big tree, just to pinpoint the path lookup costs (big
enough of a tree that you see actual cache effects). Then do that
either single-threaded or multi-threaded to see the locking issues.

But what I keep coming back to is to just have a fully built "make
allmodconfig" tree - which I have _anyway_, and then doing

     perf record -e cycles:pp make -j64

on it. You'll need to do something like

    echo 1 > /proc/sys/kernel/perf_event_paranoid

before starting your profiling session to make it possible to do that
profile as a normal user and get the kernel data.

And then look at the end result with just

    perf report --sort=dso,symbol

which avoids sorting by process, because I don't care _which_ process
does something, I just want to see the kernel symbol table end
results. Press 'k' to zoom into just the kernel profile, and Bob's
your uncle.

You can play with callchain data ("-g"), but I tend to like the plain
flat profile to just see where things are happening. I'll do the call
chain if I then start to look into things like "which caller was the
main reason for that queued_spin_lock_slowpath cost" kinds of things,
but it's not always even necessary.

Unless you have some big kernel debugging options on, what you
normally see for that load would be

 - memset and memcpy (including very much our user-space versions of
it, like clear_page_rep and copy_user_generic_string).

 - depending on number of CPU cores, locking (I *despise*
folio_memcg_lock, but that's not from the pathname lookup, it's the
page fault path, particularly WP faults)

 - page table setup and clearing

 - ... and finally, pathname walking, generally with
selinux_inode_permission and avc_has_perm_*() fairly high up

So it's not like 'make' is dominated by pathname walking - the process
related stuff tends to be higher - but I've ended up using that as a
kernel profile source because it's a real load for me.

Also, most of the time by far is spent in 'make' doing various string
things in user space. Our kernel makefiles tend to have a lot of
symbol expansion etc. I just ignore all the user space stuff.

There are other loads I occasionally look at, but this is basically
the one I always tend to return to because it tends to stress the two
things I personally end up interested in - the VFS layer and the VM
code. I don't really tend to do IO etc.

Put another way: there's nothing _special_ about the above, except for
the "it's a real load that does actually show a few core kernel
areas".

Also, the above is just about the least fancy use of prof you'll ever
see. No events, no special hardware counters for things like cache
misses or anything, just plain old "where does the time go". I do end
up looking at the annotated assembly code (press 'a' on the selected
symbol), but it's worth noting that even with hardware profiling
(Intel: PEBS, AMD: IBS), saying "exactly where did we spend time" is a
pretty ambiguous thing on modern OoO cores - you have to interpret the
data by just seeing lots of it. But usually you can see "hot loop
here", "mispredict there" or "that load is taking cache misses", so
the instruction-level profiles do need to be taken with a huge grain
of salt and some experience with that microarchitecture to really make
sense ot them.

                   Linus
