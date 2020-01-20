Return-Path: <SRS0=4oDv=3J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F59DC2D0DB
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 13:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1039021835
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 13:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIbUnkhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgATNeC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:34:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60301 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgATNeC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jan 2020 08:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579527241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwpNszM110rHiJ1N+usZzr+cFXg9YZihnelnexkMGzs=;
        b=bIbUnkhRwQSjdtv1u7XmwEgpbNBIBnAPQBs505NKQRymzdXC9l2/Wo2DvcsZEKWKhSb1Rr
        hjwwO5htAD84pzBzd4tDZxI7uUPfx2LgNurs5uuNQW7SgFYROk/QXyzxrDfrx6esCmDpCI
        teGOVeD/dlR3b2PRB1qrtQt6fb2N3Dw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-A-5PQLrhNsWK4DpryDrABA-1; Mon, 20 Jan 2020 08:34:00 -0500
X-MC-Unique: A-5PQLrhNsWK4DpryDrABA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 513F61005512;
        Mon, 20 Jan 2020 13:33:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3934C7C35A;
        Mon, 20 Jan 2020 13:33:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200117202407.12344-1-sds@tycho.nsa.gov>
References: <20200117202407.12344-1-sds@tycho.nsa.gov>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     dhowells@redhat.com, paul@paul-moore.com, selinux@vger.kernel.org,
        omosnace@redhat.com
Subject: Re: [PATCH v2] selinux: fix regression introduced by move_mount(2) syscall
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <930459.1579527237.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 20 Jan 2020 13:33:57 +0000
Message-ID: <930460.1579527237@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> commit 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts aro=
und")
> introduced a new move_mount(2) system call and a corresponding new LSM
> security_move_mount hook but did not implement this hook for any existin=
g
> LSM.  This creates a regression for SELinux with respect to consistent
> checking of mounts; the existing selinux_mount hook checks mounton
> permission to the mount point path.  Provide a SELinux hook
> implementation for move_mount that applies this same check for
> consistency.  In the future we may wish to add a new move_mount
> filesystem permission and check as well, but this addresses
> the immediate regression.
> =

> Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts aro=
und")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Reviewed-by: David Howells <dhowells@redhat.com>

