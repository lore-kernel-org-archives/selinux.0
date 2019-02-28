Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A5C10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 21:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61033218B0
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 21:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="eWkM1v9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfB1V7H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:59:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39542 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfB1V7H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 16:59:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id g80so18559358ljg.6
        for <selinux@vger.kernel.org>; Thu, 28 Feb 2019 13:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOnicnaPZLCx6rhRdGG6VdZxKzqTd1h0e7AH5mlj0Ww=;
        b=eWkM1v9p3AgleI0PEaZgq0sH42aT2smd6ffJAqitKFxyTu0xCzYmdnWAlS9/eQLDS2
         HNOI9ptpnwMtbo8tDK/V88pEQf1UxsqmMCPSErcLpQ6sJSbsWT+QmacBe9BPdqEmwEKN
         rpt+e51CHxKxrzqPCkz55MlUIg7PqywcCC4wwP5EaLvH8ZGaJWuKKAKdZ0qSY9CH9QEE
         0NG1NXSySk48plCn78/mpkoYvpzGB/jnkMxnKZDCYuGR7sqzOVoctb75AUPT0XSb/TAA
         1DcO8CiLgMU7y07GBsKblk8vkAtcecGTAaF3UGeeYNI4UoyQYyxVj4WxKurZ2jvoH/bX
         izSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOnicnaPZLCx6rhRdGG6VdZxKzqTd1h0e7AH5mlj0Ww=;
        b=ZIMmL5GtNzoZm3fQj86hANpOe8WgpEvCABq22VuEnnMiEe4k0nq5OH3af+F1/6YZLp
         ddzQNHFibz4HNjbCCe+eJmGsoCWD7JakxVjTXO0zd+Axuh9vnqDNDf57yfMRb0ndYxRH
         vtBLUtj/1bWrQZjsWrk0Off7BGOI6hgBmTbcnVs5X7RqMQEUv5cT8C1Rj6jFdSLzoPF6
         rq8UkPwr31xWLd7NmMPHf8Gy2TjtGxPIUTTdsCc3tSx1qUu1kqoNAca5oYwTQsj/sEXv
         InJM084+4OBnRcw27YkICM7YJLty22ysX56ohsLZkV9LXWkpFvmJpn6JG+5cXBklf8ll
         Njcg==
X-Gm-Message-State: APjAAAWnxA9h2zpa8ewY1c13Sa3VP5nISNNqjGMHZDQq46pXBQ8Kqexg
        OU4Bvb01Y9UmVLywgeHnFfQVTgrsilWxFHxEZRQWUOw=
X-Google-Smtp-Source: APXvYqyJChQNxC6nqcUzcnScClvZGd4866+CgcqlfiDeqn7QROXkMpI9N9RVxkTSi7ikY+hW3e8X9IUHraFZrhTFxIA=
X-Received: by 2002:a2e:413:: with SMTP id 19mr628819lje.196.1551391145080;
 Thu, 28 Feb 2019 13:59:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1v04mouWw@mail.gmail.com>
In-Reply-To: <CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1v04mouWw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Feb 2019 16:58:53 -0500
Message-ID: <CAHC9VhR1ZNyZqGB3Si-z77zLwaTBf-pkQk19rVqofs4P_oVtFg@mail.gmail.com>
Subject: Re: IB pkey policy problem found via the selinux-testsuite
To:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Cc:     Lukas Vrabec <lvrabec@redhat.com>, danielj@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 13, 2019 at 4:35 PM Paul Moore <paul@paul-moore.com> wrote:
> Hello all,
>
> On a fully up-to-date Rawhide system you need the following line added
> to the policy/test_ibpkey.te file to get a clean run of the
> selinux-testsuite:
>
>   allow test_ibpkey_access_t self:capability { ipc_lock };
>
> The breakage doesn't appear to be due to a kernel change (previously
> working kernels now fail), or a Fedora Rawhide policy change (nothing
> relevant changed since the last clean run), but I did notice that my
> libibverbs package was updated just prior to the breakage.  I haven't
> had the time to dig into the library code, but I expect that to be the
> source of the problem.

Just to be clear, I don't believe this breakage is limited to the test
suite, I expect any users of the SELinux IB hooks will run into this
problem.  I believe we need to update the upstream and distro
policies.

-- 
paul moore
www.paul-moore.com
