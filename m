Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76BDC433F5
	for <selinux@archiver.kernel.org>; Mon, 10 Oct 2022 20:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJJUaC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJJU3i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Oct 2022 16:29:38 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DBF21806
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 13:28:08 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id m81so13878880oia.1
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yxbDYatxrJnQvjr/GFzCtmXU6Nv4rtItYsT4X4RmZ5k=;
        b=bYk/b45QFD4d2Lgafr4R6+d3JLVRpBvhIEkqV2QrCFYpGG8WFFojdRuZ27FBmERAIV
         wuy+t0NdErwFZX355kwVJ52eho1gJqstEn2m2+LkuUamZV3MK7XlNmcUB8DUoSuKrPqj
         LgOtxQigrx71PAC7yTrVWfnLYVeYqpfluW6d/wSkbrrgFRROy8K2UDOTsWL5lo0E/Vu8
         N2euSBpU5HidD7yckAQqXYnGsN6MPDy1GgWm0f9XfgndpqxAidtLmC6WhkIOnaFBoduI
         LslWy8Thj+TF1yzYpXbF5n7QUy+SqZwOcJl3VJaw/1YgWI3zHCqZFQWwIuJPIzRqtjQB
         0/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxbDYatxrJnQvjr/GFzCtmXU6Nv4rtItYsT4X4RmZ5k=;
        b=qI2XG8FmPXF+nJlzCcwWfMk46P0r95JMLEOQuwwYC1dQUKaDSGF7Egkx8oUnjeAP1I
         8agEzTgozZGy6p3LWTwiwlPfwdSXg16it1bcRZZb0kqf2/VZMDl8h0SSQKmq/1qy0HTV
         3/tKks7n8PJ8lbHe1m6yrRPFl1Xc9IJl9tPtBgHd7RdFvRRKRu3EnSmodB4TwecsiXIr
         pc/Q5+edCdFvUeAN7kWUr8oLbcXvM0pV7HlVwtjkWfh6nQ8QC8qwKmKnUJ435KoEy2nV
         U6EA0Pjd1u6mWFZMjj3fDafZ58DmdoXEXKSLTNz2b1nyim6B1zPoHiMAvGQ7PlQjpBBt
         VXqg==
X-Gm-Message-State: ACrzQf3qdW4gVlZdXiP3A0xdNrVMbc6qLU92icZS0OO//4sUYuHf1n79
        BX/Mo89KnJ8aJu+e8ydj8AlwJmx8GWaBzE/BdjdZRMVHNg==
X-Google-Smtp-Source: AMsMyM7cqFvln8iMhTIby/uF8Km3hESW/zkXU1SiGR4Tg7oUJzi407MJQa0j/D80ismCdpwX5lOvIh2QuTsoiDvrr3s=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr15383283oiv.51.1665433688047; Mon, 10
 Oct 2022 13:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQFxHtjJ-8FQpB71WHhHwOgREGwU4TexjO5Vty8pjM+o3A@mail.gmail.com>
In-Reply-To: <CAFPpqQFxHtjJ-8FQpB71WHhHwOgREGwU4TexjO5Vty8pjM+o3A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Oct 2022 16:27:56 -0400
Message-ID: <CAHC9VhQFidA73Sd+FnnVCU1Urho1odAV-7435RtrdiP7xXAceQ@mail.gmail.com>
Subject: Re: systemd socket activation selinux context pr review
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 10, 2022 at 1:21 PM Ted Toth <txtoth@gmail.com> wrote:
>
> I'd appreciate it if some committers would review this pull request
> and add comments as it seems to have stalled.
>
> https://github.com/systemd/systemd/pull/24702

Looking quickly at the GH issue it looks like a rebase has been
requested?  Doing that might help things ...

-- 
paul-moore.com
