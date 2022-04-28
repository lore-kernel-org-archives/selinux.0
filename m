Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10350C433F5
	for <selinux@archiver.kernel.org>; Thu, 28 Apr 2022 05:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiD1FuB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Apr 2022 01:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiD1FuA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Apr 2022 01:50:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A822AE04
        for <selinux@vger.kernel.org>; Wed, 27 Apr 2022 22:46:47 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id d12so7130102ybc.4
        for <selinux@vger.kernel.org>; Wed, 27 Apr 2022 22:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acCmiAFeUKSb3f8UtEoB0zywf8yA7MpHB3Qa5wbIUz8=;
        b=mnuuKuGElQavxBj7lser61CbewlQVKMabIOG3mpBZHBFpIp6VhAnILfSQbs1NIAiOo
         HUdQLw0Dg+jZw9qp72ww+HThNqqglc3yw6Q/YBr/wJ9vSgA/MTxe63kaP5x7BkAuxov/
         33BFaNrufrwrtlttgVMpnwzOoJAX6EhdOYIQoZtbcFtntEPNt8qMi4OKBeR9515FRtnS
         e8G9Uro+3ItpJtO5UVxCRFi8xN8iIOHLOlVxUQQ8ac1KL7LtZZzA0DzStHv9KlLa5+r+
         BzozPUZX6x/YRkCoG9XbM7eAGLS7y+CL+r4nwQfxiUkaZHMgaylouPSkXQT+Yhuj5XBU
         FSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acCmiAFeUKSb3f8UtEoB0zywf8yA7MpHB3Qa5wbIUz8=;
        b=nq6FsNu2CYqqYa/gz2V9xO1uhyHzbUn24KhA3vfOfcHuScX/8UOdqOl0Q0cI3t227I
         pEUIP9uB7tSIHCBbADv5toD0HkULrWJ2uIqoD9wrhiNdjxiaF06gJwcOUg5D4zLGun6M
         r6tweSoo1/yxq98gpGWNcft+ljb4aE1OHMmRrIDwNTOZKtonbKufcHkTsAsjFjecjPOS
         hQaW44ym1PsviWEv9VoRwhcqIPpPCuvtLm4NWIlx1kN02pTb+8qeaZUmm339pzBsu2hR
         FzIFoQbZkh8usX1OQ6U87r+8wBqykZmbJyA/lsZuUT03twLQty0+Sx4rlsjijcI4A5zw
         n3+w==
X-Gm-Message-State: AOAM532z+flOWrjH9fR96ZtWvaKbmjEVxua24vkbnS77yfkjUnZlSCcs
        IEo9mPvTtf1OT19BU0HVHrgqGo6EwjLqW9LhW5Tx6A==
X-Google-Smtp-Source: ABdhPJwyJpRLrfcLW7+hjh/Wrn7475LqPrZ0d6/AHSn1ri3HAWeWqm5KfdQzi7bz2ndEZbLxU4A5EQkir2dn5nofCJ0=
X-Received: by 2002:a5b:a4c:0:b0:628:b143:5bd with SMTP id z12-20020a5b0a4c000000b00628b14305bdmr30117306ybq.212.1651124806342;
 Wed, 27 Apr 2022 22:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220422013215.2301793-1-tweek@google.com> <20220427135823.GD71@qian>
 <YmlQy7jnIY6Wh7/2@kroah.com>
In-Reply-To: <YmlQy7jnIY6Wh7/2@kroah.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Thu, 28 Apr 2022 15:46:29 +1000
Message-ID: <CA+zpnLd7EJzutxcfFEoCjnG0_JhCFeyxYDtiEzaYL19rwtjBwA@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: use kernel credentials when reading firmware
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> Ugh, yeah, a put_cred() is not called after this.

Good catch, I wasn't aware that an extra call to put_cred was required here.

I'll send a new version for the patch. I'll update the commit log as
well, with the recommendation from Luis. Thanks.
