Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5121366541;
	Mon,  9 Feb 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631413; cv=none; b=KTy+0V7q1pl83F5MtYReYmiV1uBMNt1IAvMb4m9fEKf52hxE5i1+XaWSc+q4vWnwEAjAYsA0sQ0356auB4NtdxsyhF++onPwkiCA+NviogXgrIMI6nJuM7b3QTw/4R6uP+kGyzkC681BaQFh4MK2GdvaotcJHlt59KkwK5Q0dDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631413; c=relaxed/simple;
	bh=WjbpcBJrTCw2VxKXHrEc6wUoh07yU+yuSD46xsD9lLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIJ653M6qxWs1l+2ItFRVQ9qqFN4QzU5Z8BIqK8UEM10Qx5W9Z+sUhNpi50DfrzQe4GlcKwQ60AOFk3t6jvnUjBaOE7mb2784caI4ZaCTvZlE4xcI6YiLTAkL4qrNRDjvao1jcNoXG4UI0oSPRVG6U5eAUEpNQhzv7PKpyRJqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 619A2tgd071551;
	Mon, 9 Feb 2026 19:02:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 619A2l00071490
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 9 Feb 2026 19:02:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <85546d35-c7bd-49bf-b0c3-9677bde25859@I-love.SAKURA.ne.jp>
Date: Mon, 9 Feb 2026 19:02:47 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
 <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
 <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
 <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
 <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
 <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
 <aYmoDwO-YXrc4W1c@secunet.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aYmoDwO-YXrc4W1c@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/02/09 18:25, Steffen Klassert wrote:
> The problem is that, with adding IPsec offloads to netdevices, security
> critical resources came into the netdevices. Someone who has no
> capabilities to delete xfrm states or xfrm policies should not be able
> to unregister the netdevice if xfrm states or xfrm policies are
> offloaded. Unfortunately, unregistering can't be canceled at this stage
> anymore. So I think we need some netdevice unregistration hook for
> the LSM subsystem so it can check for xfrm states or xfrm policies
> and refuse the unregistration before we actually start to remove
> the device.

Unfortunately, unregistering is not always triggered by a user's request. ;-)

For example, we don't check permission for unmount when a mount is deleted
due to teardown of a mount namespace. I wonder why you want to check permission
for unregistering a net_device when triggered by a teardown path.

> 
> The same happened btw. when xfrm was made per network namespace.
> Here we just leak the xfrm states and xfrm policies if some
> LSM refuses to remove them.
> 
> I guess we need a solution for both cases.

Is replacing the NETDEV_UNREGISTER net_device with the blackhole_netdev applicable
( https://elixir.bootlin.com/linux/v6.19-rc5/source/net/xfrm/xfrm_policy.c#L3948 ) ?
If no, there is no choice but break SELinux's expectation.

