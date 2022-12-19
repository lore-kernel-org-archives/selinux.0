Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506F0C4332F
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 20:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiLSUvU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiLSUul (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 15:50:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC9015F1A;
        Mon, 19 Dec 2022 12:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671482938; x=1703018938;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DGQDRUgrSwtvV+jdEtEqE1ophZ5C/2tMRIX8ibAaOQs=;
  b=k4qYG+Z0rdQrdAZ3z5hMGyw8Y6aQ0FE+m03wGB4qZhsIgUUqC3AJNnEf
   52v1rmDp8Gz78npLsxS50+tqeY0PskrT19aaq07c22aFGGF9JCBpGnng9
   GVh9CHxXperJJzfQAdjm+eDrdYZHWfLv92AADHJvvM6SfF3tQLZ8I0xgu
   zBiGJTmK5Z01iy4fqyxNa5Ewl2q/V8+A+OPaGTqyTgo/kfM9bJv8z7mKE
   GMlfBgQXBWfQ/IfsfAGuY1IufXUgasMSne0gn6ij1SMa5/ivAVrExL8m8
   vmekdsjZnWLX/dxVPxrpfH+3qBBZ70rmVmvG+gETHbMcR0qEOFJgahmg/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="383790952"
X-IronPort-AV: E=Sophos;i="5.96,257,1665471600"; 
   d="scan'208";a="383790952"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 12:48:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="757777936"
X-IronPort-AV: E=Sophos;i="5.96,257,1665471600"; 
   d="scan'208";a="757777936"
Received: from wootaekl-mobl1.amr.corp.intel.com ([10.212.220.86])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 12:48:50 -0800
Date:   Mon, 19 Dec 2022 12:48:49 -0800 (PST)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Subject: Re: [PATCH v2 1/2] security, lsm: Introduce
 security_mptcp_add_subflow()
In-Reply-To: <a902fa8f38238fca00094e067cbd147c472d108c.1671469167.git.pabeni@redhat.com>
Message-ID: <37412e5c-334f-91e3-807e-0c348791bebc@linux.intel.com>
References: <cover.1671469167.git.pabeni@redhat.com> <a902fa8f38238fca00094e067cbd147c472d108c.1671469167.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 19 Dec 2022, Paolo Abeni wrote:

> MPTCP can create subflows in kernel context, and later indirectly
> expose them to user-space, via the owning mptcp socket.
>
> As discussed in the reported link, the above causes unexpected failures
> for server, MPTCP-enabled applications.
>
> Let's introduce a new LSM hook to allow the security module to relabel
> the subflow according to the owing process.
>
> Note that the new hook requires both the mptcp socket and the new
> subflow. This could allow future extensions, e.g. explicitly validating
> the mptcp <-> subflow linkage.
>
> Link: https://lore.kernel.org/mptcp/CAHC9VhTNh-YwiyTds=P1e3rixEDqbRTFj22bpya=+qJqfcaMfg@mail.gmail.com/
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - fix build issue with !CONFIG_SECURITY_NETWORK
> ---
> include/linux/lsm_hook_defs.h | 1 +
> include/linux/lsm_hooks.h     | 9 +++++++++
> include/linux/security.h      | 6 ++++++
> net/mptcp/subflow.c           | 6 ++++++
> security/security.c           | 5 +++++
> 5 files changed, 27 insertions(+)
>

Hi Paolo -

Thanks for the patches, the MPTCP content looks good to me:

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index bd387d4b5a38..43b90784d914 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1680,6 +1680,10 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
>
> 	lock_sock(sf->sk);
>
> +	err = security_mptcp_add_subflow(sk, sf->sk);
> +	if (err)
> +		goto release_ssk;
> +
> 	/* the newly created socket has to be in the same cgroup as its parent */
> 	mptcp_attach_cgroup(sk, sf->sk);
>
> @@ -1692,6 +1696,8 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
> 	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
> 	sock_inuse_add(net, 1);
> 	err = tcp_set_ulp(sf->sk, "mptcp");
> +
> +release_ssk:
> 	release_sock(sf->sk);
>
> 	if (err) {

--
Mat Martineau
Intel
