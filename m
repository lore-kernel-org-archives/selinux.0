Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC7FC433EF
	for <selinux@archiver.kernel.org>; Thu, 28 Apr 2022 09:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiD1JuJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Apr 2022 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346620AbiD1J0J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Apr 2022 05:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E83B7B571
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651137774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJP5mV4jzpHRZn0otYuAKveMulHHSOpNMyewdi5952M=;
        b=Bo2Gck3xY1rVt7OJHQoJwI3lwN56qzGxyE6OXGheiOrfBVjyc73r80K3oiIz2o5l2UspSX
        R0aTqIthlOG70Lrmo22iOs07oArNuiMa7Wda0bBLIVxsolA2QAQDe6W4sGuQbPuUA3qxGl
        /7qDjZilcr9FaNgwAul8TpUZAP3Oybo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-gyGbr_e9PoK711oauwU2xw-1; Thu, 28 Apr 2022 05:22:53 -0400
X-MC-Unique: gyGbr_e9PoK711oauwU2xw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 162641E17FE3
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 09:22:53 +0000 (UTC)
Received: from localhost (unknown [10.39.192.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCD30C44CD6;
        Thu, 28 Apr 2022 09:22:52 +0000 (UTC)
Date:   Thu, 28 Apr 2022 10:22:51 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     SELinux List <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: Re: [PATCH for-3.5 0/5] selinux_restorecon(3), setfiles(8): skip
 relabeling errors
Message-ID: <20220428092251.GJ1127@redhat.com>
References: <20220428065354.27605-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428065354.27605-1-lersek@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


A couple of comments:

I'm not clear from the patch series what the difference is between an
error which ignored (and counted) and an error that would actually
stop setfiles immediately.  With setfiles -C, will all errors now be
counted and cause setfiles to exit with 1, or will some errors still
be fatal (exit with 255)?

Why on earth is setfiles originally calling exit(-1) at all?!  I
didn't even know that was allowed.  I wrote a test program and this
does indeed cause the exit status to be 255 (because the status is
&-ed with 0xff).  Never seen a program before calling exit(-1).

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit

