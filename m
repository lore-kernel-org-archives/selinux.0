Return-Path: <SRS0=nyjS=2N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1D4C2D0C0
	for <selinux@archiver.kernel.org>; Mon, 23 Dec 2019 23:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06722073A
	for <selinux@archiver.kernel.org>; Mon, 23 Dec 2019 23:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0xXZYnb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLWXEV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Dec 2019 18:04:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46018 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfLWXEV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Dec 2019 18:04:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so19194001ljc.12
        for <selinux@vger.kernel.org>; Mon, 23 Dec 2019 15:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqcM5KAJpHOe8eLSgLngBPY9ypcT9P0u+Smp9zSx9A8=;
        b=0xXZYnb8QnwbXAHlOLPUGD1wCQM6TKxYnus3UgKSK3BlL96TRO5VwxXPG00q9BF1ED
         4eHaXQTCjWF7EEilm1T01Kxn/euMgK3DQd6PxYEArE3e2Eo2fjlqvCve5N86/SsxfinU
         ETq4Qn7d4cyRSX1IPYngwXTtp1FhJrKbGKCE4lvpqC/nqyEc+1BgufHmVy1Pstp72Sg4
         x6BKPedT0yPjHdkD60JvO5Hm6DJpt1Mi1cX+4YdcZ7SSgCaLhys68c6Dg+8aeODVkhej
         HJY8YM31466Wt0HQFF9RBi02MR1UBHIsKDicnLGbrhOHzxYoAcqdwL1qT+r4d+ya57Jj
         O4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqcM5KAJpHOe8eLSgLngBPY9ypcT9P0u+Smp9zSx9A8=;
        b=s/XqGSyXwKFrZ8hhu1J28sTxS+L8CDstw63PMTtfMFlwoDp2lLnVZjnMyK2ZPm2/ld
         Qj8uzRK59FJecThUaVVPj09knuQFK0pADb98vYM9BF0DFU6y/TUi99HAl2sHVbptvN7E
         Kul8UvXX3YI+MPNj9sN9o1PVQ4CjtYLlYzBy5Tdew0QrDjb3ptgGooy3F9Y5aiEeI6fo
         qj22bYi/03HDKqLWjIyaCZ/+6hP/gTdyISdAJsjD+/Ko8lgXMcLIBpTWF/3JgT5h3wai
         CSfL8AxExJyDAVRpCihhnh02zvMOwUQgpSvJ8fUDd7wqnkVtNXZu2o/yiaOGTV+BMsgV
         +fUg==
X-Gm-Message-State: APjAAAX/pl5KyyfiAl6T27+btpPIN0EfZABAInezwubw2qtV5A/kqC1j
        Lz/ANB7ib6Rur828JtgVfHaEeWuq/1TV85G77Yvl
X-Google-Smtp-Source: APXvYqwda+FhAcECcjhJDxyGrrZLaWhGpF6NXxaEM1hxiD4YQtrzA+OPxse+ZO6ck/mpXGfD95Ihjtj3nkRVb9AA1vE=
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr18948349ljj.243.1577142259137;
 Mon, 23 Dec 2019 15:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20191223091512.GL2760@shao2-debian> <CAHC9VhQfCmWbd7Yt0Jcz-QpSqXidri5PNgb_514+sfah5w3K6g@mail.gmail.com>
 <CAHC9VhQTphqNxZ7ndNRCy-iff3ugFjLan+CoWT8v6joF_smNzg@mail.gmail.com>
In-Reply-To: <CAHC9VhQTphqNxZ7ndNRCy-iff3ugFjLan+CoWT8v6joF_smNzg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Dec 2019 18:04:08 -0500
Message-ID: <CAHC9VhTK2oi6OcEUPZPRhvKA1RG2+-iyZFfMuKYDZ_cAo9063g@mail.gmail.com>
Subject: Re: [selinux] 66f8e2f03c: RIP:sidtab_hash_stats
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>,
        LKML <linux-kernel@vger.kernel.org>, selinux@vger.kernel.org,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 23, 2019 at 4:37 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Dec 23, 2019 at 9:37 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Dec 23, 2019 at 4:15 AM kernel test robot <lkp@intel.com> wrote:
> > > FYI, we noticed the following commit (built with gcc-7):
> > >
> > > commit: 66f8e2f03c02e812002f8e9e465681cc62edda5b ("selinux: sidtab reverse lookup hash table")
> > > https://git.kernel.org/cgit/linux/kernel/git/pcmoore/selinux.git next
> > >
> > > ...
> >
> > Jeff, please look into this.  I suspect we may need to check
> > state->initialized in security_sidtab_hash_stats(...) (or similar).
>
> I realized that Jeff may very well be on a holiday so I took a closer
> look and this does appear to be the/a problem.  If you try to "cat
> /sys/fs/selinux/ss/sidtab_hash_stats" on a system where the policy
> hasn't been loaded it blows up in a bad way.  I'll write up a fix
> right now and post it as soon as I've verified it fixes the problem.

Fix posted (see archive link below) and merged into selinux/next.
Thanks for the problem report test robot!

https://lore.kernel.org/selinux/157714208320.505827.13006028554511851520.stgit@chester

-- 
paul moore
www.paul-moore.com
