Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEB1C33CAC
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 12:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CB52082E
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 12:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+jcRIP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBCMVS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:21:18 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35555 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCMVS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 07:21:18 -0500
Received: by mail-ed1-f41.google.com with SMTP id f8so15769088edv.2
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 04:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NeuF3JT4YnWf5M5XotA5SOaOYm5JDISTm500jhc8pMA=;
        b=N+jcRIP/yJy+WbwjuAB6mYHW9AZ4VkUSRed5p9+ytniDI0QG4+BZfHFXteLcmOhT8r
         xwNMMFJobsJUA9DSg4IWAFHmlBKBCi8KhdL69Pfi7zRPTr1KWikwQnqmv/BGxgF2WSRM
         GzN6PreqKHGZ30lX0gys9hZr/eARgqS73gXnd4cGuFMQJapFYR8irlO9shjUBn3r53WF
         Bm0bf7R2FuNn6cQsJj2D1LgMSCpEVF91DXO1ZoaM7b/syNNKUdBqYYaaIARExv5TwTqE
         Q9DXgtNwSjCTxTcxTSYHhufaJ0HHghq3H3+hqQVbtgmU2jXVgpUY6Fo7ey/b0CXkwFmD
         vrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NeuF3JT4YnWf5M5XotA5SOaOYm5JDISTm500jhc8pMA=;
        b=iv3ukgWZmFUOdQSLZ8M2s26QVj15UqWCv07W00wTBW3vpjl+poaf5G7GUV4w4rsozf
         Q7A/sX4TTa0T8IplAXtrUdw4gSXdQyXElS6elXWp2S8oJGhwxNM6GFGvwFEbyfwMTgbi
         HDkCi5dCKJhVtvUB8JhN40oUIyqFhDFZc5Na8dQAwHSsJrUIXrsw7hcm2iCEDiUhVZMb
         BKFIw+uauclK7lVyAxcwpQV8LopkDuJU0bC19l/9GbimVBbgnSYmNUcZ8BDTUNIEBWqM
         Yud63vBtaz2MDgCzefPdijfm8V6gJuF6M5pMVF/8kemPNYau3MPaGauZYQDjy6dTmStL
         zrnQ==
X-Gm-Message-State: APjAAAX+RR6vUdv0eozwy15h85sUVFxFx7tPqH8bgGa6DlWWj9rliqGR
        2K5z79cZPp38C3S7hcogrMu46qiR
X-Google-Smtp-Source: APXvYqzKSnePedMrK+2l4aYKU9vIiG0lTQY0AvymNN6PYjYesgr5x0mtTMcW+gavMzB+6nHSFUB+HA==
X-Received: by 2002:aa7:d816:: with SMTP id v22mr11592814edq.364.1580732476460;
        Mon, 03 Feb 2020 04:21:16 -0800 (PST)
Received: from [192.168.1.178] (i59F77C12.versanet.de. [89.247.124.18])
        by smtp.gmail.com with ESMTPSA id gg24sm1036148ejb.68.2020.02.03.04.21.15
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 04:21:16 -0800 (PST)
To:     selinux@vger.kernel.org
From:   Denis Obrezkov <denisobrezkov@gmail.com>
Subject: rangetranstion in cil fails and doesn't produce explanatory output
Message-ID: <6a4178fa-72fd-22af-519b-16cd2ec6c3a1@gmail.com>
Date:   Mon, 3 Feb 2020 13:21:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I am trying to make rangetransition work, this is my cil file:
(type foo)
(type bar)
(allow foo bar (file (ioctl read write create getattr setattr lock
relabelfrom relabelto append unlink link rename execute swapon quotaon
mounton)))
(rangetransition foo bar process s0)

Now, I am trying to install it:
semodule -i lximage.cil

Failed to resolve rangetransition statement at
/var/lib/selinux/refpolicy_mcs/tmp/modules/400/lximage/cil:4
semodule:  Failed!

I use Debian Testing with refpolicy enforced. Policy type = mcs.
What is wrong with my module? How can I get more explanatory output?

-- 
Regards, Denis Obrezkov
