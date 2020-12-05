Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC8DC18E57
	for <selinux@archiver.kernel.org>; Sat,  5 Dec 2020 19:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BB523110
	for <selinux@archiver.kernel.org>; Sat,  5 Dec 2020 19:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLETUM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbgLETUJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Dec 2020 14:20:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF718C0613D1
        for <selinux@vger.kernel.org>; Sat,  5 Dec 2020 11:19:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a3so9952378wmb.5
        for <selinux@vger.kernel.org>; Sat, 05 Dec 2020 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=vKYNJyYVXyF+nBGPgTZpNTlAvnr8n0UKXsJiKrwDjwg=;
        b=VaTAeXQawjlBUiDqEpCEbwU3QJ4Vi+Dbxk2+KB8PcFkQIj990SEDBdTbuArp2uCbt6
         S4PBFP/3TyE/p9ZSHHs1suWac4uTOMqEheFmbL5zWHWd39nGi6usYW/MfVKfntsvT915
         f/ZH6sECfX+OHUYNA4INVfdV6rIT5g58saa4bwhl0raBAfEW9d6ESg7DQToYYl2IKvlT
         nGYPBFqauVpQ+QMDBt7A6wJLwcpIp18SuWaKQmPJvfKhAXWSckv5uMR5pGK9vqEmGCmE
         /hy+9tC4up6GYQVPpQaAaGVd1aY/6qreIT4Kh64/FtaOr+Y6Jr4Jj5UIgZLff1lfsrjt
         Y3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vKYNJyYVXyF+nBGPgTZpNTlAvnr8n0UKXsJiKrwDjwg=;
        b=L4AJMM/7Wwq5zEM/ZDPvGmLlucjYVqrbcgIfYwDgmvubfuOMb2pfaVOxHiUuE6jNuo
         wKIbs1nBeOvXwlVrUln/8PJiWyGjSnHiedQ8yBfbax4AUy9OgvHv0L5GgaPkO+kudGzM
         BZ1SJfa1OmDQj2iK9GO8xWRb9l9wzzHBHlXKnKIgJ4HFtgqbkqQFnvReRwlYFaz7lVMT
         myF5C6+PUS1bNtjbAiujJwhRX+tNvbDe/+awMRhowsKDMFmvUGTbafS6TWB8SH5Cpi1H
         +55ir5F59+YSmMDnuYTAnzHysIJcdUBc/oUKbr2nUBPzbQjQWqowJCrkvVdfxMWMYisr
         vRXA==
X-Gm-Message-State: AOAM5323cAAoq0YkkhfXfwdnBMq4pTuyXfWdBP923I9bjL8k0Uhbe3A1
        frdgyTMf+lIxwXlKMshh+3DrLUhhmPBpfDr8+UnY5w==
X-Google-Smtp-Source: ABdhPJzn9iQwsxL40pE/JEeO6iswAwY/4UokEX+VVT5nm7f9dQsDMsciOEGlIKQ4SAO6CoVJQZEmiNqjnIx42WgBWqA=
X-Received: by 2002:a1c:e342:: with SMTP id a63mr10756072wmh.64.1607195965308;
 Sat, 05 Dec 2020 11:19:25 -0800 (PST)
MIME-Version: 1.0
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Sun, 6 Dec 2020 00:49:14 +0530
Message-ID: <CAP2OjcjCFYiyMfqa=X__X6g0U0143U5Fd-xGaKJgGNabFUpr7w@mail.gmail.com>
Subject: How is policy.31 created from modules under /usr/share/selinux
To:     selinux-refpolicy@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi All  ,

Good Morning .

I am following the SELINUX NOTEBOOK & trying the same at my end .

- The refpolicy modules are copied at /usr/share/selinux/refpolicy
   i can see around 400+ modules there .
   But can senior member' s please help me understand how is the
   /etc/selinux/refpolicy/policy/policy.31  created using the modules
available at
   /usr/share/selinux
   The command i followed :
                $ make install-src
                $ make conf
                $ make load ( tried even $ make install )
                $ make install-headers


- This can help me to debug an issue where i am trying to get selinux
of my custom
   distro where all the make command are successfully executed but the policy.31
   is not getting created

- I can even see the "include" folder also getting created for make
install-headers

Any pointers will be helpful or please let me know if i am missing any
aspect here .

Thanks ,
Ashish.
