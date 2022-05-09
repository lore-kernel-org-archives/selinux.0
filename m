Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602BDC433F5
	for <selinux@archiver.kernel.org>; Mon,  9 May 2022 17:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbiEIRTJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 May 2022 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiEIRTI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 May 2022 13:19:08 -0400
X-Greylist: delayed 149 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 10:15:12 PDT
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BF3D6D;
        Mon,  9 May 2022 10:15:10 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 72354AC7; Mon,  9 May 2022 12:15:09 -0500 (CDT)
Date:   Mon, 9 May 2022 12:15:09 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Aring <aahringo@redhat.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 8/8] net: use new capable_or functionality
Message-ID: <20220509171509.GB28406@mail.hallyn.com>
References: <20220217145003.78982-2-cgzones@googlemail.com>
 <20220502160030.131168-1-cgzones@googlemail.com>
 <20220502160030.131168-7-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220502160030.131168-7-cgzones@googlemail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 02, 2022 at 06:00:29PM +0200, Christian Göttsche wrote:
> Use the new added capable_or function in appropriate cases, where a task
> is required to have any of two capabilities.
> 
> Reorder CAP_SYS_ADMIN last.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Thanks, for 2-8:

Reviewed-by: Serge Hallyn <serge@hallyn.com>

though I'd still like to talk about the name :)

> ---
>  net/caif/caif_socket.c | 2 +-
>  net/unix/scm.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
> index 2b8892d502f7..60498148126c 100644
> --- a/net/caif/caif_socket.c
> +++ b/net/caif/caif_socket.c
> @@ -1036,7 +1036,7 @@ static int caif_create(struct net *net, struct socket *sock, int protocol,
>  		.usersize = sizeof_field(struct caifsock, conn_req.param)
>  	};
>  
> -	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_NET_ADMIN))
> +	if (!capable_or(CAP_NET_ADMIN, CAP_SYS_ADMIN))
>  		return -EPERM;
>  	/*
>  	 * The sock->type specifies the socket type to use.
> diff --git a/net/unix/scm.c b/net/unix/scm.c
> index aa27a02478dc..821be80e6c85 100644
> --- a/net/unix/scm.c
> +++ b/net/unix/scm.c
> @@ -99,7 +99,7 @@ static inline bool too_many_unix_fds(struct task_struct *p)
>  	struct user_struct *user = current_user();
>  
>  	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
> -		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
> +		return !capable_or(CAP_SYS_RESOURCE, CAP_SYS_ADMIN);
>  	return false;
>  }
>  
> -- 
> 2.36.0
