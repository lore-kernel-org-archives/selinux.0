Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC9329C48;
	Fri, 13 Feb 2026 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977988; cv=none; b=ije6kt0DhVWW0BkoFqjITTVLPDT1Z74SqOdd8p4cDilj3hfOYijEtWYtTFzQqczXNef8DRVfWsd+KYjbCenDWGva7G+ImXcT4pFgOTdo8Jd4mTa5IzpsBEe9FgEcUPox2uf16aruWsuc119OWMSj31679gMA8bvtB8F23K3yChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977988; c=relaxed/simple;
	bh=vCg2LakybupL1p6dSOlwsPr4WWiWS1mA94XqrkwlrRI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0TdKVgvwVUVYQXxqgK1Z/JM7CSU/xP2SCtAah8M5w8e301TMOMkYhOL0Dq/lNxWKdxV301FxFD/2bzWeTXWf0ClLuOxNJy8dzVHylVh+1fkP47eVnED0cHzL2W1JqaIx3S5iULeYkxPignjJ/pCfPcRHA2UsyCYvvihidCtgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qxE6V3zV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qxE6V3zV"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A50A8207C1;
	Fri, 13 Feb 2026 11:19:37 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wsU87H5HLerd; Fri, 13 Feb 2026 11:19:36 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8D84A20660;
	Fri, 13 Feb 2026 11:19:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8D84A20660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770977976;
	bh=u23SGGFLS4yZzOc7p3Nk64gmtl+CbSo42vHCOowkYgY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=qxE6V3zVH61L2X55p0s8aK94VAaWzqQWzgFUorlfShxuRZri5fl1L3VESemjDHzPU
	 08wa+OLc5TmWJBdw0lNTNUAxgOuKjt4qTEyaOEQpPC3JfqfVVvNFKnG13DOAEIXWgg
	 rQhrDdRbgQYhtF1J3KH353kbOAhZzSEgqzR5XyaC9ln9hajv7acFagv118eYvYzYUz
	 JsBGfSaSGF/1M2WUOjp10P0eswlNI582tBnlHsj9zIdoWVNcojz9X/0EGscP/CrYXy
	 K8QWt0bSKqzO0KC3Po82MJfXHMzg8s3BnQBs0+draK75q1S39suBjjWXsIYTD6jtx+
	 FGPW4J86/l1nQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Feb
 2026 11:19:35 +0100
Received: (nullmailer pid 1819279 invoked by uid 1000);
	Fri, 13 Feb 2026 10:19:35 -0000
Date: Fri, 13 Feb 2026 11:19:35 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Network Development
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
Message-ID: <aY76t_xYCHmLq6Ur@secunet.com>
References: <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
 <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
 <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
 <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
 <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
 <aYmoDwO-YXrc4W1c@secunet.com>
 <85546d35-c7bd-49bf-b0c3-9677bde25859@I-love.SAKURA.ne.jp>
 <aYnDWbxo-jAzR4ca@secunet.com>
 <7c17884d-dbf1-4c2c-9813-0c5369cfdcc9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c17884d-dbf1-4c2c-9813-0c5369cfdcc9@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Feb 09, 2026 at 11:26:14PM +0900, Tetsuo Handa wrote:
> On 2026/02/09 20:22, Steffen Klassert wrote:
> > On Mon, Feb 09, 2026 at 07:02:47PM +0900, Tetsuo Handa wrote:
> >> On 2026/02/09 18:25, Steffen Klassert wrote:
> >>> The problem is that, with adding IPsec offloads to netdevices, security
> >>> critical resources came into the netdevices. Someone who has no
> >>> capabilities to delete xfrm states or xfrm policies should not be able
> >>> to unregister the netdevice if xfrm states or xfrm policies are
> >>> offloaded. Unfortunately, unregistering can't be canceled at this stage
> >>> anymore. So I think we need some netdevice unregistration hook for
> >>> the LSM subsystem so it can check for xfrm states or xfrm policies
> >>> and refuse the unregistration before we actually start to remove
> >>> the device.
> >>
> >> Unfortunately, unregistering is not always triggered by a user's request. ;-)
> > 
> > As far as I remember, a security context is not always tied to a
> > user request. It can also be attached to system tasks or objects.
> 
> That is not what I wanted to say. There are at least three routes (listed below)
> that can trigger xfrm_dev_unregister() path. You could insert LSM hooks into the
> netlink_sendmsg() route and the del_device_store() route, but the cleanup_net()
> route is a result of tear-down action which is too late to insert LSM hooks.

Yes, I know that.

> The NETDEV_UNREGISTER path can be triggered by just doing "unshare -n ip addr show"
> (i.e. implicit cleanup of a network namespace due to termination of init process in
> that namespace). We are not allowed to reject the cleanup_net() route.

And here we come to the other problem I mentioned. When a LSM policy
rejects to flush the xfrm states and policies on network namespace
exit, we leak all the xfrm states and policies in that namespace.
Here we have no other option, we must flush the xfrm states and
policies regardless of any LSM policy. This can be fixed with
something like that:

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 72678053bd69..8a4b2cbba0e0 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1822,9 +1822,11 @@ int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
 
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 
-	err = xfrm_policy_flush_secctx_check(net, type, task_valid);
-	if (err)
-		goto out;
+	if (task_valid) {
+		err = xfrm_policy_flush_secctx_check(net, type, task_valid);
+		if (err)
+			goto out;
+	}
 
 again:
 	list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f2aef404b583..fd00f2d20425 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -923,9 +923,11 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 	int i, err = 0, cnt = 0;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	err = xfrm_state_flush_secctx_check(net, proto, task_valid);
-	if (err)
-		goto out;
+	if (task_valid) {
+		err = xfrm_state_flush_secctx_check(net, proto, task_valid);
+		if (err)
+			goto out;
+	}
 
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {

> > 
> >> For example, we don't check permission for unmount when a mount is deleted
> >> due to teardown of a mount namespace. I wonder why you want to check permission
> >> for unregistering a net_device when triggered by a teardown path.
> > 
> > I just try to find out what's the right thing to do here.
> > If a policy goes away, packets that match this policy will
> > find another path through the network stack. As best, they
> > are dropped somewhere, but they can also leave on some other
> > device without encryption. A LSM that implements xfrm hooks
> > must be able to check the permission to delete the xfrm policy
> > or state.
> 
> Do you mean that calling xfrm_dev_down()/xfrm_dev_unregister() might
> result in network traffic to be sent in cleartext ?

Yes this can happen, but it is known. You can either install
a global block policy with low priority or use a LSM to
prevent this. The latter does not work unfortunately.

> 
> If yes, we need to consider updating the other patch at
> https://lkml.kernel.org/r/20260202123655.GK34749@unreal to replace
> the NETDEV_UNREGISTER net_device with the blackhole_netdev. (That is,
> xfrm_dev_{state,policy}_flush() does not actually delete a state/policy
> but instead updates that state/policy to behave as a blackhole. Then,
> we won't need to call LSM hooks because we no longer delete).

I think there is a clean way to fix this. We could just unlink
policy and state from the device. Then we could do the same as
we do when a state becomes unavailable due to expiration. We mark
the state as invalid with a flag. On expiration we do this with
XFRM_STATE_EXPIRED. We can add a new flag and do the same as
xfrm_state_check_expire() does on a hard expire. I.e. fire
a timer that notifies the userspace key manager that this
path is not avalable anymore and return an error. This way
userspace is informed about that and all packets matching
the policy are dropped.

This is of course a bit more work and requires testing.

