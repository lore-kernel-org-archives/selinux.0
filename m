Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E69C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 20:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0A2206ED
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 20:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="CvL9cy6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgAJUiO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:38:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41096 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgAJUiO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 15:38:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so2454128lfp.8
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 12:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohxv7/AQm9sxn9/G4cC4SFGNmcMj4WUAVoS5w0ph5Iw=;
        b=CvL9cy6vALYprOWCiG9nHFRtp7dXeoSd3Y6txf52mBlIJAt7REa5RgfhrhohYs3bED
         Db3oLbjNs2lj1RJlv2v6qrRy0xwT4vSM/juZP1qpb8wn6f5xMtsN0z7ZC1T5M9d3LlVT
         chEoDcM9Z9CwlptXHbSuJTHX+i6yXNHuuV0vVnFrPybWojEvPqrK2Ac7zsO+ZxHXDUs2
         fKyVx05O2FdfqtiP33TZnaowM0fO6FgiPEtDB1JpUBCqRPIlQQ6TfQnhnoKnAyb9aHEP
         NXForlC3TP4clCAKLwx+4JZDCIWWUO8zhVRJ76fEkP/JaBHTa5TsQJqc3we9trbz00So
         /UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohxv7/AQm9sxn9/G4cC4SFGNmcMj4WUAVoS5w0ph5Iw=;
        b=Zkc3vH/zrWczuIg6ZGhnxEtQgtSc5HnCgQHuQ9Nttu5+wp5sgfLr+JHBb1fwIOUwC8
         dRmumxQ/XV10DQCwfjn3++RBQ5iKpjzHoAKGdyuZ97ECVk1LGPYSnIG817DUNyPws4jA
         hwqM/TQkoDVgeeL8bhWkZ/mqTspiwIrx8B+l7rhDa6dOhSnVnXyIYFLqkLkHKZON3WEP
         BULF1qBTjZ1fN/SwQWDgjGk1LQ+3KRfignNn0sBsvQHt1grGQ9/CyN1rTg6Mrt7q2YFL
         yOUyMiRIdAlebyVVUgTZDea5L66ukCk0TFVwxsJf8KwKUjtLROFKV+nIxezJPNExrEUH
         rZkQ==
X-Gm-Message-State: APjAAAXW9j9XaHxymUecinnNo1PMen7TyxQOFGtBs4ktS0dASLGj1BP0
        VuimMUStX4bNKg1TrPwz+i92Mf3k+N5xeRQ3mOkk
X-Google-Smtp-Source: APXvYqzYe1MUuEgZ3Y3mpM8MGvDzguhYjoPapSXFHijT9owt1bcz/JPMe10Ak2Og9tsgMphb+gxbEzczd+afoTu0qw0=
X-Received: by 2002:ac2:5983:: with SMTP id w3mr3506797lfn.137.1578688692589;
 Fri, 10 Jan 2020 12:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20200108140958.870283-1-omosnace@redhat.com>
In-Reply-To: <20200108140958.870283-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 15:38:01 -0500
Message-ID: <CAHC9VhS7fWscz-dOwwBDdzoeUr4-7Yt410RSEZPctoNBTnAsJw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: reorder hooks to make runtime disable less broken
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 8, 2020 at 9:10 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
> infrastructure to use per-hook lists, which meant that removing the
> hooks for a given module was no longer atomic. Even though the commit
> clearly documents that modules implementing runtime revmoval of hooks
> (only SELinux attempts this madness) need to take special precautions to
> avoid race conditions, SELinux has never addressed this.
>
> By inserting an artificial delay between the loop iterations of
> security_delete_hooks() (I used 100 ms), booting to a state where
> SELinux is enabled, but policy is not yet loaded, and running these
> commands:
>
>     while true; do ping -c 1 <some IP>; done &
>     echo -n 1 >/sys/fs/selinux/disable
>     kill %1
>     wait
>
> ...I was able to trigger NULL pointer dereferences in various places. I
> also have a report of someone getting panics on a stock RHEL-8 kernel
> after setting SELINUX=disabled in /etc/selinux/config and rebooting
> (without adding "selinux=0" to kernel command-line).
>
> Reordering the SELinux hooks such that those that allocate structures
> are removed last seems to prevent these panics. It is very much possible
> that this doesn't make the runtime disable completely race-free, but at
> least it makes the operation much less fragile.
>
> Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Changes in v2:
>  - rebased on latest selinux/next
>  - added comment above selinux_nf_ip_exit() call to ensure it remains
>    ordered correctly
>
>  security/selinux/hooks.c | 101 +++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 31 deletions(-)

Thanks Ondrej, I've merged this into selinux/next and added the stable
kernel CC.  Normally when we mark something for stable I send it up to
Linus during the -rcX development phase, but I think this case is
somewhat unique in that it isn't widespread (and there is no
indication it will become widespread) and it requires privilege to
trigger.  Also, while not a major factor, we are at -rc5 which means
we are very near the end of the -rcX cycle and I'd rather not
accidentally break something else this late in an attempt to fix such
a limited problem.

Comments and objections are welcome ;)

-- 
paul moore
www.paul-moore.com
