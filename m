Return-Path: <SRS0=MRHa=BY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C409CC433DF
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 19:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987902078D
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 19:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="Z4xhNYsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHNTIn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNTIm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Aug 2020 15:08:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918DC061385
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2020 12:08:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z18so9213968wrm.12
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2020 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=VcHOXKf01MmYpQPvyIi5UM/lvqxZEoomCErcmCPpfxw=;
        b=Z4xhNYsKDBmJ9MFO2JErlpRsQtmvvWPg8SMM9p77lhQiCEIZPEZIt8QJiUO+SGdZLu
         2avMrJ/pakomGPqHp1io6FwaiRxvYhmqW4iHPgoGPlkEwu8k0/RDlIf/QghRrRFF7O1d
         4xTLVT21qQ+FABU/fqUo/HfF7gZ0ZqxdoHQki075E4j2OqjMaHtHzTnpkky5E3mEi5bX
         +MzZQyJYZHUt+QAP5099OtVdAcMEiba8IuqyZCZ6N3alS5T/Pum9rrcsAk0iKYZKWZuM
         lenhNBDC7CzVhkktSN4k0xaR5w0q0azfm3IJRBa1zGyDWzarC0xvlDKq8n4su2VU0Skn
         2BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VcHOXKf01MmYpQPvyIi5UM/lvqxZEoomCErcmCPpfxw=;
        b=t7I7rIL7HvRGXGs0ue9M9GcgxPeGrJm2ke4vy+DWIHu33R3K+eWmNM3Od8YeUT5oXo
         fnEFLB5fMGDldm9KKeIuDEvV0sCZqhNvDYt20xRXLtWUsuNOKN+ZMncq4kDSNu6lyik6
         pulsgxgvg7FcJdeI/UD0TQ8Dy5L4IVJqLxstmCNVQaQll/XcjWLkTfvKX0/4jD8O//fO
         JLzgVFVBGaz2bc8KkyfF7rUDo6dIDCtjzxt3pdQgTQMqu+x5/j6HqprHbsPY9Lxw47jj
         R3k2pVbLZYpdCEXM939Y3M/O5KMxBlppY7sUVt7ulanS5ho8GJf3E4UO25iVtjWuVNP1
         4VNg==
X-Gm-Message-State: AOAM531pctKapK2kX26dggATzd3loiW6pWvj72QrLonhymdRb3fcqloi
        45/+O5bpdpXLhzjhBxe+EyQuC8VskH3yDWy+Mtf3vVWN8+IL5kD1
X-Google-Smtp-Source: ABdhPJwSu1nS25vx7vH9um3/BwDXRE7TyffenUdhVUFm+j2CzHOW48GNMVnAD8hV0k1y0OCoJtHieWc66RKKCSpEEGk=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr3836081wrw.362.1597432119076;
 Fri, 14 Aug 2020 12:08:39 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Fri, 14 Aug 2020 15:08:13 -0400
Message-ID: <CAGeouKFPaq=UicAnedT48Kr+GtBaDVKAoRhT3ukiEw3Nq5mtDw@mail.gmail.com>
Subject: Creation of repo for Linear Assured Pipeline work
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Folks, I'm working on tools to automatically generate SELinux policy
for Linear Assured Pipelines, that is, verifiably tamper-proof and
non-bypassable information transfer between two information domains,
e.g., moving files reliably from one network to another, with
filtering along the way.

tl;dr: https://github.com/PeterWhittaker/LinearAssuredPipeline may be
of interest to you, if you do any work with using SELinux to define
Linear Assured Pipelines.

The basic approach is to:

1. Define a pipeline in YAML, and verify that the pipeline definition
is correct according to a schema document, also written in YAML (I'm
using Yamale for schema validation). I got this part going this past
week.
2. Use the pipeline YAML to automatically generate SELinux policy
statements. This is most of my plate for next week and until it's
done.

One of the motivations for doing this is that the basic TE statements
used for the transition between any two elements in the pipeline is
the same: N can read from N-1 and write to N+1, and no one else can.
If the filters use folders to move files along, then only N-1 can
write to N's folder and only N can read and delete from it, and only N
can write to N+1's folders, etc. There is a lot of repetition, with
only the specific types changing from step to step.

(I've done step 2 before by hand, which is why I am working on doing
it differently this time. It is a lot of work, and error-prone).

The other motivation is to ensure that the pipeline itself is clearly
and cleanly and correctly specified before writing any policy
statements - and there is place in the schema for canexec-style
statements if a filter needs helpers along the way: Capture in the
high-level YAML file the general structure of the pipeline and any
per-step exceptions, validate of all that, then generate SELinux
policy from something you're pretty sure is already correct. If the
generation code is correct, the policy should be correct.

Feel free to check out the repo, poke around, ask any questions, open
issues, fix stuff....

Thanks all, have fantastic weekends,

P


Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP
