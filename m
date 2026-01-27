Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA11F9ECB;
	Tue, 27 Jan 2026 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485919; cv=none; b=dy8xGlIenOgfs0uPuKBbFNJRAysVdIWFnneTguT5O+pF3oAaw9Yay4d5dAoV6VivFz5MzqYyLQ3MbRwASN/+Dm+WDoExsgE1ops9zDKHWlXWwA04HmYL8yPJWWLd616LKVyFT41ax8JSCHxbsQaww56ZuTBMvpI6YTWscTcXEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485919; c=relaxed/simple;
	bh=bRkobea5ohiwWDKJh9IQ7cjBDH3Erht57kFyuuUvxww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJiGvOxLxBYPPrR8joda7KY+HPLbjmQQxxfijyje8GzxEw8o/8J8aW+pZhHClcsXshraxVBQfsZQsQWsc9YkcXCfgEsaLJmfCgHOYnCyDt83v8MsVI8YT14WmP6NpYuj3J//DZqJjPyEJgsfje6U1+SDD1MJLutaU1eOaBikwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60R3pUI5089632;
	Tue, 27 Jan 2026 12:51:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60R3pT3q089629
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 27 Jan 2026 12:51:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
Date: Tue, 27 Jan 2026 12:51:29 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp

On 2026/01/27 7:33, Paul Moore wrote:
> On Fri, Jan 23, 2026 at 5:13 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Since xfrm_dev_{state,policy}_flush() are called from only NETDEV_DOWN and
>> NETDEV_UNREGISTER events, making xfrm_dev_{state,policy}_flush() no-op by
>> returning an error value from xfrm_dev_{state,policy}_flush_secctx_check()
>> is pointless. Especially, if xfrm_dev_{state,policy}_flush_secctx_check()
>> returned an error value upon NETDEV_UNREGISTER event, the system will hung
>> up with
>>
>>   unregister_netdevice: waiting for $dev to become free. Usage count = $count
>>
>> message because the reference to $dev acquired by
>> xfrm_dev_{state,policy}_add() cannot be released.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>>  net/xfrm/xfrm_policy.c | 35 -----------------------------------
>>  net/xfrm/xfrm_state.c  | 33 ---------------------------------
>>  2 files changed, 68 deletions(-)
> 
> I didn't make it very far into reviewing this patch, because it looks
> like xfrm_dev_state_flush() is called by the bonding driver's
> notification handler, and I don't see that reflected in this patch?

xfrm_dev_{state,policy}_flush() are called from only the bonding driver's NETDEV_UNREGISTER
event notification handler and the xfrm module's NETDEV_DOWN event / NETDEV_UNREGISTER event
notification handler ( https://elixir.bootlin.com/linux/v6.19-rc5/A/ident/xfrm_dev_state_flush ).

What this patch kills is not xfrm_dev_{state,policy}_flush() but
xfrm_dev_{state,policy}_flush_secctx_check(). No need to touch the bonding driver.

LSM hook for checking whether to allow deleting a file in tmpfs which is still mounted
makes sense, LSM hook for checking whether to allow starting unmount of tmpfs makes sense,
but LSM hook for checking whether to allow releasing memory in tmpfs while unmount operation
is already in progress causes nothing but a resource leak / denial-of-service kernel bug.

What xfrm_dev_{state,policy}_flush_secctx_check() are causing is something like
"LSM policy is refusing release of memory used by a file in tmpfs which is already under
unmount operation".
xfrm_dev_{state,policy}_flush_secctx_check() are too late to make LSM policy decision.
A must-not-fail operation has already started before LSM hooks are called.

