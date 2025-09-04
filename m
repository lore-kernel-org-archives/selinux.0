Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247CE2F4A1D
	for <selinux@vger.kernel.org>; Thu,  4 Sep 2025 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979567; cv=none; b=bEek9VzpuHAKZWQm7/xqnyWDw48LfYHgHJ69/mj9D07cCZiTTPUVD1t/3PTcVYi8fdOmG/BOuy0y+XFm1YwoHNWAbG7FfaKGV0ejPw0OK99FtH5SVhy8Xr2vBxwaCgRqvzqEK0qK5MZP7SabS9zC+jFciV87WabNmpzWUnhnZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979567; c=relaxed/simple;
	bh=r+uBilJr/vxSmXMH/1DtvnIISLAsJ6rpYpq0ZuqxWg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEZrRgnQVrOcuJizhhL94/rQGfqVk0hoBQos32cBq1mJO4FwnjCU6Uwd6XPB1lwNFVGZTAuAXNtUnoI+0iZXfn1zoFyLVz0u3j9n8kQ1M1zDMvCCDslOlptcZWFzY1Z3YGzmyppeyTSIJabnUPUpZpm7OmshBkhuAzsGpCXzkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5849qZi2091419;
	Thu, 4 Sep 2025 18:52:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5849qZxs091415
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 4 Sep 2025 18:52:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3be8c5b7-a5d1-497d-8fbd-c74c1e22034f@I-love.SAKURA.ne.jp>
Date: Thu, 4 Sep 2025 18:52:34 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar
 <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
References: <20250814225159.275901-36-paul@paul-moore.com>
 <20250814225159.275901-63-paul@paul-moore.com>
 <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhSf=zo0BkTc_=Qqq59OMVHsMUs_OqcmSUK501LYpAdMYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/09/04 5:32, Paul Moore wrote:
> On Thu, Aug 14, 2025 at 6:54 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> Reviewed-by: Kees Cook <kees@kernel.org>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/tomoyo/common.h        | 2 ++
>>  security/tomoyo/securityfs_if.c | 4 +---
>>  security/tomoyo/tomoyo.c        | 1 +
>>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> Tetsuo, does this look okay to you?
> 

Yes.

