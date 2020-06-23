Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D7C433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D82420679
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIlqst66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbgFWNPT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732662AbgFWNPS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 09:15:18 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E873CC061573
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:15:18 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g7so16474094oti.13
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klXMq9NPLFIW0GPQwWSKwfvpoYhiAxb0mG+oIrMT1Dk=;
        b=kIlqst66uHqurWGseabFnYNrXbBry2VYaiUHzGWqZoCin4lPTZxl1omUkzC3Al9wOO
         cMXHqqbBg1/0Cf68IuHJd/kDt1ToKSolYrAgjLxszG9gZy7DFRXeF9lH9sPBsrgjLQ64
         0zffnd9pUKnQLyB0yWL+TijQufwVzpfoFVjjqdOR9pKk0RLo+XG8xzaiIBXwTjHUZ2mq
         9FBYWlb1rd0FtVj+v4P/HgoaDFQNbJbYf3Au/79a7Dk9L/juQxCCFzDGfrNTbKeN9gjk
         iCvqXDanErTR2XieL3Lgg8PXxepGHtG2m0ojJDZLBrO70PsTU5P1PhbW4eAFz6QXRSm2
         /FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klXMq9NPLFIW0GPQwWSKwfvpoYhiAxb0mG+oIrMT1Dk=;
        b=mstGZLm+tgz7CcMS3lN01F0XE+pWVVM2MHFc+q9AcCpoQ/zoRE9TGwfGNkUJjK9Y4h
         4k4z7dX9qSGqukk88SPD38+g/4RAVv9sr7EsZ9tcrv3eUiXUQgVonA1+Rz7cJho6iXum
         KWWGjR2uFUCzYKoXXnF12kIQPsaLaZN7y+jsvCmZieAKUGHLrozqtFX/oIhLfPWyVH/y
         PndwkEG4RsnwiFGUIQ50smC7qn7jHu7htNe5FHLgMuYv8JrD4WoTKHTU7ni8A2dyjJMd
         8mPDdkY+YlB9cQXAHCNdNDZ2Evm20ntQ3LVmmN+gYxpQsLIbz84NjAX3k8YLIbVcF69J
         DXHA==
X-Gm-Message-State: AOAM532zCdEBM0S8CxIOpQwVkzdhSy4ehX4oHuahTyXG/Oo0FsWl6ptN
        Urfh+KIJcT/CMYWtEPmmACcRJVqBEcWzOOZuQwg=
X-Google-Smtp-Source: ABdhPJy8+OFJljcK405HFjnlsrjevtitClqMc55YZXMHfSKA5UIqdQKU7xu59nLXPKEego5njQQdjdwbUmt+1kCzUxg=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr4121605oth.135.1592918118393;
 Tue, 23 Jun 2020 06:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200623123702.401338-1-omosnace@redhat.com> <20200623123702.401338-4-omosnace@redhat.com>
In-Reply-To: <20200623123702.401338-4-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 23 Jun 2020 09:15:07 -0400
Message-ID: <CAEjxPJ6icR4UdMsameoRXr1C_X7jzCwqYUCXsNLSrJZ4W=Mfbw@mail.gmail.com>
Subject: Re: [PATCH testsuite 3/4] travis: fix git/cache handling
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 23, 2020 at 8:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The current way of fetching new changes from git blows up when there has
> been a force-push. Switch to just fetching and then checking out the
> remote branch directly rather than using git pull.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
