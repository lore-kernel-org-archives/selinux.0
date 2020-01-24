Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610AEC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210D420709
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="o5VY+fpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgAXTIi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:08:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41249 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbgAXTIi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 14:08:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so3574021eds.8
        for <selinux@vger.kernel.org>; Fri, 24 Jan 2020 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3sJpV6yWm3fpPJ9mK++/ynTxy1qYzfb+A9IhQO37wE=;
        b=o5VY+fpzD0NLNQMJ9eBECLtyPXw3H1EFw14k5t8QXlg/h9TM4CPiwqbLMAGXDHv17Z
         Jle5utr15mBrq4V1yFfDD8TAirsJNKjAVQfP6VCH0AoEpSsVE8uOHRKZnNLf2w4k1zTg
         aHiQ03S4scRgqgO3ctMnBlIiKBm7ku9w6eJx42IsxTV24IZMdBPoV0aRgeVVV0pcbZoX
         OOnzbvDkH4ZGsz/s96O432UL47FE4eOhfwpEnOyC4VyL2TX1HxEE4UMvzWXTtTA2oRfp
         rjcSU8ngJ3DmyyWQSV0HRz7W4Um7jSe3TYYdRB/miifhdC726+Y7jrhoKYiF1QkTMBar
         xWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3sJpV6yWm3fpPJ9mK++/ynTxy1qYzfb+A9IhQO37wE=;
        b=qiLfPqvGTTLtkbTDwmCTE02XamYsaJ+shyJe5wPT+Qz2CP9NrhlKwxA0vnrrpr9FuB
         7woIDsx0zYddhNQ8xmvUE+Q6ut2Jr+39O16vfE4pcnxyQckVvQtW+AceVb0c48OTyj0X
         FWSPFIm4O2hB2eOxL/Xjuu//I88Dsjy7Utsl8bjHgEVcexNlo63zk2JLsvGjLPmly6jm
         R2koieNlbWv97+3Q0B5teat6YLaulJHoVvp5NX5Bu3YdEjs1oktP9x/D0cVFVCiFDznl
         u8sJMqdl0hvv+0ItMoUDGEG8EFAYQuCpSIk4PMdHFO3miyvZi7ffg9HusJMvhGnLz3DG
         rP9A==
X-Gm-Message-State: APjAAAUHgfq6NHRKkNrKaypqGLKAPqH6QRFDGWC/ZupatK4duZ4XtYRU
        2VkV2XHdXXimTpZ+T28R4Ty3pQlwq3y+Wn/T12m5
X-Google-Smtp-Source: APXvYqyDNlqZ0y5SJrw4bJxXOONFVmjk03Ri5WMCe93c145o+cp4GbzPU5ut/btxt07N8ZgXgiKzsG+orgbhcp+0AbM=
X-Received: by 2002:a17:906:494d:: with SMTP id f13mr4018495ejt.95.1579892916726;
 Fri, 24 Jan 2020 11:08:36 -0800 (PST)
MIME-Version: 1.0
References: <157981918030.502116.11086856862222322471.stgit@chester> <a07232e1-9536-3020-89e5-c76f45cd35dc@tycho.nsa.gov>
In-Reply-To: <a07232e1-9536-3020-89e5-c76f45cd35dc@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Jan 2020 14:08:25 -0500
Message-ID: <CAHC9VhQbOHuEXMffk5ARdZ1nPzoOk=x6+Z33a-PMKYJxLyH24A@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: move variable definitions out of binder_common.h
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 24, 2020 at 9:06 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/23/20 5:39 PM, Paul Moore wrote:
> > From: Paul Moore <paul@paul-moore.com>
> >
> > Move the definitions of variables out of binder_common.h and into
> > binder_common.c in order to prevent compiler errors.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

I'm pretty sure Ondrej is fairly busy right now with DevConf.cz so I
went ahead and merged this into the master branch.

-- 
paul moore
www.paul-moore.com
