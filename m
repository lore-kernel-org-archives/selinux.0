Return-Path: <SRS0=snKE=RM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC52C43381
	for <selinux@archiver.kernel.org>; Sat,  9 Mar 2019 02:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4432081B
	for <selinux@archiver.kernel.org>; Sat,  9 Mar 2019 02:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="emGisPRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfCICsK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Mar 2019 21:48:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33721 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfCICsJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Mar 2019 21:48:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id z7so19041942lji.0
        for <selinux@vger.kernel.org>; Fri, 08 Mar 2019 18:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYWvC2l1xA4YrcNPzDAHfJqVVW9Dp1XzT55iJTupNtU=;
        b=emGisPRKEzxAIbjHwMl6kzuAQ2EEbGTqxQL4Kyo1NURG8bcx6EaBI+rHK7JqKQC/bj
         74d3MGfOMio2DsV3G0PWs9X5SAprW5DO6cQwuZ3Kdw2vfr6GEF9Vuoxi3lyhjIdxO7mf
         HTsipAFtPg9a7ekYVXwxScHoizGNHc+brW2zl9/QZuzej2X0FM+43o8LzFLKAgBCuBGh
         ii09NdOylTmoP+9YqFaYT7ppCXkM0juf95MxUQ1S6CNsuOlxLIdqeKRdIDjXLBCj5kI4
         iI4lxOEiNUe8d7+kURiPeF9RmDb/zr4TmeN2Iv+KJpH7Ky0pzcrf9MQi6ZyA2qeCk7KG
         apJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYWvC2l1xA4YrcNPzDAHfJqVVW9Dp1XzT55iJTupNtU=;
        b=iEShlYV1MF6jDQubPOvHZEvsqQrELfIqel0LWRXCul9O2Tf5t6Muj9Ru2FfOkbBKlf
         B2RxbqraTZ4ADCQyAnFG9aoAy/PXqMmFAd6iXACBUK3QV6G0N0IqxqoDAFXAmWlPwrze
         jyp1Yw3sovd7NJ6YmW8hIOt+WACJRAjeI3PbH3YrBi3mOClc7V9E4XmQu4BioutTySCq
         IWiYXVVeHYLcakL49Sz1ji2Tp2TrTakWHubF4TU+d64EAHMsauqqf8OUhdMA9tPTSS3J
         4Bzb2Ph+w1LIZkDwQYi7GgVAEkadHpV5Bu5dYcihN8yUWwaIe4B7v6I2kl5oH+jhSnJT
         9Rkg==
X-Gm-Message-State: APjAAAV9zlsYlBAAan85Z9mAZ8HEPcMIcrQA/lJ36tAQibdz2/KPy1Ab
        7pOgwIkXDgHD3M0s+tr+hxzg5sebaiSE7wds/vOv
X-Google-Smtp-Source: APXvYqzNN+JwNXYH0+PAql7bqmDnTiYsTs3kVHY/nT2DhZW2XjHsqjtoM4aiyFDvTT830CitUaDyJ01CY1yUOL65aI0=
X-Received: by 2002:a2e:7a08:: with SMTP id v8mr10700626ljc.161.1552099686938;
 Fri, 08 Mar 2019 18:48:06 -0800 (PST)
MIME-Version: 1.0
References: <1e5accb3a4a5575ada1dbdfc6e5d9e4358131f83.1552061254.git.lucien.xin@gmail.com>
 <20190308170838.GF13515@localhost.localdomain>
In-Reply-To: <20190308170838.GF13515@localhost.localdomain>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 8 Mar 2019 21:47:56 -0500
Message-ID: <CAHC9VhSdkFORw88rusQ6Kzr3zFX9HB_GNkrbB2LViqOb1ozUzg@mail.gmail.com>
Subject: Re: [PATCH net] selinux: add the missing walk_size + len check in selinux_sctp_bind_connect
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Cc:     selinux@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 8, 2019 at 12:08 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> On Sat, Mar 09, 2019 at 12:07:34AM +0800, Xin Long wrote:
> > As does in __sctp_connect(), when checking addrs in a while loop, after
> > get the addr len according to sa_family, it's necessary to do the check
> > walk_size + af->sockaddr_len > addrs_size to make sure it won't access
> > an out-of-bounds addr.
> >
> > The same thing is needed in selinux_sctp_bind_connect(), otherwise an
> > out-of-bounds issue can be triggered:
> >
> >   [14548.772313] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x1aa/0x1f0
> >   [14548.927083] Call Trace:
> >   [14548.938072]  dump_stack+0x9a/0xe9
> >   [14548.953015]  print_address_description+0x65/0x22e
> >   [14548.996524]  kasan_report.cold.6+0x92/0x1a6
> >   [14549.015335]  selinux_sctp_bind_connect+0x1aa/0x1f0
> >   [14549.036947]  security_sctp_bind_connect+0x58/0x90
> >   [14549.058142]  __sctp_setsockopt_connectx+0x5a/0x150 [sctp]
> >   [14549.081650]  sctp_setsockopt.part.24+0x1322/0x3ce0 [sctp]
> >
> > Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> > Reported-by: Chunyu Hu <chuhu@redhat.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
>
> Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Thanks, this patch looks good to me.

> Paul, how can we get this into -stable trees? SELinux process may be
> different from -net trees.

For patches that warrant inclusion in -stable, I merge them into the
current selinux/stable-X.Y and send it up to Linus once it passes some
basic sanity tests.  Since we're still only half-way through the merge
window, and this is an obvious bug fix, I think this qualifies as
-stable material.

I'm traveling at the moment with not-so-great connectivity, but I'll
get this merged and verified early next week.

-- 
paul moore
www.paul-moore.com
