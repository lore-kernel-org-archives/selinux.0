Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A9C433EF
	for <selinux@archiver.kernel.org>; Thu,  6 Jan 2022 19:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbiAFTmK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbiAFTmK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jan 2022 14:42:10 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8CFC061245
        for <selinux@vger.kernel.org>; Thu,  6 Jan 2022 11:42:09 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id q4so3341364qvh.9
        for <selinux@vger.kernel.org>; Thu, 06 Jan 2022 11:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:content-transfer-encoding;
        bh=XFLTzc3mQnE2NhCM0FHvqlpQckzaxu6j0ere81B+tEU=;
        b=GPrr3qcvYno2TBE2H5FN6GaTe/f9cGbuzRThyfII/fxwqo3RckgrkIuREICvQyH9s7
         AOaGvLfFXI8Gr/qh5hF1I6tf2Jbxsh/KCqnX3XwRa6BE7xhuOWy+ddO7PjmDHoAdNxxY
         8P6p0SaI5NhBMVNGbhqfaeTEOdlzo6HVIn0fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:content-transfer-encoding;
        bh=XFLTzc3mQnE2NhCM0FHvqlpQckzaxu6j0ere81B+tEU=;
        b=EhrJwc6vTQQvO/wlp6hkIbcBHqCC4CxvI7bA/Si6ObPShgKsXV+1RIgSY0wXAIXGD3
         cxVWym4BZLRVmBU18ae4h1mkPxleKgx3vJupcYBaFGgGO9UAZ4wZwbAWjTlEawovAtR7
         rV6cCwyQqABZGm0ZxU/3SFS7dcLmyK08Izh52lZaTy+ELFltw24xYoKRmCevHlS6FvwS
         VNeu6ZIZfvRnIaavGOt02S1TwoDz9apliLRZ+XtGcX0gnF0S5hpuOEITicJeJ/WvM7KO
         jRt5TkOwzPVqIqaqAKmyJ6L+eXhZEge7b1DazAaDeo7flRImK1uK2SGblasEexdYmupR
         NztQ==
X-Gm-Message-State: AOAM530lSX7+JGqtjVloEK7+AyT1l24Mv8W5dwCDGqF1x1+wpo21ztf1
        P8zPQzy9MN98nspGhTnQf66tSA==
X-Google-Smtp-Source: ABdhPJyIf9b8QBeSBHt2rm18koENrv3g3bRt+4BhzEcH/eSwVhDViEjXuvzCbXCTOMPYC8luYt2e4A==
X-Received: by 2002:ad4:594d:: with SMTP id eo13mr55287442qvb.112.1641498129081;
        Thu, 06 Jan 2022 11:42:09 -0800 (PST)
Received: from [192.168.1.126] ([72.85.44.115])
        by smtp.gmail.com with ESMTPSA id k9sm2167517qta.48.2022.01.06.11.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 11:42:08 -0800 (PST)
Message-ID: <14da8945-fc25-7361-6840-c5f4640dac77@ieee.org>
Date:   Thu, 6 Jan 2022 14:42:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20220106
To:     refpolicy <selinux-refpolicy@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20220106

Notable changes:

* Module versions were dropped. Policy module versions were removed in semodule
   many years ago, so they no longer serve a purpose in the policy. The
   policy_module() macro still supports the version argument. If it is missing,
   a default version is set, to satisfy the policy syntax.
* The MCS constraints changed to reflect the usage in systems, primarily for
   separating containers and VMs. To separate a domain by MCS it will now need
   to opt in using the mcs_constrained() interface.
* New support for grouping user domains and their surrogates, e.g. user_t
   surrogates user_wm_t and user_systemd_t, such that allowing the user domain
   to domain transition to a child domain will be allowed for surrogate domains.
   See pull requests #365 and #381 for more information.

New module:
- obfs4proxy


-- 
Chris PeBenito
