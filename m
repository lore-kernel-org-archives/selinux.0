Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F6C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D226E2077B
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oJVda0Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLJTTb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:19:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37872 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfLJTTb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 14:19:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id u17so21189095lja.4
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2019 11:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFFaHeLywLCEIsIYE3gh04d4L/LDub1CmkA503m7820=;
        b=oJVda0Q/NoNyjxFVM9bPSGiRbiru85lnYXQDbbNKNI3A7Ue4sB4D6ziXDu8bu+CPIP
         PeUQ5Kw29mhsSnoUuX/PrC/D1rW1WOChX3yooN1liuE3+AsO14Bb3LgEeFwYlZ84zeiV
         +0l4H9DcIUa2gc4uQPRYCm9JoriRxGZ3v2ZBZel55W5RP0ymDH19AL7H5TMHqye2Arph
         5ELGGjjzzALUXWybXwEHOQSCZ7FlsTwoKNe7NFSM93+Q+CVRkcKs+5KGlX2iL8NXvku9
         MfsmXxKn4BJLexUzXeMOCm+FbwYtA4W9Tj48JOCgAmM9ivH34PTAld14uSjXOe6VafF1
         Z+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFFaHeLywLCEIsIYE3gh04d4L/LDub1CmkA503m7820=;
        b=SM5suCAFF5rKdrIx9rSBtS5KeP1s2/6Rg856zMeTmbFN8pcTXY6OQPGplA+oY+RN58
         Z4CLKtyc0oONmnpeJSBd0vCYa+BIWuPG+IQaXWdWkTbMkNy4Li0O9+11bpbPG6PrTwhO
         2exbJzJiqTtevFS5UwpWMDDmK0dgxZ+5n2KPKKea3r9nmuZ0fdX/ZF0V3PEUA9IH66hT
         ykKa203fD5QWqm9vcBleTgCQfsSP6roe6cnvZKRT4vdPcXsYIEdunIxFycWmqOU/kuto
         DlDJSMVIa7rhtfoNQKLdVTEJLmxTfRq8O/100Sewb6ecvxINpL+vIX3XSp4webbMydoH
         nWkg==
X-Gm-Message-State: APjAAAWKg0Rur3CVhyOlMCPEDqQWwowCK1SraPLHnvJ1kN9m0FjoR/xx
        RJmvRXIOxpPA00VzXZSgA3XozPiKc+iSkSVkOl18uTg=
X-Google-Smtp-Source: APXvYqwoHdoFaC9VqOmbCrjLyG60Izi0pyFDrXtJVEVwH8HxY528XWdNXlFXpR2SdkpmiKjV3xGi6/j7rHAj3t7HO2M=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr7448075ljj.243.1576005568716;
 Tue, 10 Dec 2019 11:19:28 -0800 (PST)
MIME-Version: 1.0
References: <157594281322.676903.11041338053333686450.stgit@chester>
 <f7e43b67-3f46-e480-f8b0-e86eff85293f@tycho.nsa.gov> <CAHC9VhSO0Jaqyxw_5AtPTTQTqS+Q9CWhBQQ7822hvUS8MWLy6A@mail.gmail.com>
 <2abbcb79-4384-cfb0-1feb-c3a2e042a2ed@tycho.nsa.gov>
In-Reply-To: <2abbcb79-4384-cfb0-1feb-c3a2e042a2ed@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Dec 2019 14:19:17 -0500
Message-ID: <CAHC9VhTS+MpwkJNg=hLsjzwNqwPcEN1yEVkXh8=k6Wdh+S+kWA@mail.gmail.com>
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

On Tue, Dec 10, 2019 at 11:12 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/10/19 10:54 AM, Paul Moore wrote:
> > On Tue, Dec 10, 2019 at 8:44 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/9/19 8:53 PM, Paul Moore wrote:
> >>> In AVC insert we don't call avc_node_kill() when avc_xperms_populate()
> >>> fails, resulting in the avc->avc_cache.active_nodes counter having a
> >>> false value.
> >>
> >> incorrect value?
> >>
> >>     This patch corrects this problem and does some cleanup
> >>> in avc_insert() while we are there.
> >>
> >> submitting-patches.rst recommends describing in imperative mood and
> >> avoiding the words "patch" in what will eventually just be a commit log,
> >> ala "Correct this problem and perform some cleanup..."
> >
> > Well, you've made me feel better about my nit-picky comments on patches ;)
> >
> > Are you okay with the following?
> >
> >    selinux: ensure we cleanup the internal AVC counters on error in avc_insert()
> >
> >    Fix avc_insert() to call avc_node_kill() if we've already allocated
> >    an AVC node and the code fails to insert the node in the cache.
>
> Sure, or just "Fix the AVC to correctly decrement the count of AVC nodes
> if it encounters an allocation failure on an extended permissions node."
>
> >> Should probably add a:
> >>
> >> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> >>
> >> Might be easier to back port if you split the cleanup from the fix, but
> >> your call of course.
> >
> > I waffled on that last night when I wrote up the patch, and more
> > generally if this should go to -stable or -next (despite what is
> > claimed, adding a "Fixes:" tag means it gets picked up by -stable more
> > often than not in my experience).  At its worst, not fixing this bug
> > means we could end up effectively shrinking the AVC cache if xperms
> > are used *and* we happen to fail a memory allocation while adding a
> > new entry to the AVC; we don't cause an incorrect node to be cached,
> > we don't crash the system, we don't leak memory.  My thinking is that
> > this isn't a major concern, and not worth the risk to -stable, but if
> > anyone has any data that shows otherwise, please let me know.
> >
> > I'll go ahead and add the "Fixes:" tag (technically this is the
> > *right* thing to do), but I'm going to stick with -next and leave the
> > cleanup as-is just to raise the bar a bit for the -stable backports
> > which I'm sure are going to happen.

Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
