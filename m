Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD82EB64D9
	for <selinux@archiver.kernel.org>; Tue, 27 Jun 2023 01:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjF0BtM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Jun 2023 21:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjF0BtI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Jun 2023 21:49:08 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AAEED
        for <selinux@vger.kernel.org>; Mon, 26 Jun 2023 18:49:07 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bff0beb2d82so3978538276.2
        for <selinux@vger.kernel.org>; Mon, 26 Jun 2023 18:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687830546; x=1690422546;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPAPtjQQk1JMXxt6JCYMVRlP/DgzO+acMDWDPGPCAIY=;
        b=TtATvEdGnXKkviFw1wlwo7rwNg1qkWCLRTcObyQK5YsnNOUEQ2lJw8fa0aejzSFkmL
         mEk6m+BjH4uJcAdj18+Q4kagvLFoVZKoDk5P5CIeK3wzS/v9KvlZeNwIBbKYAJAE+0jN
         lLCaikYho4jXwnrlDRPKMjNoIzQk9PWBcZB77r7/Ih74CuLZbXaT7BztpAHv94m+M9oF
         TPgOYBNx3BXWWUrQpy0HHlwcG431BkUbXhLXL2MRmi+38+vYvEp9wajWIPLlqXfZ1xTi
         lMQJdf3HeUP69mxZ0H4EyXI7ybkouG6XyPLW3JfJdt65oSaN1Oo+nc4pQSTv/L3vK1Km
         pfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687830546; x=1690422546;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPAPtjQQk1JMXxt6JCYMVRlP/DgzO+acMDWDPGPCAIY=;
        b=l74pMZGQvvUEH+g4ZO9JFuXYt3LRjvZx2i86sMW5m8GSVsNB7vic58s41gwX/eZkTt
         +Fq6OfQJxNUHOc3H0hNuzXjoCqLjlkIoyq1zYSqq73n9vYQx1+trlIizbJyk5TTAM/Pa
         z+vCVKRL56SSO9PXkxClbzOQjItk/wUeogmXRUN8u74CWNDZTEdS2Cx9X3if6+nlCeYx
         HiHyY6NpyzN2dn3vhZLr+v7SLbadzehahZMO0zUyXey18RP9MukOzhUVJLasas8VJczB
         F+sAOb64g8jLzIzkeV5J+M0r9dMHHZG+Zr40p1y10wfTrh+JGb1UCCvBZmTNYA8UaNT8
         G9eA==
X-Gm-Message-State: AC+VfDytClM3w9f6f4xL1QiDTXEfzwnV04MN3k0FtlWUbuLeeWOsBJV+
        KhWA8VpS8A6FqVJqptDnu0GdQu616Djrp+OHcOh1WOxPeBvJjk4=
X-Google-Smtp-Source: ACHHUZ5t8RczIiC/ZECJs1Ok/DJDG3FlkZFU6rtbp6e01mnNoqLm0IU0q314xNtvqTikZHVM10qvEZQNBDE/S7Z2pb0=
X-Received: by 2002:a25:9207:0:b0:c26:d015:e427 with SMTP id
 b7-20020a259207000000b00c26d015e427mr2712817ybo.13.1687830546277; Mon, 26 Jun
 2023 18:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRpBZpqwJ4J+sPHr=ZMmkpd5qmLW-a+B+GGKre=NSU-AA@mail.gmail.com>
In-Reply-To: <CAHC9VhRpBZpqwJ4J+sPHr=ZMmkpd5qmLW-a+B+GGKre=NSU-AA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Jun 2023 21:48:55 -0400
Message-ID: <CAHC9VhS-+aVX1UF7QyZbq-GqF6ZV=L+b5iNokoXBrbKL5kr7Ng@mail.gmail.com>
Subject: Re: RFC: style/formatting changes for SELinux kernel code
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 8, 2023 at 10:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Hello all,
>
> Over the past few weeks, as time allowed, I've been working on adding
> some automation to my Linux Kernel workflows.  Most of this has been
> scripting various maintainer tasks, e.g. reviewing and merging
> patches, which I expect is not very interesting to most people reading
> this, but I think there is one aspect of these automations that might
> be interesting for a wider audience: basic patch sanity/verification
> tests.  These tests are intended to mimic the sanity tests I perform
> when reviewing patch submissions, things like "run checkpatch", "make
> sure it builds without error", "ensure the style/formatting is
> reasonable", etc.  For those that are curious, you can see the current
> tests in the repo below, but I will caution you that there are surely
> problems with the scripts, they are still very new and barely tested;
> expect changes.  I should also note that I haven't published the
> tool/framework which I use to run these tests just yet, but the tests
> are intended to be standalone so there should still be value as-is.
> My thinking is that by sharing these scripts, and keeping them
> updated, it will help keep the developers and reviewers sync'd as to
> what is expected from a SELinux kernel patch.  Much like checkpatch, I
> don't expect these scripts to represent a perfect, ideal standard but
> I think they represent a "good enough" example where the accepted
> verification failures should be relatively few.
>
> * https://github.com/pcmoore/git-verification_scripts
>
> With all of the above in mind, I wanted to get everyone's opinions on
> the style/formatting suggested by the scripts above.  As anyone who
> has looked at the SELinux kernel code knows, the style is somewhat
> inconsistent, both with respect to the SELinux subsystem, and the
> kernel as a whole.  That unfortunately means that if we want to be
> able to start vetting the style of new code changes, we really need to
> properly (re)format the existing code first.  Before I went too far
> with this I wanted to see what it might look like when applied to one
> of our ugliest source files, security/selinux/hooks.c; you can see the
> results in the commit below:
>
> * https://github.com/pcmoore/misc-linux_kernel/commit/3f94fd77b46522a038e=
b6771b63d0a6d36ca3547
>
> I'd like to hear what everyone thinks about making a change like this.
> I personally think it is a positive step forward, but I do acknowledge
> that those who have to do backports will likely feel some occasional
> pain.  As the backport pain will eventually subside, and the benefits
> of nicer-looking code and improved/shared patch verification will
> continue, I'm leaning towards reformatting the code, but I do *really*
> want to hear what people have to say before we do this.
>
> Also, just in case you think I'm pushing my own crazy style ideas on
> everyone, the scripts in the GitHub repo above actually leverages the
> kernel's own clang-format configuration (with a minor tweak).
>
> * https://www.kernel.org/doc/html/next/process/clang-format.html
> * https://github.com/pcmoore/git-verification_scripts/blob/main/configs/c=
lang-format.d/clang-format.linux

If you have any concerns regarding the style/formatting changes
discussed above, please speak up soon.  If I don't hear anything
within the next few days I'm going to do ahead with the style fixes.

--=20
paul-moore.com
