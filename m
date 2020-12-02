Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9958C64E7C
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 11:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A157B206E0
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 11:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgLBLTb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgLBLTb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Dec 2020 06:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606907884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tAhmwJShQ3diQ7cz0ZpXZNxX9852SCjjEuE1qiqe/zQ=;
        b=GqrmSwz8BWzGSh6eA9QiP21JGsakY/QAdBANwFkXefcv6OfpsopUknccjpyoiDtnyvb4RH
        GRuZRENcpMUfpK4x6qRU7FQIO4BLsCBCMbC4hVDNwYlSl0J+ydOwAyZEsrL2fnC1LlCf7q
        x0fhG7WgAT71HQNuJ+mVvX/kc/Z6rjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-CTYDQAGdOqaExq7WtvnRdw-1; Wed, 02 Dec 2020 06:18:00 -0500
X-MC-Unique: CTYDQAGdOqaExq7WtvnRdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C910A8558F3;
        Wed,  2 Dec 2020 11:17:59 +0000 (UTC)
Received: from ovpn-115-102.ams2.redhat.com (ovpn-115-102.ams2.redhat.com [10.36.115.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83C1F5D9C6;
        Wed,  2 Dec 2020 11:17:58 +0000 (UTC)
Message-ID: <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
Subject: Re: [MPTCP] [RFC PATCH] selinux: handle MPTCP consistently with TCP
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org
Date:   Wed, 02 Dec 2020 12:17:57 +0100
In-Reply-To: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-12-02 at 11:31 +0100, Paolo Abeni wrote:
> The MPTCP protocol uses a specific protocol value, even if
> it's an extension to TCP. Additionally, MPTCP sockets
> could 'fall-back' to TCP at run-time, depending on peer MPTCP
> support and available resources.
> 
> As a consequence of the specific protocol number, selinux
> applies the raw_socket class to MPTCP sockets.
> 
> Existing TCP application converted to MPTCP - or forced to
> use MPTCP socket with user-space hacks - will need an
> updated policy to run successfully.
> 
> This change lets selinux attach the TCP socket class to
> MPTCP sockets, too, so that no policy changes are needed in
> the above scenario.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  security/selinux/hooks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6b1826fc3658..9a6b4bf1bc5b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1120,7 +1120,8 @@ static inline u16 inode_mode_to_security_class(umode_t mode)
>  
>  static inline int default_protocol_stream(int protocol)
>  {
> -	return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP);
> +	return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP ||
> +		protocol == IPPROTO_MPTCP);
>  }
>  
>  static inline int default_protocol_dgram(int protocol)
> @@ -1152,7 +1153,7 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
>  				return SECCLASS_TCP_SOCKET;
>  			else if (extsockclass && protocol == IPPROTO_SCTP)
>  				return SECCLASS_SCTP_SOCKET;
> -			else
> +			elseextsockclass

Whoops, my bad! I don't know how this chunk slipped-in. I'll fix it in
the formal submission for inclusion, if there is agreement on this
change.

Thanks!

Paolo

