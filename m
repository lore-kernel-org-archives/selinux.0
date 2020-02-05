Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1B0C35247
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 23:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878A62072B
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 23:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vo5MQ6K/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEXV0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:21:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43042 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXVZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 18:21:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so3891132edb.10
        for <selinux@vger.kernel.org>; Wed, 05 Feb 2020 15:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nac0OcsMqrzxHo9VlvWmwuwRU03Enoj5FoP2F5tzkIY=;
        b=vo5MQ6K/wlkswomziYvdauNPRCcG0xqhhqZ/Gy9cV1gsnrwg8JF8xqCC4RW9/s0qX0
         c3cnHR5wBgPuPfszk3yiNcQJsK7MCQXPF7PR3cCmwsOAe0ryrzO67ybZgFTIlvMsbNcW
         cT0kh0pL5IcvJmj9fcwp8BFlMt3G96LAb/mzD3/7TtYAvANJ3xCHiS0cEGMAxHX7X6Gx
         ln/8UJ7iORrmvkU+XrfqOU+ZTwPfqwwpxtC/rwSUDlw6mVIF/JE8B5Uwmj+IrXRNfd70
         a+DnAARxCQDwJFDhy6i0m4LS9xI2TZfNYpwB1363kcDY6jsrWQDZNlCuyPlcqsOPZIMm
         m/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nac0OcsMqrzxHo9VlvWmwuwRU03Enoj5FoP2F5tzkIY=;
        b=aNUDWdo+hc1r+aICDAEpBwDNH++Zc8IXuiw0+qhDZtJEM/+rM0WR3YKiXS0DT6D4yj
         nDzPfUHfJaa3DPtZKnbf6WEzaqJ+fkcsEX5oieNvAgvUGlm1mF38IcdCs9G4Xx2Mk5xO
         ZYBswC6JP8N6ZGfBlPp4GE+DL31Qbn//F8IppjnhvqtQ/xaMhrNvI/4iq8fKEPLJVOta
         9auaEPFPKPXw1Ah7inx1B/fKhNuAFKrBZAlUaQsGid1eSlRKv3iXANFdaX6tHZ1vkIuy
         iqiPXqB7onEKFYpoPVsYiS9uTZCtJ+vIphMicmkvcAgwXm7bRSfFF8PubdjUg431FDcB
         A/7A==
X-Gm-Message-State: APjAAAVL89jUJWoifjgei3VC/6FK/gxtgO5/RHA7njmcUxBsV+22ul6D
        R4HyccduzW/tH8rrkJkINjAvtw55A0uhmrd2qBlK
X-Google-Smtp-Source: APXvYqwYFkgb8CkRf+dyAwav8mZ8GCzB5l9Ewvt7aCXolIq0ea4x2T0EPp7rFmXJmWnphvWh17vxyMSioie+RVoNarM=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr483118edr.164.1580944883981;
 Wed, 05 Feb 2020 15:21:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhR3oV=d7S+PELcCg+Qt7hjV_GJYGmqMdCNvsxAWCJYfHA@mail.gmail.com>
 <441c893b-5cfa-1675-c568-2c04b3bb841a@virtuozzo.com>
In-Reply-To: <441c893b-5cfa-1675-c568-2c04b3bb841a@virtuozzo.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Feb 2020 18:21:13 -0500
Message-ID: <CAHC9VhQ0qqHLWqmYbKMnfkXB6NFQyocjemEcLT9508uJPaTSPg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: sel_avc_get_stat_idx should increase position index
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 1, 2020 at 2:49 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> If seq_file .next function does not change position index,
> read after some lseek can generate unexpected output.
>
> $ dd if=/sys/fs/selinux/avc/cache_stats # usual output
> lookups hits misses allocations reclaims frees
> 817223 810034 7189 7189 6992 7037
> 1934894 1926896 7998 7998 7632 7683
> 1322812 1317176 5636 5636 5456 5507
> 1560571 1551548 9023 9023 9056 9115
> 0+1 records in
> 0+1 records out
> 189 bytes copied, 5,1564e-05 s, 3,7 MB/s
>
> $# read after lseek to midle of last line
> $ dd if=/sys/fs/selinux/avc/cache_stats bs=180 skip=1
> dd: /sys/fs/selinux/avc/cache_stats: cannot skip to specified offset
> 056 9115   <<<< end of last line
> 1560571 1551548 9023 9023 9056 9115  <<< whole last line once again
> 0+1 records in
> 0+1 records out
> 45 bytes copied, 8,7221e-05 s, 516 kB/s
>
> $# read after lseek beyond  end of of file
> $ dd if=/sys/fs/selinux/avc/cache_stats bs=1000 skip=1
> dd: /sys/fs/selinux/avc/cache_stats: cannot skip to specified offset
> 1560571 1551548 9023 9023 9056 9115  <<<< generates whole last line
> 0+1 records in
> 0+1 records out
> 36 bytes copied, 9,0934e-05 s, 396 kB/s
>
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  security/selinux/selinuxfs.c | 1 +
>  1 file changed, 1 insertion(+)

This is better, thank you.  I've queued this up for selinux/next,
you'll see it in the repo once the merge window closes.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ee94fa4..ad5530e 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1504,6 +1504,7 @@ static struct avc_cache_stats *sel_avc_get_stat_idx(loff_t *idx)
>                 *idx = cpu + 1;
>                 return &per_cpu(avc_cache_stats, cpu);
>         }
> +       (*idx)++;
>         return NULL;
>  }
>
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
