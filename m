Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DFC433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32A8206DA
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 15:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzLsxyJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHTP2D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTP2B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 11:28:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D6C061385
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 08:28:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so1857802qka.3
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=QeBaOE/jjojLwV9Oa1OEVn5rjOXSZnNk6EPKZD+cLfo=;
        b=dzLsxyJuZEViK+BiVkB13NOcnImTU7O9DMeTHgaBrjZ4Dc+brJ9epI6V+/bNSqlXls
         +q2ei0KssLcR5S3WUUuxj5UHDeIxdLzYyaWtrUGVVt4MO/+JAZpRV0RJsh+KgUgtid0x
         54Tyz+88eYhHUPpag8YM2sHzh0cofsu0dsqiT2ZYjC7fqyHkQWaI/rxdCjQPiZXJG4R9
         d4ofUmGAvRypW0/6taQzyRYeQeJWB+Gr979zjkF9qkVFohwJp+xnHb2u3IQq+r+GCTUm
         FoV4FLoZL9kHyvxnDbrdG3c/AFO+fR9YsfmUlnHTabifERVLrisqaa5PfyIVbLWxFtYF
         GrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QeBaOE/jjojLwV9Oa1OEVn5rjOXSZnNk6EPKZD+cLfo=;
        b=I1p1OEcmjx1XbFtFpJbbiIqQgRzL8Sx3N9f4VP9ougRDl0dQ1U3EUAbOViGJuIKrtL
         HKUsjqtOBscvDyx+eyRuiTlYSGY9R9o7H7Z3rRLXy1gH+UFAlpdkjJOsaOZdHv4lV285
         8dDuWT9n9pVOK0xhIaih0Hb99mz5TrEylIzEizeZXWJoUKN9bbdWZ+reCPPbz9rl2ASE
         swOXqN+8uqGPZOXpV/lrvazhe6/db8A/MQaxfh448KRZk/VrQO1monut6KAEpO46G8EW
         t9WEixOi/fiZyvuV5tzYyemtEWrv/+1tRThxTLsksO6BovcsaPm9uBxW+44z/VFqUYPK
         vBxg==
X-Gm-Message-State: AOAM530ttJDlrtPgGYyOBVvX5nHuhlB4gn6v6N4AylvR9cOAZKb3ale5
        +5ZeRp7qXpiuD7KkJt1g+VgP1SPmT0U=
X-Google-Smtp-Source: ABdhPJxyjD/z65fB7S2Bcj/yUbV6CJvaLrfLbOCRZZBFwMuLBiU1jEXoOxujT9b6ZoYiXvC5MJxsxA==
X-Received: by 2002:a37:a543:: with SMTP id o64mr3056611qke.177.1597937280349;
        Thu, 20 Aug 2020 08:28:00 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id p33sm3499255qtp.49.2020.08.20.08.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 08:28:00 -0700 (PDT)
Subject: Re: [PATCH testsuite v3 2/2] travis: run the full testsuite on a
 Fedora VM
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200820084447.1030353-1-omosnace@redhat.com>
 <20200820084447.1030353-3-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <899c6b08-13fa-b5d4-04aa-7002fb67c842@gmail.com>
Date:   Thu, 20 Aug 2020 11:27:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820084447.1030353-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/20/20 4:44 AM, Ondrej Mosnacek wrote:

> This patch removes the old hackery to test-build the testsuite and
> replaces it with scripts that run the full testsuite on a Fedora VM. The
> scripts are based on William Roberts' work on SELinux userspace CI [1],
> which does a similar thing.
>
> This patch enables testing on Fedora 32 (the image ships with kernel
> 5.6.6) and Rawhide nightly images (with kernels close to mainline).
> Switching to other versions can be controlled via CI environment
> variables.
>
> One downside is that with this patch we lose the test build against
> refpolicy, but it shouldn't be too hard to add testing on a Debian VM
> with refpolicy later on.
>
> [1] https://github.com/SELinuxProject/selinux/commit/562d6d15272420542bf65da328bc5300219fce76
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
