Received: from 2.mo583.mail-out.ovh.net (2.mo583.mail-out.ovh.net [178.33.109.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F26DCE3
	for <selinux@vger.kernel.org>; Thu, 14 Mar 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.109.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424844; cv=none; b=sTSBeYQCyjSChrZukvTNZUfWfqySQD0kK1xhdxQErF636gTp6KTpVs6+uNXHQBEyEcBSC8Sn4OABthdygISWqnQMqH6QDY/dNo7Hlw2p1/NWAR3c2Apl8mjtn2K3V5eaik1715z3OXh5hiBWro44MwaRj11tiukHs2NgiMKPYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424844; c=relaxed/simple;
	bh=U+xowBtqIre3LWrYMqV9TTZdASkB2YrieNdqOR172Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RvyYwQMGZdKth1TkfpYW5PcLG0X2uMtBgAmD3f+gsQk0f1c1CW/0/VM6lspe2EnckCynOY9Tw8SbVE527ly+p2HlDzssa/D4TZgafSsYGmrauoF2Ipw5SG+T4MVlHvC7oaRou82vWhhMeAUw1eEyLHJ3KQ8ykicV1zlEyv9/nBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwillikers.com; spf=pass smtp.mailfrom=jwillikers.com; arc=none smtp.client-ip=178.33.109.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwillikers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwillikers.com
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.17.203])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4TwTX43b8Mz1NXG
	for <selinux@vger.kernel.org>; Thu, 14 Mar 2024 13:59:32 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-b2v6c (unknown [10.111.174.60])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 385DE1FEE7;
	Thu, 14 Mar 2024 13:59:31 +0000 (UTC)
Received: from jwillikers.com ([37.59.142.110])
	by ghost-submission-6684bf9d7b-b2v6c with ESMTPSA
	id pvS4A8MC82X4zQAA60DLjw
	(envelope-from <jordan@jwillikers.com>); Thu, 14 Mar 2024 13:59:31 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S00409d8e42d-f973-47ad-9005-3728d640a575,
                    8CF15EA0C2CF9E4DB08C403A31B0CB6F73BB2D81) smtp.auth=jordan@jwillikers.com
X-OVh-ClientIp:69.5.141.1
Message-ID: <f87f2db0-3c2b-4ac9-94f3-ef7f0d95d3e8@jwillikers.com>
Date: Thu, 14 Mar 2024 08:59:29 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libselinux, libsepol: Add CFLAGS and LDFLAGS to Makefile
 checks
Content-Language: en-US
To: selinux@vger.kernel.org
References: <20240313224806.2859045-1-jwcart2@gmail.com>
Cc: James Carter <jwcart2@gmail.com>, jordan@jwillikers.com,
 winfried_mb2@xmsnet.nl
From: Jordan Williams <jordan@jwillikers.com>
In-Reply-To: <20240313224806.2859045-1-jwcart2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 199284286430477599
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfvefhjggtgfesthejredttddvjeenucfhrhhomheplfhorhgurghnucghihhllhhirghmshcuoehjohhruggrnhesjhifihhllhhikhgvrhhsrdgtohhmqeenucggtffrrghtthgvrhhnpefggfdvffelvdevfeeghfetkeeiieejuddtieetueeijeevtdelleeghffgiedtudenucfkphepuddvjedrtddrtddruddpieelrdehrddugedurddupdefjedrheelrddugedvrdduuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehjohhruggrnhesjhifihhllhhikhgvrhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht

On 3/13/24 17:48, James Carter wrote:
> In libselinux there is an availability check for strlcpy() and
> in both libselinux and libsepol there are availability checks for
> reallocarray() in the src Makfiles. CFLAGS and LDFLAGS are needed
> for cross-compiling, but, unfortunately, the default CFLAGS cause
> all of these availability checks to fail to compile because of
> compilationerrors (rather than just the function not being available).
>
> Add CFLAGS and LDFLAGS to the availibility checks, update the checks
> so that a compilation error will only happen if the function being
> checked for is not available, and make checks for the same function
> the same in both libselinux and libsepol.
>
> Suggested-by: Jordan Williams <jordan@jwillikers.com>
> Suggested-by: Winfried Dobbe <winfried_mb2@xmsnet.nl>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>   libselinux/src/Makefile | 4 ++--
>   libsepol/src/Makefile   | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index d3b981fc..41cfbdca 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -104,13 +104,13 @@ override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
>   
>   # check for strlcpy(3) availability
>   H := \#
> -ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char*d,*s;strlcpy(d, s, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char d[2];const char *s="a";return (size_t)strlcpy(d,s,sizeof(d))>=sizeof(d);}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
>   override CFLAGS += -DHAVE_STRLCPY
>   endif
>   
>   # check for reallocarray(3) availability
>   H := \#
> -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){reallocarray(NULL, 0, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
>   override CFLAGS += -DHAVE_REALLOCARRAY
>   endif
>   
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 16b9bd5e..7b0e8446 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -31,7 +31,7 @@ endif
>   
>   # check for reallocarray(3) availability
>   H := \#
> -ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>\nint main(void){void*p=reallocarray(NULL, 1, sizeof(char));return 0;}' | $(CC) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
>   override CFLAGS += -DHAVE_REALLOCARRAY
>   endif
>   
This works great, thanks!
