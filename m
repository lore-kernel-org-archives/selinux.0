Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1304C4332F
	for <selinux@archiver.kernel.org>; Mon,  7 Nov 2022 21:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiKGVRr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiKGVRc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Nov 2022 16:17:32 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B16467
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 13:13:37 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q186so1143617oia.9
        for <selinux@vger.kernel.org>; Mon, 07 Nov 2022 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pHms/O+9VBq8irGp3MyiuJlyANLL/CCV2NFYd5lytyA=;
        b=fbz0dJ0XnDpsx+hMge6yfECCLrQ9kRAHBi+2sKrgralxQwXVYVPHT1wlH0vOI9aXS8
         Q69Cl3BJx4YPMF4NRILvqzetKOldQMWspeGTkz0lcPKpFBHfezWWbmdr/ZwTypsvUFdJ
         g5J3srFyn2ZUZP5+9zDAEtyqAlGXF0vIdYcpbhgL85wp04jFhnedzI1rRnmZjWbn6RAL
         mYWri7hGGN55fKqX+3zh9NzgGpFjgaC7vxXACDyVgFcJ4ZkzpfW7oo1SQYpXUBAmPu8Y
         6jkwwIrJAv0O2KHOkdhSm95DZ/t0cfAUEvg9DHWvzYQvYg8crJo1G2MC38vRRwBc4bkh
         4FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHms/O+9VBq8irGp3MyiuJlyANLL/CCV2NFYd5lytyA=;
        b=NVIs2k45JO7wi01QFHFEChtwgp67Mvipn0U47Q9f1HMj3oAHfsolfavVDwvk9gw2OJ
         mfF26erhA4YcjmaOrh5AJ7hutY1ySmW6B9LEQAoaB69ltsL64KO6ZSltLaesMUCPkoG+
         CJeBNxIdzwDtkscC08RqnAhNMRsBQxTcORmDRtx6PpnzMJsP0B7LdCBY74KkSkmF1/pn
         FKr1E+612hFC2Lod6oKvt+CgfFLMKCDXDYDgmFA6iynTDdTAnhN8Fn+B002wJgJVXhid
         Ui3y/QPtZOsLReSJAauybIS8qcZMWHXkoeemz0D1CzXFYksBeP1Bnii2I98LdihlL6Ww
         Bduw==
X-Gm-Message-State: ACrzQf2Y65P8tHVWlW7i4vzKwJr0S6WlYqyWyx6ryvROvGYY1Yjb1JqT
        xRrZ09Mbimnairm6+5Y4KTpOS6SIgWTPw5k7gtku
X-Google-Smtp-Source: AMsMyM4KnQnz9BbylEC8a4qKc19JcYPq3m7VWW4QnZi9Gv86OMlxbUuEIKo61OnWavUhJ9RvHyxDno+RIArn4c7OBDc=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr14688971oiv.172.1667855616463; Mon, 07
 Nov 2022 13:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20221107205754.2635439-1-cukie@google.com>
In-Reply-To: <20221107205754.2635439-1-cukie@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Nov 2022 16:13:25 -0500
Message-ID: <CAHC9VhTLBWkw2XzqdFx1LFVKDtaAL2pEfsmm+LEmS0OWM1mZgA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add LSM access controls for io_uring_setup
To:     Gil Cukierman <cukie@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 7, 2022 at 3:58 PM Gil Cukierman <cukie@google.com> wrote:
>
> This patchset provides the changes required for controlling access to
> the io_uring_setup system call by LSMs. It does this by adding a new
> hook to io_uring. It also provides the SELinux implementation for a new
> permission, io_uring { setup }, using the new hook.
>
> This is important because existing io_uring hooks only support limiting
> the sharing of credentials and access to the sensitive uring_cmd file
> op. Users of LSMs may also want the ability to tightly control which
> callers can retrieve an io_uring capable fd from the kernel, which is
> needed for all subsequent io_uring operations.

It isn't immediately obvious to me why simply obtaining a io_uring fd
from io_uring_setup() would present a problem, as the security
relevant operations that are possible with that io_uring fd *should*
still be controlled by other LSM hooks.  Can you help me understand
what security issue you are trying to resolve with this control?

-- 
paul-moore.com
