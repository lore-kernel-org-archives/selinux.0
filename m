Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CF5C35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A480C21744
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 16:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOdTXQ7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgBYQYp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:24:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40604 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgBYQYp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 11:24:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id i6so52033otr.7
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3Bxjd/XTqNrcRha4uKIr0AVs5GYe1PrwUyw8vfsnTk=;
        b=fOdTXQ7gD5aOPPMej0gDzjHUoeAR5h/Ch6ugobpqlVErrWdddGskoRt98mAlK65QCt
         2wnVTIQ03aSPaYCIb+4NCmNG2bR6azga+CFk1QHTFv8/vb7Qb7gl1xwBJRsRbXnY4424
         7oo2OtILqK51dgh2QZSWJPUwDK5eAuuW4pMyou6C/UlPW1FeWtPHHzSyElzCxfUN00xs
         kWabxFu7yL1a5bGwWxJ2jQ74kLR/4qPvCFGWGFc5RhakyG1M+14mGft72dXpQsUsZSvg
         WJgDZOzhA1VG2MMurlqqVHQdW1NLNfrIUHYCrkEHbr+hnk8yhMSMRbdwPgOZstfbMg4w
         GJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3Bxjd/XTqNrcRha4uKIr0AVs5GYe1PrwUyw8vfsnTk=;
        b=e5uAO9J9XGTAMcaO4Pfh57sJZd/0TgPwTZQ+v8VYjpCyDP2IBTzysRjAzlllaTRo/p
         u/nBsDu/dB7kUhgEb9GsLaqG6cNM4C1kdMC23bHe7YrILbgAhwuiuU/y9rikkwgifzYi
         kx3r0CH3OdH6+fLAZVla0JJmnfTs002u07ijjaDROIDwRfc4oi1JCivx/eJdtlk+G+g7
         QtEq2464xsVx2lk0EsRMd6WQiaRlocMTqipXsPtN42kB5GxSbBUojjwb974iUj6RaJoI
         6J02Pf2Hqj37JFHpBeEXDj/bKRu2Np6rPdsMfa6sHIuJAv6TwinU0VWAIo+m/zdJu97j
         HFNA==
X-Gm-Message-State: APjAAAWTQwNTPeW6IWzH/svqexc/ksOZWNtdnGXTXpdg9xwunDuW1bZ7
        1eWJztPjdAPON6FDwvf11D6h4fTF/NeCBb8Vvere/w==
X-Google-Smtp-Source: APXvYqzOF45nEe+HCGUUmBIDsbllVZQfNxIFKql8hEZUbxcXA9/3YGgw+WnRcsEBTRONWQGLUsPmpz7V494tu+tpRqU=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr46283385otl.162.1582647884716;
 Tue, 25 Feb 2020 08:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20200224141524.407114-1-richard_c_haines@btinternet.com>
 <20200224141524.407114-2-richard_c_haines@btinternet.com> <CAEjxPJ7HXQGdWX5KHs42OEGVR9doSD_FpUAH0TR+U96DPu4ukQ@mail.gmail.com>
 <feb9aa8f41509a9f0eb4b8a8b198e73e5acdd352.camel@btinternet.com> <CAEjxPJ55qz3m-KadVe8X1Z5Un2EcpwWkA1H8hFb3nYz7y5jKXA@mail.gmail.com>
In-Reply-To: <CAEjxPJ55qz3m-KadVe8X1Z5Un2EcpwWkA1H8hFb3nYz7y5jKXA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Feb 2020 11:26:16 -0500
Message-ID: <CAEjxPJ6cMrqbpqCxsog9HOY98awjDMPJ7UpNfCS99_pViwv1AQ@mail.gmail.com>
Subject: Re: [RFC V2 PATCH 1/2] selinux-testsuite: Use native filesystem for
 tests - Part 1
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 11:18 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> If you just ran the nametrans tests in the host filesystem rather than
> in the separate mount, I think it would work.
> This would require adjusting the type_transition rules however to
> reflect the actual parent directory type (probably test_file_t).

I just confirmed manually that name-based type transitions work over
labeled NFS.  The problem is just that your existing type_transition
rules aren't matching on the parent directory type because you are
creating the files in a separate mount that is using one or more
context= options rather than in the base mount itself, unlike the
setfscreatecon() tests above them that just operate within the host
filesystem.
