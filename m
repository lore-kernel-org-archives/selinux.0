Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F209C83000
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57A0206D7
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFoCzR42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgD1P6I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:58:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54526 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728117AbgD1P6I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 11:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588089487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pnFl0PqSRzegWv9vKpfb6I2iA6EksKg+yUNljMPLZ9o=;
        b=DFoCzR42jDIFZ2Qxi2iwgPYx9i75cPlM6LaTJ0AF5nor5PnYUNgyRU7gK3pVMx+j23v0SD
        KN6JZWHI6KiUcBn2LmtlVUAJ33qI6I6YHIBNewPBsqY75M73eSMAUnKga09+bDwaRYypbk
        1Xwyo51fZwlp52UPpQbtKAHKinW2MH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-dkCEzet3Oii9ohNOiPQaFg-1; Tue, 28 Apr 2020 11:58:05 -0400
X-MC-Unique: dkCEzet3Oii9ohNOiPQaFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E18DE108BD09;
        Tue, 28 Apr 2020 15:58:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A71EB60F8D;
        Tue, 28 Apr 2020 15:58:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAEjxPJ5+DtZfX36OLYiLbU=1tGZcPUWFUi1=mFfx=ntehtvd3Q@mail.gmail.com>
References: <CAEjxPJ5+DtZfX36OLYiLbU=1tGZcPUWFUi1=mFfx=ntehtvd3Q@mail.gmail.com> <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com> <924658.1588078484@warthog.procyon.org.uk>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     dhowells@redhat.com, Paul Moore <paul@paul-moore.com>,
        keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms [v2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1072934.1588089479.1@warthog.procyon.org.uk>
Date:   Tue, 28 Apr 2020 16:57:59 +0100
Message-ID: <1072935.1588089479@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> wrote:

> 1) Are we guaranteed that the caller only ever passes a single
> KEY_NEED_* perm at a time (i.e. hook is never called with a bitmask
> of multiple permissions)?  Where is that guarantee enforced?

Currently it's the case that only one perm is ever used at once.  I'm tempted
to enforce this by switching the KEY_NEED_* to an enum rather than a bitmask.

I'm not sure how I would actually define the meaning of two perms being OR'd
together.  Either okay?  Both required?

> 2) We had talked about adding a BUILD_BUG_ON() or other build-time
> guard

That doesn't help you trap unallowed perm combinations, though.

> to ensure that new KEY_NEED_* permissions
> are not added without updating SELinux.  We already have similar
> constructs for catching new capabilities (#if CAP_LAST_CAP > 63 #error
> ...), socket address families (#if PF_MAX > 45 #error ...),  RTM_* and
> XFRM_MSG* values.

David

