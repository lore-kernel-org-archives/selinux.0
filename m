Return-Path: <SRS0=hg1M=T6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1B0C28CC0
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 09:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0852547A
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 09:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li64GW8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfE3JYw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 May 2019 05:24:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33768 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfE3JYw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 May 2019 05:24:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so2330876plq.0;
        Thu, 30 May 2019 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TSm5If1axkhBC10X4aY5pi8UcYtCt09qdX35aB2u9qg=;
        b=li64GW8H/Ah9ummMZPe0UV7DeHLl81MSAqn6hmQWhVa7fZU6yQvi5/bq4u9Jn9wMpa
         PEuA4XBpY7QV6+xUS+AJ1YX34wfX439gDnv+huhpnrXlUxutkpFolQnyS87ZAO1aGtBM
         IbBW/8w8OKBoicfI0SryiJsGfBOtfVzW9E1dx56/uGN25l5Qv8S2iYeqJ6TPJToVawIY
         0Z/8ELvdOBIiwfRlmTEnvf9y/2/nmLVQRYZOMsAkZCns0OVtaL/I/5Dk/PPq6Kz/g/Ay
         /xNblYyz9ucpT0K9FZRcyHboUlJHN04oyHGU3qNMpcjwNErf9seS15pKohce/0ekSg5r
         0+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TSm5If1axkhBC10X4aY5pi8UcYtCt09qdX35aB2u9qg=;
        b=qO/mQRosNZ3qBYQ0PVMeorYifpLjlG5kHqlISLXCI+9a8Iq2ElnXa+n6sZcWfGfb/g
         YfbXZ1zS1B+svLTHlB6QUgaXMKzrJROhluLd5ZwbyqQJDAe4fTjYnrelGQVgmSatpKEN
         CfbLT3dVTiBmcndAKBi2eLbwv0JgNEmdFT+rvlRAcmTIcDDl6+744sZjBAwBVcQyVivv
         w7ot0dZzr2VY0tW3wvOyLROwT7f7hyw6RQPcBiFhYjb+oOwXQC9YMIv3fwSE26OZ68bS
         vGCDv65BJc2GQY+2JOkL56s7MbmPAlJ1jptvD/4k+tnSP6VRkS6uEXmTsJoLt/pvEfNO
         ZP/A==
X-Gm-Message-State: APjAAAWlgLV5V0/tAiLDhNiJMgGva8ht5PQvHWi8yG/TJyTzSrf5ZEU6
        x8H7Ld7AqImWPQ76hMBo/qw=
X-Google-Smtp-Source: APXvYqwWpiD1XEzg5ZgrnUus/WfE9ll8IA/MMoH9m33b0L8Vx7WSs0yomD12CgzCoKsRLXkE7aQmYQ==
X-Received: by 2002:a17:902:20e2:: with SMTP id v31mr2826387plg.138.1559208291700;
        Thu, 30 May 2019 02:24:51 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id n2sm1822040pgp.27.2019.05.30.02.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:24:51 -0700 (PDT)
Date:   Thu, 30 May 2019 17:24:26 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        ccross@android.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] hooks: fix a missing-check bug in selinux_add_mnt_opt()
Message-ID: <20190530092426.GA3666@zhanggen-UX430UQ>
References: <20190530080602.GA3600@zhanggen-UX430UQ>
 <e92b727a-bf5f-669a-18d8-7518a248c04c@cogentembedded.com>
 <20190530091848.GA3499@zhanggen-UX430UQ>
 <236195a3-b607-5cf6-ac60-8c5ea2e95b41@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <236195a3-b607-5cf6-ac60-8c5ea2e95b41@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 30, 2019 at 12:22:15PM +0300, Sergei Shtylyov wrote:
> On 30.05.2019 12:18, Gen Zhang wrote:
> 
> >>On 30.05.2019 11:06, Gen Zhang wrote:
> >>
> >>>In selinux_add_mnt_opt(), 'val' is allcoted by kmemdup_nul(). It returns
> >>
> >>    Allocated?
> 
> >Thanks for your reply, Sergei. I used 'allocated' because kmemdup_nul()
> >does some allocation in its implementation. And its docs descrips:
> 
>    Describes?
> 
> >"Return: newly allocated copy of @s with NUL-termination or %NULL in
> >case of error". I think it is proper to use 'allocated' here. But it
> >could be 'assigned', which is better, right?
> 
>    I was only trying to point out the typos in this word. :-)
> 
> >Thanks
> >Gen
> >>
> >>>NULL when fails. So 'val' should be checked.
> >>>
> >>>Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> >>[...]
> 
> MBR, Sergei
Well, my mistake. Thanks for your comments, Sergei!

Thanks
Gen
