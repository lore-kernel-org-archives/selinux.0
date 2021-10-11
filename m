Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D6DC433FE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 08:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2E260EB1
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 08:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhJKI15 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234910AbhJKI15 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 04:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633940757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPIDn6jZ4xcKU3yErhqkhpAbDMT4kGrK2fHigOjqNqk=;
        b=DIRi0AqnlUhQQVDgriKJrjX6JkBBW2WsXr5ZalhSTT+NAbVbkNqBVbZB9JEv4mPyBlWva7
        xTwKOyFopVwvVKemHLp3ET67z5zXlztU/+d6k4BpD63BJvYC1vIUq4rcffUn2SaAUsyJrZ
        c9AWAVfrMF7n+6G5o1ycPQszTN4LD9k=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-CWN5olSiNZ2WNRz2xe_Aeg-1; Mon, 11 Oct 2021 04:25:56 -0400
X-MC-Unique: CWN5olSiNZ2WNRz2xe_Aeg-1
Received: by mail-yb1-f199.google.com with SMTP id p8-20020a056902114800b005bad2571fbeso10927137ybu.23
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 01:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPIDn6jZ4xcKU3yErhqkhpAbDMT4kGrK2fHigOjqNqk=;
        b=Pp5CVo4CbX5h6hhE5RK7uYTiNN5s3fp34Elf2YehHIRqqBg/mAkSLex5IpIDuYliMa
         xyGahcVg2cD3yqnFmnjvXKmJYXdMeVqP1cOfJTryGvHRth151WEaPciSkYZWR341ngBT
         OUFCUJst9OxVVmcglPBEnKEyT4JYXR2fEK9WOl09z6kEVcU7SYGk3zMx9vWlCicRHnzV
         mWb3NOwupsWqocVkVQ/OsUkMmiZm2K2zD6VOVxnwArevUCu0RQnb3w0hw99cdAbjcfl8
         1XbvUW4LMuzKN2NB18K6rd93GTXQ9Nt+HpXJ7d1kG+aqek6he9olvR4RECNH612LgRWU
         eywA==
X-Gm-Message-State: AOAM533Q/y2ObjCMKD5WDqf8QzGyJ+nCHpwyyyxrh2m1GiQ2xl1eQqXC
        wKX7aOCINfX7yloJ0n2Mxf47sa6K+cAXviOz5g1nwiBSQz/MDs13avE/lhXuAb8EgbEmKOQYCd+
        X2oRwJmF68GqPWKYmd0k0QAqFMHbb5wEB/w==
X-Received: by 2002:a25:e650:: with SMTP id d77mr20741305ybh.256.1633940755630;
        Mon, 11 Oct 2021 01:25:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJTAi4Z0o58EbzREqFbZm2UUnUA7fJpAuvm1bjyaeutp6cihN4K6AG1bOHkTTnjPexupVkQ+HgW6rn7RZPV/8=
X-Received: by 2002:a25:e650:: with SMTP id d77mr20741291ybh.256.1633940755405;
 Mon, 11 Oct 2021 01:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210728140313.68096-1-omosnace@redhat.com> <CAHC9VhTDagTt1CKDRPkVrcvHwWPbSzzPp3HSS3ZzsbLapTBAxw@mail.gmail.com>
 <CAFqZXNuT=-m2QVgw+Awm3HcK5pt8niKb+yu2Tspy2RCsLByrWQ@mail.gmail.com>
 <CAHC9VhT6YcAWn4KrsfjpJQGDetEVy7LNh8DsrMrycW8y57Y20Q@mail.gmail.com> <CAHC9VhQF9R76ojBBrAQ=WHOAgHNGKJDobY+a_qohJJCQWQDw4w@mail.gmail.com>
In-Reply-To: <CAHC9VhQF9R76ojBBrAQ=WHOAgHNGKJDobY+a_qohJJCQWQDw4w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 11 Oct 2021 10:25:44 +0200
Message-ID: <CAFqZXNs_hU_r6uxiUiWPGiYhJ5EzdxMWWwtbp-ZPMfaZ1rTNCg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race condition when computing ocontext SIDs
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Sujithra Periasamy <sujithra@google.com>,
        Xinjie Zheng <xinjie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 7, 2021 at 5:34 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Aug 16, 2021 at 4:38 PM Paul Moore <paul@paul-moore.com> wrote:
> > Please try to come up with a better solution that leverages proper
> > locking primitives, and if that isn't possible please explain (in
> > detail) why.
>
> It's been a little while so I wanted to check the status of this ...
> have you spent any time on this, or is your position such that this is
> the best you can come up with for a fix?

Sorry, I had to put this on the "let me get back to this later" list
because of other priorities and didn't get to pop it out of that list
yet :/ I haven't yet looked at other alternatives.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

