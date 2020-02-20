Return-Path: <SRS0=5MQ6=4I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B12EC5ACC4
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 01:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069B02465D
	for <selinux@archiver.kernel.org>; Thu, 20 Feb 2020 01:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jtbv9xv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgBTBdR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:33:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35631 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgBTBdR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 20:33:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id y25so9512226edi.2
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 17:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j77dQs+yd9qzXCy9U1fBmgMotbAqwan0g5ePOW5pm5Y=;
        b=jtbv9xv1FCmvWdo9L9dEIqTs02yUZ85zga9tma4kUahVoK2Sle8vNcVh2gF926q56F
         2j36GvKcrvP9tf5zEJ79kFCRvuULsXazQsBstS+vQg4u/cl6spz4yc81baLCb29i9oUh
         h+wWgjZwaJqFI7v0HSY5DD5wZPjQVCx38AK86e1Dq7cdaGaSTA8NG5y4HklAU8eDicQj
         knhfPFKC7S6HyN6U2VD2gEUpjbZeAA5pVoJXAOxDBBmp7DsTzjKJhliFfDKFJYCl1Bo7
         XI0hdPCzq6gbXYcxxitL+2S8WYUkK8K46MkziH3d5USMpprchdqLUrGBCWsg6D0r1bKa
         IR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j77dQs+yd9qzXCy9U1fBmgMotbAqwan0g5ePOW5pm5Y=;
        b=bVP4bM6Z6yd/mnVe75FW+yfMt3r3s/aVi74Nzoz2pm8/EuTDF4hq0g9KtrBFpr497L
         AIxxPETXWzQsM+vI1YBed4nC98DCvCgoP1aR0WqLCkRSrHxP4ESUUXShRIAUyhWIn7bf
         kg3Rh4hJ8m3ZuOSJNJruK9TRsz2D1BfYfl4chsAIGEK52/wMHmGFfEL+qgpEw8ylQTOf
         g5LvmKMM0Rng8EEzP2A3du0KxlUKyxyz91mi56XX0ApuOBJadAXcfS0c3r37Ftsv4xVj
         oKr3s7Uxp3HT4iD0KUXqEg54DaUl3KdfkDwHyc3RmtXJWPQ8Y1YFq2/09+3qco+jAPnM
         N26A==
X-Gm-Message-State: APjAAAVKS52CKKyMpCVEeKIdHFn3atnjKLaYqilw5y5KNk8sHROC/oxy
        hlIanVJSqwH6spFWYjwlhRq+paTXmhnt8GsFkIfJ
X-Google-Smtp-Source: APXvYqwjtvbj5/Mq4VDhbOPrlYYz8o/837jR/DMlxzksYaFdyZLZiNTG1di2p4kdPbGDO+AFbH/hhmbVEOmPBiKhd44=
X-Received: by 2002:a50:fd15:: with SMTP id i21mr25945580eds.12.1582162395398;
 Wed, 19 Feb 2020 17:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20200130202239.11498-1-sds@tycho.nsa.gov> <20200130202239.11498-2-sds@tycho.nsa.gov>
 <306f9a78-695c-dfd3-3524-3814997fac51@tycho.nsa.gov> <099d42f9-f26a-be99-8bac-f151812a4726@tycho.nsa.gov>
 <CAHC9VhQMPEcgQVid2L4a4iO=2DUW+vwM1_vVxf0+KAum5+bYnA@mail.gmail.com> <e5de947b-4b80-6f1e-8dc5-c434c1fa6201@tycho.nsa.gov>
In-Reply-To: <e5de947b-4b80-6f1e-8dc5-c434c1fa6201@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Feb 2020 20:33:04 -0500
Message-ID: <CAHC9VhRaYdctY7YmZGg5q_4-12sWMNeVd-HYXTOoQ_kfembzeg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] testsuite: add further nfs tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 8:16 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/13/20 5:12 PM, Paul Moore wrote:
> > On Thu, Feb 6, 2020 at 11:36 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> It would be good if we could get tools/nfs.sh running on kernels going
> >> forward in addition to regular runs of selinux-testsuite.
> >
> > I've never tried this ... is it possible to mount a NFS mount over
> > loopback?  What about labeled NFS?
>
> Yes to both.  That's how tools/nfs.sh works.  I added instructions to
> the README.md as part of the patch for dependencies and running it, but
> it isn't run by default.

[Apologies to Stephen who is getting two copies of this, I forgot to
hit reply-all on my original response]

Thanks.  I'll look into adding that to my automated testing.

I also need to set something up to check to see what other subsystems
drop in security/selinux both in the linux-next tree as well as in
Linus' tree during the -rcX phase.  The keys patch is the latest
snafu, but there have been others.

-- 
paul moore
www.paul-moore.com
