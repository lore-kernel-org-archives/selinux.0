Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35431C43381
	for <selinux@archiver.kernel.org>; Wed, 23 Dec 2020 15:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9A02333B
	for <selinux@archiver.kernel.org>; Wed, 23 Dec 2020 15:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgLWPLz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:11:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbgLWPLz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Dec 2020 10:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608736229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UdamdvEc1UB90Pxbe/5fgSAC5AbBY2QjoSZZcVJXl7s=;
        b=BOqSSWD1udKUyFe4IwnmraAgtu9NYF1JjYcuVao+ebY97UOd0we56btDFo2ejWUntFwcp+
        kg+th2ngl8mIv/xUUvgT/PtJMei2nKsZHGBZzBmvbELBXSbpSFKgGdWO/Q6Q03Pjjd64me
        04A4Ek7a6QVXZq1yAf8JMeKG1cFzu8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-M1wKBa22OF2AsMW29UBMaw-1; Wed, 23 Dec 2020 10:10:25 -0500
X-MC-Unique: M1wKBa22OF2AsMW29UBMaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B33F3107ACE3;
        Wed, 23 Dec 2020 15:10:23 +0000 (UTC)
Received: from ovpn-113-44.ams2.redhat.com (ovpn-113-44.ams2.redhat.com [10.36.113.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D9CF6F7EC;
        Wed, 23 Dec 2020 15:10:21 +0000 (UTC)
Message-ID: <8650019f70725323545e41c5ecf6b1344671b4fa.camel@redhat.com>
Subject: Re: [PATCH] linux: handle MPTCP consistently with TCP
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        mptcp@lists.01.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 23 Dec 2020 16:10:21 +0100
In-Reply-To: <CAHC9VhTUain0=AXvxu3k7e46DCnFuQtcrgQFrEsz9b0uNQnqtQ@mail.gmail.com>
References: <fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com>
         <CAHC9VhTUain0=AXvxu3k7e46DCnFuQtcrgQFrEsz9b0uNQnqtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-12-23 at 09:53 -0500, Paul Moore wrote:
> On Wed, Dec 16, 2020 at 6:55 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > The MPTCP protocol uses a specific protocol value, even if
> > it's an extension to TCP. Additionally, MPTCP sockets
> > could 'fall-back' to TCP at run-time, depending on peer MPTCP
> > support and available resources.
> > 
> > As a consequence of the specific protocol number, selinux
> > applies the raw_socket class to MPTCP sockets.
> > 
> > Existing TCP application converted to MPTCP - or forced to
> > use MPTCP socket with user-space hacks - will need an
> > updated policy to run successfully.
> > 
> > This change lets selinux attach the TCP socket class to
> > MPTCP sockets, too, so that no policy changes are needed in
> > the above scenario.
> > 
> > Note that the MPTCP is setting, propagating and updating the
> > security context on all the subflows and related request
> > socket.
> > 
> > Link: https://lore.kernel.org/linux-security-module/CAHC9VhTaK3xx0hEGByD2zxfF7fadyPP1kb-WeWH_YCyq9X-sRg@mail.gmail.com/T/#t
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  security/selinux/hooks.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Based on our discussion in the previous thread, the patch below seems
> fine, although it needs to wait until after the merge window closes.
> 
> Paolo, it sounded like there was at least one other small MPTCP fix
> needed, likely in the stack itself and not the LSM/SELinux code, has
> that patch been submitted already?

Yes, it's already in the Linus's tree:

commit 0c14846032f2c0a3b63234e1fc2759f4155b6067
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Wed Dec 16 12:48:32 2020 +0100

    mptcp: fix security context on server socket

Thanks for the feedback && happy new year;)

Paolo

