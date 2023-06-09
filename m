Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78CC7EE29
	for <selinux@archiver.kernel.org>; Fri,  9 Jun 2023 02:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjFICWU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 22:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFICWT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jun 2023 22:22:19 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F639269A
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 19:22:18 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5664b14966bso11582827b3.1
        for <selinux@vger.kernel.org>; Thu, 08 Jun 2023 19:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686277337; x=1688869337;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7GkzvWGo8LVIilwXTa9Amc70beC4kl4jwbBB1cIdha0=;
        b=KrxJ28PW9tEM1BrpzrBHouwTtF7uUjoJk/1WqXZK1CU6Hd6KBNwycG09QHVDqfhk49
         SGtvSUewmu3YVUVlpm+w6D0pPaXDTsCv8fPoNs2kUImHfVf4+iU2uKfcQgOgTViqZV8z
         m7R1qZvKrBQcRUfJzRG8CWu8ZU1qX8GzBBJIX8KSzdX7kC1HNrix172wm+SkkKckvT9H
         R4rDmqzkAkfWp1gETVqmdTQkt+QFt4V7GLLf2YQLc0qkWxULCjsw/z4EsteIKWF2YfdP
         1ZnTwmEY6XWcOPNvvyblh8bOSJ6Pt3ymurrSW0Y82TPDpkbeA2QPgRDUaKKyt0mAnRpF
         rKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277337; x=1688869337;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GkzvWGo8LVIilwXTa9Amc70beC4kl4jwbBB1cIdha0=;
        b=ENoy6euI4sf+PEfz6jeZ6avJyfs276lHs4dRBLZCNEIM/RDeqFeOpd01S0ki732PXx
         WWIVr9W6xTX3Kmb/EKL1kpiH7okZDAcOqje741dSfQ1C68HlkqZ78Mh8PDLwOB8vcibK
         tf7ZQSNJUIFNYrt6MiUtq1BUBwcX250+PMwqd9sa+GZpg9YTcNXzMUXJJ2GQ9cowozOt
         m7Lgupm7iF9Zlc9YEObNQLFFjpXbvPx0uoI8u5gB/lgY9bJzrKUmZZOUqwWIAAwJlNaS
         Aj7CtZjYIjgkCt2kEBL7LZa4SD6rMtFzBK/IwzG8lwA1CBo/P4ibSGJjEG44mj1CtZp1
         OEFw==
X-Gm-Message-State: AC+VfDzXCr4myeH0dFCDoUG5Wbl8LsMotHhynXqr1MzNguuAK27VSZH3
        ZOkl5K8CtqtaKZ7dWnVURXcNR1nHlas/PpVzT3S/J4i+QSpXmV8ilQ==
X-Google-Smtp-Source: ACHHUZ6Bt0piJlNFBGEDl14pVWW+swo8D3M3JOTXRYL/v9iecRlbHU8sNZt9CfORY/aI7Qul5GtrZJdUTgIwfW3oQ3o=
X-Received: by 2002:a0d:d107:0:b0:556:c778:9d60 with SMTP id
 t7-20020a0dd107000000b00556c7789d60mr1127072ywd.43.1686277336939; Thu, 08 Jun
 2023 19:22:16 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Jun 2023 22:22:06 -0400
Message-ID: <CAHC9VhRpBZpqwJ4J+sPHr=ZMmkpd5qmLW-a+B+GGKre=NSU-AA@mail.gmail.com>
Subject: RFC: style/formatting changes for SELinux kernel code
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

Over the past few weeks, as time allowed, I've been working on adding
some automation to my Linux Kernel workflows.  Most of this has been
scripting various maintainer tasks, e.g. reviewing and merging
patches, which I expect is not very interesting to most people reading
this, but I think there is one aspect of these automations that might
be interesting for a wider audience: basic patch sanity/verification
tests.  These tests are intended to mimic the sanity tests I perform
when reviewing patch submissions, things like "run checkpatch", "make
sure it builds without error", "ensure the style/formatting is
reasonable", etc.  For those that are curious, you can see the current
tests in the repo below, but I will caution you that there are surely
problems with the scripts, they are still very new and barely tested;
expect changes.  I should also note that I haven't published the
tool/framework which I use to run these tests just yet, but the tests
are intended to be standalone so there should still be value as-is.
My thinking is that by sharing these scripts, and keeping them
updated, it will help keep the developers and reviewers sync'd as to
what is expected from a SELinux kernel patch.  Much like checkpatch, I
don't expect these scripts to represent a perfect, ideal standard but
I think they represent a "good enough" example where the accepted
verification failures should be relatively few.

* https://github.com/pcmoore/git-verification_scripts

With all of the above in mind, I wanted to get everyone's opinions on
the style/formatting suggested by the scripts above.  As anyone who
has looked at the SELinux kernel code knows, the style is somewhat
inconsistent, both with respect to the SELinux subsystem, and the
kernel as a whole.  That unfortunately means that if we want to be
able to start vetting the style of new code changes, we really need to
properly (re)format the existing code first.  Before I went too far
with this I wanted to see what it might look like when applied to one
of our ugliest source files, security/selinux/hooks.c; you can see the
results in the commit below:

* https://github.com/pcmoore/misc-linux_kernel/commit/3f94fd77b46522a038eb6771b63d0a6d36ca3547

I'd like to hear what everyone thinks about making a change like this.
I personally think it is a positive step forward, but I do acknowledge
that those who have to do backports will likely feel some occasional
pain.  As the backport pain will eventually subside, and the benefits
of nicer-looking code and improved/shared patch verification will
continue, I'm leaning towards reformatting the code, but I do *really*
want to hear what people have to say before we do this.

Also, just in case you think I'm pushing my own crazy style ideas on
everyone, the scripts in the GitHub repo above actually leverages the
kernel's own clang-format configuration (with a minor tweak).

* https://www.kernel.org/doc/html/next/process/clang-format.html
* https://github.com/pcmoore/git-verification_scripts/blob/main/configs/clang-format.d/clang-format.linux

-- 
paul-moore.com
