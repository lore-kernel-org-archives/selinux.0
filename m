Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5E1EB64DD
	for <selinux@archiver.kernel.org>; Mon, 24 Jul 2023 03:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGXDOT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 23 Jul 2023 23:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGXDOS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 23 Jul 2023 23:14:18 -0400
X-Greylist: delayed 6319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Jul 2023 20:14:14 PDT
Received: from mfwd09.mailplug.co.kr (mfwd09.mailplug.co.kr [14.63.195.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240AF3
        for <selinux@vger.kernel.org>; Sun, 23 Jul 2023 20:14:14 -0700 (PDT)
Received: (qmail 21032 invoked from network); 24 Jul 2023 10:27:31 +0900
Received: from m41.mailplug.com (121.156.118.41)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        24 Jul 2023 10:27:18 +0900
Received: (qmail 3161038 invoked from network); 24 Jul 2023 10:27:18 +0900
Received: from unknown (HELO sslauth06) (lsahn@wewakecorp.com@211.253.39.62)
        by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
        24 Jul 2023 10:27:18 +0900
Message-ID: <0ef69b62-4efd-816d-e01a-befa161e8fa0@wewakecorp.com>
Date:   Mon, 24 Jul 2023 10:27:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selinux: optimize major part with a kernel config in
 selinux_mmap_addr()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>, thomas@t-8ch.de
Cc:     Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
References: <20230710082500.1838896-1-lsahn@wewakecorp.com>
 <CAEjxPJ6Mun2m3=uHpTR9dh74kxMsav3yd7CF1QeBPYuX=eN=dg@mail.gmail.com>
From:   Leesoo Ahn <lsahn@wewakecorp.com>
In-Reply-To: <CAEjxPJ6Mun2m3=uHpTR9dh74kxMsav3yd7CF1QeBPYuX=eN=dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

2023-07-18 오전 4:21에 Stephen Smalley 이(가) 쓴 글:
> On Mon, Jul 10, 2023 at 4:25 AM Leesoo Ahn <lsahn@ooseel.net> wrote:
>  >
>  > The major part, the conditional branch in selinux_mmap_addr() is 
> always to be
>  > false so long as CONFIG_LSM_MMAP_MIN_ADDR is set to zero at compile time.
>  >
>  > This usually happens in some linux distros, for instance Ubuntu, which
>  > the config is set to zero in release version. Therefore it could be a bit
>  > optimized with '#if <expr>' at compile time.
> 
> If your distro is configuring LSM_MMAP_MIN_ADDR to 0, you might want
> to bug them about it, because that's not a great idea for security.
> And if you intend to use SELinux there, you'll want it set higher.
> Default value in the Kconfig is 65536.

Thank you all for feedbacks!
I'm closing the door of this topic with them.

Best regards,
Leesoo
