Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291FC2673B0
	for <selinux@vger.kernel.org>; Fri, 27 Feb 2026 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154898; cv=pass; b=b/brRdIpE+n06uOVeRNMbnuXyzjRCNLIDUlePrc1WKWN52tdOfXpqGZ6fdYGU7dCwHmPGeVgDnRU7mtfjJ6SwwfnC2Q5cbvVTadv2Dexihgh88feqAHPtktXFvT56Wr1c45t6vM534clPJ3GAAv2LP21Wnfff7xVKp9FQTCL2SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154898; c=relaxed/simple;
	bh=AFxEP4SVCc1CPd/QViXf8u7kAv9Bo53ydmyQL2ZQjQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jis9g2Nl/UyS7OzcUsGkzmhbkx8OZMQDFPAlmPBw+KanDUyCVRtsN+7zCZDebkcYlDvCHnjZg9WJwc9A3KqoKO4w0QZGXwPxjkA9qy6R4HEyczhDC5d4sFmgBfFQv7OILz6D/Qy/UoGOWnKxyBRMF8FJJ+MldCS2ng/GcbfDm9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U9/JjTBl; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U9/JjTBl"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354c19bf64bso623011a91.1
        for <selinux@vger.kernel.org>; Thu, 26 Feb 2026 17:14:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772154895; cv=none;
        d=google.com; s=arc-20240605;
        b=kQjJwP2Q6n+0cAxM3XJ4rm+e5tRV5nco+9VqLqz5QybQSXNrVKrnS3BaXYwp6xpNiY
         bVqfWdnlWZ0DA8emqP24XiWhfikVXkTool24+zqH9DsBjpQERyeW67a4+N0bh31wDAlW
         Y39CWZD+gaubtLZhKLzy3aZ+RR5W9rCwcXRiSqY3TqsxnYKmMU3x6RtUEy6LgxCA3AOE
         M2tbrC8L8NAynzP5MJA+8gtUSM2X/Nph/aYkKlCs9FLv0lBJQcx7Scshz+kQ3vflB1kK
         CHK0R1fFozwIzFcWjJ+j37ynPo6hTNN15AwCSOfRaBdH8grI8gy4tn47oDrF54N/Kjd9
         cRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQqUVN9Jj0ur5CDgtlNPFsrMXqiRpbvuG+RpeE9RNCs=;
        fh=1OY4tV9r8ZDS1yFU8pHxC4cnpwaSwrJ5DLBf3Qdp25I=;
        b=LuuIxfOdF9aasn65xexE67Q2WAYZJd8iQeNEPDTMie5N3MfyXXWoOmD7Fc1rTwft6N
         Sm6JOuaXtcyP6UqwXtsiYbL8roUYJh7k3pHwLw+5xjVvw8VsRc3uwXdrKoebKXdJJAGO
         qITBzZtCMbK3CacAQHRxMgvawT2tRtBy2AnIaVZdI6ZPPqQzA62uWi5Y9gnNSfnCoYH0
         S5Rjpu7gmFQu+8ucMi8jBNP5GFUWst2ySMKsE7vlIw6tFaVyUiJDXxkW92UTxT4Sl8ej
         mRFE4/BaBnGJ7i5MyQWVwGmvsfg9iRhxrniYioYzc7dCRNzb8uoLgtDyJr3HlOSXQRLw
         Pgrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772154895; x=1772759695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQqUVN9Jj0ur5CDgtlNPFsrMXqiRpbvuG+RpeE9RNCs=;
        b=U9/JjTBlnXUCb5bT+gPaB/6RoLQSwkluV0LnilvZSz8hFnRPy9U4G3zXt692hqnWU4
         aZ8AXHzEwkVvm+ExE1/Gck7CSbwyZUJpHaf2WAlt0BAvm4IhttqriMbMT7kprL4yvCuB
         hpAjYHuSXXtd3it6hUXirUiV2GpnvRShJ4+UX+ORqyTO2JIYctr8C+0Y7Gt1bXO0p9UA
         o8EAGjK04H5swdMXwP+lpE37+dIDSSPR2BWh74RRZ2TtidJvHxM8FrbZJDeQkLL5LYOo
         3TCy2FPI+F5NNsqr+xqTO+FrFqxOatWAjdq08zlrzNB+sXZwgGrrLBANij8A7w10+WB/
         nH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772154895; x=1772759695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQqUVN9Jj0ur5CDgtlNPFsrMXqiRpbvuG+RpeE9RNCs=;
        b=a8OmNwUXCRgmwseLhGKqRWbE929u1NX+lsIqleFyvzpKFpZyA0tYw8lUQBTLzIFA4E
         +r/xKlfAFrMl2Acsc5AKZju4kjmC1fIxJKmVbhCSgvTcnwtLyiZ3P8Hs7NLyERMXsBV+
         tztRIYRFq17F8fVFVvH9I0tSc5tVzTWGmE3o+nWs0sigR7mx5s6oT9p6mfkzDG19DLI9
         Kga/U2291BEGeZX5bCT1LTgbwL4WbNvmomA6G0jUKgAnk3uo5sYSvFVNBWHCwTDL6kxb
         BYJgwk7SYXQ2xJDY5UmsY24phvJ6dZJ0+/3FNDd6yaPMWZITJuwfPF68SWBPwzbvKvgp
         MU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXneVPiZ4vjWTE3a0/wQ+RN2MwZy9JyJZEgdfsavOPHlb9TpNwRSPiwVWn1WRcNW6mkzUtTpYYO@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTz5jpCJGlG0nxXXd10E00N+kF4BRy0RRvTrAYz+ZkKOuxFpe
	vftFKY5pW4nfWxakG3CUTcUSudN/Xg2frct8JE0zRoBIcm0egtBp/sLeBsNYSzJyBaE16M+QXzn
	6FfouBqYDCzo/x8X9OwlhTocCYkXwEalOmsKPQub+
