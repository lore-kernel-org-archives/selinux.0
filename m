Return-Path: <SRS0=Vz70=67=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E914C433E0
	for <selinux@archiver.kernel.org>; Sun, 17 May 2020 21:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AEB20735
	for <selinux@archiver.kernel.org>; Sun, 17 May 2020 21:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="b9W1j74R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgEQV7a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 May 2020 17:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgEQV7a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 May 2020 17:59:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CA8C061A0C
        for <selinux@vger.kernel.org>; Sun, 17 May 2020 14:59:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bs4so6836204edb.6
        for <selinux@vger.kernel.org>; Sun, 17 May 2020 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROlRoqEJS/m8nAAsZexBrkdo4BzRRx2EAs6qFgCMo+c=;
        b=b9W1j74Rsdc6gmyBfvY9Lv4/KXqgkkhEwdf7NsL3ccSkCdVUhuo/wUN6hQ3WH5msc+
         pyrYocZorNEmhf3+z0Cw5pzvARQnKqR8d9GPJTmFOgYccvrG9gMCkpoaZROlCTAbuT3x
         P0sEzneeCjBFUScaYI6/Qpx4KR/O+izx2MkGI5byad7/CPiBRf2L6uMx3ZoiNw/l6c9e
         lU13BA7ddXoewQstEm4ykPw8/n3fyZ3R3bIBBjPYY96lc6olgl1TUQNOYIPLOEuFJrM0
         6uvwy+9YD6VC0AJTcpZbGpji3toE+hV1o6CLqMQ9iKjCwmdJIgC+uQK+rFPbpCV/FVlk
         QTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROlRoqEJS/m8nAAsZexBrkdo4BzRRx2EAs6qFgCMo+c=;
        b=eF7T/fS1mr5JxMd1rFpz9x/sQk7FFKhVVdREz3tiY2/GDrx5FWGRaM8YMQ9fQ1S52V
         cxayZDsOJ0lWHzWYR+oqp212Dv9/OMtB05ytqciTjo/8oYRRzXdMKsvfA/Qe1qE8RM4h
         H5rvh7Q6k9lKFE3gXAvi18WxUbgCI4Jwgvl3YUuAHhMX0Djpa6e3ZnvRICFksw1PcpdZ
         8ljK1BagdWhFd+D3OSvgFgyJ126GhFP8lsd36s8rXDO1J+1eVxEf8ih3Ri2cXtjd5h2i
         EQElvnikheJCJIBsMZ4/tq4DMDhPXwZgqZE5MWzWHWGy4y9dIvyIKJ6RW3tPtxaBGDZ5
         NSYQ==
X-Gm-Message-State: AOAM531Qa8myA6uLdDY/kIogXspGzQugPLt1bClj4TPn/44BK/h2jXda
        dFRZuxnHJXAdTSzM8hhGE97LWbhKZEN9YvrdpMNr7KQ=
X-Google-Smtp-Source: ABdhPJzQRIdqjSJXqWnaU8cfNmfwUnDiu6cKBlnPDZeyT7uuP9rMjRuIlyQ0Qg7F6tCBs8QWf+gjDsm5JiNOfL2TyiA=
X-Received: by 2002:a05:6402:14d3:: with SMTP id f19mr2467545edx.135.1589752767582;
 Sun, 17 May 2020 14:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
 <55ef0d617fa84d72f142ec0fa6492e5c5e1b1e2b.camel@btinternet.com>
In-Reply-To: <55ef0d617fa84d72f142ec0fa6492e5c5e1b1e2b.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 17 May 2020 17:59:16 -0400
Message-ID: <CAHC9VhQ5f_h_H=CyunX2tKbCgHP8o2Jp4dyMLzX0t9XkG8TPgQ@mail.gmail.com>
Subject: Re: Bad context in PostgreSQL page on SELinux Project wiki?
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Peter Whittaker <pww@edgekeep.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, May 17, 2020 at 7:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> I update the notebook occasionally to keep track of changes for my own
> reference, but currently have no plans to publish a new one. If you do
> have comments I'm happy to take them onboard, however no guarantees to
> publish.

I just wanted to say thank you once again for all your work on the
notebook, it's a great resource!

I understand not wanting to go through the process of generating new
editions of the notebook, but is the source material posted somewhere
online so that people who wanted an updated copy could access it?

-- 
paul moore
www.paul-moore.com
