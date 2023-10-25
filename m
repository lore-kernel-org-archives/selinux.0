Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39352C07545
	for <selinux@archiver.kernel.org>; Wed, 25 Oct 2023 17:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJYRH4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 13:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjJYRHz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Oct 2023 13:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFAF132
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698253635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q44DgZ13alDBCwh+CF+qo4ac5iqbhmGnbgMKNEIvceU=;
        b=bip8104/UGZ3qeuMfrfIXiGMsiuWtueNAlru//1qo3VcFoHDW/LXg67VZw40tJLKY8V45J
        G+XOIfaIpMv+QOQRP7PdwZpfvsO9SLsGTLvI9DTf7DzeV+PUiBjNNKFzlgYA5M9G+p5k5j
        EB4xmzTHe/ktobmYzuj2G+IKAmmW/Eo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-ksvRUQ4POpaPMmqmcwKsmQ-1; Wed, 25 Oct 2023 13:07:11 -0400
X-MC-Unique: ksvRUQ4POpaPMmqmcwKsmQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BF47810674;
        Wed, 25 Oct 2023 17:07:10 +0000 (UTC)
Received: from localhost (unknown [10.45.225.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AE35492BE9;
        Wed, 25 Oct 2023 17:07:10 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: SELinux Userspace Release?
In-Reply-To: <CAP+JOzRpR7d3ssMqbcFXT6ZLVMfkRyaSMzjf4dPiLhzHJorHgg@mail.gmail.com>
References: <CAP+JOzRpR7d3ssMqbcFXT6ZLVMfkRyaSMzjf4dPiLhzHJorHgg@mail.gmail.com>
Date:   Wed, 25 Oct 2023 19:07:09 +0200
Message-ID: <87v8auhbr6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> The last release was on February 23rd, it seems like we should do
> another release before the end of the year.
>
> Thoughts?
>
> Jim


Yes, please.

I'll be offline until end of the week. I could start collecting
necessary data and announce the intent during next week. Or if Jason
want to manage it again, I'm fine with it as well.

Thanks,

Petr

