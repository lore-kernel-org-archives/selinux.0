Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305BAC169C4
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 23:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53A2218DA
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 23:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WC0vPa+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfBHXuC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:50:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34180 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBHXuC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Feb 2019 18:50:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id d9so2262827pgl.1
        for <selinux@vger.kernel.org>; Fri, 08 Feb 2019 15:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YHWqyblAo3CO+v/mPCcoaCeAr1CzMmx2d2e4oQUg/KQ=;
        b=WC0vPa+3Dri7UkxabNTcJQaOf5mGtxMJbAMagDVjnf7vtLJcx9MLBi6h2nlTS/ZTjz
         ZLqKeGO39qt3f0qfgiMP1YkM3f17uH87or1WYhqw5p39o4oHZVh1Y1U5Fj/VWcGcDNjQ
         35724xpri7Hq+PqJy5+Pv5+VR30bqLzCf8TDpSyNdIDniZOqj8DWZJ/73mvrx0GPjLjd
         kO1hfkJBDJjg1X9itJIq1fHHrjnf4NKQJ/1KdeQWPTSd2RslkDMyiRhi/Z3S3SYLBA7+
         DeZssR9KCq9aTY6CYvAUyWB84diT0xQ6yT8yQjcsG5jCgZWyDhZfQbucJWimNMGAvWUW
         lIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YHWqyblAo3CO+v/mPCcoaCeAr1CzMmx2d2e4oQUg/KQ=;
        b=H1dBykJ2kzErGpVWCK2+LLZHpWx9z6Asp1F+im/2xAGU6aFJXeHC8e69uX+OEvp5y3
         aU/uNRhtEbelXmOxeaanRXmMvV5tZnIw0ryWe/I83GucT2KZFrnwZt7PYiHUpB/YjihQ
         W18wnGxdORh5ZJujwCQ6sx+mZ02xEYqEa3ckuo7nSxkDjat1Rp2+3bbLo6U3wzs/sIGZ
         GQTLLgphretn3B7DuzdJYzjtFVypCxNzH/9NZfvH/cWvnQWXOVOFr12g88nJzHyin1jC
         Nm0D6sPRtunqR3MXq2q5r99jX3VGf3WvGu5txaO5T8DikYT/imiEKg3cyUPIPXY6+1b1
         5LPg==
X-Gm-Message-State: AHQUAuawYEPA3/dwxJAvIyViXUie98vvfC51RCHTTjFI7NUaRvXCknZV
        nnYiS6uVGkHy4UwmuTeV/Xrd/Q==
X-Google-Smtp-Source: AHgI3IY7/JSIPC6U9I+umqFX7/xRceqk3v2dKB47GQmQbCZ3uXe14yV8i8yf6PTzaa+IDUPUBOAzxw==
X-Received: by 2002:a63:d810:: with SMTP id b16mr17766883pgh.220.1549669801471;
        Fri, 08 Feb 2019 15:50:01 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m3sm5646043pfi.102.2019.02.08.15.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 15:50:00 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gsFuB-0001wS-So; Fri, 08 Feb 2019 16:49:59 -0700
Date:   Fri, 8 Feb 2019 16:49:59 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, selinux@vger.kernel.org,
        paul@paul-moore.com, ddutile@redhat.com
Subject: Re: [PATCH rdma-rc v1 0/4] IB selinux related fixes
Message-ID: <20190208234959.GA7442@ziepe.ca>
References: <20190202090945.4106-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202090945.4106-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 02, 2019 at 11:09:41AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This is second version of previously sent patch "IB/core: Don't register
> MAD agents for LSM notifications", due to the fact that we found extra
> things to fix during the review, I grouped that patch together with
> other fixes in that area.
> 
> Thanks
> 
> Daniel Jurgens (4):
>   IB/core: Unregister notifier before freeing MAD security
>   IB/core: Fix potential memory leak while creating MAD agents
>   IB/core: Eliminate a hole in MAD agent struct
>   IB/core: Don't register each MAD agent for LSM notifier

Applied to for-next

Thanks,
Jason
