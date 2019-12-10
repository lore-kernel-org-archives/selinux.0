Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD15C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2C5207FF
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="W0YZld0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLJPyz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:54:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41787 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfLJPyz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 10:54:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so20460377ljc.8
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2019 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijslnoB1mBdpuhM6+WH6kOPsika8H8COE1NDFtpaX2k=;
        b=W0YZld0i2vqJA36wUjoZxIFZT/OZyGegByXDs5jpXBNf8o1k4egF4RqP9iu1nkIRJ9
         5WN44OgMMpveXm+ufxW+qaCFyRfMm/nIwc3RVz7WDsUFAmBRT/5vIVrBx+R+00r6FlC/
         gffwk+shCJuCbAwMCQV9xCe9sUuWGmio6PWBvp6Wd9KxHNpXG25ghpHHi/sHlQFaFu5C
         B6+VhJYrsgDoW1QUBbU4+Rk9V/P4EKHpxndNupCx0hB4aCmtX3QcY2pr4+CYIxXZd3v+
         WOTrT+mi1u/lDwDav6tjDXel1afV6bZcsgCqrV9hrNQKeyIp02OarVk00lrMNH0O5JtR
         skuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijslnoB1mBdpuhM6+WH6kOPsika8H8COE1NDFtpaX2k=;
        b=dlxbM7Ykke/hNP+Hdk70s0RgOAl23ZbpdzkX1tPdM7pIbxZ3T5gQKhgWs+X11uKfHB
         51vUgGN9TM/3nX2kwZDMOVmCTgRoDi+Q8OfCmANKcd6gbZ+omwV/4/bqKsnrwr12rVgm
         6PSSs2yNJsqqcf4EjyNPDc2/7Hk/Vzv1h54aVzyWyxk7oybXv00GnPdXZ6gEbb3Z2GrX
         Dwm9nhkNorqTLltzyjtCuAKgjHWf2oFgj32CbWFN2uB7B4SLFxMuCNJOmto+BuVisoUf
         Riz0Sz779NntZ29AxGCBAi1xH/Dq1pwJeXkxumQE32SlxVbnc9YXzix4K7FPF0C2KMUm
         JN8w==
X-Gm-Message-State: APjAAAWp3CWpl6xhYFrtU+4p+dvDYZc0MNVcShDIsV56T2pDvV5fvuu5
        jJPdtc6INudmsSoFXNNozI0BQnmGCu7oqDr3I83f
X-Google-Smtp-Source: APXvYqxPwAXLSrlxztA3s0jc8baV/mrc1s/nbHO7xhJCGPkj/UBlbdcVfEBJneSiONKpO3fDq+1LXbnvODk44auk7As=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr3614762ljj.225.1575993293353;
 Tue, 10 Dec 2019 07:54:53 -0800 (PST)
MIME-Version: 1.0
References: <157594281322.676903.11041338053333686450.stgit@chester> <f7e43b67-3f46-e480-f8b0-e86eff85293f@tycho.nsa.gov>
In-Reply-To: <f7e43b67-3f46-e480-f8b0-e86eff85293f@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Dec 2019 10:54:42 -0500
Message-ID: <CAHC9VhSO0Jaqyxw_5AtPTTQTqS+Q9CWhBQQ7822hvUS8MWLy6A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: ensure we cleanup the internal AVC counters
 on error in avc_insert()
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, rsiddoji@codeaurora.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 10, 2019 at 8:44 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/9/19 8:53 PM, Paul Moore wrote:
> > In AVC insert we don't call avc_node_kill() when avc_xperms_populate()
> > fails, resulting in the avc->avc_cache.active_nodes counter having a
> > false value.
>
> incorrect value?
>
>    This patch corrects this problem and does some cleanup
> > in avc_insert() while we are there.
>
> submitting-patches.rst recommends describing in imperative mood and
> avoiding the words "patch" in what will eventually just be a commit log,
> ala "Correct this problem and perform some cleanup..."

Well, you've made me feel better about my nit-picky comments on patches ;)

Are you okay with the following?

  selinux: ensure we cleanup the internal AVC counters on error in avc_insert()

  Fix avc_insert() to call avc_node_kill() if we've already allocated
  an AVC node and the code fails to insert the node in the cache.

> Should probably add a:
>
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
>
> Might be easier to back port if you split the cleanup from the fix, but
> your call of course.

I waffled on that last night when I wrote up the patch, and more
generally if this should go to -stable or -next (despite what is
claimed, adding a "Fixes:" tag means it gets picked up by -stable more
often than not in my experience).  At its worst, not fixing this bug
means we could end up effectively shrinking the AVC cache if xperms
are used *and* we happen to fail a memory allocation while adding a
new entry to the AVC; we don't cause an incorrect node to be cached,
we don't crash the system, we don't leak memory.  My thinking is that
this isn't a major concern, and not worth the risk to -stable, but if
anyone has any data that shows otherwise, please let me know.

I'll go ahead and add the "Fixes:" tag (technically this is the
*right* thing to do), but I'm going to stick with -next and leave the
cleanup as-is just to raise the bar a bit for the -stable backports
which I'm sure are going to happen.

-- 
paul moore
www.paul-moore.com
