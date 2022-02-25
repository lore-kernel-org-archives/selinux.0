Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E16C433EF
	for <selinux@archiver.kernel.org>; Fri, 25 Feb 2022 02:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiBYC7L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 21:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiBYC7K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 21:59:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01B731F03A4
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 18:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645757919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CauoURgUZ4v50QCANyExBUMWNUuGIGlFYqjgg6YLGL0=;
        b=DFTtIq8lrmgUXhU1EZ6px9SNO+EeSGsVBYnqr7/hQBYS3a960WEv4f9MTz6aEHCWlHt6jU
        tdR86WkPYy7TC/qJFG+o61dI18vdret/G7COICNVtsuw9/Gp6weff1W/CeKYHlZU5F5aEi
        582VAzJIcugUQ0888Z2gXNqyR3Y84UA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-9KiPuduhNoGkDQTcqavK1g-1; Thu, 24 Feb 2022 21:58:37 -0500
X-MC-Unique: 9KiPuduhNoGkDQTcqavK1g-1
Received: by mail-pj1-f71.google.com with SMTP id g19-20020a17090a579300b001b9d80f3714so2484777pji.7
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 18:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CauoURgUZ4v50QCANyExBUMWNUuGIGlFYqjgg6YLGL0=;
        b=mDPWV5r4frQW2F6pQnSbyjLICKxfeEMlSLoRaurW3rmPiVj79YR7lttlzVxs/PL73Z
         EQBCy+Tnlwfa90wdwgyLRNQxUwH0GX+iTfdYL4aM/9RAXOK41pjmt/cAXN+Ml/HssSxC
         75U2jOFFmulYp1GYbkS4Hn0Qbo+mYjBb9OGoAWFP+h/Cz8N9GhARlglCk/POzae3YHA4
         yl+ER4EieWLuo5aUSZgXjF83TG8Sv/KaUQOH75IrkzNgf1fP2PnuKBJ00zWE9OjsuXxN
         IptbjPO9CP11iQ0pMFB6YLGCvTZl6wWvrODpC4TmS8zBc2I5e8pH5Hq/W5ueFV+WUM/G
         aFxQ==
X-Gm-Message-State: AOAM530ezj7Q9DNOVIaiBr+mfPQh6T55UiuUA+Ee8IxabOY/iMXxPGQx
        QH1rW2b1vxKvE/1XH/YuK+XPtJzsOtStBabHV+uhxDchJAiudhjf8snXDnoFLiWzGbyPZqguooL
        CeJgqddufEDhNObq1Qw==
X-Received: by 2002:a17:903:244a:b0:150:25d1:d2ff with SMTP id l10-20020a170903244a00b0015025d1d2ffmr1997049pls.70.1645757916654;
        Thu, 24 Feb 2022 18:58:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOGBViVIjSEs20HiGON+uKIVzSeyomY20qDxZXbhJhU+z/NsaHHhe2vINl/rCk0vkgrzDJ8Q==
X-Received: by 2002:a17:903:244a:b0:150:25d1:d2ff with SMTP id l10-20020a170903244a00b0015025d1d2ffmr1997024pls.70.1645757916338;
        Thu, 24 Feb 2022 18:58:36 -0800 (PST)
Received: from xz-m1.local ([94.177.118.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm891513pfh.83.2022.02.24.18.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:58:35 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:58:26 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH] userfaultfd, capability: introduce CAP_USERFAULTFD
Message-ID: <YhhF0jEeytTO32yt@xz-m1.local>
References: <20220224181953.1030665-1-axelrasmussen@google.com>
 <fd265bb6-d9be-c8a3-50a9-4e3bf048c0ef@schaufler-ca.com>
 <CAJHvVcgbCL7+4bBZ_5biLKfjmz_DKNBV8H6NxcLcFrw9Fbu7mw@mail.gmail.com>
 <0f74f1e4-6374-0e00-c5cb-04eba37e4ee3@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f74f1e4-6374-0e00-c5cb-04eba37e4ee3@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 24, 2022 at 04:39:44PM -0800, Casey Schaufler wrote:
> What I'd want to see is multiple users where the use of CAP_USERFAULTD
> is independent of the use of CAP_SYS_PTRACE. That is, the programs would
> never require CAP_SYS_PTRACE. There should be demonstrated real value.
> Not just that a compromised program with CAP_SYS_PTRACE can do bad things,
> but that the programs with CAP_USERFAULTDD are somehow susceptible to
> being exploited to doing those bad things. Hypothetical users are just
> that, and often don't materialize.

I kind of have the same question indeed..

The use case we're talking about is VM migration, and the in-question
subject is literally the migration process or thread.  Isn't that a trusted
piece of software already?

Then the question is why the extra capability (in CAP_PTRACE but not in
CAP_UFFD) could bring much risk to the system.  Axel, did I miss something
important?

Thanks,

-- 
Peter Xu

