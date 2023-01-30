Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E11C54EAA
	for <selinux@archiver.kernel.org>; Mon, 30 Jan 2023 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjA3RrB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Jan 2023 12:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjA3RrB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Jan 2023 12:47:01 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDED03B64F
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 09:46:58 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id d10so8152557pgm.13
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 09:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc9yMjuBL6bCfJegjSMFj2dAWgcmknuIWAglX+a4xFc=;
        b=Cx14tgaB1RYOjixoeKLmjs0jibQfEpPcsG1FsZhjKbt5/xu2CXwlzjU1NqDNldvgA2
         88ymL7fZG5z0cOpm4IG1EBdet9zrlWgrLyjvTJx8cRn7F2GCATzzSvasSoHlNfpFJTP1
         z6VZ2Tx41+o26U7tdNzXFFkCbB/Odp3WeqkrbjSarOMFZr5iFaWYINp/dqs9lWSOmNUt
         DqhtH280MBXEGFwc+40tCvYta72yx7dZ8uL3a2l7sQsmSeZbHVyF3xpFoBi4NOddHDCZ
         Lx/vsr637aMvPUptCbwCNAg/QjB/cH3IxWmUdODKeeJqkZAgTGk8ctKwNimauUBmtsVF
         Aulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc9yMjuBL6bCfJegjSMFj2dAWgcmknuIWAglX+a4xFc=;
        b=lU+vvS9YNRoD4iLEOF5sptUADOc/TlpPalkRbm7OaXFM6FZx/lXUBXWVps8fHkre2j
         I7UyfhT5JCb/6QOKmcSfCJxpLzfUmVz6jxHX8OERHPNtGGXM+ymRI5YnmfE56lDtuOvt
         s0GeHA8BbZkTTi+dWnj7535pqlLr9uo9j2xlKWdsAxCpJP/aV0EzmkbWjvYqGv9yefsN
         vyaE7JMhpVPwrzsZnDs827/gVJeXs2TUA5gC3zswpZbW4yxX5uxj7pjSeBjxc/9uL34O
         L7hq+H1cGi1BP/pcIdeOBe4Alr0I+mG6kzZW4vEEknOtv3x+I/sAoVmIBv5My+Wi7YYA
         dQQw==
X-Gm-Message-State: AO0yUKVeJ5VUnVHxyWcSO2tCDWp95p60Lwk/pI9j1T7jam+6cT4V1pBv
        P8SopOzWCsOwZvotm0lNcWDyUpxk5ufSBke/jkepBL8xkPk/
X-Google-Smtp-Source: AK7set9j0bjS1qh1rvOMlP7TL8n7zxbMQVJpWF1OJtzumRSuDAA2uWkdvhTmPakplq+6422jz/GNxBgbVC0CKvNBbhQ=
X-Received: by 2002:a62:8e0a:0:b0:592:a8af:4ffc with SMTP id
 k10-20020a628e0a000000b00592a8af4ffcmr1887180pfe.52.1675100818166; Mon, 30
 Jan 2023 09:46:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whR4KSGqfEodXMwOMdQBt+V2HHMyz6+CobiydnZE+Vq9Q@mail.gmail.com>
 <CAHC9VhR1jRM2K0757sNYS8VvSUxRWOKUJ1unbsZm9LOEM3Up6Q@mail.gmail.com>
 <CAHk-=whLndwMFSF_OAWdqxXYXUev_H9YqEkXQ1_PKoPO8u=G2g@mail.gmail.com> <CAHC9VhRWz2N6ezZckSwtZvM3J75prdq7ckaoQgAO+ECz527qCw@mail.gmail.com>
In-Reply-To: <CAHC9VhRWz2N6ezZckSwtZvM3J75prdq7ckaoQgAO+ECz527qCw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Jan 2023 12:46:46 -0500
Message-ID: <CAHC9VhRgR2BV3v_1o3JGdBT80UxiMSGUcrLVG8Tj3JiKynZYNw@mail.gmail.com>
Subject: Re: Looking at profile data once again - avc lookup
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 30, 2023 at 12:14 PM Paul Moore <paul@paul-moore.com> wrote:
> On Sun, Jan 29, 2023 at 2:37 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Sat, Jan 28, 2023 at 2:33 PM Paul Moore <paul@paul-moore.com> wrote:
> > Honestly, considering that the selinux code is literally more
> > expensive than THE REAL WORKLOAD it is checking, I really want people
> > to take a second look.
>
> WE WILL

I should add, do you have any particular test script you use?  If not,
that's fine, I just cobble something together, but I figured if you
had something already it would save me having to remember the details
on the perf tools.

-- 
paul-moore.com
