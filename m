Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F790C3F2D3
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D14246AC
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce9ntMcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgB1Pzl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:55:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35305 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727070AbgB1Pzk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 10:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582905340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9l1FAG7CGlgVvJteRLkrnQcPAMg0EaFzCpUiL9mbDvM=;
        b=ce9ntMcpPK299XO4RVsHgYdmmWixXZ6pWkFlu+uB23Qfv91ZSzNOJO94xe+E0ByuTt3Tky
        6w1dD6B/47ckm7X+V1pg26nV8Ii90qvGLl3k2xK7ocoQiWZnTK88207hc3vD7CRurNq80X
        klhVi6VW3QcZHDB+//6ddE6NdAxNJ9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-muO-ArpfPoqnTeUEmVnQPA-1; Fri, 28 Feb 2020 10:55:37 -0500
X-MC-Unique: muO-ArpfPoqnTeUEmVnQPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CDA18017CC;
        Fri, 28 Feb 2020 15:55:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7881990F5B;
        Fri, 28 Feb 2020 15:55:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c5d6ae72-4f5d-fe41-c025-0eaa4616b7eb@tycho.nsa.gov>
References: <c5d6ae72-4f5d-fe41-c025-0eaa4616b7eb@tycho.nsa.gov> <20200220181031.156674-1-richard_c_haines@btinternet.com> <20200220181031.156674-2-richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     dhowells@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, paul@paul-moore.com
Subject: Re: [RFC PATCH 1/1] selinux: Add support for new key permissions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <103613.1582905334.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 28 Feb 2020 15:55:34 +0000
Message-ID: <103614.1582905334@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Regardless, we need to revert the original patch and create a new one th=
at
> addresses the KEY_NEED_PARENT_JOIN issue I mentioned and that adds the
> key_perms capability in the right place in the first place, not apply a =
fix on
> top.

I think the problem is that selinux_key_permission() is munging the new pe=
rm
set into the old perm set and then passing that to avc_has_perm().  Really=
, we
need to work backwards if the SELinux policy is described in terms of the =
old
perm set.

Is there any way to make that possible?

David

