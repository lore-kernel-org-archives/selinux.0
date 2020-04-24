Return-Path: <SRS0=CFpO=6I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4ADC2BA1A
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 23:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C0B221EC
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 23:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rg1rQNFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDXXn2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:43:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgDXXn2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Apr 2020 19:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587771807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kn71fKQPXjFiFyBCKyTUfbDk234UOuOzANAj2lsywGw=;
        b=Rg1rQNFDX9J5fbqpcrVGwxX6+L/nFvDofrSeNApV0wkS1xGD4MWu6RyQrzuEzmaRMf9PUc
        v7KOPmi+hpka0lw439Vd/8TMq2T+c4nxNL26mVMnu5ATjpei4E4Po85MhkDVSYeadR40bu
        lgGF9b5JF8NdD9g20pN5PwlM2e2glI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-QGFYqvRHPGej_b3I7gIH4Q-1; Fri, 24 Apr 2020 19:43:25 -0400
X-MC-Unique: QGFYqvRHPGej_b3I7gIH4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09572107ACCA;
        Fri, 24 Apr 2020 23:43:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C5A35D9CA;
        Fri, 24 Apr 2020 23:43:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
References: <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com> <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com> <2136640.1587472186@warthog.procyon.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: Problem with 9ba09998baa9 ("selinux: Implement the watch_key security hook") in linux-next
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3834192.1587771802.1@warthog.procyon.org.uk>
Date:   Sat, 25 Apr 2020 00:43:22 +0100
Message-ID: <3834193.1587771802@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> wrote:

> > > and then use this newly created mapping function in [...]
> > > selinux_watch_key()
> >
> > No, I think I should just hard-code KEY__VIEW there.
> 
> FWIW, my comment was based on a version of linux-next where you were
> making policycap based permission adjustments to KEY_VIEW and I
> thought you would want the same adjustments to be applied to both
> access control points.  That code appears to now be gone in
> linux-next.

I don't think I changed KEY_VIEW specifically; anyway, that code is on hold
for the moment since it collides with this.

What I was wondering is if I should change KEY_NEED_xxx from a bitmask into an
enum to remove the confusion about whether or not you're allowed to provide
multiple 'needs' OR'd together.

> > +       perm = selinux_keyperm_to_av(need_perm);
> 
> ... and add a check for (perm < 0) as discussed above if we stick with
> the switch statement.

Actually, there was supposed to be a:

	if (!perm)
		return -EPERM;

after that line.

David

