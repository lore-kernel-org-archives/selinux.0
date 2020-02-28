Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D38C3F2CD
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D5C2469C
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ntq/j99d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgB1PwX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:52:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726956AbgB1PwX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 10:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582905142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QeDDvIlIvp9n6uthJiSaGQ6hRT/OCi29aojj51brMS4=;
        b=Ntq/j99din8Rw25Fyxgrji/U5cXsDOzUo7RmE6mVuY88kdkVkIMEMjEbhLkyqOUk+BcyKz
        PIkDyPNujS+2vSmGr2F1KRbS6MrGZ0ZsH7/AG8XbGxh6H1y37vfaOweoNZEd1eAR5+5CnT
        S7k/FXwkcEfbFAH1oqFNLjSa2qVVk3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-FYA5loj8PTuQtU24hOG4Xw-1; Fri, 28 Feb 2020 10:52:19 -0500
X-MC-Unique: FYA5loj8PTuQtU24hOG4Xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DED39800053;
        Fri, 28 Feb 2020 15:52:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9C4F5C6DC;
        Fri, 28 Feb 2020 15:52:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHC9VhQ+pNTJjb=ipG_gsTSpv6-rEtWTL2sybrOnjyBJ+==2hw@mail.gmail.com>
References: <CAHC9VhQ+pNTJjb=ipG_gsTSpv6-rEtWTL2sybrOnjyBJ+==2hw@mail.gmail.com> <20200220181031.156674-1-richard_c_haines@btinternet.com> <20200220181031.156674-2-richard_c_haines@btinternet.com> <c5d6ae72-4f5d-fe41-c025-0eaa4616b7eb@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>
Cc:     dhowells@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH 1/1] selinux: Add support for new key permissions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <103186.1582905135.1@warthog.procyon.org.uk>
Date:   Fri, 28 Feb 2020 15:52:15 +0000
Message-ID: <103187.1582905135@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> wrote:

> Yes, you really need to revert this patch David, I mentioned this some
> time ago when the linux-next conflict appeared.

It is reverted.

> Also, future patches like this *really* need to go in via the SELinux tree,
> not the keys tree, as they affect the SELinux kernel ABI and if they aren't
> merged via the same tree lots of bad things can happen if we aren't careful.

Are you're willing to take the matching keyring changes with it?  The SELinux
patch won't build without them - but they have to go in at the same time
otherwise the keyrings part will malfunction.

David

