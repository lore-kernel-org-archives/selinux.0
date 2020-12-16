Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5BBC2BBCD
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 17:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498DF23428
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 17:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgLPRXr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Dec 2020 12:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbgLPRXq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Dec 2020 12:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608139340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXLz4GBlBIA+qANQwvjhTocMpigMw8q0S0l6pSC0wEU=;
        b=ByAoYxbdLn7vuaByXGmL7Ki2dQ8bC2LSSOXJdBYJTTaS6BkD/kW/DhoBGH7tVWp2lUBfPI
        FEWFRjwgJPePWxNNK9r0R5JzIUPuENSO9pmHZNNuHbDF/mQoiUiBvCP0TFSgkN3qkSYu0C
        aERjNPwUb0FyUE04qH+QVtb2Muo6MLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-AGLEAh8kPZaFcwPJXu6waQ-1; Wed, 16 Dec 2020 12:22:17 -0500
X-MC-Unique: AGLEAh8kPZaFcwPJXu6waQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A42C800D55;
        Wed, 16 Dec 2020 17:22:15 +0000 (UTC)
Received: from ovpn-112-143.ams2.redhat.com (ovpn-112-143.ams2.redhat.com [10.36.112.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49C9F71D4D;
        Wed, 16 Dec 2020 17:22:12 +0000 (UTC)
Message-ID: <02d190afcb6e32f4aa3d1d228f762ab620f3c406.camel@redhat.com>
Subject: Re: [PATCH] linux: handle MPTCP consistently with TCP
From:   Paolo Abeni <pabeni@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, mptcp@lists.01.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>
Date:   Wed, 16 Dec 2020 18:22:11 +0100
In-Reply-To: <27d6afd1-9a2e-e258-dd09-e943de06f480@schaufler-ca.com>
References: <fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com>
         <27d6afd1-9a2e-e258-dd09-e943de06f480@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Wed, 2020-12-16 at 08:31 -0800, Casey Schaufler wrote:
> On 12/16/2020 3:55 AM, Paolo Abeni wrote:
> > The MPTCP protocol uses a specific protocol value, even if
> > it's an extension to TCP. Additionally, MPTCP sockets
> > could 'fall-back' to TCP at run-time, depending on peer MPTCP
> > support and available resources.
> > 
> > As a consequence of the specific protocol number, selinux
> > applies the raw_socket class to MPTCP sockets.
> 
> Have you looked at the implications for Smack?

AFAICS, the only hooks which can be affected is
smack_socket_post_create() - that is, the only hook with a 'protocol'
argument coming directly from the socket APIs.

If I read the code correctly, such hook behaves independently from
'protocol' value. Overall no changes should be needed for smack.

Thanks!

Paolo

