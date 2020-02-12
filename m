Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28539C352A3
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 03:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F206A206D7
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 03:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uj1wCy2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgBLDRa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 22:17:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40187 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgBLDR3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 22:17:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id p3so684824edx.7
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 19:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RE15EJdsIKQxzRJbIxCFVMJk+0seSzUjqA6IxkKMdfg=;
        b=uj1wCy2gPcCZ7S0AqU83K19vwujH6Ply0s+P839a507GXDuVJ9UCPZM7BTeN3SVrxC
         G6Eq8RvMDyjxdDNAEOIfrViZlwMxEsbHxm5eiQiXIUzywzwWV0UzFce5IOmncS+MEuo1
         9IU0AQW1kaFebYy6+WKjDu9CaC3dIH9RadhTkJex6VkgeRrL7vLnxTLOoHLsfr6A+Bf+
         MY33psuPYIm2DbE7fj7419TLPxz/R+tElbTiifLgwrhEi4J/14HYFBG6Q4RxU+YTsnuS
         lYWNKP4fRpaa9+nbtrL3L3qh1PZUVzU/VuNU7pY1uXxhd8LNY2BbQLUDaEBU2CMqW8sm
         E9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RE15EJdsIKQxzRJbIxCFVMJk+0seSzUjqA6IxkKMdfg=;
        b=P/r9RSdqtR1QrJSFD2Ornh6xaKn31bqZg8JM/fWcs2NKruIHYCS3PYuu6n/RNJC0qA
         ULLzY4UpBB4x265eEeUeC542urLQMIFYB5wbFXSQk29X/X1WpTQ5UpaY7ir2wpzJ15Sv
         fDEWlSlI7jOME0EDYSw5KZcgWr7bx6eKjiwvjb/63TWzNSkSM+hdtFdJs1ug14kJ59sF
         N2YO4RZNQhwB4kppWIF7nLOKLK7gc30G8WXHVKFZJPrHUhqECWSzfo3EAofuVhdCeAbK
         Yr3+TZ685PrsPfw+9jhfwE7cTg1Udzb/pNJsnhYB9AdfCmHeErS3IMIpZc16aH81mtYe
         pKOA==
X-Gm-Message-State: APjAAAXPOjujHVxkm9/Ky+poVejlAuWmRMOLphf7AV5aZEHp7HPJHosK
        ju0bkcZmi2vAgBVl1IfeordaqGDA4pkG6RPCgSGL
X-Google-Smtp-Source: APXvYqyHCiiN6oXTN7ZQP6ljA4ERUQofXGYHnq8vJHGmwB1jP9aWiO76pTg6f5hjJhdy3qSVCbxPsXIMiRBsXV0d2hY=
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr8996071edc.128.1581477447006;
 Tue, 11 Feb 2020 19:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20200206165527.211350-1-smoreland@google.com> <91465612-2fb2-5985-ba45-d4d9fcf0f70c@tycho.nsa.gov>
 <c61fc8f6-55c2-c717-5090-e535b7bdbb4f@tycho.nsa.gov> <CAKLm694DMH0JCpHuT4HgMd4yCNJZPFMpex8iEiRF9kRjPb0d6g@mail.gmail.com>
 <a8321785-902d-9186-fcf5-ee12a362a207@tycho.nsa.gov>
In-Reply-To: <a8321785-902d-9186-fcf5-ee12a362a207@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 22:17:16 -0500
Message-ID: <CAHC9VhQVcgQ7ZKXi+Umm51WNgfNSzNX7Zoe=MyaLo1rRm-uUtA@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labeling for bpffs
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Steven Moreland <smoreland@google.com>,
        Colin Cross <ccross@android.com>,
        "Connor O'Brien" <connoro@google.com>, kernel-team@android.com
Cc:     Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        anton@enomsg.org, tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 6, 2020 at 1:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/6/20 12:41 PM, Steven Moreland wrote:
> > On Thu, Feb 6, 2020 at 9:35 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>
> >> On 2/6/20 12:21 PM, Stephen Smalley wrote:
> >>> On 2/6/20 11:55 AM, Steven Moreland wrote:
> >>>> From: Connor O'Brien <connoro@google.com>
> >>>>
> >>>> Add support for genfscon per-file labeling of bpffs files. This allows
> >>>> for separate permissions for different pinned bpf objects, which may
> >>>> be completely unrelated to each other.
> >>>
> >>> Do you want bpf fs to also support userspace labeling of files via
> >>> setxattr()?  If so, you'll want to also add it to
> >>> selinux_is_genfs_special_handling() as well.
> >>>
> >
> > Android doesn't currently have this use case.
> >
> >>> The only caveat I would note here is that it appears that bpf fs
> >>> supports rename, link, unlink, rmdir etc by userspace, which means that
> >>> name-based labeling via genfscon isn't necessarily safe/stable.  See
> >>> https://github.com/SELinuxProject/selinux-kernel/issues/2
> >>>
> >
> > Android restricts ownership of these files to a single process (bpfloader) and
> > so this isn't a concern in our architecture. Is it a concern in general?
>
> I guess if the inodes are pinned in memory, then only the original name
> under which the file is created will be relevant to determining the
> label and subsequent rename/link operations won't have any effect. So as
> long as the bpfloader creates the files with the same names being
> specified in policy, that should line up and be stable for the lifecycle
> of the inode.
>
> The alternative model is to have bpfloader look up a context from the
> userspace file_contexts configuration via selabel_lookup(3) and friends,
> and set it on the file explicitly.  That's what e.g. ueventd does for
> device nodes.  However, one difference here is that you could currently
> only do this via setxattr()/setfilecon() after creating the file so that
> the file would temporarily exist in the default label for bpf fs, if
> that matters.  ueventd can instead use setfscreatecon(3) before creating
> the file so that it is originally created in the right label but that
> requires the filesystem to call security_inode_init_security() from its
> function that originally creates the inode, which tmpfs/devtmpfs does
> but bpf does not.  So you'd have to add that to the bpf filesystem code
> if you wanted to support setfscreatecon(3) on it.

Considering the relative maturity of bpf, and bpffs, I think it's okay
to take this small step right now, with the understanding that more
work may need to be done, depending on how this is generally adopted
by distros and users (for those of you not following the other thread,
I've merged the v3 draft of this patch).

However, I've been noticing a trend from the Android folks of tossing
patches over the wall without much thought beyond the Android use
case.  I understand the Android devs have a job to do, and products to
focus on, but I would strongly encourage them to think a bit longer
about more general use cases before submitting patches upstream.

-- 
paul moore
www.paul-moore.com
