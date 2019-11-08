Return-Path: <SRS0=6fGn=ZA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7286BC5DF60
	for <selinux@archiver.kernel.org>; Fri,  8 Nov 2019 18:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EE3214DB
	for <selinux@archiver.kernel.org>; Fri,  8 Nov 2019 18:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RvuvnlKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKHSjH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:39:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34684 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfKHSjH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Nov 2019 13:39:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id 139so7263637ljf.1
        for <selinux@vger.kernel.org>; Fri, 08 Nov 2019 10:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQFnTwuRqhYAsQvf7lXFvGo2c1sUmVGvnUwePPPTe4Q=;
        b=RvuvnlKeJZu7reXZ5NBjJANyuNdaq7oXNqqFoUMbv/aBRwAiEljl5mG8rDuTyxTAXr
         zgrdYWO/1FEeUw/ixvDAJnUE2xelxgDI1PYv/XHmFUfE2zFzd3slfhg9LzTUFA9FwDfv
         uxDDAHgNN7mPyWevaO4Oq7OnmIAzQxYRC/q/fCEus2PQHMwy3DFYTPz5sZlM8AyPAKnC
         qO4aHMDnWllGa3qMA/G49UpODnN+qx3+935FmoFvmlUdUl9nMSAKs0A2/3BG3EGuJ39g
         CgAIGwxviZkjFiDN73a8qMUiLLm89+8QNVs42T22ANw/+d63MnoElD2pzA5Sasa8Iskr
         r89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQFnTwuRqhYAsQvf7lXFvGo2c1sUmVGvnUwePPPTe4Q=;
        b=h6rehILqwtHKXh5rxUXLhVHZ9JETudMtVygTcc2oHxgMGtab/BQktlgL7FwyHSu4/e
         ZkGICh0daki0gK3E8xbYdhzoIFLmvZJ7qtvVwQDkycJhCy9hRztYjRSxtLFEepnf40sR
         7K2ABhk2ME42jL2P5cOPtGc2eWpZ1z14ZG0mKETR8FcnjFZCLlU03PREbr4NZ2bSI0G3
         IeSNpvoiPFzK75ner5vUIKFw3rxHK4g008DZxBDWt4mHqrgy9XnTo0sZJcRHgx9ocTmv
         FQU4e64tpwe5tNFKNIL8ypxdblm8TfsyZz2U0gsHHE9Jqj4ok9vLd09I/3TutefaKcAX
         XInw==
X-Gm-Message-State: APjAAAXQAB+T5DfSkaT3XPSoMnCEzxKvXH0XRCGnqc3tivlJv6T6HnIP
        uC3ux3P2k+scayGeXBVH6CLHOq29wBTBVyvdutW+
X-Google-Smtp-Source: APXvYqwq0ve3s3164xuWiytSBUNOtC5TG6EjmA3PoV86+8rL3gxjSH20wuUihDBVcSJlUe/VOWyFPmWwOAORWqbu6wg=
X-Received: by 2002:a2e:95c5:: with SMTP id y5mr7953326ljh.184.1573238343833;
 Fri, 08 Nov 2019 10:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20191030131633.9356-1-sds@tycho.nsa.gov> <CAHC9VhQG=2VwJiM=LrZxZaSXWELbsu61pw2ynNgL0NAO+SvYMA@mail.gmail.com>
 <de944969-6d9f-8fbd-ffe1-4f9bdd7410f2@tycho.nsa.gov> <CAHC9VhSzoDnHK+fDXocShQALW32ctoOOC7GOeb_tEQsnm-1d0g@mail.gmail.com>
 <14181dcc-aa6f-8fbb-6244-08ed39591f30@tycho.nsa.gov>
In-Reply-To: <14181dcc-aa6f-8fbb-6244-08ed39591f30@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 8 Nov 2019 13:38:53 -0500
Message-ID: <CAHC9VhQnoGLM7H-vR-kDBgdib5gPehVpNPr+d85VRFs5UYHnqQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add SELinux hooks for lockdown integrity and confidentiality
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 7, 2019 at 1:07 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/7/19 12:48 PM, Paul Moore wrote:
>  > On Thu, Oct 31, 2019 at 10:01 AM Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > That is an interesting question: do we consider dmesg output to be
> > part of the stable kernel API?  My hunch would be "no", as I've seen
> > things change quite a bit there over the years, but IANL (I Am Not
> > Linus).  However, that said, logging a reason string via audit seems
> > like a good idea (especially since there is presently a many-to-one
> > mapping between reasons and the SELinux permission).  Further, while
> > the audit field name is part of the kernel API, the value is much more
> > open.
>
> Ok, any preferences on the audit field name or should we just create one
> and cc linux-audit on the next RFC?  lockdown_reason=?

Definitely CC linux-audit as I expect Steve will want to have his say.
FWIW, "lockdown_reason" seems reasonable to me.

> >> I also wasn't sure about the pr_warn() above.  If we reach it, it is
> >> effectively a kernel bug. We could mirror what the lockdown module does
> >> in lockdown_is_locked_down(), i.e. use WARN() instead.  Of course, the
> >> SELinux hook won't even be reached in this case if the lockdown module
> >> is enabled, but the lockdown module could be disabled so I guess we need
> >> to check it too.
> >
> > Since this seems security relevant, I wonder if we should be using SELINUX_ERR?
>
> The benefit of a WARN() is that it will give us a stack trace showing
> the offending caller in the kernel, which would be useful since it would
> be a buggy caller passing an invalid lockdown reason (LOCKDOWN_NONE or
>  >= LOCKDOWN_CONFIDENTIALITY_MAX).  pr_warn() or audit_log() won't give
> us that info.  We could do both of course.

It's a balance between development needs and freaking out
administrators (although perhaps rightly so).  I also worry a bit that
WARN can be disabled at build time so having something like
SELINUX_ERR could be a good fallback, assuming we did both.

-- 
paul moore
www.paul-moore.com
