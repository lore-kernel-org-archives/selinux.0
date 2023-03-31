Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DA4C76196
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 13:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjCaNNY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjCaNNX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 09:13:23 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5C11A45F
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 06:13:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0586E3200077
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 09:13:21 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute4.internal (MEProxy); Fri, 31 Mar 2023 09:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        pleasantsmoke.com; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680268401; x=1680354801; bh=T0
        j3xlbJWSpXFtfAwNAGwSFingcct/jzIiKj7xfAf4Y=; b=HNGLfyB9gtTGdz7JsH
        RL0jronQErr83WrsUgjbmrccescd8WnUepgImoUvk4nfsYKbEyCYZrrp8m509XSP
        9xYcPFIcMcMwV7MpeyT8xhywT04IfHJsm1GeVKW47B6P3XR7HAk2aB4wyjlMOJ/1
        NAgdukehmIBAqQWzV99HXk49WsQBBCtsoDrDjv7eMh5mIAM/k2W3crT6JpZRobvQ
        D1MoVD2nt1MTOLyZ1FSK4kvDHO257SSkJDWgA00X1X3i0JwhmecYJ23fQx+uek6X
        +eE4IGgMbcyLdBApOtaR6RCroi0rqbJQPlHd77phM/IfAVqVQ1vXSfsteW010tbh
        6jqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680268401; x=1680354801; bh=T0j3xlbJWSpXFtfAwNAGwSFingcct/jzIiK
        j7xfAf4Y=; b=Q9oh0IL2cAf/hUj0+aLV8kWyXeTyWmFRG6/I5afxh+CvLS4PWTo
        qzpN2+KwJ8ViByHDe/WzcLgkp2omT1hzIAwKSlKvYQJOpPTfb7/sE/2/JmwmGYhA
        fvuZkvJBcavUz43Icvz09/KIOGxULWxoBtPs7IRpyS6fF70wJEkt1bpFOGfw8OVZ
        lTAva4RlgAuMi7TbfhSXrE4k2YOPpof3aus7b43S+vV6lvgReUKoVZQsoJBHpXIO
        20AOF7gbDYSsDp6QItKtJXA/6WEsVPxDMUE3OINIKwwMvj4bF1kdiDL8Adao3/DR
        ctA0VduDURtIL+8jVDuuS+p3WkfW3lzJp2A==
X-ME-Sender: <xms:cdwmZBdLZbSuM_4tebLzEpwEIjtgPuDuuqirQ5DcRRDwMAOYFJNgLw>
    <xme:cdwmZPO-wUMtYRYXq-qYQUDPRGGnVqG-a-smFxC2rX7pZxjMnaNTV3y-M4uM9c2k5
    enXsM5KdoBUZr_EN8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedflfhonhgrthhhrghnucfuthhrrghushhsfdcuoehjohhhnhes
    phhlvggrshgrnhhtshhmohhkvgdrtghomheqnecuggftrfgrthhtvghrnhepteehteelge
    eikeegfeehheeuleekudehheeiiedtiefhudetleetffejleejhfdunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhohhhnsehplhgvrghsrg
    hnthhsmhhokhgvrdgtohhm
X-ME-Proxy: <xmx:cdwmZKj3cKSVQ8VXnSlVS37oQKRHmuUipm0JkFj0CfjOlHkUB2LOpQ>
    <xmx:cdwmZK_OXcZPagP-jKPBL0ta5M3kn53kM2-d2UySrOkjtFj5fn763A>
    <xmx:cdwmZNv-OUUxxBeRO8z3M5C-2AdrJxO-gs2NjvisGUVFZqQneX3RoQ>
    <xmx:cdwmZL5hVdr8eaCgTrwXxosDpYHcrS8s0ZaaxoQEhCjvTLLAIb4SfQ>
Feedback-ID: i5281472f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 699EB2A20094; Fri, 31 Mar 2023 09:13:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <c58a0cc8-6453-45ca-9bfc-f041b0e7478a@app.fastmail.com>
Date:   Fri, 31 Mar 2023 09:13:01 -0400
From:   "Jonathan Strauss" <john@pleasantsmoke.com>
To:     selinux@vger.kernel.org
Subject: Possible bug in policy compilation
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I'm not sure if this is the right place to post this, I was writing a
policy for an API gateway and couldn't figure out why I wasn't getting
a domain transition. Turns out I was missing `type init_t;` in my
require block in the type enforcement file, but the compiler did not
complain about the missing type.

This was in stark contrast to the policy I wrote for a JVM application
(JVM apparently needs the world + dog to operate) using audit2allow and
forgetting to put the proper type requirements in the require block.

Seems like it should have failed with the missing `type init_t;`

OS: Alma 9.1
Kernel version: 5.14.0-162.18.1.el9_1.x86_64

libseccomp.x86_64, 2.5.2-2.el9
libselinux.x86_64, 3.4-3.el9
libselinux-utils.x86_64, 3.4-3.el9
libsemanage.x86_64, 3.4-2.el9
libsepol.x86_64, 3.4-1.1.el9
selinux-policy.noarch, 34.1.43-1.el9_1.2
selinux-policy-devel.noarch, 34.1.43-1.el9_1.2
selinux-policy-targeted.noarch, 34.1.43-1.el9_1.2
setools.x86_64, 4.4.0-5.el9
setools-console.x86_64, 4.4.0-5.el9


- Jonathan Strauss
