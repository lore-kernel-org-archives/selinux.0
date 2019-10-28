Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65108CA9EAF
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 01:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C65C20679
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 01:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHILIH3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfJ1BHa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 27 Oct 2019 21:07:30 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39906 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfJ1BHa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 27 Oct 2019 21:07:30 -0400
Received: by mail-ot1-f43.google.com with SMTP id i6so428811oto.6
        for <selinux@vger.kernel.org>; Sun, 27 Oct 2019 18:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wCtcJnKRvyd30lFGywDyhkJJFI2nGTbuAOKfN0EBg6c=;
        b=QHILIH3rH419Sw/C9d2fCt/vJr5ptTEzdyjoivkS5t/2st991uv8HZwgI+nWLoyYoC
         3E2Sd8Kq3TIAuLnWyDXv9VpCEGPYhEkSwQ85EAR2DpZQ4FWOS975GEHRldMqk+DwoOGJ
         yD85Ercn5zZa6pzy3NY1u+QPqBpWc4QaRkAx7nrQD54NhMiIzasm/Rp51EZz+hs55m/0
         sqd1ZMagHOlrBFZlqS9sIIv+uPrJ9AL9RE+6O9UybJg71UoGQQmd6wGtGLx+LPvSLniF
         odgoNLQR4FMLpYyqh5tvreJygJ0CfQk2ZUYsXvCLpgjGmNhvwfY7DDNJXT6MfgB14Wu4
         4LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wCtcJnKRvyd30lFGywDyhkJJFI2nGTbuAOKfN0EBg6c=;
        b=tbMMjuggISzKfbpGUMI9taIOWg/1+h2HvJX8tTMwBylgNC2Odo5CaNyOAuqEz3CbXQ
         jOel0kGhSCT7y3z7DTJiG7VoheX4DqwmJk2hbIBtBa0rLM9t71x83MUsGwVaPNlUwmhD
         2LnUXUFGE7cqbADStcX9On6nimw8gvRcaSz9+snmqGGZrXKG0T9KQtGsHdDRg4LhOLwj
         MlYpDGUoO9h0nUP/VTvMp4DF2uWNHbxNECZGNibCfa0ydj4YDeLDog6imQU9uf7IvoC5
         PbPnwoWXtXApGCJBI+GJkhve8VcAnhHtf05ewy+2nYj17tifSEcOKrUcQ+Cbiiz01GGI
         Ta9A==
X-Gm-Message-State: APjAAAXi1K9zyCegRKB2vG5cZiIiWMA88f+t4SOrzTE/HNUwmKZkvTo+
        49uRsbnUhjWQc7YeXbmHp+KNu5vR
X-Google-Smtp-Source: APXvYqydptmv2CQ9nIpKw0kDAtujV15vPpkHCP1KwnpFF71OeiG4dEZZlylxkv5tncik64bLyU4n2Q==
X-Received: by 2002:a05:6830:11d6:: with SMTP id v22mr2954333otq.142.1572224849236;
        Sun, 27 Oct 2019 18:07:29 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c8b:a4fa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id c15sm3287162otk.12.2019.10.27.18.07.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 18:07:28 -0700 (PDT)
To:     selinux@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Add portcon rule to existing policy module
Message-ID: <bded2b55-30eb-e039-19cd-4e834ad5ca28@gmail.com>
Date:   Sun, 27 Oct 2019 20:07:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I have a policy module that consists of a .te and an .fc file.  I would
like to add a "portcon" rule to this module, which (AFAIK) can only be
done in CIL "format."

What I've got today is:

1. Build a "traditional" .pp file
    (make -f /usr/share/selinux/devel/Makefile).

2. Use /usr/libexec/selinux/hll/pp to convert the .pp file to a .cil
    file.

3. Add the port context rule to the .cil file.

Is this the best/only way to do this?

Thanks!

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
