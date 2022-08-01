Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BA5C00144
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 23:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiHAXGT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Aug 2022 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHAXGT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Aug 2022 19:06:19 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96AA29C92
        for <selinux@vger.kernel.org>; Mon,  1 Aug 2022 16:06:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u9so14672883oiv.12
        for <selinux@vger.kernel.org>; Mon, 01 Aug 2022 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rFaG78hGppqyEaV7sglOcQ+vFBt1MT2K6UHXnsijDug=;
        b=0gpOV2jR9Ldyi7tWjReQ6fHVuZkXi246dTuVekkLE+udpqmfspyyVLV1/zMWAChxc2
         1Ac+d3ITcUQnvPOO7CPt7aVGZa8CfqGOI6sNHCIcsZZnbWq74mAANt7OyqDleRsvdqzL
         YshLVoEhtsghq6x/JkRJvx9rq1ZImRE9esUruyh0fXKTIiSDj0GJLswrLKDp2ersZB8F
         Hu0atpgTHkw0Zi1lKmC2zz5Y4/LG82SL0GX+pwK1VWmiDRPPvrKP1JhVS/xCSLYLwmzy
         909xLAh8M/2hvLyflN9Sq5ICwKhSKT2w2m7GIIJqqQNUukxqnyJ2+ypTBIGq0DJXYWpa
         uUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rFaG78hGppqyEaV7sglOcQ+vFBt1MT2K6UHXnsijDug=;
        b=8Jt+6GqvXrF/1h/ZEgklvPl28EybKwwpAF0PTI8ymC5vB08baxf5FQTnhTyPfg2OjT
         6K87Mj+NAYDWaBo1mr+I6PoFsy9Mt8JbEHq6Wn/Aqy//9MkY5EVhTNKlzn5ML/FGHEBg
         F3szWv+4CcGkJ7aOk5Xtq5VJP3zBx7dmoQpB95gZVvJnGER/8mq90W0hquExTU/PcJTQ
         iwXylUdzsdNIP63ociDnVAo5a2gwApvL8k4MNBEW41wdJdWuCydeza5Rrj03ork/tuFl
         LMBy+CxVI0YL/HOwSYSkwJbI/qR+wjXz7NZIzLaLNA9tZ7XJpe/u7lu+G5gdDBKB+SGV
         1Z1A==
X-Gm-Message-State: AJIora91GtpE1hg0RYeUBGSIp+sC3ydTDf9/NIe0bpy7zp70VzP9a9F5
        WPo5HlnMeb1mtGMRIHzz6+Fe18ECVE0rK3sbKoam
X-Google-Smtp-Source: AGRyM1tW7X8dx4hifAe/n9Vs8A9hR+7H3zIyRYozgA1dH3CB2MVrmhq+7tur1N9HEi6/m2TV1SRxSL/FTg0L+UrrDgo=
X-Received: by 2002:a05:6808:2389:b0:33a:cbdb:f37a with SMTP id
 bp9-20020a056808238900b0033acbdbf37amr7455375oib.136.1659395176996; Mon, 01
 Aug 2022 16:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <20220801180146.1157914-3-fred@cloudflare.com>
 <20220801230030.w4rgzlncgdrcz7q2@macbook-pro-3.dhcp.thefacebook.com>
In-Reply-To: <20220801230030.w4rgzlncgdrcz7q2@macbook-pro-3.dhcp.thefacebook.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Aug 2022 19:06:06 -0400
Message-ID: <CAHC9VhQZAdpQuWu7nHtGq2EtSyD=16awQ5p46Wz6Xd2Mwoew4A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] bpf-lsm: Make bpf_lsm_userns_create() sleepable
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 1, 2022 at 7:00 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 01, 2022 at 01:01:44PM -0500, Frederick Lawler wrote:
> > Users may want to audit calls to security_create_user_ns() and access
> > user space memory. Also create_user_ns() runs without
> > pagefault_disabled(). Therefore, make bpf_lsm_userns_create() sleepable
> > for mandatory access control policies.
> >
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
>
> We can take this set through bpf-next tree if it's easier.

Thanks Alexei, but I'm currently planning to merge it into the LSM
next branch once the merge window closes.

> Or if it goes through other trees:
> Acked-by: Alexei Starovoitov <ast@kernel.org>

I appreciate the review/ACK, would you mind reviewing the tests too (patch 3/4)?

-- 
paul-moore.com
