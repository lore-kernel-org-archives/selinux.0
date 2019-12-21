Return-Path: <SRS0=Y3F+=2L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72085C2D0D3
	for <selinux@archiver.kernel.org>; Sat, 21 Dec 2019 16:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4275D21927
	for <selinux@archiver.kernel.org>; Sat, 21 Dec 2019 16:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mzjQaps5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLUQCu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 21 Dec 2019 11:02:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40804 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUQCu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 21 Dec 2019 11:02:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so9338707lfo.7
        for <selinux@vger.kernel.org>; Sat, 21 Dec 2019 08:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHdcMDpf8IolRPfeOn2sGCNg2EQjHxCfsmV0ayw9qok=;
        b=mzjQaps5cDiq5MiKd2IrArQZeG/Y5b2CjMMAAKLEH7LubGPtWD0u4L65VsNrdUFvwp
         YMAwignOR8pwDs25BfGffFSKQhqgZMhD/oxsA8VVtHsL6wvciDd5TumAMbM1CTGpg+9d
         GNZaSOIsUeGpyfb5RFIj143BLTnrkJnlzbyA7MO1KZBHvpAdinkmsC7mDThjPX7ehp9O
         qScqrTVH+uWhfJIvSpoaSwMPvpDm7zifRkmFBwzXQJ5IscTe6s5RPrMocJWiyL5nr2Yj
         LnwfcHNvrtKJ/WMCD9+VSLiluMci/QPqbQpww5tA/MIHzyYxxR0o0WF/VjJ9+NbmAD6T
         vq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHdcMDpf8IolRPfeOn2sGCNg2EQjHxCfsmV0ayw9qok=;
        b=k6LH2glf9otQr9SQXwv03xqYkFo1RuuvXyHHDS/IfTBChtv+OpAasPkn80KhZQFXCS
         0iNXitPPFmc4qQh/KpaN5cYDW4L7+8x1IxrbN/gOPsiVYrBp56EfV5a6igH6Ye2lanwf
         G0ENH2bhOiQOTJYSHVixsxkX4/uV+ZGFp39WFJkujHh5DnKVhqMTi1UcUXZ1Nu+XjeeC
         MUkiY4CS80iw519rzpxEzRJAyuc7CEKxqskraaGYaIOAglpcMC1hfKtObl9DSIhZzf+U
         8KvFdF34t+VGhi2cmd26xLHloTfURA4s86+7OkpFypOT0z8oF4n+X75BNQUP971lt196
         tRsQ==
X-Gm-Message-State: APjAAAUEtTCclCYtyyRWy4qt/zkpGqhI9SPPkRp/oMSrHjtaAp03JTiO
        F+VhTttwEiAdf0+gvpOiCpyFANx2mfTlmIb/7B6q
X-Google-Smtp-Source: APXvYqyLHkXQKL1J3OTxU/bdu+Dcp2xdETA1TIZPPVamsSrtI6ATBOw181IvkYtNU2YBVCydfZgA8n8t22WATazkpxU=
X-Received: by 2002:a19:4a12:: with SMTP id x18mr12207385lfa.158.1576944168281;
 Sat, 21 Dec 2019 08:02:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhSv9BsjqNtwdpAv1yj630L-k8UBcWA5bwC9ySevrPw34w@mail.gmail.com>
 <1576843382-24184-1-git-send-email-rsiddoji@codeaurora.org>
In-Reply-To: <1576843382-24184-1-git-send-email-rsiddoji@codeaurora.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 21 Dec 2019 11:02:37 -0500
Message-ID: <CAHC9VhTRnuWd=-ED=rr_OqVGV5b-VGQ4rHXMAfuOdJFDRCwG4Q@mail.gmail.com>
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jaihind Yadav <jaihindyadav@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 20, 2019 at 7:03 AM Ravi Kumar Siddojigari
<rsiddoji@codeaurora.org> wrote:
> Thanks for correcting , Adding the signoff of orginal author in the
> following commit .
>
> From 6308b405e2097ab9d82c5a3894815daf7331e0b6 Mon Sep 17 00:00:00 2001
> From: Jaihind Yadav <jaihindyadav@codeaurora.org>
> Date: Tue, 17 Dec 2019 17:25:47 +0530
> Subject: [PATCH] selinux: ensure we cleanup the internal AVC counters on error
>  in avc_update()
> To: rsiddoji@codeaurora.org
>
> In AVC update we don't call avc_node_kill() when avc_xperms_populate()
> fails, resulting in the avc->avc_cache.active_nodes counter having a
> false value.In last patch this changes was missed , so correcting it.
>
>
> Signed-off-by: Jaihind Yadav <jaihindyadav@codeaurora.org>
> Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
