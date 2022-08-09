Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C0C19F2D
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 16:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245001AbiHIQYP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244955AbiHIQYO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 12:24:14 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEF6251
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 09:24:14 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10e6bdbe218so14512612fac.10
        for <selinux@vger.kernel.org>; Tue, 09 Aug 2022 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Z9smeiHaowhZIMNz4dkj+u/pPU6V5N9JLwKRjUQKdm8=;
        b=7jLBqF/l6tiTgMBgzDF4sY9CkUgNYCCW+RkX7NClFhNvzPZv63lFNymbKgEqIlhz8L
         BwcfneJKPQACnhB802skKl6CFF8QjosFw1y0RgBjT3nBImk8UpBKxG1Fplw7Auu2OL+8
         As/v09E7bWMOGjCeUJLp5vNqBdTbUnH8vYLbuA8xsPSJ2Y6DDNdmOMw/SyxsRCebrN8+
         7KnyNuAY6dYotzHbwniEu4U42ZeB0swQgdm7WCIa5oFA/niUz+zl45mRWGKdbW+tx4qT
         DSCSlmQ6cRs8/65T5qIQU4217q8i9+th8LV7BCvDdKb7rDrTgs7xNdvd5FEvTueX5koz
         vx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Z9smeiHaowhZIMNz4dkj+u/pPU6V5N9JLwKRjUQKdm8=;
        b=HgeHvE2sXZnQ62ktWhhnzMwmHqaPYZkazwtbIJbq9HsayAdw/J67TBrQ2OyD6flcNe
         dyhZpGKZ9Vzr7ctvnZgudddA44h/mo/wSdd/rHxvV29BluWLzrBJN8aXR0qUmRNZgMF2
         q3QRnj9vOz+796kqWfHzhBxP3VdHUDtlrdRu2drpo0DAud0LaaQaw8iuBCWusvW2L6Vu
         2LxFlx31jEHCv2e3sqImZMnwmsDHz+uefutf0IQNQG3XnSowi9feCsFx42/AVTOBd6YA
         gIYFKjUk6p7x5J35JJcuRVr99rL+/EZ5i+H/XpskgJEHaRoRIlYmVa4CimhrdfmktLZ+
         8xMQ==
X-Gm-Message-State: ACgBeo3kioEgr7stkHw4PyFClAw9rl/lEhrT8ea9XZ1DEcm/eqUuk9/X
        /4FRM6rYhXcjMxfxTwAaeskf/A6uuoAW0ItfJHhh
X-Google-Smtp-Source: AA6agR5t3t2xYDAO2iIxFDr6OWwjPrx0zk4ZEHM+NUNxA3iKzvoRk9AGh0Letj7Dw1vUFcjokNJoHSj78KPToQPYQRw=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr14799112oao.41.1660062253476; Tue, 09
 Aug 2022 09:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <ffbb5ff1-cec7-3dad-7330-31fdfb67fecc@huawei.com> <cc760579-36f4-fe32-3526-bb647efd438c@huawei.com>
In-Reply-To: <cc760579-36f4-fe32-3526-bb647efd438c@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 9 Aug 2022 12:24:02 -0400
Message-ID: <CAHC9VhRCt9UKih_VzawKr9dL5oZ7fgOoiU5edLp3hGZ2LkhAYw@mail.gmail.com>
Subject: Re: Race conditioned discovered between ima_match_rules and ima_update_lsm_update_rules
To:     "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        luhuaxin <luhuaxin1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 7, 2022 at 11:19 PM Guozihua (Scott) <guozihua@huawei.com> wrote:
>
> On 2022/8/8 11:02, Guozihua (Scott) wrote:
> > Hi Community,
> >
> > Recently we discovered a race condition while updating SELinux policy
> > with IMA lsm rule enabled. Which would lead to extra files being measured.
> >
> > While SELinux policy is updated, the IDs for object types and such would
> > be changed, and ima_lsm_update_rules would be called.
> >
> > There are no lock applied in ima_lsm_update_rules. If user accesses a
> > file during this time, ima_match_rules will be matching rules based on
> > old SELinux au_seqno resulting in selinux_audit_rule_match returning
> > -ESTALE.
> >
> > However, in ima_match_rules, this error number is not handled, causing
> > IMA to think the LSM rule is also a match, leading to measuring extra
> > files.

...

> > Is this the intended behavior? Or is it a good idea to add a lock for
> > LSM rules during update?

I'm not the IMA expert here, but a lot of effort has been into the
SELinux code to enable lockless/RCU SELinux policy access and I
*really* don't want to have to backtrack on that.

-- 
paul-moore.com
