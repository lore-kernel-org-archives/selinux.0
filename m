Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6341C636D6
	for <selinux@archiver.kernel.org>; Mon, 20 Feb 2023 22:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjBTWdY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Feb 2023 17:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjBTWdX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Feb 2023 17:33:23 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4BD166E4
        for <selinux@vger.kernel.org>; Mon, 20 Feb 2023 14:33:09 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 132so1295250pgh.13
        for <selinux@vger.kernel.org>; Mon, 20 Feb 2023 14:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLwOTv5Yy6Sac/xq6+MRSYPr4yE0GAyv3hN823qQyP4=;
        b=eRCx2dyy/zZAmFYJ5XYXadNAuywkc4GIO4aMt972ISL1UZnpTuz4FCPBr3kuI7MmOC
         t7Pa2Uw5+5g0oRBIdRI3oY4XTdkLA11okOfXIpHc+MGIYciy7meDpsF00/8r5vvfGtcF
         8qOt8AAvW2LhdUgzhEcsJpuLVAZANw5zdar7se7ogn0fW+7AgpPx4t2rpSoj3sc2LQVu
         IvAIhYcgaZYMwrIrLqtsTGJiYqjzZU3Fv9KgPZuX8myShtykWWtCJPsXOd0TNjqUfsOB
         PtjD5VQk94W/FmspUXDH43dpTUyHFjj6CXQngEDGnVzoRt28O7ymcQICaAc8PLE+yhly
         30rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLwOTv5Yy6Sac/xq6+MRSYPr4yE0GAyv3hN823qQyP4=;
        b=1vkiozgqetZoPJXAjxtJVWFFhKnACfgWKLUPc4OmJYoF/zOBParlmTr1n6Adr8WB2t
         Sx60eBTJ62aEQnxDhgoyJ3rOmv3LBictWYBj/QmT5Q26gdrTUzurPW8VCvQeXp0/Tb9B
         IsOHB06WpjervYOURTm8AEWZOPMx/3ago+FaUnob8TZ2EUNRoDZG8cR49km9Xax/BjPi
         BV/RKG4pnTBnkP8TGB3+/QjhXMIdeEC1/F2STi7ujZZxIlru5dKS62ygX76A7dpqI2rB
         l6lgNEDJtnyl26azGfRvdwlbnyG+KP2RZ3Rc/zfcRLV+ctSadT6blNg6K/L3qf+tMOcZ
         qEJA==
X-Gm-Message-State: AO0yUKWYasAAE3bTbX/o6vTihaMUHf6dHzT1mhF9YcIyfWoFgx4Qz61W
        HgY3mwESMi4cyXp6z3W0PjiLlJWw6xYOiWzxchqmqo+17vlk
X-Google-Smtp-Source: AK7set8UsJsUAG+K/p+24hv0gnSb60Hk+iFu0SLa3UQGkjaVxN9B5mGp+lfJYehV4Z6V1UP1P7p7KxYOKbIQKQTC6x0=
X-Received: by 2002:a63:b513:0:b0:4fb:9dab:66bc with SMTP id
 y19-20020a63b513000000b004fb9dab66bcmr395825pge.1.1676932388632; Mon, 20 Feb
 2023 14:33:08 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Feb 2023 17:32:57 -0500
Message-ID: <CAHC9VhQQPqren_Y4ipzjwcLo8CSXz=x=ABpk6PtjX5J2_WgY=w@mail.gmail.com>
Subject: SELinux pull request for Linux v6.3
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Just a quick FYI that there were no patches queued in the selinux/next
branch for Linux v6.3 so you won't see a SELinux kernel pull request
during the current merge window (assuming there are no breakages).

-- 
paul-moore.com
