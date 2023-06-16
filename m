Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6706EB64D8
	for <selinux@archiver.kernel.org>; Fri, 16 Jun 2023 05:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFPFoT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Jun 2023 01:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjFPFoT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Jun 2023 01:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82208123
        for <selinux@vger.kernel.org>; Thu, 15 Jun 2023 22:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686894212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bW+e6H/DTEN8UNhvPywJwaMdGD4jgcUzw/Lz558z0qc=;
        b=bmrQytco8B5MrVw8HOvNGp3eFBaXXyWRwagSMLYVOmVFgqRR2SBCu8jT9Lv9SpKJ1wnton
        +5NORd4GBKV917jYK7WlPePmbP5QrRcC3W7DNeANpWlh1HYoNx8vLcfVL9n5WB5KgSYDVc
        5NlwIOLBhkBhxDGr1OYJdX3LS+PHV60=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-Bn5NCHZoN-mknGzBhRFLZA-1; Fri, 16 Jun 2023 01:43:28 -0400
X-MC-Unique: Bn5NCHZoN-mknGzBhRFLZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C69E85A5BB;
        Fri, 16 Jun 2023 05:43:28 +0000 (UTC)
Received: from localhost (unknown [10.45.224.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F35121415102;
        Fri, 16 Jun 2023 05:43:27 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Cc:     Lennart Poettering <lennart@poettering.net>
Subject: Re: SELinux and systemd integration
In-Reply-To: <CAHC9VhRAXQyzG7OsgXQfWT09qEFQRmeN2foGLGnU8cHdRKePUA@mail.gmail.com>
References: <CAHC9VhRAXQyzG7OsgXQfWT09qEFQRmeN2foGLGnU8cHdRKePUA@mail.gmail.com>
Date:   Fri, 16 Jun 2023 07:43:27 +0200
Message-ID: <87r0qcotc0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> Hello all,
>
> Amongst Christian's various other SELinux contributions, over the past
> several years Christian has been working on improving the SELinux
> integration in systemd.  One of the things that Christian has been
> working on is revamping the SELinux permissions that systemd uses for
> unitfile operations, both to resolve problems and generally improve
> the mapping of permissions to systemd operations.  As this work has
> been languishing for several years, I would like to see if we can get
> things "unstuck" by proposing two things:
>
> 1. I've provided links to the systemd GH PRs below, but I think it
> might be helpful if Christian could provide a quick summary of the new
> permissions, how they map to systemd operations, and how they map to
> the existing SELinux/systemd permissions with a focus on helping
> policy developers migrate existing SELinux policies.
>
> 2. Given the significance of systemd to modern Linux distributions, I
> think it might be a good idea if we selected a SELinux "liaison" for
> the systemd project.  This person, or group of people, would work with
> the systemd folks to keep the SELinux integration in good working
> order, review systemd code as necessary, and help represent the
> SELinux project within systemd.
>
> How does that sound to everyone?  If we are in agreement on #2, and
> assuming he would be willing to help out, I would like to nominate
> Christian as our SELinux liaison to systemd; any objections?  Anyone
> else interested in helping out?

I agree with the Christian's nomination.

As for #1, I looked on both, but I have to admit that I had a lack of
understanding of the problem and so I would need some time to get
into it. Therefore I postponed it due to other priorities, (but never
come back). If it's still open I'll focus on it next week.


> For reference, Christian's systemd PRs on GH:
> * https://github.com/systemd/systemd/pull/10023
> * https://github.com/systemd/systemd/pull/20387
>

Thanks,

Petr

