Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C922C25B47
	for <selinux@archiver.kernel.org>; Wed, 25 Oct 2023 16:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJYQ5D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJYQ5C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Oct 2023 12:57:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2622132
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 09:57:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079f6efd64so8206976e87.2
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698253018; x=1698857818; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aWjE83/X5MkFdkKrsN4ujKlP1sGWfTkuGP0AIlO2VoA=;
        b=fYEi58TkJxB6nn+KXGlRMPAZ3V+EsFlFdFbYrftaiYwKkKjNkzTf2VxowQ+qBqdtJm
         rl6kH1wOJamGPg1JgDh8f1tVevvQagnowuiI0SceTpsDwGqciUD1GZnzt3DFk0J72vmd
         raaNwriYATLq+88139qABVAHpAqjQul6R3oHCGJALlZ8brdxWYeC3X+TtP0eyFMHjXFs
         8bJH/LtKey7rpa6J7j+oSQbO0KowdkmPIDEGwO1/vECreLTMFhWpbN7lAc0flKW/WFHG
         d4YhpT+84jf8spxCvn4CGi5y351mj5QG27nQ01rX+p6XMrMjt0p9xTQkRauHxsvaOokC
         zDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698253018; x=1698857818;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWjE83/X5MkFdkKrsN4ujKlP1sGWfTkuGP0AIlO2VoA=;
        b=pSE9PsuYGi159yRJiDVYeoQA+oFLUYoVa0GcWEhmL9MlIQ5nxgnxizd4DvtmtxrSKI
         /eDvFc7poibSGDEBe/DpcaZwHJAf5gn3er+LYBd/evGwXFtspr+H4SCy71/P9jlj2fxU
         zUTzaOQEty7/l+nO+OhPLQucqOy7W+4c8CuUWR6sv9b0A9CUmoS+VxCZTif/0eVBeyuI
         KnWVJSTIeJ/pq/bAL7HSdf8sQtS2LubeSyYY3+f3tVc0iLT4AziXVAznOSk5fClWyLGg
         ShLAPZwHWn+RkdsVDMEAPHzbHYcze15DLTy4Erg7MfjFBOvDEHzXny9hU62V9KY3ISSX
         4NbA==
X-Gm-Message-State: AOJu0YwL2RJIWSaLA5c+1YYa95g7dSl8MmauULyggFvUldpwoUCPNguK
        uRn7bmMUvLBgOVWyFrRk0vGKn5eH7QyAk6JHhcC+yoXN
X-Google-Smtp-Source: AGHT+IGys8mQruwlLWC3/hJuENe4kh3RDRE8lcTUdcD4VMQxMH22FrxmG2kxay1ZQPcF5q33I7bGKZPNzMyL9HAI4Zg=
X-Received: by 2002:a05:6512:239c:b0:508:1889:bfc0 with SMTP id
 c28-20020a056512239c00b005081889bfc0mr2005484lfv.5.1698253018146; Wed, 25 Oct
 2023 09:56:58 -0700 (PDT)
MIME-Version: 1.0
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 25 Oct 2023 12:56:46 -0400
Message-ID: <CAP+JOzRpR7d3ssMqbcFXT6ZLVMfkRyaSMzjf4dPiLhzHJorHgg@mail.gmail.com>
Subject: SELinux Userspace Release?
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The last release was on February 23rd, it seems like we should do
another release before the end of the year.

Thoughts?

Jim
