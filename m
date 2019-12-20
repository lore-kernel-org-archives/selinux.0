Return-Path: <SRS0=yCNt=2K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAF9C2D0D2
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 13:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7339E222C2
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 13:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lT23K32L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLTNsU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:48:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38078 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfLTNsU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Dec 2019 08:48:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so10075009ljh.5
        for <selinux@vger.kernel.org>; Fri, 20 Dec 2019 05:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hg5STfXorHKAxgt7CaWaH0qAIyfvoSiPfhGulZ9vBv8=;
        b=lT23K32LbiDEbYb65nadstYYsp2GiYsKzxqGzErTJn8D52OkkMPTdyzYQmzvl9+RUq
         3IjIaJUk/J4ocH88aoRlpeiLQuEnhYp6eQz9lh4845y4VzNHX2qtvjqJz4PFe5ncz1+H
         PdifeQDe3K0qQoK4/go4kXEzajBzlAn3rKdqb6Pr1HFiqXpyvDXWvyWBJ6RLTaSCxQR8
         Gmi0DXs3hsJffLRbQAk79csR8QPO8zkpuiuPcqcwAFSUG35fqQGsMWA3jaD+kjDRDQ/Z
         u2vOXQ/saHm1m9izdWVHbOUM+ZJI2nceZx16OUbaNqS3d+xClCSTcamoABNPbNRE/Mh7
         x8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hg5STfXorHKAxgt7CaWaH0qAIyfvoSiPfhGulZ9vBv8=;
        b=NhpbNz3pn8zjyNGa3tw4WEuIfn3rssgg+ifkQ7ZF+L1EEnI0Gs30VRvp827dCifwGl
         7hqzinnkJUBJk1AR8SR0Z+kixABGDlrMnyhGkoDYxcXegwW73w9gIxVM+xcB7BdTnVnj
         o3HvUuS267lIUq0/083JIgMyMpCODaGzH6b09asbx37/Ifdav7mWeFQAIsJhccxi7c47
         0JLERDH8/7O2chgHsLhvhNPwk4DIg2IBoCBV5JK4flGeHOc0wMceo8VeXCacjVVD7mjq
         HKR+IbwSc9oOmZJVOj97bjmjpbDawfXoTlC8xk16vJdDKreAJ8xwow7ptARSaqDo/Sey
         vmDQ==
X-Gm-Message-State: APjAAAUGGceocbKE25sa6XUwYZGuRVl+F5dAUhpu3Yxriu0eBHgP8hw9
        FQd/fD+5xzRq4exguoPu8vOGOEmjAFaNJGgY7+STKm8=
X-Google-Smtp-Source: APXvYqyFNsAyZe431QU8ls3HZL0m1ySGEpjjQAPDrP2l4h8YKO6fiyfr/Agq88Z4RCIsP657s4mgMmXI578/vlHF+5g=
X-Received: by 2002:a2e:8188:: with SMTP id e8mr3316742ljg.57.1576849697917;
 Fri, 20 Dec 2019 05:48:17 -0800 (PST)
MIME-Version: 1.0
References: <1576836441-4140-1-git-send-email-yanghui.def@gmail.com>
In-Reply-To: <1576836441-4140-1-git-send-email-yanghui.def@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Dec 2019 08:48:06 -0500
Message-ID: <CAHC9VhTup_3LnC+i77_bC93G0GUdh1xY7JM5fbRD5_oPO9=jMA@mail.gmail.com>
Subject: Re: [PATCH] netnode.c : fix sel_netnode_hash be destroyed
To:     hui yang <yanghui.def@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 20, 2019 at 5:07 AM hui yang <yanghui.def@gmail.com> wrote:
> From: YangHui <yanghui.def@gmail.com>
>
> we often find below error :
> [   30.729718] Unable to handle kernel paging request at virtual address fffffffffffffffc
> [   30.747478] Kernel BUG at sel_netnode_find+0x6c/0xf0 [verbose debug info unavailable]
> [   30.818858] PC is at sel_netnode_find+0x6c/0xf0
> [   30.824671] LR is at sel_netnode_sid+0x3c/0x248
> [   30.829170] pc : [<ffffff8008428094>] lr : [<ffffff8008428154>] pstate: a0400145
> [   30.833701] sp : ffffffc026f27c50
> [   30.841319] x29: ffffffc026f27c50 x28: ffffffc026f27e40
> [   30.849634] x27: ffffff8009132000 x26: 0000000000000000
> [   30.854932] x25: ffffffc016f0aa80 x24: 0000000000000000
> [   30.860224] x23: ffffffc026f27e38 x22: ffffffc026f27d34
> [   30.865520] x21: 000000000000000a x20: ffffffc026f27e40
> [   30.870818] x19: 000000000000000a x18: 0000007a13b48000
> [   30.876118] x17: 0000007a16ca93c0 x16: ffffff8008e56b2c
> [   30.881406] x15: 0000000000000020 x14: 002dc6bffa5d9e00
> [   30.886701] x13: 203a644974654e4c x12: 00000000000017c1
> [   30.891997] x11: 0000000000000000 x10: 0000000000000001
> [   30.897292] x9 : 0000000000000002 x8 : ffffff8009933090
> [   30.902588] x7 : ffffffc0725fd090 x6 : 0000000004fd9f2c
> [   30.907881] x5 : 0000000000000000 x4 : 0000000000000000
> [   30.913176] x3 : 00000001ffffffff x2 : 0000000000000000
> [   30.918475] x1 : ffffff800a10ca80 x0 : ffffffffffffffe8
> some sel_netnode_hash[idx].list==NULL,so happend this.
> I add spin_lock_bh on sel_netnode_init.
>
> Signed-off-by: YangHui <yanghui.def@gmail.com>
> ---
>  security/selinux/netnode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 9ab84ef..aa0eeb7 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -293,11 +293,12 @@ static __init int sel_netnode_init(void)
>
>         if (!selinux_enabled)
>                 return 0;
> -
> +       spin_lock_bh(&sel_netnode_lock);
>         for (iter = 0; iter < SEL_NETNODE_HASH_SIZE; iter++) {
>                 INIT_LIST_HEAD(&sel_netnode_hash[iter].list);
>                 sel_netnode_hash[iter].size = 0;
>         }
> +       spin_unlock_bh(&sel_netnode_lock);
>
>         return 0;
>  }

I'm confused as to why this patch solved your problem.  The
sel_netnode_init() function is only run once during early boot and
there shouldn't be any other threads trying to access the netnode
cache at this point.

Can you explain the conditions under which you see this problem?  What
kernel are you using (stock distro kernel?  upstream?  Android?)?  Can
you reproduce this problem?  Can you provide source code line numbers
associated with the func/offset lines in the backtrace above?

-- 
paul moore
www.paul-moore.com
