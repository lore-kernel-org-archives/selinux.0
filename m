Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01043C433EF
	for <selinux@archiver.kernel.org>; Thu,  7 Apr 2022 00:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiDGA45 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 20:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiDGA44 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 20:56:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E3256206
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 17:54:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p15so7650861ejc.7
        for <selinux@vger.kernel.org>; Wed, 06 Apr 2022 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBY7MfURAnrk3e2eMPUupiDZ9us+zriUazkPG0w9nls=;
        b=IB/+6gjqe1fengOd2CqzChI2WnIKh/Q+pSJWdnS1VOBus4VrIE5UfiADd9Zkx64rwE
         72oqBnVRAO/DkzrtkyR6P+mjFPUV4gBSXS7W+/pJBF1oU90kLIGh5gbaC3caAcy8NlES
         lgQMC4aGO8x+e0veH8iA4H+9DZbxNd9ZPTwuhluK5iQ9uW3zOSrq0HUeCE33lqOD0Cd5
         wsdWDPOcAp99jZYiwyatKLMJtOwO/wKGV75Sjyfm7MIl36UM9i5N6LgV4fI70UYLRzyG
         OsSrc/YjQM7ELhM78+iQb4Hi/CtltKTgc09rugbvMyjHrQmC5sTeFw8UrSw7/XSYBV/Q
         BEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBY7MfURAnrk3e2eMPUupiDZ9us+zriUazkPG0w9nls=;
        b=nF3d/4e1EqRMzKHe1F0M0eEqLU0BTcGmiKgvuJ3N/xS1w/AGt6kW5kiNh91aTxl31h
         jzXTiET08ryfVF89WYDyXojfOUlolL+ARbcoHK7c3sobvs/zi3nTgmU3tvwQrmL5SrPf
         Vg70HVrpQP7lRdIjeSRLW18ArSnp/3+ORhYp7tlkqfOH+8tdxWlKQz+4mVOpWv4OZeZg
         c3K0ETYsv43w6N1NdFGuqEPYvrnFmFxbAXY3NvG50EKGC3tjGq+ZA/ebekk6PrRWChVF
         JF0qYpbYcqRy0qBKtToPVSPNNwfJa+0kUMrO0fcaChY9JGJNVl/mc3N2h21HBr9hDyv1
         Budw==
X-Gm-Message-State: AOAM530+yLBKLTflqbUg0F06jGn45EtrVV71lABXM0RchMaiFyuzPhXk
        /GoyqCvrgbosIxKzRwj2+ZFTxGquxj4I9/3iLR02ApNdAg==
X-Google-Smtp-Source: ABdhPJzST3gAun8XH0s6FTXYG7dfbL6h2zebw6qddCmOyGm7QCy8uRgNXK0gKwxA62Dg1LC9+N3SmSz+2+Ew1klt73M=
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id
 mp9-20020a1709071b0900b006d8faa84a06mr10683679ejc.701.1649292896452; Wed, 06
 Apr 2022 17:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220405081925.5668-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220405081925.5668-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Apr 2022 20:54:45 -0400
Message-ID: <CAHC9VhT+fd-CZuBMmGK=5H6ouNDG9+11qQYmJ0nhm-YVadG7Cw@mail.gmail.com>
Subject: Re: [PATCH V3 Notebook] How to add a new policy capability
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 5, 2022 at 4:19 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Describes the steps required to add a new policy capability to:
> kernel, libsepol, and policy.
>
> Also add the ioctl_skip_cloexec capability description.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes:
> Clarify naming conventions.
> Change enums from POLICYDB_CAPABILITY to POLICYDB_CAP
> Add ioctl_skip_cloexec
> V3 Changes:
> Fix typos and 'Policy Updates' text.
>
>  src/lsm_selinux.md              |   4 +
>  src/policy_config_statements.md | 139 ++++++++++++++++++++++++++++++++
>  2 files changed, 143 insertions(+)

Merged, thanks everyone!

-- 
paul-moore.com
