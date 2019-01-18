Return-Path: <SRS0=8zWZ=P2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C7DC1B0F7
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4212086D
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 21:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iu7needD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfARV2V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:28:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37926 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfARV2U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jan 2019 16:28:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so12828864lja.5
        for <selinux@vger.kernel.org>; Fri, 18 Jan 2019 13:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptiKQHZpSF2UTVbrZJYVWjv37xJIFijoMub/PcNWz/E=;
        b=iu7needDjR/BFl/8KIYc1ikip3lB8+W7dQifNIEwvHv2dHIJpH1OyXYFPN7pKT+3Wk
         /gXRIhE9qQkMV2Zucz2qoG5lU7fHJG93nxqRzPY8YF2iZAj3KuBWGaXQ4DbYkOCSE/cJ
         gKReMhb6j6CB1e4RvxYcW6/8PA7PiGftw8SrYUBh3SOqRbFo+pVIYHdEmtqB5tf3mCho
         LABrRrTYL9pOOaBxjSYIcV0V5rApEdAJ2BYHh7KHN590cK6Z2xqK8VTsRhjqbUJZcIir
         kFAGMTkoPvcJT9mHke22vltbWGgDF3NxzoWgMNqaQm/BzmjTk1TZzQ9OmsxM9Mj3i1+G
         wwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptiKQHZpSF2UTVbrZJYVWjv37xJIFijoMub/PcNWz/E=;
        b=iCch5E48l92880BoTX32xBqO4hmIx7RhXpPOc4sLjuOq79HvicBYwjErSuzdWcTNCm
         WZz0vPbYMoeQ9HTd9f3GkgIXqdwYvPmOKYkE0Qe7ETs0BQvW8CBKedCHeQtwkTzv1PMS
         xHMIBt2f0iApnYImEUIJ8S5StSQP39uVRo2FBj6H06s3RQ6SGnOSRNHiHQ3vjj6XgMxN
         d1ASwBZbEy8XHCUxNavqYcvYn1p7246bU+YFJX9/UHgqiUpLaEbx36ZIwuXv/b09uGUL
         CC8muD6fAIH9nv8Ckp0FVZaZWINH2/G209gNg7yN85M7KZ2frq7o4FBb4gcIszuHF2Bg
         yU+Q==
X-Gm-Message-State: AJcUukdyhE3qf348JyynjpL0b1tABHMPrgAwsvFCMbVHI+BVdOetgO3U
        ULYXCnEdQ5MIvWNg7w0Xb9YU/FShNtVQgLJ+Lq75
X-Google-Smtp-Source: ALg8bN7SesHIY0ux42nuvNAkeWYzOwVxhof8TnOt4JkMC03tnxI/DKrTaKUnvYRmClItGZWuDo/9i7qoUW11WxkOLv8=
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr14028640ljj.18.1547846898466;
 Fri, 18 Jan 2019 13:28:18 -0800 (PST)
MIME-Version: 1.0
References: <1547821427-157169-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1547821427-157169-1-git-send-email-weiyongjun1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Jan 2019 16:28:07 -0500
Message-ID: <CAHC9VhSbtqhiMQdNJ_6yeX5+ggwVNyGYXe-E=bMj2V2z2MmAsA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix error return code in policydb_read()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        selinux@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 18, 2019 at 9:18 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fix to return a negative error code -ENOMEM from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Fixes: 31696241e96e ("selinux: convert to kvmalloc")

Unfortunately this commit isn't to be found in any of the SELinux
branches, or Linus' master branch; based on the subject line I'm
guessing the original patch is in a -next branch somewhere.  Please
find whoever pushed this patch to linux-next and have them apply the
fix.

Thank you.

> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  security/selinux/ss/policydb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 6b576e5..ef616dd 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2490,6 +2490,7 @@ int policydb_read(struct policydb *p, void *fp)
>         if (rc)
>                 goto bad;
>
> +       rc = -ENOMEM;
>         p->type_attr_map_array = kvcalloc(p->p_types.nprim,
>                                           sizeof(*p->type_attr_map_array),
>                                           GFP_KERNEL);
>
>
>

-- 
paul moore
www.paul-moore.com
