Return-Path: <SRS0=b3nl=PF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E4AC43387
	for <selinux@archiver.kernel.org>; Fri, 28 Dec 2018 18:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB65520866
	for <selinux@archiver.kernel.org>; Fri, 28 Dec 2018 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546021930;
	bh=wETxS8yv5oz2j+Av9PXHzqyaT65DaOn8yQ5ajhQvc8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pE7MAu7/rX8g/KFSWRMclStWvk4ijQ3zOtymDdUhEhxZtAb0qRRUYp4e1afVcuCsy
	 TnPkMr7FTdrfOgcFGgWrog7FaA5CnQQqZTMbFys4onfYrZYlafyf7WwMxW3McSOrpq
	 fRg0pYzlp586L1E8Bkqhg59F8XmhKu0DhCu4HqgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbeL1ScK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:32:10 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40148 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeL1ScK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Dec 2018 13:32:10 -0500
Received: by mail-yw1-f68.google.com with SMTP id g194so7309385ywe.7;
        Fri, 28 Dec 2018 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zhibui6nYCIUyqevpVgofPw4n2CDQK0crqL94X3txcg=;
        b=Yc6ErdU96fjt9k1CPxxDiMsXxUT4+CAgmsojGiZyztp4Ixiok51gWlJkIeYtnQ1H78
         EMsMBL34t7V23yq5kuooH6YR0HdRIBwGinZl7KnJEC8fyYx4ijkK4P3XTHXn1TalvIm6
         Ta9ylH7hNYTaFT+L9mc1ispWOsk/kKzmRbpE5p+RINE2rQFfv0l2fuuZQRm4wf7fXK+v
         sdhHDyl+/p/XVdUgJLJL771AfBlkTDbBFYGOp2IuDp7ulB9oYZdx2acIXHzhoMFP4Wn0
         N/zn0NFiXAgAIs1jhSym5HraxZZElaJ7Dpw2InU5shxCrltuWLKRb6fdTB5VWou9B035
         u6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zhibui6nYCIUyqevpVgofPw4n2CDQK0crqL94X3txcg=;
        b=IN09I2P2HRP4qTMFpkyCIhz8dcYwkEjghUmd9TqeaYAoZburzPLAavmUoqkTvvLsjY
         axgHaAThppxD2T7qyvXmd0t1BT4ToElkexebL+Kl5kMzRiSTopkZl8YShvyflvh9HkE0
         /cAW9VeOYRVGVkbIErPURFwPyYrobUme1U6bXXhQE5XZ6YfuTKbv2Sj9Db0Bo56Wg9i7
         VZ4u/i/Y3aiXek0EuPvLaT5PZlX8REVm6lDlaQA+VnFImA6m02jKXsh0ya1X/HU0oyYS
         58F1SnPm+DeHao7G5PD3UpxmsS4Fm+ihHI3E//RDYWVdot/fy//WYArxGuPdJSX0uGeW
         J1aQ==
X-Gm-Message-State: AA+aEWbYoKQAKRvL71m4xEWV6bdBWvxFiCNo7vmUmNrl10qj7KJAQEUB
        q8m1tpjDt2QFenPFRiyi3oI=
X-Google-Smtp-Source: AFSGD/Vbk3IKc6Z6bDMgBy7hGvzFo0jcy06FYJJhLAmWKj75ny/Fg21UUUdG8Fz+k4L1KvFmEo3B+Q==
X-Received: by 2002:a81:a6d7:: with SMTP id d206mr28933728ywh.484.1546021928235;
        Fri, 28 Dec 2018 10:32:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4800])
        by smtp.gmail.com with ESMTPSA id f10sm25258547ywb.26.2018.12.28.10.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 10:32:07 -0800 (PST)
Date:   Fri, 28 Dec 2018 10:32:04 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 1/3] cgroup: fix parsing empty mount option string
Message-ID: <20181228183204.GM2509588@devbig004.ftw2.facebook.com>
References: <20181213141739.8534-1-omosnace@redhat.com>
 <20181213141739.8534-2-omosnace@redhat.com>
 <20181213160309.GT2509588@devbig004.ftw2.facebook.com>
 <CAFqZXNs+Zi0-6Syj9Uy4TajOQkukngafyUp_VW+VStzgorVYOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNs+Zi0-6Syj9Uy4TajOQkukngafyUp_VW+VStzgorVYOw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 28, 2018 at 04:14:01PM +0100, Ondrej Mosnacek wrote:
> > Applied to cgroup/for-4.21.
> 
> I still can't see the patch in your for-4.21 branch [1] (and it
> doesn't seem to be included in your 4.21-rc1 pull request either [2]).
> Did you perhaps forget to apply it?

Indeed.  I'll amend the pull request.

Thanks.

-- 
tejun
