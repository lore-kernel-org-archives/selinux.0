Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E5C433EF
	for <selinux@archiver.kernel.org>; Sat, 25 Sep 2021 21:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2CC61019
	for <selinux@archiver.kernel.org>; Sat, 25 Sep 2021 21:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhIYVJT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 25 Sep 2021 17:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhIYVJT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 25 Sep 2021 17:09:19 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C5BC061570
        for <selinux@vger.kernel.org>; Sat, 25 Sep 2021 14:07:44 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 138so31984593qko.10
        for <selinux@vger.kernel.org>; Sat, 25 Sep 2021 14:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/SGkRPBSB8dPRPRXA9OlKy7WPjmR8rq7KbrmQpk4oWY=;
        b=BzJ3ZpTzm6vISNhNRaGgfNex55RmBtbT6i1sXYkp6w9FbkPpeTqYxQ/IsYLPwS7ANB
         IFJnMzKv6xyaFyj13xCY/0BdcF1QpQ1CkF57aE0tA+pMdQ3QghWe8/PdCE8Fcipyc61k
         w3ZQiTjjVlIeqacbAdQbnmEjk0H0VcBkJJHDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/SGkRPBSB8dPRPRXA9OlKy7WPjmR8rq7KbrmQpk4oWY=;
        b=Gq4HHUsIN+5HbOHLO9qUTjm2v+27pSl+ONbFtld16s1nSkJjNXWOVJanbL/gU6Y/ll
         cQrgOSZiKbWRNx54m9P4j5wjxS3/1k4Ra/cMylyE2DrbQtZkiOoZ75Jt2iKBAaHcmsxR
         54ic65rgwu13Rj+UPx3na8T1oZzqfWRKpYKq9V4ToWR+5l45G4YXdSn7QW1yW4vnn2g5
         uVUTyW6zeaStMw9lBJeXxFawTBdXWSjSI1pPIeCsOHXakQqJSPIJ8AJPBDLYRTD9wJzR
         DdzPWOBpaA+ZskQcV2g7b7If7XkybiMQ1m5znjoAJnM4j5z81Ywf9noMfBWKvu6Mkdg1
         NXPw==
X-Gm-Message-State: AOAM533d/zIwDUZxTUM2hAYpzaO3ULUMZxmnX8VK5Q/pBDlJ1faLMqCt
        b2yNjIakTvQUXgTBsNF6LSky1tAhOcYn2Q==
X-Google-Smtp-Source: ABdhPJy6nlSDJRak7aFaQBgaV5yZQvPIuKQf1jrPbTIUNgf2HbK4JdhVm7hND+d8Vx1VjJ87uGR7rA==
X-Received: by 2002:a37:9543:: with SMTP id x64mr17317076qkd.281.1632604062808;
        Sat, 25 Sep 2021 14:07:42 -0700 (PDT)
Received: from fedora.pebenito.net ([72.85.44.115])
        by smtp.gmail.com with ESMTPSA id u13sm8716182qki.38.2021.09.25.14.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Sep 2021 14:07:42 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux: use SECINITSID_KERNEL as the subj/obj in the
 lockdown hook
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <163243191040.178880.4295195865966623164.stgit@olly>
 <CAEjxPJ5pxox=oE0TxmEFA-PkFGPDbAjtK_nqM3y-xaT0e3or0w@mail.gmail.com>
 <CAHC9VhTAY0povyGpv3QhiE9n4WDmnSYTi9Cq8ZnVO_AkH8M6EA@mail.gmail.com>
 <CAEjxPJ7wkCyPZb7h3C_U3zVmJtiVtm4FAi5K+6U7kS63g0Vm-w@mail.gmail.com>
From:   Chris PeBenito <pebenito@ieee.org>
Message-ID: <38bc94ba-b200-e141-2423-6c7f64234a10@ieee.org>
Date:   Sat, 25 Sep 2021 17:07:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7wkCyPZb7h3C_U3zVmJtiVtm4FAi5K+6U7kS63g0Vm-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/24/21 11:12 AM, Stephen Smalley wrote:
> On Fri, Sep 24, 2021 at 10:22 AM Paul Moore <paul@paul-moore.com> wrote:
>>> On Thu, Sep 23, 2021 at 5:18 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> The original SELinux lockdown implementation in 59438b46471a
>>>> ("security,lockdown,selinux: implement SELinux lockdown") used the
>>>> current task's credentials as both the subject and object in the
>>>> SELinux lockdown hook, selinux_lockdown().  Unfortunately that
>>>> proved to be incorrect in a number of cases as the core kernel was
>>>> calling the LSM lockdown hook in places where the credentials from
>>>> the "current" task_struct were not the correct credentials to use
>>>> in the SELinux access check.
>>>>
>>>> Attempts were made to resolve this by adding a credential pointer
>>>> to the LSM lockdown hook as well as suggesting that the single hook
>>>> be split into two: one for user tasks, one for kernel tasks; however
>>>> neither approach was deemed acceptable by Linus.
>>>>
>>>> In order to resolve the problem of an incorrect SELinux domain being
>>>> used in the lockdown check, this patch makes the decision to perform
>>>> all of the lockdown access control checks against the
>>>> SECINITSID_KERNEL domain.  This is far from ideal, but it is what
>>>> we have available to us at this point in time.

> Can we get Linux distro and Android folks to speak as to whether they
> consider the check in this reduced form to still be useful or whether
> we should just remove it altogether?

FWIW, I think the check should be removed.

-- 
Chris PeBenito
