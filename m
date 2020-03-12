Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0924C10DCE
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 12:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710D8206B1
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 12:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Fh/HWWOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgCLMgU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:36:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41715 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCLMgU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 08:36:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id m25so7188074edq.8
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19IX5jXpAHiyt8OjDfdK/XhP2vczbKr3OKKvpQwMdx8=;
        b=Fh/HWWOJlGz/yfShzHkKwoskblvxcALNCxnhGFpDLngmnqCcchegriqZUVYomjZi3o
         WP0BbNsA0iLJCl5tb6PTllDjRTol9IPBC6w7YZFy4ZvlLaITIAsEBbbjw5s2pPn71TUn
         6C+D+JH24Sfc3r32gmiUY+NY4fVYaekv4tw1FEOZlu/zcWvvelLDyNbpouyDX5LvgYhU
         fZ6ph6TWNx1zAIVKiHUsR2W6RM5X94cYGMpLHN9JaXRLTrnaIEHMw0uD2aCrEephroZh
         /X764XhjQz74oqy69W3hLc461EkjykwzsE1QMCt9qfRlgGxoOvWAGFs70XfV+9KR6Kix
         Kacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19IX5jXpAHiyt8OjDfdK/XhP2vczbKr3OKKvpQwMdx8=;
        b=aazoTP1fGgLI9veNhCV3SiqQbh8NXDJEysY4Mb5Yg50hisNI/kMzUGHEMO7XA5ImWN
         RA/ubRIJFKVxRe/MMuCU/XAQmSe7IwesXVyS47UxBMT17zv/0jftaORKCd/NGkSafhv8
         dTavTugHzXbvoN2/5XQ7b7t9DDm1Fc1d/PikrPCkUaJkLCBgJhMBw1VvBTkUFUy0X4C2
         MoOWlV4KU0XWM0Ef7jxsMGqXC1GgtKC+S/QA0X0VTOYMFSquYIXsRNuH17Lj3dlNTz/J
         gyoH0CfXhacUXt9FuFzbHI25kfspFtZGMKVYBnA3tz0NpHPedXuUzPZAgM3aIjE+/R3d
         Q7pw==
X-Gm-Message-State: ANhLgQ1SAT8Tiwx+L+jJEnWpSkTgDJy8nZ5efWuGNHVYWASPcPDZBsde
        F70ERfkG3PijXXjd/EYMUtbjqr9JeX+UXgyvxeApNFw=
X-Google-Smtp-Source: ADFU+vtGrEZqpdnx7iBeH2Rq5qEkVkUndUaBOfUNy2gGEF0xCBbLkXExBZkQ1adz3QDcsr+6vGEfPocxa2ubxObO3zk=
X-Received: by 2002:a50:e108:: with SMTP id h8mr7135316edl.196.1584016576169;
 Thu, 12 Mar 2020 05:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200312084001.101645-1-omosnace@redhat.com>
In-Reply-To: <20200312084001.101645-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Mar 2020 08:36:05 -0400
Message-ID: <CAHC9VhSD-mLS8C1f+n+8F81ed4nSonWmj=gdDT=YGsG9gm0Cqg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/bpf: ask for unlimited RLIMIT_MEMLOCK
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 12, 2020 at 4:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Currently the code sets it to at most 128K, but this is not enough in
> some aarch64/ppc64le environments. Therefore, stop guessing the magic
> threshold and just set it straight to RLIM_INFINITY.
>
> Fixes: 8f0f980a4ad5 ("selinux-testsuite: Add BPF tests")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/bpf/bpf_common.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

I have to make a similar fix to the audit-testsuite earlier this week,
I didn't think to check the selinux-testsuite because the bpf tests
were running just fine on my aarch64 test system.  Sorry about that, I
should have checked regardless.

One small style nit below, but otherwise ...

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
> index 681e2eb..f499034 100644
> --- a/tests/bpf/bpf_common.c
> +++ b/tests/bpf/bpf_common.c
> @@ -41,24 +41,16 @@ int create_bpf_prog(void)
>
>  /*
>   * The default RLIMIT_MEMLOCK is normally 64K, however BPF map/prog requires
> - * more than this so double it unless RLIM_INFINITY is set.
> + * more than this (the actual threshold varying across arches) so set it to
> + * RLIM_INFINITY.
>   */
>  void bpf_setrlimit(void)
>  {
>         int result;
>         struct rlimit r;
>
> -       result = getrlimit(RLIMIT_MEMLOCK, &r);
> -       if (result < 0) {
> -               fprintf(stderr, "Failed to get resource limit: %s\n",
> -                       strerror(errno));
> -               exit(-1);
> -       }
> -
> -       if (r.rlim_cur != RLIM_INFINITY && r.rlim_cur <= (64 * 1024)) {
> -               r.rlim_cur *= 2;
> -               r.rlim_max *= 2;
> -       }
> +       r.rlim_cur = RLIM_INFINITY;
> +       r.rlim_max = RLIM_INFINITY;

If you really want to simplify things you could assign those values
when you declare "r":

struct rlimit r = {
  .rlim_cur = RLIM_INFINITY,
  .rlim_max = RLIM_INFINITY };

>         result = setrlimit(RLIMIT_MEMLOCK, &r);
>         if (result < 0) {
> --
> 2.24.1

-- 
paul moore
www.paul-moore.com
