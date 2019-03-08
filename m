Return-Path: <SRS0=fbu5=RL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5DBC4360F
	for <selinux@archiver.kernel.org>; Fri,  8 Mar 2019 17:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6099205F4
	for <selinux@archiver.kernel.org>; Fri,  8 Mar 2019 17:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcHtUTw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfCHRIn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:08:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45092 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHRIn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Mar 2019 12:08:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so21961270qtg.12;
        Fri, 08 Mar 2019 09:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/o1vzj4/pTNZIc7vJibk+/IU+Tu9zMhtXigpagVWbkA=;
        b=WcHtUTw/1S/kuTneHxZFQy78O+XTBFJitHS/OQWozHry/g4Qea5n5leB/pmJqTPvYZ
         /wbINRCSXR2Q6Fu5rHrl14oRrBnwhh35Yi9gxCqZ4/VI9ggx2mxn+GnNelT+A5j+WJNQ
         JLvlaHwnCkdvmLsrLukc01CisAtryz93V0dliCFkw3oBZnG3OA4RrKoG7r0zH0Icqnin
         1CFFM7U7eUFaC67ulFm5D5nwZpSGC3qIQPrPRl6/Na1VpY0nxtcfloEsdKQO4vJi/sKm
         Mhancn7F61wyD0OM4BviX9wRA0CXJ8wUr+/p4gJc6XYabuLhVu/EEMJqIBAY2gnz8QQL
         A4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/o1vzj4/pTNZIc7vJibk+/IU+Tu9zMhtXigpagVWbkA=;
        b=ios2GgE3QE+jP9mxqbmCSfg56y/EHcbpunRhEIGmrtx6T20V6B8BMW9blOabuaTPZl
         JJJKZrJgVwXOabwVZP74Su0PT2QyHVWnKQ8xEKVXe1pXrcdyIbZwywoyH60cKAoVr7md
         Jw7vdVnjxbP3qedBXht5mzlYZCgZ81SNWRxECx8K6XrG4W7ecaDmYVlpJkPjJDrxF+xu
         5QP7Nr9pIlW7MWQMugybazGEccs6nmDVuXmG1o9qbI3OdUUMYmBxvcyIGqKy6ranhy5w
         ccaAGWKMfAC0N8hoGCo8m6fqFvjGAZ319OLB2LftI+qrz4GpyrRcMou5w0Ca3J+C/2G5
         x1FA==
X-Gm-Message-State: APjAAAXVG8wkJCFDYGyIai9COKXHWgCZY/3w0nWDR+BKxV618JkC93Sk
        QG4HiuC/oLhm083kijEc6UI=
X-Google-Smtp-Source: APXvYqzuZpyHj/m6e3Os7eruLdkTd7rlnOzY2riezkcKtTRUpbZUspdtzJ//abjlCBG1TZlxumnA0w==
X-Received: by 2002:ac8:36b6:: with SMTP id a51mr15381124qtc.208.1552064922022;
        Fri, 08 Mar 2019 09:08:42 -0800 (PST)
Received: from localhost.localdomain ([168.181.49.39])
        by smtp.gmail.com with ESMTPSA id q23sm4114004qkc.64.2019.03.08.09.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 09:08:41 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id C4CBF180BE0; Fri,  8 Mar 2019 14:08:38 -0300 (-03)
Date:   Fri, 8 Mar 2019 14:08:38 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     selinux@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH net] selinux: add the missing walk_size + len check in
 selinux_sctp_bind_connect
Message-ID: <20190308170838.GF13515@localhost.localdomain>
References: <1e5accb3a4a5575ada1dbdfc6e5d9e4358131f83.1552061254.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e5accb3a4a5575ada1dbdfc6e5d9e4358131f83.1552061254.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Mar 09, 2019 at 12:07:34AM +0800, Xin Long wrote:
> As does in __sctp_connect(), when checking addrs in a while loop, after
> get the addr len according to sa_family, it's necessary to do the check
> walk_size + af->sockaddr_len > addrs_size to make sure it won't access
> an out-of-bounds addr.
> 
> The same thing is needed in selinux_sctp_bind_connect(), otherwise an
> out-of-bounds issue can be triggered:
> 
>   [14548.772313] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x1aa/0x1f0
>   [14548.927083] Call Trace:
>   [14548.938072]  dump_stack+0x9a/0xe9
>   [14548.953015]  print_address_description+0x65/0x22e
>   [14548.996524]  kasan_report.cold.6+0x92/0x1a6
>   [14549.015335]  selinux_sctp_bind_connect+0x1aa/0x1f0
>   [14549.036947]  security_sctp_bind_connect+0x58/0x90
>   [14549.058142]  __sctp_setsockopt_connectx+0x5a/0x150 [sctp]
>   [14549.081650]  sctp_setsockopt.part.24+0x1322/0x3ce0 [sctp]
> 
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Reported-by: Chunyu Hu <chuhu@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Paul, how can we get this into -stable trees? SELinux process may be
different from -net trees.

> ---
>  security/selinux/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f0e36c3..dac9bdb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5120,6 +5120,9 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
>  			return -EINVAL;
>  		}
>  
> +		if (walk_size + len > addrlen)
> +			return -EINVAL;
> +
>  		err = -EINVAL;
>  		switch (optname) {
>  		/* Bind checks */
> -- 
> 2.1.0
> 
