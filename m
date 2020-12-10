Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695DFC4361B
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 02:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E70D23C40
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 02:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgLJCYf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLJCYf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Dec 2020 21:24:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D82C0613CF
        for <selinux@vger.kernel.org>; Wed,  9 Dec 2020 18:23:55 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f23so5153417ejk.2
        for <selinux@vger.kernel.org>; Wed, 09 Dec 2020 18:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=oyW3yYiwwD3vPgcT/tMBDZelcO3WB69dUjevN0fFZFw=;
        b=zMozSb6vzayNYoF3jtSHD6L3Z6OG4qIDLbAgWlKHurwSFMXrYsYUM5WDbxkLBrdyaL
         24I6V7zOMXL0yDQmvMhgoRbAbR8pMAZy7GUznO7ohPhAEsYyGVVE31K3EKGao4AUCiMq
         UNCsN/OQ+w/SuoVaRNbrOwrlBtWsLPP2sdDSkSKlOje+Xzs13+PsVPqk/10grxJsZKti
         BwGERUSlAHuxHIMNp1G5KzkHGUVT6Cyv8ri+pYziNCFXJTIJJbvoICyfbvRiEGanhtg9
         G+Ub+xq8nL5Ma25dW0hENX9Gl+u41wQoiya7GbC5uK0FWgq78nZrtZBsUM47HusoqqRC
         YW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oyW3yYiwwD3vPgcT/tMBDZelcO3WB69dUjevN0fFZFw=;
        b=XhEUQKHDI4amlLP3p2uecVvy+Tt5za0n52xfLtnhwp1T6pRNoUhFWkGXkfil0dqf5y
         7Wgwvv9XrVLO9r0ViTOaSOgg3wCpwZMuI5O/i9NL2YG26QTbYQj2KgyGkCkWWk/KfmWU
         huxw+DFKmotOnY2dhULjhexDGoKORocysn51EK/k/R+3srdfbZC46HDK+P1YlGfCWUpp
         bsZPqpyNMy3gAb/pwHRXkrSvT48Qol+RhWk/EgtiJ7UtHHVvwpSIqBhZKalT8EgpLRYH
         tjcKuq/SFEO2TqHrPqSIdBaVbVHwW7/jAbvby72LPnF9TQ1BJx95G6KuxR3IEf2douBk
         KQbQ==
X-Gm-Message-State: AOAM530EoVGWp5KbSqko60IRkfKpxb0q1kU/NONEg89imYg3ESP2XwUZ
        uZ3kNb7b9CHBdchndbhO49TdgzL3fuhQOvl/rsgJK9uFdLiB
X-Google-Smtp-Source: ABdhPJznIE/388wgE7WneWr+rRQHSnh/m9XF+XEDP8n588P7v72rn3RQ7G+7nJWg/n7iLXkjdfONmWE1tHtd+X+Cb2E=
X-Received: by 2002:a17:906:1393:: with SMTP id f19mr4461193ejc.431.1607567033391;
 Wed, 09 Dec 2020 18:23:53 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Dec 2020 21:23:42 -0500
Message-ID: <CAHC9VhSRBDwnz6ewVKDYv77oPW=ddKge6UVe66+cV_ZS63PsLA@mail.gmail.com>
Subject: New release of The SELinux Notebook (20201209)
To:     selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

I just made a new release of "The SELinux Notebook", originally by
Richard Haines but now updated with community contributions.  We have
over 100 commits and six new contributors since the original release
on GitHub - thank you!

* https://github.com/SELinuxProject/selinux-notebook

-- 
paul moore
www.paul-moore.com