X-Gm-Gg: ATEYQzzGE70o30+XuUPPNaWuk2627KrxN5nZnFwn1rVSj+H1q/mesUeTxKyFSZaCVdG
	jHixRRXy0yqLiTqpJD9jxQbaA2Jt9aBPIQt4RX+8zPEBg1ATz/UCAyLSEdamEVHWkmmc+KC1FZQ
	ioJNezWMQ/1eNOtwfR45qjQkevm//SoyheUoCYF2JW5bkK/i6rrO/MvylT6sHacEZ8a6xy8+Bjx
	erVqJVpjJ1JBr7FOav1ehpLokpT5FlxDmRm2OVOF4+Lo01xy1wN9tBCsC5n/U6oeadhFJdlzAnj
	14c/quI=
X-Received: by 2002:a17:90b:544b:b0:352:ece8:1f6c with SMTP id
 98e67ed59e1d1-3593862e0f3mr3813116a91.8.1772154895448; Thu, 26 Feb 2026
 17:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
 <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
 <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
 <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
 <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
 <aYmoDwO-YXrc4W1c@secunet.com> <85546d35-c7bd-49bf-b0c3-9677bde25859@I-love.SAKURA.ne.jp>
 <aYnDWbxo-jAzR4ca@secunet.com> <7c17884d-dbf1-4c2c-9813-0c5369cfdcc9@I-love.SAKURA.ne.jp>
 <aY76t_xYCHmLq6Ur@secunet.com>
In-Reply-To: <aY76t_xYCHmLq6Ur@secunet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Feb 2026 20:14:43 -0500
X-Gm-Features: AaiRm51x621_XfCY40Hc8f8iSKC879LJQZ171MjucCMdOkNtdcj3-nihadK0SaY
Message-ID: <CAHC9VhRvw+YCkxkdLr2smK+dXRTXSZY8zD=md-1CD02rRJbALg@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 5:19=E2=80=AFAM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
> On Mon, Feb 09, 2026 at 11:26:14PM +0900, Tetsuo Handa wrote:
> > On 2026/02/09 20:22, Steffen Klassert wrote:
> > > On Mon, Feb 09, 2026 at 07:02:47PM +0900, Tetsuo Handa wrote:
> > >> On 2026/02/09 18:25, Steffen Klassert wrote:

