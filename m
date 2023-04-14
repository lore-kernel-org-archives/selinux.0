Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4AEC77B6E
	for <selinux@archiver.kernel.org>; Fri, 14 Apr 2023 13:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDNNnF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDNNnE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Apr 2023 09:43:04 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A68061BD
        for <selinux@vger.kernel.org>; Fri, 14 Apr 2023 06:43:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C64BB3200933;
        Fri, 14 Apr 2023 09:43:01 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute4.internal (MEProxy); Fri, 14 Apr 2023 09:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        pleasantsmoke.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681479781; x=1681566181; bh=7X
        gz7EmbbBgapXbEMQ8piQD17oAo6IfC1jKDkRvtBx8=; b=hTjU8W0u9D1tQRwLTx
        0LXuu5EkmklybHiWs2qZaTtlwDFK8ImrTbLUVsKQur8uaALwzsQm/BQj/JBWDGPp
        KijZUjbbr6URvqlPvrkv1q1VypN5zEmmWSNZuHuBrrkK33V6DZANov+DJQdD6wZw
        ljAb2+jnG5+L1piwAQuh5XoES/b0JHLd7el0QFNf6bu8LGaB1jCfOQRVn5XFZRVN
        Srm/9S2UvTm0PUQnFNtXnv0wGr2iqWbRodzZ41hXswq7a6mR/r0RyFKIQcra2js2
        9ohLcpqmn+DKFndzU9C9OmLKn4ob1szmpU8VrCCiPsMxVOFVuSwPfEFwDP6pKTzs
        KmkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681479781; x=1681566181; bh=7Xgz7EmbbBgapXbEMQ8piQD17oAo6IfC1jK
        DkRvtBx8=; b=B12EjWgMOkw0OdtfeZLourVkkUz0Y56df4bTkO8nGhftLjAAYx0
        Wx/FQsFrZY6DrvK2RC3quRnMBiwL7G9Rmcx7no12CDntsiuSlBZUw4PCFAjoxfMi
        6itUQpef42fDgIvSa6hLSvT8B6nrIzorfYxkNYAU/FSHrWYP+PUhUqnAf15DyRRG
        POAYpzLExkKymbV3nasRjCdvsEGzCCSjzP4HeUFIflZ6DDvBeZN/kqnFxJ3RiAUw
        GPOoVcO0B1ydEi8vXPWA8W/u9yxWhzN4fYqLs/USf4R1gNdccXFtaeRBqSVxAfQw
        y4z4Wa3ZukDzFxrHTtXz+Hm4z4Nx2kiwzzA==
X-ME-Sender: <xms:ZVg5ZIKd641m-ymoZ6kPZ1fcBDfoLDWxHIkqZg3vw9HUtveUy7_BtA>
    <xme:ZVg5ZIL4olTFSTg7ESd1MIRsDZO1XanKQ7W4aNTUsOQVA7Tg8U5tFvU2Ba_hEdWgT
    bSVFJoX5nQIWmca7iY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ohhnrghthhgrnhcuufhtrhgruhhsshdfuceojhhohhhnsehplhgvrghsrghnthhsmhhokh
    gvrdgtohhmqeenucggtffrrghtthgvrhhnpeektdelfeejveehgeeuudefffffieduhfek
    leetueehudevheehkefhvddtkeefffenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhohhhn
    sehplhgvrghsrghnthhsmhhokhgvrdgtohhm
X-ME-Proxy: <xmx:ZVg5ZIvz4D9r5UfK0qU-HH7kxV636-w9YSPcET6w8NDOY-DpiDwD9Q>
    <xmx:ZVg5ZFYAnqCxujnYx353WJp9FVyYitefIz0nmUr1ifLn6VJ3dBb60A>
    <xmx:ZVg5ZPYsH3eCyv_kXSwScFnuuYOnVXpr4iwUTYCbwmxopwwcn2Ttgg>
    <xmx:ZVg5ZADXpqMmwrfWjU94btvZ4Td4FKlhufYXaRFXt0ZCrp0rIRag4Q>
Feedback-ID: i5281472f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2B9332A20080; Fri, 14 Apr 2023 09:43:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <beaf2f5a-d95b-4fa9-89c5-7bc5dcbf85f2@app.fastmail.com>
In-Reply-To: <CAJ2a_DfJUQW9Obq-8y=w6AZcK9svv4hqWrzRx3yWvSugFzaAKg@mail.gmail.com>
References: <c58a0cc8-6453-45ca-9bfc-f041b0e7478a@app.fastmail.com>
 <CAP+JOzR_nL0Y12hOU2gTU6=U+J4YaZsyE6TLMQWFSUi0dJ3NCA@mail.gmail.com>
 <b0037c2a-c10c-4819-8add-14c176aed942@app.fastmail.com>
 <CAJ2a_DfJUQW9Obq-8y=w6AZcK9svv4hqWrzRx3yWvSugFzaAKg@mail.gmail.com>
Date:   Fri, 14 Apr 2023 09:41:56 -0400
From:   "Jonathan Strauss" <john@pleasantsmoke.com>
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     "James Carter" <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: Possible bug in policy compilation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche wrote:
> The following statements should be redundant by using init_daemon_doma=
in():
>   allow init_t gateway_exec_t : file { read getattr execute open } ;
>   allow init_t gateway_t : process { transition siginh } ;
>   type_transition init_t gateway_exec_t : process gateway_t;
>=20
> The fact that the domain transition is not triggering means either the
> subject process is not labeled init_t or the entry point is not
> labeled gateway_exec_t; search for avc messages regarding the
> permission execute_no_trans.
>=20
>=20
> [1]: https://github.com/SELinuxProject/refpolicy/blob/8e8f5e3ca3e5900c=
ad126cb8b4fadaa8adb8caac/policy/modules/system/init.if#L343-L348
>=20

I've spent quite a bit of time trying to recreate the situation to no av=
ail, I think it might be conflicts with systemd and kernel security feat=
ures as I just ran into this not starting for another service yesterday =
with nnp and sesearch indeed contained the "allow init_t proxy_t:process=
2 { nnp_transition nosuid_transition };"

Completely uninstalling the policy and reinstalling fixed it (which is h=
ow it was updated), I definitely missed something.

Thank you for all the help.

- John

