Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1D5C4167B
	for <selinux@archiver.kernel.org>; Wed, 14 Dec 2022 22:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLNWOp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLNWOo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Dec 2022 17:14:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7A3D388
        for <selinux@vger.kernel.org>; Wed, 14 Dec 2022 14:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671056036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aW8p5rry295NkbefzP1yJqPHwKJ4e7g3eAuxYhpUnzE=;
        b=IJp3+KV+nakUD8Vhwa05F117HxERJ8sBy2y1hrQyVKbEXA/27GW32oJjr0Uwhqwxnue/wP
        0swYgW9rLmYl8XkKX54RX7dK9zxLO9kh0XQL2NMlltdM5V9TqdgZlq3bAwt6cWq/nK/y1B
        fJN49eJ6JRz07zUJCciJNZgvxoGrafQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-Sa05Hjk-OMiz-6KGx9BlWg-1; Wed, 14 Dec 2022 17:13:55 -0500
X-MC-Unique: Sa05Hjk-OMiz-6KGx9BlWg-1
Received: by mail-wm1-f72.google.com with SMTP id 9-20020a1c0209000000b003d1c0a147f6so242017wmc.4
        for <selinux@vger.kernel.org>; Wed, 14 Dec 2022 14:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aW8p5rry295NkbefzP1yJqPHwKJ4e7g3eAuxYhpUnzE=;
        b=WShbHKS7+lNs2PvI+0r5/ocm+3ELp1hCBGiy/qKzxuVCi0CCtV7YZfwRWnvlY4mWSA
         06g0TUieIfKQNB88EBhFmEGia0OeJGJaJagWK1iVt+sdF0+6Cx6V4Zgx0Xq8e+ALfWzz
         QUJg8vZXrFX5IaCZTDgeUKrUO9D3V4V9ML4k44hl5PCo1Vm0tP3QN/X+I3dJr6NatAHA
         YSeAKn50cQl374dHLTVH/z/5ZwECMQXUsyR+S4EZnjJ4LFwF4SvUq/KrqlWRPvfLo6TU
         TECI4bxC5N32JbOk6mpbI/4KeNAJpLVqqmSIdAxlnsNMeyPJHTbNYVbEOMghWGDNSbqq
         CdyA==
X-Gm-Message-State: ANoB5pn+2WDwC13PS5s9//udV6OzH6WXPM64nf40GdhRLcIXGXT1gfls
        KMF+V+AIiEDsqbaNAgb6G5kuq/Qtq5Aw9TATOcA77k1glLVDXp42+jZEjLHrGq8szSR+77sM4iy
        Gm0LJO3kldXxJWl6MEA==
X-Received: by 2002:a05:600c:5386:b0:3cf:8155:2adc with SMTP id hg6-20020a05600c538600b003cf81552adcmr19884827wmb.33.1671056034276;
        Wed, 14 Dec 2022 14:13:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf68HKsZKNnRWxk2Lze71V2S9dTijIVMH9f0Wt6PD1jdQF6OZ5wOAj/Q1v+j8/lMDCgXi1f6KA==
X-Received: by 2002:a05:600c:5386:b0:3cf:8155:2adc with SMTP id hg6-20020a05600c538600b003cf81552adcmr19884817wmb.33.1671056034014;
        Wed, 14 Dec 2022 14:13:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c430b00b003c6b70a4d69sm3502193wme.42.2022.12.14.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:13:53 -0800 (PST)
Message-ID: <401591eef86a3c47065e9873d3f25ff978f0a51d.camel@redhat.com>
Subject: Re: [PATCH 0/2] lsm: introduce and use security_mptcp_add_subflow()
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Date:   Wed, 14 Dec 2022 23:13:52 +0100
In-Reply-To: <cover.1671054577.git.pabeni@redhat.com>
References: <cover.1671054577.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2022-12-14 at 23:01 +0100, Paolo Abeni wrote:
> This series is an attempt to solve the LSM labeling breakage
> reported here:
> 
> https://lore.kernel.org/linux-security-module/CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com/
> 
> As per previous discussion, a new LSM hook is introduced and
> invoked by the mptcp code to let LSMs set the appropriate label
> for the newly created subflow.
> 
> I'm not sure the chosen hook name is a perfect fit, any suggestion
> more then welcome.
> The new hook requires both the mptcp socket reference and the
> subflow socket reference, even if the provided LSM implementation
> for selinux ends-up accessing only the subflow socket. Possibly
> other LSM implementation could need or use the addtional parameter.

I forgot to mention this has been tested vs the reproducer described in
the above link and vs the mptcp self-tests.

Cheers,

Paolo

