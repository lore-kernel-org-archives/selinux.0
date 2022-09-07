Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2646AC54EE9
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 20:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIGUTS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIGUTM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 16:19:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC068C12C7
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 13:19:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fg1so10863262ejc.2
        for <selinux@vger.kernel.org>; Wed, 07 Sep 2022 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=glF9Wd/uocdMUVOO/byKq2ElDfR2TN3KnkGRWhMghb0=;
        b=CeI1SE/kwCmNs6+rg2ZcplgUu2AcIbO64nSnsKstU+DpIe8rf6aN1No5X0R+QU7mh2
         qK2bugH2TRfF0pl/1QjDEDYynR+zdZpMYuiAR7MbR4vWtDC0OTUCj0brqtgGnNe41qro
         wUOK9HYZ2UMbudwS6lsUe9PtamU1uLZLb/IPq0w6ECrSzU5ry0CbXbs3SX7zsSf1i4+T
         lX3GGlGpeW1eXfROf1UwVTRPJ4Y6oYVjoNmiVqzkmPmtyLhig0c+gBZD/EUAH3KioPsY
         YH2ofj27sXlNh/yH1T2tvlF+QTf8ORpPwiqUtb9mmqqvcS1dBA34iLai35OyhihwFZ09
         bXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=glF9Wd/uocdMUVOO/byKq2ElDfR2TN3KnkGRWhMghb0=;
        b=Umlit6xk/NFEAzvyMPRUpWfHmaKiov993aVZTUeJNACSlPs5DdEojnBg88rjZXpsVs
         e9DzxPozoBoJoZTueJvMfA9xekNWeVydZZMU5clexObfGA7aEqq2K1LundRY0Rdpcwci
         7Y4EJlA9mSSBpLp1O3aVLaapM/ku9lHRyU7GV0f4DGhGrWTEf/7u5O0KoVVXT97SvvFk
         zjdb+OKs/57xxEj0wR35jNcoV6M6sQyGYFODgJv8d2OJb8PMIXoFxpxud2yoVLSFJCdO
         Drh9iX2FWOQ+tFItQAPAYEoKj5EFBljS1Nn0CIjogtp36NTrwevE7JbDIxG6BPkAnROi
         fF2w==
X-Gm-Message-State: ACgBeo2GmIK0KbDdTMvr0hLYg/im1oQmH+0h3BfCzh1Hval6HGPLCgmA
        H+D3PtQNt9gVUoo2HyzkVb1qLHl3SJu5ZthWIlbrmt9G
X-Google-Smtp-Source: AA6agR4QMpx2NSVLSFMwcGZEo6lkcSYNB49eTAfeEK0G+Bvsb//NlvIIIc01NGrOEv7z6ZtIzdiDh9/IDdedcT6nLhw=
X-Received: by 2002:a17:906:6a0b:b0:76f:a2e:10fc with SMTP id
 qw11-20020a1709066a0b00b0076f0a2e10fcmr3548036ejc.521.1662581947118; Wed, 07
 Sep 2022 13:19:07 -0700 (PDT)
MIME-Version: 1.0
From:   Ted Toth <txtoth@gmail.com>
Date:   Wed, 7 Sep 2022 15:18:55 -0500
Message-ID: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
Subject: context of socket passed between processes
To:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

systemd uses a helper process (sd-listen) to create sockets and pass
their fds back to its parent. I've patched systemd to call semanage to
get the context for the port if it exists and create a context using
the returned type when calling setsockcreatecon. Everything looks
right i.e. the port type is retrieved, the context is created and
setsockcreatecon is called without errors. However 'netstat -Z' shows
the listening sockets type as init_t and not the type in the
setsockcreatecon call, is this the expected behavior? Can anyone help
me understand why this is happening?

Ted
