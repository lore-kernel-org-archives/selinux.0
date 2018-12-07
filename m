Return-Path: <SRS0=Nhvc=OQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E75C07E85
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 14:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFCD20892
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 14:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zIx8KDSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFCD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLGOUr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:20:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40575 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGOUr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Dec 2018 09:20:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so3143383lfe.7
        for <selinux@vger.kernel.org>; Fri, 07 Dec 2018 06:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6eARRly0/G4R5VobOUF+NT73P0kNx7R7dV/TLseKrM=;
        b=zIx8KDSB1bZk1rEjp5sezhh4JIVnrVjBevLlAqK1vaBpr73NLTMWtkq3XvyDM0v1eU
         9Ix8BHfiR8SxS8YgT2Go45hQa86pOAWbFGE9fet71rwHhf9Bp8N3t9RB47Pv5IKRCDIa
         X9kUJUFSULBXSL1e3ZiPmRcMZ9M/kxpX3qvATD2WDkvfZf894NzqK2rk8yFFpuDFWCx2
         lt/a2pBJSwaCK2RGtIC/H20WRDJT/lcsnvcKsToSG29Mjr631URfAXtoosf3rtjUPLK+
         gzXwGgqduENkfY3jjOVWNeONjuGqab1nM3apQa9O6dJV2G9LyWEE1n5KaJs9Lx1ysJ+M
         xBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6eARRly0/G4R5VobOUF+NT73P0kNx7R7dV/TLseKrM=;
        b=S23JzrrQSsR9xWN9WKQJ8GzI1OxXkRQGUdg3giF88QulfQgxvVIqyfi63tF7xZPymZ
         o+TWhNkwI4Mp4Uflf1PiYoxLFip0TLjkT2Lc7X7F9FX3kWThCiVS4AC+jbvRx77MQbIc
         BpSipLnF6M40L8mnf9WkSWGiXAmDjwNz0Aq4PY6LiYeD9qe8Vavzad7mjI7WUHZbJyMu
         BZIbuasLqbXJV4zWS83PNQDQOqpW0+sbur2ULOjaSyK+R4uaqjR2vZZ6dPSIMKdfUyHZ
         Dteqjs0beP+QdyJh9Je6DeITtcPhF/qs7AaCKt34drhNpUlrwwqR56bQy1tUbuhERxSd
         OYmA==
X-Gm-Message-State: AA+aEWZCXKjhOawmlCmAixFp/Aq0fjknacGQynu6ww4cKddbUgNIS7+P
        QaoyQXGs88RW2cXorbGIHLWO8pndrYXZuDSSS0yTknU=
X-Google-Smtp-Source: AFSGD/VVXCd3yP3niEOlOfVh2axQ/rBH4np2U1jJ0YcPJQAQDUVx2jIc5hCHFMCLg6jdofa/I/CS4d6ZW1NytX2q3t4=
X-Received: by 2002:a19:40cc:: with SMTP id n195mr1446558lfa.40.1544192444826;
 Fri, 07 Dec 2018 06:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20181204204209.21542-1-sds@tycho.nsa.gov> <CAHC9VhTB8ZpHt3fUL4_SY2qaYZUg4au7eLLOBgnpmT-72hmCaw@mail.gmail.com>
 <d6084640-eb4a-76d4-102b-6c71c927f236@tycho.nsa.gov>
In-Reply-To: <d6084640-eb4a-76d4-102b-6c71c927f236@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Dec 2018 09:20:33 -0500
Message-ID: <CAHC9VhT1ACM7pYR=JuBT0ofCME1LPHh5dFJZEKo2XQ8SJOH4-w@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: avoid silent denials in permissive mode
 under RCU walk
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, bmktuwien@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 7, 2018 at 8:04 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/6/18 6:57 PM, Paul Moore wrote:
> > On Tue, Dec 4, 2018 at 3:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> commit 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
> >> results in no audit messages at all if in permissive mode because the
> >> cache is updated during the rcu walk and thus no denial occurs on
> >> the subsequent ref walk.  Fix this by not updating the cache when
> >> performing a non-blocking permission check.  This only affects search
> >> and symlink read checks during rcu walk.
> >>
> >> Fixes: 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
> >> Reported-by: BMK <bmktuwien@gmail.com>
> >> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> ---
> >>   security/selinux/avc.c         | 9 ++++++---
> >>   security/selinux/hooks.c       | 4 +++-
> >>   security/selinux/include/avc.h | 1 +
> >>   3 files changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> >> index 635e5c1e3e48..f0e7bc0dc442 100644
> >> --- a/security/selinux/avc.c
> >> +++ b/security/selinux/avc.c
> >> @@ -1021,8 +1021,10 @@ static noinline int avc_denied(struct selinux_state *state,
> >>              !(avd->flags & AVD_FLAGS_PERMISSIVE))
> >>                  return -EACCES;
> >>
> >> -       avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested, driver,
> >> -                       xperm, ssid, tsid, tclass, avd->seqno, NULL, flags);
> >> +       if (!(flags & AVC_NONBLOCKING))
> >> +               avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested,
> >> +                               driver, xperm, ssid, tsid, tclass, avd->seqno,
> >> +                               NULL, flags);
> >
> > I realize the issue here is specific to the VFS code paths, but if we
> > are going to introduce a general AVC flag to tell the AVC code not to
> > block, it seems like we should honor it everywhere.  I would suggest
> > moving the check into avc_update_node() itself (it's static, so
> > hopefully any perf impact will be negligible).
>
> Ok, I'll do that.  Just to clarify though, avc_update_node() does not
> block, nor does any of avc_has_perm_noaudit().  The reason we have to
> skip avc_update_node() in the non-blocking aka rcu-walk code path is not
> because it would block but because it would grant the denied permissions
> in the AVC entry and then avc_audit() would subsequently bail with
> -ECHILD since it would block on calling the audit system, and when we
> retry on the ref-walk code path, the cache entry will already contain
> the permissions and nothing will be denied or audited.  So it is a tad
> confusing.  I'll add a comment as well.

Yeah, it took me a little while to realize that, a comment in the code
would definitely be welcome.  I'm also open to a better spot to put
the AVC_NONBLOCKING check; I suggested moving it inside
avc_update_node() simply to catch any other (future) callers which may
need to use it, but I recognize that isn't a great fit either.  As you
point out, ultimately the problem is that we don't want to skip the
audit record, and since the audit queue might block, we have to play
it safe and not update the AVC.

-- 
paul moore
www.paul-moore.com
