Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB0C433EF
	for <selinux@archiver.kernel.org>; Tue, 28 Dec 2021 21:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhL1VcH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhL1VcH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Dec 2021 16:32:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743CC06173F
        for <selinux@vger.kernel.org>; Tue, 28 Dec 2021 13:32:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q14so70950249edi.3
        for <selinux@vger.kernel.org>; Tue, 28 Dec 2021 13:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cHTU5eSbVn+Nq+7+XwSfl6tfJrjIWfjd65MmcAa33Tw=;
        b=e32C6fkJy9hBkegXx689ALBUQNblaYKuVEwDLVzJJ9wPRgTmwXIDmSNJ5taBcWaziO
         qXm0VQucFDSpa82knvAD0/iYHg7LCZQuQST/39ybNhF8uqdPV7LhpOHfHhtR3gFGt1Q9
         rrmtWaD/JM8DSe04Xz4o3PbkoJfxZ0/Z/tt0PUXEfXB6zPTH+WWssfyeaHTm0M3vgS97
         tyuy1xXLvIePI8jN2TtbQYFvyA/3nBU2lOMjP0OO2VGyN3j+Qup8EkTpC1kU2BCKLUb/
         UZY48OewoTL9kkOMarn1uyGF8enMMdQ7AG33l++xpfIiBUCSLO0pBxrRfobpZByjQERm
         Ag9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cHTU5eSbVn+Nq+7+XwSfl6tfJrjIWfjd65MmcAa33Tw=;
        b=5mte4qwdjU1yM4jgFcLCaXUXQuqI7Zvk16VpLMVUI35u/vpc4u1V6Es65bWMPCJY6o
         CIX43cDTkufZZ30yHPCC2DkQYUEXPgHTq4heD3nTi4vEn1grSqF3lLUWWOKOus4F5RSY
         QVNMMEQ2WyKRNE+Svq0KCyugbXRAK36guRV9fX6I8iVolbsxELjzBNd3G0rfJfVVrW7+
         wT4qDPUX2ZWTRAlJ3fg71uYQaS3WPn3iti03vzBkRV2o7RLD2iL0nirWfuAhtJ1H2r8r
         mPPQj80MsCq0sd5zRuqVI6YUuxElHGlWXo0dZGlOt+LNNXq2pATXNwtfvRj+PHVuZ5VW
         VHnw==
X-Gm-Message-State: AOAM530o+Yvpfm/Wh18NpDZAXas5JoSj9IA+pEOZeTt4gTU6c7nztzgs
        hixKtm/AYM2pPcugxC87yi54spjCzM4cQTxiBJ3P
X-Google-Smtp-Source: ABdhPJzQ0p02hmA9Dta7IcVRKcye7gXhGSFiKcQLB60AX9N1OiN+KPZZOiQV2nM76TPAUe8O3ecK9jo6izsxo4LT8p8=
X-Received: by 2002:a05:6402:1388:: with SMTP id b8mr22841120edv.171.1640727125234;
 Tue, 28 Dec 2021 13:32:05 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Dec 2021 16:31:54 -0500
Message-ID: <CAHC9VhRrwLKn1mbMPjsaVwye8YVhP2Y6qxTz6pMyQoqcSFfXRg@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.16 (#4)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Linus,

One more small SELinux patch to address an uninitialized stack
variable, please merge for the next -rcX release.

Thanks,
-Paul

--
The following changes since commit cc274ae7763d9700a56659f3228641d7069e7a3f:

 selinux: fix sleeping function called from invalid context
   (2021-12-16 17:47:39 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20211228

for you to fetch changes up to 732bc2ff080c447f8524f40c970c481f5da6eed3:

 selinux: initialize proto variable in selinux_ip_postroute_compat()
   (2021-12-27 10:41:20 -0500)

----------------------------------------------------------------
selinux/stable-5.16 PR 20211228

----------------------------------------------------------------
Tom Rix (1):
     selinux: initialize proto variable in selinux_ip_postroute_compat()

security/selinux/hooks.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
