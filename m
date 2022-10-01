Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335F9C433FE
	for <selinux@archiver.kernel.org>; Sat,  1 Oct 2022 02:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiJACrc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Sep 2022 22:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJACra (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Sep 2022 22:47:30 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1D12AED3
        for <selinux@vger.kernel.org>; Fri, 30 Sep 2022 19:47:28 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id n83so6524162oif.11
        for <selinux@vger.kernel.org>; Fri, 30 Sep 2022 19:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=8tTe0Y0pbklxCbqDYU8nHJOSAp0YVZarAmz29qRaY3g=;
        b=h51xSBFSCD5qvHIv58T3BfyHFfzWYdCpLXLGoR/3yX+m0JyRZgYgBmEvHc6gGcS3xa
         6HaD1MOaJv/VxjE59eoMIctHDNfB28hpIcz3N0UBR8reuTmWRqgy3qLLgEVNR9M6jpT+
         gHDdjglOWz+ZzqfWa0GUoyoUxQxrSU3PAeUetBfxt/eM8IBHlRpWwq4ot7XgqmKHcVfl
         Jf2KUQHkjI0UcDmCGxnUlKfys3/xMaySlQhrP1zYjXuBSzKx5VVHCaxefLI1JnCJVnZg
         btzuTMPO6gxZMcdVH4VBvrDXteOHS1gL2mnoMMPhQq/bZGRDv+u78woETSF5Ad8utYp6
         X5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=8tTe0Y0pbklxCbqDYU8nHJOSAp0YVZarAmz29qRaY3g=;
        b=v5ZFshoSwbkbSgnF/I5zvD8/ecDUowbkI++s3UPiVdTcyvCeV/o1fM8hmxkfJJHBDW
         xlY2monqNhS+BjP7bnk1rZKf88sg9z8av88W4qf0RLM2R5ZbeRA/AOuuY9vsGV1H2h9B
         8z1WfdSwqUC4DkvxVci8qFxpj4USsbM5vhqZI19R4dN6KG1elmyt8QotRrYfq9pkq8sx
         8NT0Uey6Wk0qIJSHA+xWjw3rt7OYuKhwm7IEjVTqgpfwLiDsea6QtaqdyEei3GWntF1/
         A2lScx2eyZsu2RMhtxyUvLjgR3f01mBtdnSsDXABsG8bY9iYYu/Q5vQKwyUoPSAOzTKK
         kLaw==
X-Gm-Message-State: ACrzQf0uhlsjHW1JoJSON/7JfDIC9ARaH4bDWGy3XVeQEYI3jFaOPw6h
        uIYohphcWmdZjSWgfgx1j2C+x2TJtzcRuotn79X3YU5J9gOt
X-Google-Smtp-Source: AMsMyM7DYlZGwIcR+q2EGD5hlZ9jZuvJYm9eyX2KYTYUC8MDUa8TL9RlUWkMqYu2go+exRBwTMihoV9Z3V0e0WUAYDU=
X-Received: by 2002:aca:1c13:0:b0:350:ce21:a022 with SMTP id
 c19-20020aca1c13000000b00350ce21a022mr444153oic.172.1664592447327; Fri, 30
 Sep 2022 19:47:27 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Sep 2022 22:47:16 -0400
Message-ID: <CAHC9VhRNJjzGSbQgcTeP=GcUyAHTn__KDz-r02zSs-xcQFO-gg@mail.gmail.com>
Subject: [PATCH] docs: provide a top level LICENSE file
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Okay, so this email isn't really a patch, but it does point to one :)

* https://github.com/SELinuxProject/selinux/pull/370

While the PR referenced above is quite large, too large for email in
fact, it is that size because of the number of renamed files
(COPYING->LICENSE).  The only new addition, a top level LICENSE file,
is quite small.

Please review and merge into the SELinux userspace repo.

-- 
paul-moore.com
