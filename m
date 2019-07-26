Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2463C41514
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 22:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E24022C7E
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 22:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="17VtZ02i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfGZWOG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:14:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34620 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfGZWOG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 18:14:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so52892360ljg.1
        for <selinux@vger.kernel.org>; Fri, 26 Jul 2019 15:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tM6iRcvs2oyT/Wt34pW7ORo4I6mVuCJbX7XV+vt6GyM=;
        b=17VtZ02iyN18SKHkZeksu8ybrTXnDBYaB6pUGE0u2GqW19a3eN9TIX5k0/f4h9t5HO
         yaXE/S9pGdF+wFpa26PyPxUg6dlIeTtdcCQAGJTbWX2g+iDoVuWNdO2UuuuhL4v34lr+
         +vcixfn5Tgx3dXaOZpO476FinvXLRXCOJpOvvOu8uyAi7CroNjfwUVvEAQ7Ot5S4Yxxu
         NauuHeM7fEZKHAUNgLZRDGBQY3XrpcPU9ylD9xgzI7PxYIcF5CTnx0xazjGrOlg/ubPW
         sMaT3qyInNKzLouIUJ5BVIol2ligsh0hP3/xTi1c3dJ11XqDDkGutSrGnIuHt4chxJCY
         P6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tM6iRcvs2oyT/Wt34pW7ORo4I6mVuCJbX7XV+vt6GyM=;
        b=HThRGwx6JK3kqVhbvUtgSutylC9MgNcurowagidaB1xGIYdNYjLXg4px2hftYNIs1t
         12El2X4b0JIupRjqFioPkpC/2Q7AmoHQ+R9QiLQWUQtkh/Ep8y2hYtagrC/LAf7wz4AU
         6F1S95MbuGO2o4hoFlgoRtWhziEBrdQZyfzSTCT4q8qf4UiPKNPKUsNfyWZDJ9M114vc
         IdIVKN5Vc9NQwZjQHDMzlZ1Ul6PaE9ilF7F8ObK40xDih4Gkh+fChrg6B7BXGtBCFOpe
         3eikt18fv3jRRwAMHqQZ0cAv9sbiIm1hFrDThAMr4nxzRrIN3CeljeJk65w8sGCE4iw/
         UMBQ==
X-Gm-Message-State: APjAAAXif87LWhKKRlpYr5r1dYMS07l4M3gtlCyjkMs2yPn2h55YvNVh
        4jE+xPCxWH0AkGEJVsNj+wBawhmgJfHKVdtKwGL3pf4=
X-Google-Smtp-Source: APXvYqzcW7BFPRKH5zQXIM0uI4BFE2T9Ag129+7Kta5szZyKk08AVmLt88TF2Pb++oK4r+lUCHS4epYfiPg/jw+yusQ=
X-Received: by 2002:a2e:9858:: with SMTP id e24mr27285211ljj.91.1564179244320;
 Fri, 26 Jul 2019 15:14:04 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Jul 2019 18:13:53 -0400
Message-ID: <CAHC9VhQJ8oDqX09AdrvLJAgweaBcxETCw547CSiRyApRguXznQ@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.3 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

One small SELinux patch to add some proper bounds/overflow checking
when adding a new sid/secid.  Please merge for v5.3.

Thanks,
-Paul
--
The following changes since commit ea74a685ad819aeed316a9bae3d2a5bf762da82d:

 selinux: format all invalid context as untrusted
   (2019-07-01 16:29:05 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190726

for you to fetch changes up to acbc372e6109c803cbee4733769d02008381740f:

 selinux: check sidtab limit before adding a new entry
   (2019-07-24 11:13:34 -0400)

----------------------------------------------------------------
selinux/stable-5.3 PR 20190726

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: check sidtab limit before adding a new entry

security/selinux/ss/sidtab.c | 5 +++++
1 file changed, 5 insertions(+)

-- 
paul moore
www.paul-moore.com
