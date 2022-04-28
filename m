Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8522C433EF
	for <selinux@archiver.kernel.org>; Thu, 28 Apr 2022 09:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiD1JuF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Apr 2022 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349106AbiD1JoE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Apr 2022 05:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74FA098F5F
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651138849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=icLwfjLes+vf1PUAu7h9TpoMnoj5kVg31I/cvzuVTss=;
        b=JEvyyONQKqaFR1ST0BxCwRI1YxCBfjfvYNO6XXkc+hP8BWKNQxb1VvaOqAMst+kNqq9VPA
        yiCANvQfoFMiOc2Q5bMJt90HhGf9MoPjWxUkjOFB78QoLG5o2XLhmTV3hOjaAi3lux3Pe6
        7u+EwYMTu3XTUwABEQ8AeWVS1HSTFTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-y8SaCFa7NxaD66xrtssXYg-1; Thu, 28 Apr 2022 05:40:48 -0400
X-MC-Unique: y8SaCFa7NxaD66xrtssXYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBF4A833961
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 09:40:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25F249E6D;
        Thu, 28 Apr 2022 09:40:44 +0000 (UTC)
Subject: Re: [PATCH for-3.5 0/5] selinux_restorecon(3), setfiles(8): skip
 relabeling errors
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     SELinux List <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20220428065354.27605-1-lersek@redhat.com>
 <20220428092251.GJ1127@redhat.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <cdf16622-c2c9-9e63-e60c-ef5f3e6e2a63@redhat.com>
Date:   Thu, 28 Apr 2022 11:40:43 +0200
MIME-Version: 1.0
In-Reply-To: <20220428092251.GJ1127@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 04/28/22 11:22, Richard W.M. Jones wrote:
> 
> A couple of comments:
> 
> I'm not clear from the patch series what the difference is between an
> error which ignored (and counted) and an error that would actually
> stop setfiles immediately.

The difference is: with the new flag, we count and ignore exactly those
errors that would abort the processing (the file tree walk) in case
SELINUX_RESTORECON_ABORT_ON_ERROR were specified.

This is based on Petr's comments in RHBZ#1794518.

The whole idea is: stick with non-aborting, but *also* don't fail the
whole function in case you had aborted with ABORT_ON_ERROR. Because
right now, even though we don't abort, we still fail the whole function.

> With setfiles -C, will all errors now be
> counted and cause setfiles to exit with 1, or will some errors still
> be fatal (exit with 255)?

The latter, definitely.

> Why on earth is setfiles originally calling exit(-1) at all?!  I
> didn't even know that was allowed.  I wrote a test program and this
> does indeed cause the exit status to be 255 (because the status is
> &-ed with 0xff).  Never seen a program before calling exit(-1).

I noticed that immediately, but that's not something I want to get
into... ;)

Laszlo

