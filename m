Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D6BC352A3
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 22:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B281E21734
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 22:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rq/qV7TB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgBMWMz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:12:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47017 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMWMz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 17:12:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id p14so590801edy.13
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2020 14:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VC4Um7aJ+HFZxCMxmSPgdNaJNMoERzzQMAOauctOcu0=;
        b=rq/qV7TBoIH84nI+DE5us2lbz2eoXBAOFDnk3Gfba/2dPyl4EqMa5gUjvJOY3rOQbC
         Oxi78O6pdWrXkzYP0w47++UlG1zK4nc8vnwFe5m/s4OKScrjEk/5CuaDQyaYCahSXB+/
         /m2pZjlpaO7Tx5V4fjOS7QV7oVaYltYFpFDdCFsR0rY00UjtSIE8Qh0nNXFCkyN0WX2m
         eAON5tq+9J22EaggrReh9VMwR+/wG33E+AKpT8heDfTjgEHY5CcrhCwvabknubrN9QQj
         NvlnSe3OMf+QhHUAzeywaaJpYSifwVOolEisjHclOaPUE4I3usrWFY+gqR7A9PDw1LCY
         H3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VC4Um7aJ+HFZxCMxmSPgdNaJNMoERzzQMAOauctOcu0=;
        b=bvUDLfVNaPvXJ22NyFpjNn3PxEcXfu6uYcxg8yMulRLEk8uvAATrbAkrb2LWIjRoJE
         1OOlvfLcAtWVFRTBF3P8fapcn9mvms1XnYc0CYmLal8Wgvu5KnRekvOt+CjQ/0AYmJIL
         6p7lalwuKMpoUGJ8L/TIVmGW9T6ODodOQ0WFjfEpBOKfIIUxaFKiIeKfVa4EmPGplT9s
         vgEKv5MLmQhmz6oHk2zku8MzWmMoDyo/ozgPrEznOJk2YfLhi3oPWIrvOi2Jwb4nzd/n
         RtzzyXihdkn7JrLUecPTgeLn7GO7QW1HRtoqtrGeQEuOa6yMUQelgyESdAKo4DK1nrpG
         howQ==
X-Gm-Message-State: APjAAAWfVl5kJoFmM91KEoRV17rNI+uvF12zA2Ds1S8WYTR7fSqZc79P
        CrRIDU76sNoNu8Rtll5JLGuihpTc9mfeAwgxwPRO9Q9imw==
X-Google-Smtp-Source: APXvYqwhJ6uCwtaQTnUMxgPPDNeSF8P9RKqqPVE0Ef6roa5sDXmR9BnCTUSW4Oly/1BgeJFaXpmCyxDQcXllUMYyXAE=
X-Received: by 2002:a17:906:c299:: with SMTP id r25mr18345583ejz.272.1581631973279;
 Thu, 13 Feb 2020 14:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20200130202239.11498-1-sds@tycho.nsa.gov> <20200130202239.11498-2-sds@tycho.nsa.gov>
 <306f9a78-695c-dfd3-3524-3814997fac51@tycho.nsa.gov> <099d42f9-f26a-be99-8bac-f151812a4726@tycho.nsa.gov>
In-Reply-To: <099d42f9-f26a-be99-8bac-f151812a4726@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Feb 2020 17:12:42 -0500
Message-ID: <CAHC9VhQMPEcgQVid2L4a4iO=2DUW+vwM1_vVxf0+KAum5+bYnA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] testsuite: add further nfs tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 6, 2020 at 11:36 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/5/20 12:10 PM, Stephen Smalley wrote:
> > On 1/30/20 3:22 PM, Stephen Smalley wrote:
> >> In addition to testing full NFS security labeling support,
> >> make sure that context mounts continue to work independent
> >> of whether the mount was exported with security_label, and
> >> add a simple test of the default NFS file labeling.
> >>
> >> With the previous changes, this completes addressing
> >> https://github.com/SELinuxProject/selinux-testsuite/issues/32
> >>
> >> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/32
> >> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> ---
> >> v3 moves nfs.sh under tools/, updates README.md, and fixes nfs.sh for
> >> the relocation.  As before, these patches depend on the previous one
> >> ("testsuite: enable running over labeled NFS") in order to allow the
> >> testsuite to pass on NFS mounts.
> >>
> >>   README.md    |  5 ++++-
> >>   tools/nfs.sh | 38 ++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 42 insertions(+), 1 deletion(-)
> >
> > Both are now applied.
> >
> > [...]
>
> It would be good if we could get tools/nfs.sh running on kernels going
> forward in addition to regular runs of selinux-testsuite.

I've never tried this ... is it possible to mount a NFS mount over
loopback?  What about labeled NFS?

-- 
paul moore
www.paul-moore.com
