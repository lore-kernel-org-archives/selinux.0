Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC825C433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DA422DCC
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzRKuiIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgHFR2H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgHFRBZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 13:01:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24075C061A16
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 05:05:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x69so44680412qkb.1
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=6e9MrL4aFkRge5/wiT6mJZvLnSt18s02jYLE7vZYEac=;
        b=RzRKuiIBTuVRqKPwlNt0d8GEwciWzJ5fAZKPWfeNrkRS6Ne1zcmslhaXicey60L4kn
         WzoqHYHdESQvBEzg4RUSgLtw9fJw1WeIIZ164oTUgucBtxG7axvJc+9mSPY8r3Iglf3a
         f21rU55Wv8In2BM9dgvQ3eG0BBozdS+gw7H13xqxj9UFo+At2jrQlCHL1zCYa9LikFez
         jTNuDyMv58qWcwLIwv9M2NqM0h6wSwj9HqEPIu/gBgjkT8HoPX9l2B3voMwGxZrsqj8I
         EVpz5UUw3E//WFXLV+QCWADU+d0csdXvkoz4T7/v8oOK6FfNopwDpwUTbqtvA0c5AnS/
         9M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6e9MrL4aFkRge5/wiT6mJZvLnSt18s02jYLE7vZYEac=;
        b=skFICpji1jLwmmD1cIGoEc4EUL8gcM6qW+xS2tnJpPV6Wx5TRE2247X42jHNXwVo1C
         3sUj2LlLWR1dX2YkRjHVhycqFpGs4s53uxkvYK/rSTBfwqqOTGYIvKVwjpz8zZbFqMCN
         ioObL5+aIf2DhpQ1EnRJ9mBDpCvZhUoWkJJxXqydKBVDtth7AjVf9is6K1C2kAIHLLsO
         /vwJ8oJw1EOlAPQ9o3gD1cezW3OwxeCYSSXToPfoRqB7BdiP1FBpMYWo/fhPuaSRCPSo
         6KyUniPID+alW0xb+XyVj6A05JdbAK7d1+Xqf5WcJw81udBOvPpeJc9A89CCrMq+Q/5H
         K4Iw==
X-Gm-Message-State: AOAM533FXm5rTyyBn5PtUaROlK+OyTwi3I/xmzYvl7ocs/qEg25sX9mw
        yc5j66RVVhKz/6nQuC7p4Ia2ByT9
X-Google-Smtp-Source: ABdhPJyI3yBw7WJ0uD0EpQ4K1f+n4UNbpUtHzwQyhC+CufizmgASDKzML9IliMvyYhwd2lcg2QRGFg==
X-Received: by 2002:a37:a2c2:: with SMTP id l185mr7856425qke.417.1596715553768;
        Thu, 06 Aug 2020 05:05:53 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id o17sm4578608qtr.13.2020.08.06.05.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:05:52 -0700 (PDT)
Subject: Re: [PATCH v6] libselinux: use kernel status page by default
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        selinux@vger.kernel.org
References: <20200805194312.7188-1-mike.palmiotto@crunchydata.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <56f3aed8-03e3-f847-967c-e9c8630f692b@gmail.com>
Date:   Thu, 6 Aug 2020 08:05:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805194312.7188-1-mike.palmiotto@crunchydata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/5/20 3:43 PM, Mike Palmiotto wrote:

> Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> /selinux/status") introduced the sestatus mechanism, which allows for
> mmap()'ing of the kernel status page as a replacement for avc_netlink.
>
> The mechanism was initially intended for userspace object managers that
> were calculating access decisions within their application and did not
> rely on the libselinux AVC implementation. In order to properly make use
> of sestatus within avc_has_perm(), the status mechanism needs to
> properly set avc internals during status events; else, avc_enforcing is
> never updated upon sestatus changes.
>
> This commit gets rid of the default avc_netlink_open() in
> avc_init_internal(), replacing it with selinux_status_open(). In the
> event that the kernel status page cannot be mapped, the netlink fallback
> will be used. By default, avc_has_perm_noaudit() and
> selinux_check_access() will now attempt to read the kernel status page,
> which removes a system call from two critical code paths.
>
> Since the AVC thread create/stop callbacks were intended to avoid a
> system call in the critical code path, they no longer need to be created
> by default. In the event that the kernel status page is successfully
> mapped, threads will not be created. Threads will still be
> created/stopped for the sestatus fallback codepaths.
>
> Userspace object managers that still need a netlink socket can call
> avc_netlink_acquire_fd() to open and/or obtain one.
>
> Update the manpage to reflect the new avc_netlink_acquire_fd()
> functionality.
>
> Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


