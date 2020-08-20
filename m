Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBF9C433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 16:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD2F207DE
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 16:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWvqE0Jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgHTQ6f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgHTQ6d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 12:58:33 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D5DC061385
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 09:58:33 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so1207985qvo.13
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xWTl1NjfFSbrPR81zGedFGhmCj2wRuwgaeE8U3Ui3fc=;
        b=bWvqE0JhVXgBuCW+rFzA0UP9FVBaJa0VcgLs3vSpOkIjn2PNwB+F48EnSxn7A8HWSP
         ue4ULqj6Y9fxDoTbVMS+iisYsT4lZ4Rw7UhqV3ZfBG3z2+IM6j4etGPgP+ZG66bfGzVv
         3O8lrOdOKXXOEjh2DVkbJkP22dlxoCHvpk1lNgqLTo0+cMmJ/ZM7ae/jcQDpgrJBFGgK
         7sPp0SpY1FfQPPb3yIc5+zWzOdYfbkmeijgjPfwakDW+fOqUKss9AxP/Jel+M4neauu7
         QG9oyxveUP/CiyIn+IZN+EYaptTSnJ0yZn8LnmV0XGMV1ufR8WH8n4Eh6HIkfKtOeaf0
         h9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xWTl1NjfFSbrPR81zGedFGhmCj2wRuwgaeE8U3Ui3fc=;
        b=Yr6YxGFwI4PiAX6w74eKuUJZTBCodxjvgHGs+v7hqRp9eul3GxVtY4Y8Z5VUydJGok
         VAyCshyslX/5KvPq+pGGTVKOVKj5CMri+DkxxFrNPunRbHJbccVtDjuDDk8oC8Zs4uo+
         7Kh4t7H5JLUcbwctzwOsvBGXbBIaNjdeacZQyRbHNK3Nud0SL2KVywDiO6ZhuSBt7yjc
         Xu/OVtGB4gcQLgrpyRwO8inAyW7bj6NxSyDg05vXFO8DuKrQBIr/v5z7nsNmqrxEI2HS
         fH2fExu1G1Dps/W5zZUWERLu2pTJpY9bMPFmUmZWxZsMWgeqPjViUwr8bRr8OEYcFZxA
         NMbw==
X-Gm-Message-State: AOAM531neXm9ysw20rmi9wCyHkO411YZAj/vqk+DzVwoj/9eUPWN/zx7
        SxTCNFL+ma7QaowBH5bv+is=
X-Google-Smtp-Source: ABdhPJx/A75sr6FxDyU9DIf3RdKjv6t6xmnJXP956KZeSJ83Ip0v0Rtp3ZOFGfnVthQ1fVwgp2HxIA==
X-Received: by 2002:a0c:aedf:: with SMTP id n31mr3857443qvd.16.1597942712782;
        Thu, 20 Aug 2020 09:58:32 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id u39sm3841346qtc.54.2020.08.20.09.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 09:58:32 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
 <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
 <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
 <20200819171459.GA57975@localhost.localdomain>
 <CAEjxPJ54j6PD6oBMWj7wOVskJuUY=BLpMCkdmmqwrP1DGJ0VqA@mail.gmail.com>
 <CAEjxPJ6Kw8i_z_i2Y0A3HcK23DMoazWUZxMtNa7ErQv_bjm=QQ@mail.gmail.com>
Message-ID: <33cb7940-ebd2-1ded-4f19-9c75013a8204@gmail.com>
Date:   Thu, 20 Aug 2020 12:58:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6Kw8i_z_i2Y0A3HcK23DMoazWUZxMtNa7ErQv_bjm=QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 3:16 PM, Stephen Smalley wrote:

> On Wed, Aug 19, 2020 at 3:07 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Wed, Aug 19, 2020 at 1:15 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>> There are some corner cases currently, e.g. you can't remove the
>> security.selinux xattr if SELinux is enabled currently, and there are
>> various hardcoded error cases in the SELinux hook functions that could
>> potentially occur.  Beyond that there is the memory and runtime
>> overhead.  Getting people to start using selinux=0 if they want to
>> disable SELinux is definitely preferable.
> We could try to eliminate those error cases by checking early for
> selinux_initialized(state) in more of the hooks and bailing
> immediately with success in that case, but we'd have to go through and
> identify where we need that.

I did a quick look through error cases in the hook functions and it 
appeared that the only case where we would return an error that isn't 
already protected by a selinux_initialized() test or a test of enforcing 
mode is the removexattr() check.  So I just posted a patch to lift that 
restriction if policy hasn't been loaded. Hopefully there aren't any 
other user-visible differences.

