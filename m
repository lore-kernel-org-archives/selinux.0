Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D4C433EF
	for <selinux@archiver.kernel.org>; Thu,  7 Oct 2021 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0685A6113E
	for <selinux@archiver.kernel.org>; Thu,  7 Oct 2021 15:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhJGPg3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Oct 2021 11:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJGPg2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Oct 2021 11:36:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A64C061570
        for <selinux@vger.kernel.org>; Thu,  7 Oct 2021 08:34:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l7so24772747edq.3
        for <selinux@vger.kernel.org>; Thu, 07 Oct 2021 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30JNIa4RlokMYXSVP5L6GtMmeCNwMX56FXAsRya7W3Y=;
        b=G0/H4dTaPug2FHRNe4cauETexoqEHUZOCKYPe5TJ8isY7yL7ddD/5Kn9w1Il3cDS6K
         hQdRPjXvD01qzYvcp12nYQ3y5m90+oBvysHw7CDgWNaCyo/CBshytkzEdwanAAkGnoWI
         fch5DnQ3P08aOvAF3KBBkWXHq8zm0mYHe9tGuA8KFUQjo5riQAPRucPY0SoGSITON9KJ
         VFxRBVrsy1drt+VTRKtrXQlUYWZh6NO3r7shIrYkWq2w1vrIRzOHax/tVus1RIrFL47v
         A1id3QpQ3dEF24qvtN7pI/x8U4Mhn/EF1ENjINlV4z5d/HMTBq3mRrhUn5YDn2U3J8ve
         mkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30JNIa4RlokMYXSVP5L6GtMmeCNwMX56FXAsRya7W3Y=;
        b=NWRpUpMrJOEPMHOwds3jLHHaEy/MIf8ZtYORB3rxoWR3s4mLzPfAZVM5oKq2oXtZSQ
         pITPy8sGTrFMnlPK/jBcU4foWpwpKlpJlcXaw00hkLfBfjCc/P7KLyEhOwhdXT2ZIBdB
         c05RlSIsP5DuBn5OMUO/DU1H+3t8xE9YGY+XpXeAMFI5/RI/cph42RcPTqKgvZMKMTV2
         ZoUSJDYymzdt9sW9bBLeTPpEqkbJg/28A5Z/tusv2FgXI0in7qz8q6EAbvlx21gBrgUF
         BfO1LSqXHonUtvTh6ALt1wWpxprss039hkpmu9RAEnzTNEb2po39Nl+q/dk1YprPY0TZ
         9dJw==
X-Gm-Message-State: AOAM532qdB7+Cgp+xYsWEcRTWwrW24xlxoFGTe5z/CDJhaBLxVgILoIp
        pkVDQAKmeEgPbVMrht/u6UwOP4Zr5Eic3LCZutWROsSm7g==
X-Google-Smtp-Source: ABdhPJz7IPBm/0Srv9g2vOg1YL/Hoa2LXQilekjg13BL3eDHwKqpgczTSSfEZlM5JM7A1oaUmccIZrlsqSwPd96L+1s=
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr6250586eji.126.1633620870949;
 Thu, 07 Oct 2021 08:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210728140313.68096-1-omosnace@redhat.com> <CAHC9VhTDagTt1CKDRPkVrcvHwWPbSzzPp3HSS3ZzsbLapTBAxw@mail.gmail.com>
 <CAFqZXNuT=-m2QVgw+Awm3HcK5pt8niKb+yu2Tspy2RCsLByrWQ@mail.gmail.com> <CAHC9VhT6YcAWn4KrsfjpJQGDetEVy7LNh8DsrMrycW8y57Y20Q@mail.gmail.com>
In-Reply-To: <CAHC9VhT6YcAWn4KrsfjpJQGDetEVy7LNh8DsrMrycW8y57Y20Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Oct 2021 11:34:21 -0400
Message-ID: <CAHC9VhQF9R76ojBBrAQ=WHOAgHNGKJDobY+a_qohJJCQWQDw4w@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race condition when computing ocontext SIDs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Sujithra Periasamy <sujithra@google.com>,
        Xinjie Zheng <xinjie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 16, 2021 at 4:38 PM Paul Moore <paul@paul-moore.com> wrote:
> Please try to come up with a better solution that leverages proper
> locking primitives, and if that isn't possible please explain (in
> detail) why.

It's been a little while so I wanted to check the status of this ...
have you spent any time on this, or is your position such that this is
the best you can come up with for a fix?

-- 
paul moore
www.paul-moore.com
