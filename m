Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA570C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 15:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0F320830
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 15:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lksNMXsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfCVPRu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:17:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40475 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCVPRu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 11:17:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id h22so1987104edw.7;
        Fri, 22 Mar 2019 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ADtZh6aB2Qsg8kx5epD+1OUKRfAm7/YNbRwISkViMxc=;
        b=lksNMXsLlWlv0RuUf88p4z8RmVOlsQs+miNSsSrd/riVXRPmvGZFdx+xxjpXYanZlw
         dARrZt6IaETuvo6fPkzdOLQQf/F3ZCYxgAl8WlFaNzFKygKX0sZq8EdRK75P/Q/nSezF
         lqT+IB+mlulgT7E7ruKOHBo/lMpV370pkGj/Ha/ZtaJuUYkzmFzuWUcRkXEZ8fjcjJjc
         coAgXPkzQrBvybr1VSQjgNrYTBLgoCDR/gM2hgCyhu5gf3ufbquIFQTlSPHYIVwM8fAa
         EQTGdfzKrZRc+pvziYprtHnqT1qdgJ/S+Fq/TKGhqsKAQ63Qg0CPYFOT/eenitLus6Q5
         FGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ADtZh6aB2Qsg8kx5epD+1OUKRfAm7/YNbRwISkViMxc=;
        b=KjsmzWWZknI7IKpfdsMAQMIkvwxskneojJPEWSOzYwcRoV9+BKCq2olod0VTyA7v24
         mmKk+Ps/DbBBqKAly7NAU96g/iESiteiu8loke3TdHcMsaTJV0phXzVxMZYjabtgQXMV
         ghvHhBxIQL/9TR5ytxjhYFQLM/kAMBEf2Rd6ATXyfJKGoDTAJ4lH9f5rSN8lExLKJO5N
         Mda1nN9Xw1E8g4qtWDkBrDjgeRBd796rnkYNTsPdCliegscnhUS6vo+IOcNgiwvAmVrm
         XwncmkpFLLW9FhoE6f2dzkOZG6ubw6JkY895Y958hGXyTAudp0F4fNwBbGGHhVQwv409
         cYQw==
X-Gm-Message-State: APjAAAU4pJFROnFrVwsLIWlbmR+Cxwfldc28C7Tu1xmzVzh7QYXcBu1H
        ELfiCx7fhJGWMfGJPJVSr7fv3CiwfXiMwA==
X-Google-Smtp-Source: APXvYqxBVj1IHo1ICFLjDihja9DCTNbvm3dySPK9LV3RTqC7ubfWpAwYR8ZPI6ptqoCMxM+NMnotag==
X-Received: by 2002:a50:ac6c:: with SMTP id w41mr7146153edc.228.1553267868125;
        Fri, 22 Mar 2019 08:17:48 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id y12sm1359027eju.43.2019.03.22.08.17.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 08:17:47 -0700 (PDT)
Date:   Fri, 22 Mar 2019 08:17:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: avoid uninitialized variable warning
Message-ID: <20190322151745.GB13220@archlinux-ryzen>
References: <20190322141414.496017-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322141414.496017-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 22, 2019 at 03:14:10PM +0100, Arnd Bergmann wrote:
> clang correctly points out a code path that would lead
> to an uninitialized variable use:
> 
> security/selinux/netlabel.c:310:6: error: variable 'addr' is used uninitialized whenever 'if' condition is false
>       [-Werror,-Wsometimes-uninitialized]
>         if (ip_hdr(skb)->version == 4) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> security/selinux/netlabel.c:322:40: note: uninitialized use occurs here
>         rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
>                                               ^~~~
> security/selinux/netlabel.c:310:2: note: remove the 'if' if its condition is always true
>         if (ip_hdr(skb)->version == 4) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> security/selinux/netlabel.c:291:23: note: initialize the variable 'addr' to silence this warning
>         struct sockaddr *addr;
>                              ^
>                               = NULL
> 1 error generated.
> 
> This is probably harmless since we should not see ipv6 packets
> of CONFIG_IPV6 is disabled, but it's better to rearrange the code
> so this cannot happen.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  security/selinux/netlabel.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 186e727b737b..d0e549d4f486 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -288,7 +288,6 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
>  	int rc;
>  	struct netlbl_lsm_secattr secattr;
>  	struct sk_security_struct *sksec = ep->base.sk->sk_security;
> -	struct sockaddr *addr;
>  	struct sockaddr_in addr4;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	struct sockaddr_in6 addr6;
> @@ -310,16 +309,15 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
>  	if (ip_hdr(skb)->version == 4) {
>  		addr4.sin_family = AF_INET;
>  		addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
> -		addr = (struct sockaddr *)&addr4;
> +		rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr4, &secattr);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	} else {
>  		addr6.sin6_family = AF_INET6;
>  		addr6.sin6_addr = ipv6_hdr(skb)->saddr;
> -		addr = (struct sockaddr *)&addr6;
> +		rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr6, &secattr);
>  #endif
>  	}
>  
> -	rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
>  	if (rc == 0)
>  		sksec->nlbl_state = NLBL_LABELED;
>  
> -- 
> 2.20.0
> 
