Return-Path: <SRS0=nyjS=2N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94620C2D0C0
	for <selinux@archiver.kernel.org>; Mon, 23 Dec 2019 21:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64428207FF
	for <selinux@archiver.kernel.org>; Mon, 23 Dec 2019 21:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AHY1kkqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLWVhy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Dec 2019 16:37:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34057 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfLWVhy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Dec 2019 16:37:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id z22so14223612ljg.1
        for <selinux@vger.kernel.org>; Mon, 23 Dec 2019 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMvN3IfikatrxqeZLIO+wKS6AjEL5TBJnJcInwPc4v4=;
        b=AHY1kkqkbL1tyy0EQQ2o/SCXBRNog8yZ62J7u1trb0v/5+rMwfBnjLsRlYVIrsoH2x
         7x1ydt+L97VLLbGvLV9tURyW7dF0P8ZB0exo9F9mH/lSxP3GeX1+9Bk9srnVE0X9mXyl
         I487XNsOYBklM8DDxsGBuBcnAkjeBi036ZQ6fx9P9RINmqqpH6xALb59aZrDGC4LEeIx
         6pn57qESQhukSkHQSaZ5yWrODtPOo5D9Ax/SZ9kfIPfbeTWCDlWiJhkYhcGy3kvmFuPC
         Jh9M97fnE8K+wSPWc0k5+iOIExBXQIXHdikT9YEse63GbYy/sxj9jh0h3So4Nnlo+nQ1
         Mkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMvN3IfikatrxqeZLIO+wKS6AjEL5TBJnJcInwPc4v4=;
        b=C+bT0hHxdfPulKAteqRz8WuPrduNBecJTooEDnmBIsfvdvLG4/FJ5XJFwI7D0WlnxA
         lUs2FeaGAOUF5RkYVsGbuuswCNsO6aENV0STZXF7LnXSuBqP0hDkp9Ovr4AEnvQTZumL
         +VezX4Wnv4Pg/TYc7OF7fQvtCvjSliBCI1MtdHnmQ5PSmroOcu3zC7Se8Z+r21VuwvRI
         5PKHm5wbINglN41Ky9RWlt7eFboCpK/nf6V2BTZ7zfMgxWfx+Ka3+mwpfzKcMN7xgJvM
         S/4y03wBxoNWFRSrHSMB+ofNmCkrFcCAtZj6kBHXgO7rEr6TQn3Z2+FBcr5ohVYKRWb9
         zkYQ==
X-Gm-Message-State: APjAAAUozJCuoyrH6RAtnD7bI5dnSDYo2voy+PL6uOtxdSHrX+F1kXGN
        DOvt93+d3zAazZtACatyG5mnuuvxMifDdgYylSip
X-Google-Smtp-Source: APXvYqxoPcTQjHi2HpjbnyoXdggoClkjePbiD8iRyX3l8RqNHg5v4Ul7+zS6oq66FdgU5U9Vg18wI1qDl/piB1Yq6rs=
X-Received: by 2002:a2e:800b:: with SMTP id j11mr17392415ljg.126.1577137072223;
 Mon, 23 Dec 2019 13:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20191223091512.GL2760@shao2-debian> <CAHC9VhQfCmWbd7Yt0Jcz-QpSqXidri5PNgb_514+sfah5w3K6g@mail.gmail.com>
In-Reply-To: <CAHC9VhQfCmWbd7Yt0Jcz-QpSqXidri5PNgb_514+sfah5w3K6g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Dec 2019 16:37:40 -0500
Message-ID: <CAHC9VhQTphqNxZ7ndNRCy-iff3ugFjLan+CoWT8v6joF_smNzg@mail.gmail.com>
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

On Mon, Dec 23, 2019 at 9:37 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Dec 23, 2019 at 4:15 AM kernel test robot <lkp@intel.com> wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: 66f8e2f03c02e812002f8e9e465681cc62edda5b ("selinux: sidtab reverse lookup hash table")
> > https://git.kernel.org/cgit/linux/kernel/git/pcmoore/selinux.git next
> >
> > ...
>
> Jeff, please look into this.  I suspect we may need to check
> state->initialized in security_sidtab_hash_stats(...) (or similar).

I realized that Jeff may very well be on a holiday so I took a closer
look and this does appear to be the/a problem.  If you try to "cat
/sys/fs/selinux/ss/sidtab_hash_stats" on a system where the policy
hasn't been loaded it blows up in a bad way.  I'll write up a fix
right now and post it as soon as I've verified it fixes the problem.

-- 
paul moore
www.paul-moore.com
