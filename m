Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44211C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150B2206ED
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qHL+7rDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgAJQue (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:50:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46372 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgAJQue (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 11:50:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so2780390ljc.13
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vSiXmE4hm+vY407xZeDV00oZSz7P7Tb6Wxmt50cGzo=;
        b=qHL+7rDPAtspkZeTYhcfP5LoXq67SOKKWsQSUhE/9KZkhRscH/4+cy9tHxCw98hexJ
         KUDzz5DRsUDx6nHt72wgmEmyqxMhcBcJoQKzoV/LtB57t0eVZdBK8FxX7ZpGa+B95FAU
         IN3AiIFwMlm/s7QAh03vjgtcgPMb/tcOlA66kCH9ESNrqIhKPzyG6uUrPaaDOTVtkn5J
         YiLoKcBituDgLH7WqtJGBX5GhfjaYerfqaRX21UTu1bnJS83vLFVJcYqYZb28ZVdcp0d
         KH/d7sMxvnJzUbITb0kmRGHuj80q7Qm+8DF6zwo83ev2bICMJ9k8w3ko7UKQa3jjeEOV
         ssNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vSiXmE4hm+vY407xZeDV00oZSz7P7Tb6Wxmt50cGzo=;
        b=faE/Y96fHY231KOIoD9TLVwJbKw8XGG2V+fjIXci17lTBi6Nb30AZXorSOUVUmCeMW
         8H/b98IoOktL3PYXuUjXW3c4vsdOogf1ejVWF+UpAUsH1yFWXbbq09eDOzrsWcJj49un
         8rcHP3GLt1SXhvzTLb02UfClMz9cxPmmtGxKHP7JXGWcyxwlwKtT2wRUdVLiDpaEurV+
         NexYK7NRj9xNyO95StE7HCOCoQw1rpoSAJtMZ8WyyvBiR/OUWQLC3dlYaS2wt+OO1kLM
         kREIqcRbJug3+1uaD8qDa0i+vOGAlFVAHVP/690iENBN7D4FH27LxJQaRkyGeQt2ax2/
         dmXA==
X-Gm-Message-State: APjAAAWUdTCq3Yh6IN5maocdHQ2dfUruJLm+PF7rjiiTRz01aEpIejOT
        hx//IldPDWsqwcN8qKACsAnEOYAZVv7QC4Bhwgj1
X-Google-Smtp-Source: APXvYqyAow6uZx4yK/nJw6QxaEppyphJRbmhCS4VKJRHdMK34mml0Z79SHsmLh9ts8uHbUdaVBz7t4sgms9axT1NQCw=
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr3321630lja.81.1578675032313;
 Fri, 10 Jan 2020 08:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20200110095856.76612-1-yehs2007@zoho.com> <e71932ce-0687-02e5-5f34-980c0cad4ae9@tycho.nsa.gov>
In-Reply-To: <e71932ce-0687-02e5-5f34-980c0cad4ae9@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 11:50:20 -0500
Message-ID: <CAHC9VhT-8R4iT-V-A+6NvZgG=bh4Knieif2fuKwybnDuXvC6ug@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove redundant msg_msg_alloc_security
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Huaisheng Ye <yehs2007@zoho.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, tyu1@lenovo.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 10, 2020 at 10:13 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/10/20 4:58 AM, Huaisheng Ye wrote:
> > From: Huaisheng Ye <yehs1@lenovo.com>
> >
> > selinux_msg_msg_alloc_security only calls msg_msg_alloc_security but
> > do nothing else. And also msg_msg_alloc_security is just used by the
> > former.
> >
> > Remove the redundant function to simplify the code.
>
> This seems to also be true of other _alloc_security functions, probably
> due to historical reasons.  Further, at least some of these functions no
> longer perform any allocation; they are just initialization functions
> now that allocation has been taken to the LSM framework, so possibly
> could be renamed and made to return void at some point.

I've noticed the same thing on a few occasions, I've just never
bothered to put the fixes into a patch.  We might as well do that now,
at least for the redundant code bits; I'll leave the return code issue
for another time as that would cross LSM boundaries and that really
isn't appropriate in the -rc5 timeframe IMHO.

I'll put something together once I finish up the patch/review backlog
from the past few days.  Looking quickly with a regex, it would appear
that inode_alloc_security(), file_alloc_security(), and
superblock_alloc_security() are all candidates.  While not an
allocator, we can probably get rid of inode_doinit() as well.

-- 
paul moore
www.paul-moore.com
