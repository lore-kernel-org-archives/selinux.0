Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C27C433E0
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 20:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DDA64E07
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 20:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhBVUeZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhBVUeQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Feb 2021 15:34:16 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BECCC061786
        for <selinux@vger.kernel.org>; Mon, 22 Feb 2021 12:33:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id k13so29534782ejs.10
        for <selinux@vger.kernel.org>; Mon, 22 Feb 2021 12:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:references:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qWTFB28nRj/lNiQB70v1A1m5RvmxIiaGT4g0l6TJ6S8=;
        b=Ox4RF+MveJvDR3nn1/e7puhzLTwsBdRUriPRPqC/PsDBI/hojhTPbuhu4syK3JakKq
         MVan6zznUdqfbKGIWVBO9HKKMNhIeH0zvvdPMMmeU2i6YXyZp0YhqhBGEVJj3wUJXihQ
         gG4bGhwILpZRxlN3uBXdfVVXocuMR0ZpBBONEdvvFhls8d/lVE+hSiZJovK7GG6fcoJP
         HtIodvkkdZTYr5J5s2friyiSDeGguPtn2YPO2gL/4GYbFMV7V8xXCUiKw9dAXhiUaMI7
         5CF0wIe46r33nQkna+8vNgFcpl7+0mng/wFMKOVxOGw6kRyoWvoiFZMNG6lE92Vy8Ael
         R3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qWTFB28nRj/lNiQB70v1A1m5RvmxIiaGT4g0l6TJ6S8=;
        b=LPleShXziuLMGSGjRPb4owBcptGLPblLJySGb+JaI0MrckDKMMTPiRScOCMY/JgIcA
         ELINCKolUUoaLWqmPmB0QIrdj+dKIyRoH8d+5raVvrRjqKpX1wS4BDdpHZsFXcpam53H
         hSw9f+5itOH4Uu4Gqd+gJcUXdLC9HLiC53SdRfGSUDO3FMmZpb2mpcemPXdaCCy7pzLD
         3fmlSAmj0ZuSk5Z97R2fr2JR0LRyO3erwFXWqd/RnzOpuAcVUBTBjAr+kbg7oqhyFY2d
         3bcnpVBkda///EF+HYEoouzFOFm0oiBzPyQcsapybkt9acs1hyDjDeGuxqP5XdgnlQgB
         IBLQ==
X-Gm-Message-State: AOAM531RXnwQ74uhsCZLGax9BHEcnqSBPvo3oFQMLcRknjdEvFg90iAE
        CCFRVnXZn1s1cXM0SkfO0bvAJfnkSmc=
X-Google-Smtp-Source: ABdhPJxdOCmg00fbAk0SnoxHnhi2uK9x0P28BeMvv6bLhbkxOYXrMo8lbSPysnV0n+mCVGLG1785nA==
X-Received: by 2002:a17:906:3e42:: with SMTP id t2mr19947158eji.554.1614026014267;
        Mon, 22 Feb 2021 12:33:34 -0800 (PST)
Received: from ?IPv6:2001:a61:3570:aa01:ed31:9d1f:3ad:d0a5? ([2001:a61:3570:aa01:ed31:9d1f:3ad:d0a5])
        by smtp.gmail.com with ESMTPSA id bw22sm11097130ejb.78.2021.02.22.12.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 12:33:33 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     Petr Lautrbach <plautrba@redhat.com>,
        bauen1 <j2468h@googlemail.com>, selinux@vger.kernel.org
References: <CAEjxPJ5gK_DdNxpjMq8tvvhkq1hxsoE5vTNZAa=hiP-6s=an8Q@mail.gmail.com>
 <6b298117-2dd0-322a-4de2-b8886731265a@gmail.com> <87wnv0555e.fsf@redhat.com>
Subject: Re: [PATCH v2] chcat: allow usage if binary policy is inaccessible
Message-ID: <15f30b03-0734-9797-c529-693722daf4e0@gmail.com>
Date:   Mon, 22 Feb 2021 21:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87wnv0555e.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/22/21 7:27 PM, Petr Lautrbach wrote:
> bauen1 <j2468h@googlemail.com> writes:
> 
>> Currently, chcat will crash when run as regular user, because import
>> sepolicy throws an Exception when failing to access the binary policy
>> under /etc/selinux/${POLICYNAME}/policy/ which is inaccessible to
>> regular users.
>>
> 
> I'd rather follow Nicolas suggestion so I've prepared a patch, see
> below, which moves the policy initialization in sepolicy module before
> it's used for the first time. It seems to solve the same problem in more
> generic way. I need to run some tests on that and then they pass I'll
> propose it here on the mailing list.
> 

Yes, this is a much better approach.

-- 
bauen1
https://dn42.bauen1.xyz/
