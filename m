Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539C6C2D0A3
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 21:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0942084C
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 21:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BMXzJp7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgKBVMX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 16:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgKBVMX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 16:12:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11571C0617A6
        for <selinux@vger.kernel.org>; Mon,  2 Nov 2020 13:12:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x7so16232375wrl.3
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 13:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MP4xFQ7XEhHjxbgWUrh9t6LLrB84wd0BK5Z33Ue2kpw=;
        b=BMXzJp7YIS6ilanMd0viTQNzYhS0VpXv17iifbBerxB7OPUA2/OIqU82blbcg3g03F
         3XPeMm518BlrOJp4DugUZ3O64vlpQZWh6rb7D3Oy6OZM0CAd5iwFJx16gSJfXmzaP3Z1
         kSgWj3WO/DRCXyaPLDidWv/XI9yHM4LjtOLxwS54DU8pP/c+g7yraQhLbQB/I22rinD1
         giXOMb47FQZoHcdRcwSi4ULVrSPmw1OAxJgXJsDMMaKb+UXTk0GEVdnlzWNockuVwf8S
         JesvCO3/eZFw6aMkhLUaZeWSmG2HoJOH0tX09rHxCzhIADHe02VtB7tRH92INqu6KJlJ
         CKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MP4xFQ7XEhHjxbgWUrh9t6LLrB84wd0BK5Z33Ue2kpw=;
        b=YS4c379Mn4Q5F5Rz19a1hFLDFxG3sA414PQ7M/+s3FTpGmnJh7yItams2mKeMoU6V0
         0aJu0GamDRtnkCvUkQ4/6qYNWH9EEYkD2s3laViJbpRqgIn39PcWY35bMZwILP0PLimY
         kkQ4vaujxYB9RoD/n4Tz0LnslJrUGIZMnKoyaiO7L+576mKZOUH6DqIWwKNsSwgtGUqC
         B9amCBR2MtFalg6DyrSP+SyKWtCeWnaKsjvtghIUojsyNRe1f2E8wrdhLPv0/o9txir4
         XCp01RmGc+Uj9ScDtFCKK4lrz6nDm/v2cDUc/EN2JGQt+gZwttxh9Ei7veG480nds+GS
         WGgQ==
X-Gm-Message-State: AOAM530g8bIVADdKnckPAIjBK4GZiz4R3AOOhLYBaQuSF3kZnX3+3feg
        zOnZM6k7Jq76gST1MNBw0x8SxDIcUU0=
X-Google-Smtp-Source: ABdhPJyMh0oVTIOinLe5oFuj4mUelWIf7ME+s0Ac6+BiJ60qjTofrze+4w9/AgN0K+vVn/GWQVFddA==
X-Received: by 2002:adf:a303:: with SMTP id c3mr22235552wrb.417.1604351541534;
        Mon, 02 Nov 2020 13:12:21 -0800 (PST)
Received: from ?IPv6:2001:a61:3488:4001:8f3c:31bd:604b:4bac? ([2001:a61:3488:4001:8f3c:31bd:604b:4bac])
        by smtp.gmail.com with ESMTPSA id j9sm20817220wrr.49.2020.11.02.13.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 13:12:20 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: Re: homedir file context definitions
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <495ea932-98d8-d413-6be3-36b0d5c1e17d@redhat.com>
Message-ID: <eaac3faf-c936-af2b-9dce-5d20db8fd289@gmail.com>
Date:   Mon, 2 Nov 2020 22:12:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <495ea932-98d8-d413-6be3-36b0d5c1e17d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 11/2/20 9:45 PM, Vit Mojzis wrote:
> when investigating a bug report [1], I found that homedir context definitions (specified in .fc file) are changed based on the corresponding user (selinux user, role and mls level from the context definition are replaced - [2]).
> While replacing the selinux user and role makes sense, I'm wondering if the mls level from each homedir context definition should instead be compared to corresponding user's mls range (and either kept or replaced to ensure given user has access to it).
> 
> I have no problem with writing the patch, but I could use help understanding what the correct behaviour should be (and why).

I would also be interested in a patch that allows specifying the "user level" i.e. the mls part of home directory file contexts as a range.
In my policy objects can also have a range where low specifies the confidentiality level and high the integrity level of a file, and it would be quite useful to have user directories default to low-high.
I might have already posted something about this to the mailing list but I'm not sure.

-- 
bauen1
https://dn42.bauen1.xyz/
