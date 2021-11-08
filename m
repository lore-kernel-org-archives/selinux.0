Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9E2C433F5
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 00:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2154761251
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 00:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhKHAoo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Nov 2021 19:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhKHAoo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Nov 2021 19:44:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D675C061570
        for <selinux@vger.kernel.org>; Sun,  7 Nov 2021 16:42:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o8so55684224edc.3
        for <selinux@vger.kernel.org>; Sun, 07 Nov 2021 16:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQsMoxxo6vvZxdeXnaDyOfDzDVU+kfuV0D4OVx6iMsQ=;
        b=rIo9esb5Ao1lsyabSBqkTtwbp0LJsI0+vaazzmFoSkQPhhgFGiDPfUueMVN3lTEB/V
         KuoZ0O6+t1P2lEDo+7OK4ss281AG/LY2+4lUn8fzvanqiBX1mWOw3/uMi7kTtvcSwTrq
         edvJXKqd0suYru5DauPbzoiB2KlRa+eV0Kiq74nfVXG8N/BWkJQxyaFbd1Bl4ai3Vmb4
         LSavr1buIg14eDaEVFBQ1h8SI0X1BFpJb69trGfxwlNXw/cI4Js+AeJrGGc5CmQ0CY51
         4bht7RXG1N1FUvM/cKfxH14RRZ9qf4qBgmb09PlqYdHPR3thEeUkxGTc9rmwL9xMyz3d
         Ak3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQsMoxxo6vvZxdeXnaDyOfDzDVU+kfuV0D4OVx6iMsQ=;
        b=Os7xb9XUGzV5B5U0Szobl6p4HN6viMXI6CrBRr9sAeSMBGSPq7HaFT1kGUkpqQH+v5
         vWudSqsiAWbbnmL2si4tXyP6oG3KiLwLR/4l2dnE75P9nYRAckYSbB5yarWoHWm6Kw7D
         aF3dvnn1JLm9ZrCo18vL8S99oN6Qk5VxZEzAAPfFlMFFf3C93zP4oZQ6tF9fmcOXN81f
         lEHYMUhYnCo07UIvJUWlTdOdjt7KmQNpP1JQiKx4uiQj5s15pu/RwtahKeuZzgXOF0Pn
         5K9/hYe9iRjXNswDI7/smcLDSzsKs/CLqRJt3r9Q1D+cXUzatVibDUrBrWTg7r55ruDs
         ZCbA==
X-Gm-Message-State: AOAM532kOgLONJE/gHB/Xsc3dcPZRtL7096628Lx1aU7ArrLhm/BO821
        yd0gVCfJyIVocuZkB0dWqNOt72+Y35TTsYsVK7n1
X-Google-Smtp-Source: ABdhPJxGGyTDiq3kTPKzYcm9DKRZvSWoRdN9WdXhDYlEK9VUjuZ5DvKyIzNqLKlStk7UxW/w7fh7l82VSj/GVbKF8VQ=
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr66694182ejc.187.1636332118501;
 Sun, 07 Nov 2021 16:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20211104195949.135374-1-omosnace@redhat.com> <CAHC9VhQwpKWBF2S=vTutBVXeY9xSfTRuhK9nM9TariLVUSweMA@mail.gmail.com>
 <20211107.190959.1432110661171124830.davem@davemloft.net>
In-Reply-To: <20211107.190959.1432110661171124830.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 7 Nov 2021 19:41:47 -0500
Message-ID: <CAHC9VhTq-6rb3VbVQs4TS5DnzsguNiLB_iyq5ZFNMqqvO8a5gQ@mail.gmail.com>
Subject: Re: [PATCH net] selinux: fix SCTP client peeloff socket labeling
To:     David Miller <davem@davemloft.net>
Cc:     omosnace@redhat.com, netdev@vger.kernel.org, kuba@kernel.org,
        lucien.xin@gmail.com, richard_c_haines@btinternet.com,
        vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Nov 7, 2021 at 2:10 PM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Sun, 7 Nov 2021 09:12:57 -0500
> > When we change things as significantly as we are doing here, i.e.
> > shifting some of the labeling away from the endpoint to the
> > association, I much rather we do it as a chunk/patchset so that we can
> > review it in a consistent manner.  Some of that has gone out the door
> > here because of what I view as recklessness on the part of the netdev
> > folks, but that doesn't mean we need to abandon all order.  Let's get
> > all the fixes and repairs queued up in a single patchset so that we
> > can fully see what the end result of these changes are going to look
> > like.  Further, I think it would be good if at least one of the
> > patches has a very clear explanation in the commit description (not
> > the cover letter, I want to see this in the git log) of what happens
>
> Cover letters show up in the merge commit log message for the patch
> series so they show up in the git commit log.

That assumes the patch(set) is merged and not applied directly from
email, patchwork, etc.  I try not to make too many assumptions about
how patches end up in various trees as everyone/every-tree is a bit
different; including the details in a commit description has been the
safest route in my experience.  Regardless, the key is that info gets
into the git log in a way that is easily discoverable, the exact
mechanism is less important as far as I'm concerned.

> Paul, please stop being so difficult and let's fix this.

David, please look at the associated threads and see that we *are*
working on fixing this; no one likes broken code, we all want this
fixed.  As far as being difficult is concerned, I can assure that from
my perspective the individual who merged a patchset in less than 24
hours (during the initial days of the merge window) without an ACK
from the affected maintainers and then refused to revert the patches
when asked is the difficult party, but I guess we all have our
different opinions.

Best wishes and warmest regards.

-- 
paul moore
www.paul-moore.com