...

> And here we come to the other problem I mentioned. When a LSM policy
> rejects to flush the xfrm states and policies on network namespace
> exit, we leak all the xfrm states and policies in that namespace.
> Here we have no other option, we must flush the xfrm states and
> policies regardless of any LSM policy. This can be fixed with
> something like that:
>
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 72678053bd69..8a4b2cbba0e0 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -1822,9 +1822,11 @@ int xfrm_policy_flush(struct net *net, u8 type, bo=
ol task_valid)
>
>         spin_lock_bh(&net->xfrm.xfrm_policy_lock);
>
> -       err =3D xfrm_policy_flush_secctx_check(net, type, task_valid);
> -       if (err)
> -               goto out;
> +       if (task_valid) {
> +               err =3D xfrm_policy_flush_secctx_check(net, type, task_va=
lid);
> +               if (err)
> +                       goto out;
> +       }
>
>  again:
>         list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index f2aef404b583..fd00f2d20425 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -923,9 +923,11 @@ int xfrm_state_flush(struct net *net, u8 proto, bool=
 task_valid)
>         int i, err =3D 0, cnt =3D 0;
>
>         spin_lock_bh(&net->xfrm.xfrm_state_lock);
> -       err =3D xfrm_state_flush_secctx_check(net, proto, task_valid);
> -       if (err)
> -               goto out;
> +       if (task_valid) {
> +               err =3D xfrm_state_flush_secctx_check(net, proto, task_va=
lid);
> +               if (err)
> +                       goto out;
> +       }
>
>         err =3D -ESRCH;
>         for (i =3D 0; i <=3D net->xfrm.state_hmask; i++) {

This seems reasonable to me, and please correct me if I'm wrong, but
if the network namespace is gone at this point, we don't really have
to worry about traffic from any applications because there should no
longer be any processes in that namespace, yes?  I suppose there is
still a chance we'll see inbound traffic for endpoints in that
namespace, but I imagine the initns stack will reject it.

> > >> For example, we don't check permission for unmount when a mount is d=
eleted
> > >> due to teardown of a mount namespace. I wonder why you want to check=
 permission
> > >> for unregistering a net_device when triggered by a teardown path.
> > >
> > > I just try to find out what's the right thing to do here.
> > > If a policy goes away, packets that match this policy will
> > > find another path through the network stack. As best, they
> > > are dropped somewhere, but they can also leave on some other
> > > device without encryption. A LSM that implements xfrm hooks
> > > must be able to check the permission to delete the xfrm policy
> > > or state.
> >
> > Do you mean that calling xfrm_dev_down()/xfrm_dev_unregister() might
> > result in network traffic to be sent in cleartext ?
>
> Yes this can happen, but it is known. You can either install
> a global block policy with low priority or use a LSM to
> prevent this. The latter does not work unfortunately.

If I understand you correctly, the proposal below would address this
last part, yes?

> > If yes, we need to consider updating the other patch at
> > https://lkml.kernel.org/r/20260202123655.GK34749@unreal to replace
> > the NETDEV_UNREGISTER net_device with the blackhole_netdev. (That is,
> > xfrm_dev_{state,policy}_flush() does not actually delete a state/policy
> > but instead updates that state/policy to behave as a blackhole. Then,
> > we won't need to call LSM hooks because we no longer delete).
>
> I think there is a clean way to fix this. We could just unlink
> policy and state from the device. Then we could do the same as
> we do when a state becomes unavailable due to expiration. We mark
> the state as invalid with a flag. On expiration we do this with
> XFRM_STATE_EXPIRED. We can add a new flag and do the same as
> xfrm_state_check_expire() does on a hard expire. I.e. fire
> a timer that notifies the userspace key manager that this
> path is not avalable anymore and return an error. This way
> userspace is informed about that and all packets matching
> the policy are dropped.

This looks interesting.  The traffic would be dropped, and presumably
userspace could then cleanup the old state and establish any new
policy as required, yes?

> This is of course a bit more work and requires testing.

Tetsuo, Steffen, any chance one of the two of you would be able to
work on some patches for this?

--=20
paul-moore.com
