Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EFDC77B7A
	for <selinux@archiver.kernel.org>; Wed, 24 May 2023 20:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjEXUd5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 May 2023 16:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjEXUd4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 May 2023 16:33:56 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C995510B
        for <selinux@vger.kernel.org>; Wed, 24 May 2023 13:33:54 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba86ea269e0so2839840276.1
        for <selinux@vger.kernel.org>; Wed, 24 May 2023 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684960434; x=1687552434;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eDu4sZIpl+Am9+o0pVDeZM4/ejdKpTgNOLBERJuTHG8=;
        b=DrmktCWW8qeaQ873ThKXaoaiI/BvYFGkGBs5IuqzFvHFe3D4MlGXMYbR9vvUdoKwWf
         4k+3zqFPXoXXCqxH2kf3DCMwXXwAYUwPDMNSjaFQP6x0Qap7wclINbAFx1pBWReMjvTO
         KQknP+NdlbhLev+9SCCmSKyUPflM33mpkMwtPcNuQ8Hq0plQJ4QbKWkVeeMgDfGwx4Jj
         O05yeQhsNaIv33HIBI8v2gct32YiG5LYgXNT8Eu9WP4l1Ot8cT1DPtOSERtYpnHiVFwD
         B8kmPAvuj0L9dhkJLGWj9rWTS0GEX3dthVf3HPIcq7yjOInI/xowHk4jIdNewT4L2YOx
         5rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684960434; x=1687552434;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDu4sZIpl+Am9+o0pVDeZM4/ejdKpTgNOLBERJuTHG8=;
        b=ZXVlaxT00n2N3KLA6/seMPYn5oYqZUffe2h7MLyKP8d3E8wr0YHZCjFfG4zAeDNJ9r
         RaUqnRlNXYe11lWAgVygbWY6p1YuItXs2ZcsVRYYwZqi8kcN1oLx/RQVg1tQFDbsneGN
         R8O8V+4HEm40FgqsFQduOnOh6UpVWuEorRxer33mzISXUYiK7x7pwlgXVr4JXFeEInqY
         biE/IVDBNGBwNtXt5RyrtW0Id5HSVoqsdRqCAygEcKRkCuwSAoWhDEf6OpEGYwfGv+PQ
         4W7p40H/q2k4TJjVPS0DewiP+HfWk7cjngEZXxK582kqxPulZ8LfAq0+T+/V/aJiyvUk
         KYMg==
X-Gm-Message-State: AC+VfDy54SAuQV5BqtN7gDQ3inq15klWBQ8HmosS7jP1h+7Ou4tGgAky
        Laam1qp7/F6Gxk0M1RMi2+MG9qkIN4PSuN0rTIx+BiVkbXhvoebkbQ==
X-Google-Smtp-Source: ACHHUZ7nTzAZPMCOu7Snd+Y9OF2V+jHunUHJ1SDylc/EcskuQQPahqerOErOCrmHJRs3VTuNmjakh74aTFYS8C3VHXc=
X-Received: by 2002:a81:7b07:0:b0:55a:1e:b4dd with SMTP id w7-20020a817b07000000b0055a001eb4ddmr17770033ywc.48.1684960433780;
 Wed, 24 May 2023 13:33:53 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 May 2023 16:33:43 -0400
Message-ID: <CAHC9VhTo0LnHwfnF1kfNcosUDdB=MtBQePemR+ju81_GFSuGiA@mail.gmail.com>
Subject: ANN: SELinux repository changes
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

On behalf of all the various SELinux maintainers and myself, I wanted
to provide a quick update on some changes that occurred today to the
SELinux Project repositories hosted on GitHub.

* https://github.com/SELinuxProject

The first, and most noticeable change, is all of the repositories have
now changed their default branch from "master" to "main".  In order to
minimize the immediate impact of the change, the "master" branch has
been preserved and locked; this should allow existing automations to
continue to function, but be warned that any new commits/PRs will be
merged into "main".  You can expect the "master" branches to be
removed at a later date.  For those of you with local repository
clones, you can update your repo with the following commands:

  (assuming your GitHub remote is named "origin", and you are in your
"master" branch)
  % git remote update origin
  % git branch -m main
  % git branch -u origin/main main

The commands will pull in the new remote branch definition, rename
your current "master" branch to "main", and set the current local
"main" branch to pull from the remote "origin/main" branch.

The second, and long overdue, change was to archive the CIL
repository.  With CIL development moving to the main SELinux userspace
repository, and no new commits in over nine years, it was time to
deprecate the old CIL repository.

-- 
paul-moore.com
