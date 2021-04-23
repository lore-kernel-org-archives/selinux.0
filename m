Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D81C433B4
	for <selinux@archiver.kernel.org>; Fri, 23 Apr 2021 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BD761425
	for <selinux@archiver.kernel.org>; Fri, 23 Apr 2021 02:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhDWCT5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Apr 2021 22:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhDWCT4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Apr 2021 22:19:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B1C061574
        for <selinux@vger.kernel.org>; Thu, 22 Apr 2021 19:19:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h10so55742761edt.13
        for <selinux@vger.kernel.org>; Thu, 22 Apr 2021 19:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2ldEas4lt/K+tIJi8w8rWDYcpD4C8p0iZvKGDFSJpug=;
        b=Cn5BEiEXMySaUROISfJ3Fur0CB9RDBjS0NYPv7ITaQ+uNX5Ox8pMtvVN8QbSeWowkR
         2GVewgaxDPGVnLMjtD0kN8UJQNfd67n4rmpFtWcTPBT6+eEdNObjqfu7Axnho7mSgaAI
         YtYfOZs23ARzLLiAZk+G5lUTkYq5PBB9+2gNOQb5p6H14r7BF0fQTBpp4tp2IBA7rJyS
         +PZH34ILn7FsmSBRvpoFnKoDjDNenJkzdRSvk1SJ1E6PDDuQ49jXNoYB2NIl4XDKtw1+
         DSi4XWw9PucypoyZalIpVUQZ+87f8Um0qijujVlpQuFLOgLKjvPy/H4eV56uDRvcJDkE
         kgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2ldEas4lt/K+tIJi8w8rWDYcpD4C8p0iZvKGDFSJpug=;
        b=mo/6Wgx7NJ0wotE3m28Flf8Ff/ahiplwSmUVOCAK5ss1DimpVNMVibsTg3xylg0Jqn
         S04+FNboqK6Z30fNjInrNHDaGwhshcoJ3ouOVe9ZcvAkcSv1GsM4uS74x6M5MrYNMa6V
         5lv3XLZyLWUvNehIpimELvvJ2hK8WT4R2J8GttniGlVhMNTL8v7jVk8luDE26+f865De
         HyF4k1uDCBWF9819j+jnomnlwVPvZieO8OTRxv0L4sIZmaSVKekUON9TT+j8OtMayOV3
         5Ks6D0yytR1j0RPgo4qAutYIU1uQ4WLJDLOxXP2AQ2IwBQdBMmFzJXPyltaYSULqOxM3
         V0EQ==
X-Gm-Message-State: AOAM532y2YdckwBlH6aBXh6zEIVDcJ9GtfgBN84O3ZPil4qN87iOnhCU
        r2XX1g/BFwLJJ7NuEnyeTp2gfR28b146QHfaFjqeu50R7Q==
X-Google-Smtp-Source: ABdhPJxe66Y3TqosPDel3LceVsDnloXVBVq/um1c5lsozh5oHPHt1X2B1aRUIlTfDsJ/jn5H9Ugm357OMTaTFhIn5FM=
X-Received: by 2002:a50:9faf:: with SMTP id c44mr1684149edf.196.1619144359248;
 Thu, 22 Apr 2021 19:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <161906228493.81125.6079062739552342511.stgit@olly>
In-Reply-To: <161906228493.81125.6079062739552342511.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Apr 2021 22:19:08 -0400
Message-ID: <CAHC9VhTdSU_M1m4TJiE2edVXb-oDRA=ZhQv1AsPmAk6u5HknPg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add proper NULL termination to the secclass_map permissions
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 21, 2021 at 11:31 PM Paul Moore <paul@paul-moore.com> wrote:
>
> This patch adds the missing NULL termination to the "bpf" and
> "perf_event" object class permission lists.
>
> This missing NULL termination should really only affect the tools
> under scripts/selinux, with the most important being genheaders.c,
> although in practice this has not been an issue on any of my dev/test
> systems.  If the problem were to manifest itself it would likely
> result in bogus permissions added to the end of the object class;
> thankfully with no access control checks using these bogus
> permissions and no policies defining these permissions the impact
> would likely be limited to some noise about undefined permissions
> during policy load.
>
> Cc: stable@vger.kernel.org
> Fixes: ec27c3568a34 ("selinux: bpf: Add selinux check for eBPF syscall operations")
> Fixes: da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/include/classmap.h |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I just merged this into selinux/next, and given that we are at -rc8 I
felt a bit of an explanation was a good idea.

Typically fixes like this would be merged via the current
selinux/stable-X.YY branch and sent to Linus via a PR after a few days
of soaking and test runs.  However, with the v5.12 release likely this
weekend, only a few days away, it seems overly risky to send this to
Linus now when one considers the nature of the patch and the fact that
we can send it to Linus as part of the v5.13 merge window next week.

-- 
paul moore
www.paul-moore.com
