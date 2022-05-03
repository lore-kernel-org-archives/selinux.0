Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8535CC433EF
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbiECSdB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 14:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbiECSdA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 14:33:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572D83CFEE
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 11:29:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j15so24539153wrb.2
        for <selinux@vger.kernel.org>; Tue, 03 May 2022 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O//TZ8AQgOTifP2Ve5RKBVYlVaMT99XAuVZDHhF+ZX4=;
        b=t4OWS8r1F2PMxVGmJ7l2BzCN3j9MHsFr0g36f1x+UkP9Mu4fhMx8+F02GuRZiVqcaS
         CBEb6BOfkSt7k8jGNkQSLZGGawWlvmpo2tjX4RYNWVB0mY/DTG7YX6/V2IR9ZCPC9/M8
         zA7RDbXDDIYs76lQgCFo6irnG0tZqj0QvXUCrBqi+lqlEu8WvLYRdnnFsp2fx4Z6kA72
         V1JgYnf79xnfw0uXt28Tb2nsDIax7R2e7YS12EbwOjZc0VUym0BG3Z9eKmypvd9OrPR8
         ZU/ShcLVtaY7M5Pf65OdWdozf/4Ss+xs/ZoTmzstov7CNGichuYU2XqZdhsFDJcuDYgU
         /3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O//TZ8AQgOTifP2Ve5RKBVYlVaMT99XAuVZDHhF+ZX4=;
        b=htpjmO4x+N6u64yF5W5fdb3IghD2VsaEzIBDND3OByR+0jQRhi3W20XOuAlC8HfTv2
         yDc6uUiaKl3f3eWF3IeJaKwpuVFSpA5XozcvMoIxeY9ylyaTJafmKU1dVc81BdgU3++y
         Xy2ebcznW2CudMYpwa2FvbRB8pirOsAU63VKjTb9zznbwS4Kl2XOl6qCFWloLwIMYEEA
         3m36/m5U2V8UsgidSSyOKWvm1u88x1tPqZMpDgOR/8bHuTyKFwtNJsxt2qnCrgTGn5AB
         9TKZ8Z1kJsiQL2Mx325B7ReNSsj7NnZl6Hm8yY2XxDfHg9uArpXU5RV8cYTvhauCJFH8
         iMqg==
X-Gm-Message-State: AOAM531MmWLD6LZ7rP2xkAzoQfI4JnqpyWlaRH1joVybOKHP9yAI/99r
        oVX1DOqtR9kRRYi/Aa2EuNlnOUCCnVNV1sbBQkmI
X-Google-Smtp-Source: ABdhPJyXJN604FDM5zMX4YKzWSkjZxHuD5oPdFkB8NFvBP7EUSwC+tvj6LTz0VSqArxbIRSRaeV+KNtEIsVMNqgDa7Y=
X-Received: by 2002:a05:6000:80e:b0:20c:5b45:a700 with SMTP id
 bt14-20020a056000080e00b0020c5b45a700mr10114526wrb.662.1651602565860; Tue, 03
 May 2022 11:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220502140547.32685-1-cgzones@googlemail.com>
In-Reply-To: <20220502140547.32685-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 14:29:15 -0400
Message-ID: <CAHC9VhSyzKTpz4etPx0SMiGx2DwPcDOT7w-2uGzxRZXUbU8KSg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix indentation level of mls_ops block
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 2, 2022 at 10:05 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add one level of indentation to the code block of the label mls_ops in
> constraint_expr_eval(), to adjust the trailing break; to the parent
> case: branch.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 42 +++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
