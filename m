Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F6AC4708E
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 02:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLHCTG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Dec 2022 21:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLHCTF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Dec 2022 21:19:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7474860E8C;
        Wed,  7 Dec 2022 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670465944; x=1702001944;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Jt7NLbv+WMLBtqgdb3SxO2ErbAI1LICf45IEtoCF5VE=;
  b=XHWNUWbEyHwiHjUCxoU2tnhQfGZ3NP+1nRe94gS8sZhSlTx2LxZNewKS
   iqyLSATisl5+BcFgxgkJ+/hDIPVsO6zuP1RGLlo0C+A3+93eFbVLOCY7c
   5h13JpnOf+waK7KRDlzZ6XVjOEWVYlEhfwqZQhayTECOaWRdRtU5KEBW2
   znM69Bc5SarNPe5ZUzm74N+PhIyg5u34s2rSL0fJR3bgRvAx0cEfJld+d
   X5GkWYJCQw5egNXPaARasLs0alVw0Ay3vM1SyO3QLIA7xY1KXrhftm+P1
   M5AmI6JT3q0C78kfhlptBvFShpm3edIkVcJQgDIzIR5U3xKLhjWhcbHHf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318191580"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="318191580"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 18:19:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="735618903"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="735618903"
Received: from rtalla-mobl.amr.corp.intel.com ([10.209.87.225])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 18:19:01 -0800
Date:   Wed, 7 Dec 2022 18:19:01 -0800 (PST)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
cc:     mptcp@lists.linux.dev, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fix LSM labeling for passive msk
In-Reply-To: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
Message-ID: <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com>
References: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 7 Dec 2022, Paolo Abeni wrote:

> MPTCP sockets created via accept() inherit their LSM label
> from the initial request socket, which in turn get it from the
> listener socket's first subflow. The latter is a kernel socket,
> and get the relevant labeling at creation time.
>
> Due to all the above even the accepted MPTCP socket get a kernel
> label, causing unexpected behaviour and failure on later LSM tests.
>
> Address the issue factoring out a socket creation helper that does
> not include the post-creation LSM checks. Use such helper to create
> mptcp subflow as in-kernel sockets and doing explicitly LSM validation:
> vs the current user for the first subflow, as a kernel socket otherwise.
>
> Fixes: 0c14846032f2 ("mptcp: fix security context on server socket")
> Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

The MPTCP content looks good to me:

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


I didn't see issues with the socket.c changes but I'd like to get some 
security community feedback before upstreaming - Paul or other security 
reviewers, what do you think?


Thanks,

Mat


> ---
> include/linux/net.h |  2 ++
> net/mptcp/subflow.c | 19 ++++++++++++--
> net/socket.c        | 60 ++++++++++++++++++++++++++++++---------------
> 3 files changed, 59 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/net.h b/include/linux/net.h
> index b73ad8e3c212..91713012504d 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -251,6 +251,8 @@ int sock_wake_async(struct socket_wq *sk_wq, int how, int band);
> int sock_register(const struct net_proto_family *fam);
> void sock_unregister(int family);
> bool sock_is_registered(int family);
> +int __sock_create_nosec(struct net *net, int family, int type, int proto,
> +			struct socket **res, int kern);
> int __sock_create(struct net *net, int family, int type, int proto,
> 		  struct socket **res, int kern);
> int sock_create(int family, int type, int proto, struct socket **res);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d5ff502c88d7..e7e6f17df7ef 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1646,11 +1646,26 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
> 	if (unlikely(!sk->sk_socket))
> 		return -EINVAL;
>
> -	err = sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
> -			       &sf);
> +	/* the subflow is created by the kernel, and we need kernel annotation
> +	 * for lockdep's sake...
> +	 */
> +	err = __sock_create_nosec(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
> +				  &sf, 1);
> 	if (err)
> 		return err;
>
> +	/* ... but the MPC subflow will be indirectly exposed to the
> +	 * user-space via accept(). Let's attach the current user security
> +	 * label to the first subflow, that is when msk->first is not yet
> +	 * initialized.
> +	 */
> +	err = security_socket_post_create(sf, sk->sk_family, SOCK_STREAM,
> +					  IPPROTO_TCP, !!mptcp_sk(sk)->first);
> +	if (err) {
> +		sock_release(sf);
> +		return err;
> +	}
> +
> 	lock_sock(sf->sk);
>
> 	/* the newly created socket has to be in the same cgroup as its parent */
> diff --git a/net/socket.c b/net/socket.c
> index 55c5d536e5f6..d5d51e4e26ae 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1426,23 +1426,11 @@ int sock_wake_async(struct socket_wq *wq, int how, int band)
> }
> EXPORT_SYMBOL(sock_wake_async);
>
> -/**
> - *	__sock_create - creates a socket
> - *	@net: net namespace
> - *	@family: protocol family (AF_INET, ...)
> - *	@type: communication type (SOCK_STREAM, ...)
> - *	@protocol: protocol (0, ...)
> - *	@res: new socket
> - *	@kern: boolean for kernel space sockets
> - *
> - *	Creates a new socket and assigns it to @res, passing through LSM.
> - *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
> - *	be set to true if the socket resides in kernel space.
> - *	This function internally uses GFP_KERNEL.
> - */
>
> -int __sock_create(struct net *net, int family, int type, int protocol,
> -			 struct socket **res, int kern)
> +
> +/*creates a socket leaving LSM post-creation checks to the caller */
> +int __sock_create_nosec(struct net *net, int family, int type, int protocol,
> +			struct socket **res, int kern)
> {
> 	int err;
> 	struct socket *sock;
> @@ -1528,11 +1516,8 @@ int __sock_create(struct net *net, int family, int type, int protocol,
> 	 * module can have its refcnt decremented
> 	 */
> 	module_put(pf->owner);
> -	err = security_socket_post_create(sock, family, type, protocol, kern);
> -	if (err)
> -		goto out_sock_release;
> -	*res = sock;
>
> +	*res = sock;
> 	return 0;
>
> out_module_busy:
> @@ -1548,6 +1533,41 @@ int __sock_create(struct net *net, int family, int type, int protocol,
> 	rcu_read_unlock();
> 	goto out_sock_release;
> }
> +
> +/**
> + *	__sock_create - creates a socket
> + *	@net: net namespace
> + *	@family: protocol family (AF_INET, ...)
> + *	@type: communication type (SOCK_STREAM, ...)
> + *	@protocol: protocol (0, ...)
> + *	@res: new socket
> + *	@kern: boolean for kernel space sockets
> + *
> + *	Creates a new socket and assigns it to @res, passing through LSM.
> + *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
> + *	be set to true if the socket resides in kernel space.
> + *	This function internally uses GFP_KERNEL.
> + */
> +
> +int __sock_create(struct net *net, int family, int type, int protocol,
> +		  struct socket **res, int kern)
> +{
> +	struct socket *sock;
> +	int err;
> +
> +	err = __sock_create_nosec(net, family, type, protocol, &sock, kern);
> +	if (err)
> +		return err;
> +
> +	err = security_socket_post_create(sock, family, type, protocol, kern);
> +	if (err) {
> +		sock_release(sock);
> +		return err;
> +	}
> +
> +	*res = sock;
> +	return 0;
> +}
> EXPORT_SYMBOL(__sock_create);
>
> /**
> -- 
> 2.38.1
>
>
>

--
Mat Martineau
Intel
