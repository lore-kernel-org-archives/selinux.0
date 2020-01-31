Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3403C33CB2
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 04:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2A52082E
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 04:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="F60JnfAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgAaEYn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:24:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41654 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgAaEYn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 23:24:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so6336577eds.8
        for <selinux@vger.kernel.org>; Thu, 30 Jan 2020 20:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qefcsgr+aIZYUjUoj3PSe8yr+He/pWYTYeXdGHDkVFI=;
        b=F60JnfAFe07z7j5fVClR+8ipuPu8Y68Q86XRS9BcOQwbrSPvcWQuBpLO4qNsI6Pirg
         21E00Md1ltmPG9+ZZS1HHrmM7Hx+gonhLCCz7wUVdiNTw7ukcdjAL81H8HOVwX1Xd5rz
         unjvcrrVmiFGX0gZvmTUqGzw3fxF4Dya8wCpKow3KYpb/uajRp7BV1yPNb7TLL6cPL43
         agzurNy8VjobRE7/EgYIpcc42+r0Sfsw6c4fEoQALfgc58zomniar92BHjetx0YyyHwJ
         HGaQyoLEMzOHAMSraX4RR8F4GhEfTXqdpLvPSshRPe9fPzXiEHLp5bo9c8273IRRJ4zM
         OuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qefcsgr+aIZYUjUoj3PSe8yr+He/pWYTYeXdGHDkVFI=;
        b=ps9v9Hvq7Z5VXSkIdiwwgBE5iZ1I5nSy/XWm25OYAVMWVB9o5TuXq+54B40tbyMIHo
         oboE4zy8hez5ZbMcsbEf47Jn1vYSOvq2cB9h2v/IB5ssZcws3AQMMyf1rurgVrtTrpFD
         XIic04JH4Mj8edBRPV/77GLf9gMECv1MvQ0ksqPqxsEp6pkVOrdZZiCeCi6rlYjJVw/d
         ZbIkcbEtTUmQNGyuchP3N4rUetbE2CN5tBUR2NYbbpCQXzCpWDG3QJoKsAgKjVwnNJMQ
         Om94m+I/lXCdgO3O1vdE8wDRa96iBiBv1JXw6uj4qBalyYvxi7UEMx8b/OuYZVdbbW2r
         ESxQ==
X-Gm-Message-State: APjAAAUq1GCrZXmQlHBQVSgcSXTHDabzgMcb6+4Q3EtSpV9FmkJ6y1w5
        lTNuDtgBc6A+0Pe3eGnJbrz816iS70rPYLhqJ78W
X-Google-Smtp-Source: APXvYqxSo711xf/v0nJq+NvTG90kNiX2eJlUq+Heb8BK1C/uHixd4EEViO3iMvVT9AQpl0bczVkSUdwxGeAlrEwaaBU=
X-Received: by 2002:a17:906:c299:: with SMTP id r25mr7210307ejz.272.1580444680123;
 Thu, 30 Jan 2020 20:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20200117085836.445797-1-omosnace@redhat.com> <20200117085836.445797-6-omosnace@redhat.com>
In-Reply-To: <20200117085836.445797-6-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 23:24:29 -0500
Message-ID: <CAHC9VhQyZ3UQWZv1o_YjGQ2A27zLK8u6npo4w1s=Agi-35b1hA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] selinux: generalize evaluate_cond_node()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 3:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Both callers iterate the cond_list and call it for each node - turn it
> into evaluate_cond_nodes(), which does the iteration for them.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 10 +++++++++-
>  security/selinux/ss/conditional.h |  2 +-
>  security/selinux/ss/services.c    |  6 ++----
>  3 files changed, 12 insertions(+), 6 deletions(-)

Also looks good, but I'm holding off pending a potential respin.

-- 
paul moore
www.paul-moore.com
