Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DA27A123;
	Wed,  4 Feb 2026 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213477; cv=none; b=F/mkU2vW5l2RzSJlyx37ODpG5jkAiRdLEBvivRVLPoHL1g89RlwofIGBhbe+HXFDBnTccAxR94V9QtSznwDBHmL12Fdv7+/v+iVrsFq89mQF2wNjG1ohNVKGwGO2Sr0Rye3Z7XdhuROH5DGg6NliWbcEd5+hcFHlgBhmSzmTzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213477; c=relaxed/simple;
	bh=1NY8xj1oVBOa9QdXJ3gXRwK8an5wtbxELhV+G98rDA8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NXPjVqg9oROlxJBkqI4e1sL3GAJOA+L2iURbSnyWR/xcCrftoEmaFxH5UcwgofLEORMmC50pCsUBOqcE3Fo94JIx4stqJpC085Fm7juudMUMnkGzMsVt/BmzIHt6r4ZJkcNIOip2w/EdiByq+cKMdevpAt9eyL0Qc7QtA5gVCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 614DvVf5022147;
	Wed, 4 Feb 2026 22:57:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 614DvUCt022144
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 4 Feb 2026 22:57:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7ef21dab-3805-4eae-80d7-9779aeff3f58@I-love.SAKURA.ne.jp>
Date: Wed, 4 Feb 2026 22:57:30 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
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
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
 <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com>
 <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
 <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
 <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <74a70504-8ff8-4d97-b35f-774364779889@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/02/04 19:15, Tetsuo Handa wrote:
> On 2026/02/04 7:40, Paul Moore wrote:
>>         This is not an unusual request for such a proposed change, and
>> is something that I would expect a LSM maintainer to do without much
>> hesitation.  If you are unwilling to investigate this, can you explain
>> why?
> 
> Because I'm not familiar with how XFRM works; I'm not a user of LSM XFRM hooks.
> 
> I can't judge whether the current code is COMPREHENSIVELY GATING;
> I can't imagine what the state you call COMPREHENSIVELY GATING is.

Steffen Klassert worried that killing xfrm_dev_state_flush_secctx_check() and
xfrm_dev_policy_flush_secctx_check() might violate a LSM policy and you agreed
( https://lkml.kernel.org/r/CAHC9VhQ54LRD7k_x6tUju2kPVBEHcdgBh46_hBN8btG0vhfy_w@mail.gmail.com ),
but the reality is that nobody in the world has enforced an LSM policy for almost 9 years
that makes xfrm_dev_{state,policy}_flush() no-op. That is, xfrm_dev_state_flush_secctx_check()
and xfrm_dev_policy_flush_secctx_check() had been effectively unused.

Killing xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check()
increases "system's stability" without sacrificing "authorization".

It is up to SELinux developers to discuss what actions to take as a compensation for
killing xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check().
The compensation might be to add LSM hooks to immediately before the point of no return.
But I wonder why you want to authorize deleting resources which are going to be "deleted by
cascade" due to deleting a dependent resource...

> 
> 
> 
> P.S. For your investigation, I attach a new report that syzbot found today, and
> I'll drop "xfrm: always fail xfrm_dev_{state,policy}_flush_secctx_check()"
> because these three reports will be sufficient for people to understand that
> we need to kill xfrm_dev_{state,policy}_flush_secctx_check() calls.

