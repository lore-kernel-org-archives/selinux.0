Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8722DC38A02
	for <selinux@archiver.kernel.org>; Sun, 30 Oct 2022 16:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJ3Qh1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 30 Oct 2022 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Qh1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 30 Oct 2022 12:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3119AE4F;
        Sun, 30 Oct 2022 09:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3449C60ED9;
        Sun, 30 Oct 2022 16:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DF4C433C1;
        Sun, 30 Oct 2022 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667147845;
        bh=mPWuPtxFbVwv6fwp3AECvX5rPIjNK4xwLbIQNWGU2Zw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=CiS/cw5vNAzKZddBBCweFKRHZfE7yxND3qoWTeB/9R3iE+3xUvFXNJTR0lcDPtVYv
         9P0ury6jiDpcCP7VdMpAxI5K4wSb9VNEwkDWUCvF/BR4fuRre5xftlz2x0tIv6m85p
         C7i6hatDys33N+a//soPkFZbBMQppiky5EnV1pxjeVCsJA3JIiCxfiLYrUFajGnHy4
         6J9xpe8DxnpEwxV6g3OXabh5bLZ0B46CxHz4jgHU/1otA/a/Dvbb9irfwZr7oYMPmu
         K8tOnvIDZNhJK/FnuC/ypJYbkoNgsHXKtkDSpm0P1rkO9XXUJHJ1l1R8Ml15qkg2Cx
         Losjwy8IebfQA==
Date:   Sun, 30 Oct 2022 09:37:25 -0700
From:   Kees Cook <kees@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
CC:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: LSM stacking in next for 6.1?
User-Agent: K-9 Mail for Android
In-Reply-To: <2c48a481-391f-85c7-be4f-13bbc1553aac@I-love.SAKURA.ne.jp>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com> <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp> <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com> <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp> <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com> <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp> <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp> <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com> <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp> <11564f69-3bba-abf7-eb46-06813ff4a404@schaufler-ca.com> <98ab33d6-6c91-9c0a-8647-22f6bdede885@I-love.SAKURA.ne.jp> <aa201ed7-9ca1-9507-08cc-156f280ee5f4@schaufler-ca.com> <3266c2c2-cd7e-bc0f-0fc4-478a63d6ee77@I-love.SAKURA.ne.jp> <f7548061-e82d-9a39-ed15-0d32551b4099@canonical.com> <53b07579-82f5-404e-5c2c-de7314fff327@I-love.SAKURA.ne.jp> <aa5424f3-05a6-530b-bf5f-19e5421f8f3f@canonical.com> <2c48a481-391f-85c7-be4f-13bbc1553aac@I-love.SAKURA.ne.jp>
Message-ID: <AB202AC7-9C8D-4109-B4EA-87A7BC1BADF8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On October 30, 2022 7:02:52 AM PDT, Tetsuo Handa <penguin-kernel@I-love=2ES=
AKURA=2Ene=2Ejp> wrote:
>Casey's patchset is trying to provide LSM ID Repository for userspace pro=
grams=2E
>But an LSM ID value cannot be assigned to that LSM unless that module is
>available in the upstream kernel=2E This means that, developers are not a=
llowed
>to develop a new LSM module even with the intention to become available i=
n the
>upstream kernel, for there always is a risk of LSM ID collision which the=
 LSM ID
>Repository should have avoided from the beginning=2E Also, this means tha=
t, unlike
>PCI devices, users are not allowed to use out-of-tree LSM modules which h=
ave to
>remain out-of-tree due to proposed-but-not-accepted by the upstream kerne=
l=2E
>This is a serious bug; is LSM a proprietary/closed code where modificatio=
n is
>impossible due to an End-User License Agreement?

You are way off in the weeds with false equivalencies=2E

>You have only three choices:
>
>  (1) allow assigning LSM ID integer value to all LSM modules (regardless=
 of
>      whether that module was merged into upstream kernel)

We are not hardware manufacturers=2E

>  (2) use module name string value as LSM ID

This results is greater code complexity=2E If you see a way to do this, se=
nd a patch=2E Instead of unhelpfully saying "no, do it differently", show a=
 solution=2E

>  (3) dynamically assign LSM ID integer value when an LSM module is regis=
tered

Again, send a patch=2E

>There never is fourth choice:
>
>  (4) assigning LSM ID integer value to only LSM modules which were merge=
d
>      into upstream kernel
>
>The fourth choice is complete lockout of out of tree projects=2E

This is just not a real outcome=2E How is this any different from syscalls=
, capability bits, prctl values, ELF flags, etc?


--=20
Kees Cook
