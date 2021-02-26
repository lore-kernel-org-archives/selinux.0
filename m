Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EC3C433DB
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 01:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BD664EC3
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 01:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhBZBHk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBZBHi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Feb 2021 20:07:38 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F0CC06178A
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 17:06:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a22so11991526ejv.9
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hshTohekKVzxbI8Gdg4o7wDfhyGczePTc6NMf/Dm1B0=;
        b=t8Jhg/Wo4q4oMpwBzWgLwhR2qoUKb1jrUkLmUrJbhzrdFa1lvtizQEf/FQBlf4CxX5
         kfPYsVQXSwyirI34aU5APwxO2Wi1OfjPAqb9789iPnqnUGIOrQm94kKJ3NVewuGJzH5q
         70hpGID4SGwqyrlm5Jj8QwiJPPyVoKoVCjS7xmzvr5kBP9/1CxPppioQGyLBb1DMP0de
         zRvcaQY7LJMjI8lnWjKJnJJC6GIlZRX0jSI0+vuNg0KJc0YcnLVf4wBJHJ+NfKYiXyAY
         c1KFNQucGUusUaHkNrxPdz/+qJZ0quh0PvJZlao46WMYwCEm0pWdnnSou1wVaY1KI51v
         famw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hshTohekKVzxbI8Gdg4o7wDfhyGczePTc6NMf/Dm1B0=;
        b=TAEXjczAtdX9jJK9ohbI5lq9h5V4AWbOrwHvIgOknykdrdaQjM5+DmNdfiqpDk9THN
         N9keR/re3XPH2npJtaYxk/fzXPV+SevDsNwyGRgIQd74k035vzPw250PKBl9vhy+jrK3
         VmGllBIbFxlYeIJIZU9w+ybxg8amrzCirRQMoeb+ZmozvLF9YT3pwsnAvR+vJqb9eVre
         ooR2jP3KJY0gVk6Dui9KLcgRBduVPTuNG3Lopv7SboFa+5qb3aJxVGPM8dQnjWU+d0ut
         qReKyfP96f3yZln1Z98U4pKUdXM/ZbGV+Mb+QExRMpJh3xn2hiZrQlbsyvDp6cR7KeEb
         W66Q==
X-Gm-Message-State: AOAM5331wCCJEDKmaku7MA3u5KbDqdO8zp9J0fSIdptLVHNDjnHTebEt
        p9vgL9VM+JHNqVLgVW2sr37aM4xwCsKhKtVvLH3v
X-Google-Smtp-Source: ABdhPJz9Ym22J+71vu28hduTtY1dbebaSSmN+CFMDHNnCACBgGb8WrLJ4GnFK7OSVWzIx5rZEe326i5FwFwvcgLs/QI=
X-Received: by 2002:a17:907:3e14:: with SMTP id hp20mr509206ejc.106.1614301616841;
 Thu, 25 Feb 2021 17:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
In-Reply-To: <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Feb 2021 20:06:45 -0500
Message-ID: <CAHC9VhSaU-3_fs83kEA5bxBf9xMsE29B_O5nXFpROk4=y9kgXw@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 24, 2021 at 4:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> After the switch to RCU, we now have:
> 1. Start live conversion of new entries.
> 2. Convert existing entries.
> 3. RCU-assign the new policy pointer to selinux_state.
> [!!! Now actually both old and new sidtab may be referenced by
> readers, since there is no synchronization barrier previously provided
> by the write lock.]
> 4. Wait for synchronize_rcu() to return.
> 5. Now only the new sidtab is visible to readers, so the old one can
> be destroyed.
>
> So the race can happen between 3. and 5., if one thread already sees
> the new sidtab and adds a new entry there, and a second thread still
> has the reference to the old sidtab and also tires to add a new entry;
> live-converting to the new sidtab, which it doesn't expect to change
> by itself. Unfortunately I failed to realize this when reviewing the
> patch :/

It is possible I'm not fully understanding the problem and/or missing
an important detail - it is rather tricky code, and RCU can be very
hard to reason at times - but I think we may be able to solve this
with some lock fixes inside sidtab_context_to_sid().  Let me try to
explain to see if we are on the same page here ...

The problem is when we have two (or more) threads trying to
add/convert the same context into a sid; the task with new_sidtab is
looking to add a new sidtab entry, while the task with old_sidtab is
looking to convert an entry in old_sidtab into a new entry in
new_sidtab.  Boom.

Looking at the code in sidtab_context_to_sid(), when we have two
sidtabs that are currently active (old_sidtab->convert pointer is
valid) and a task with old_sidtab attempts to add a new entry to both
sidtabs it first adds it to the old sidtab then it also adds it to the
new sidtab.  I believe the problem is that in this case while the task
grabs the old_sidtab->lock, it never grabs the new_sidtab->lock which
allows it to race with tasks that already see only new_sidtab.  I
think adding code to sidtab_context_to_sid() which grabs the
new_sidtab->lock when adding entries to the new_sidtab *should* solve
the problem.

Did I miss something important? ;)

-- 
paul moore
www.paul-moore.com
