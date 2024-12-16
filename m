Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D0204585;
	Mon, 16 Dec 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359296; cv=none; b=O+np9sXrwPGaObBlR6Zof3E8buIzSuZWrzAgc8EzjHddr/za1pDGvbaZka76uboY1Yq7qTuRiXfpX3yl3lBdJo72XVSTeKrls0X/+POfp01ZRK7r9msC9+nh/cod5TAZh3CNSbCGPckwHYiLlDZDv9nlNfIjE3SBbdezXo6seVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359296; c=relaxed/simple;
	bh=MElMlEENTYJQv3QEDrPQ4mKy0lTJukyrhv1g80PSamw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqXwSzLGNEFtEJ11AkcMZnLnQmiOtT55HssdpUXK/Wl3042Ci0swPfny8kYlto0BUS+roFbqdzSqphXkjhhJFnzgWWDMGaQysAx7mU0KC0FudlT8yZwfAN9QLhs8PoQNG7qQEWMdyj61xF0TiIgVjR89b5p4zMgZY0GBf6frCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NGXpTPYb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NGXpTPYb"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2E5E12042FD2;
	Mon, 16 Dec 2024 06:28:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E5E12042FD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734359294;
	bh=mxutLUmRXxC9hOlpMbuLFXyKhhFJ+piQ1nIkRvimiUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NGXpTPYbKBCdHz32jl9yMUfrprMYPH7JSSl+0PdnSf5tF2FX2TPZoNmbJ9PIJw/lc
	 jHl7um3476q1QA8D6AYQNCwfPhapI4ThMYh0q8bm3L5lzvz1d5VtrGbAW4sqVG78jQ
	 xLvanf70lOsFbCOUqTf8d46X3p1Waj9V5J7ETYO0=
Message-ID: <f00152c1-6eb9-487d-af69-42573b5f79bc@linux.microsoft.com>
Date: Mon, 16 Dec 2024 09:28:10 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/22] selinux: rename comparison functions for
 clarity
To: cgzones@googlemail.com, selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 John Johansen <john.johansen@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>,
 linux-kernel@vger.kernel.org
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
 <20241115133619.114393-6-cgoettsche@seltendoof.de>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20241115133619.114393-6-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/2024 8:35 AM, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> The functions context_cmp() and mls_context_cmp() are not traditional
> C style compare functions returning -1, 0, and 1 for less than, equal,
> and greater than; they only return whether their arguments are equal.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>   security/selinux/ss/context.c  |  2 +-
>   security/selinux/ss/context.h  | 10 +++++-----
>   security/selinux/ss/services.c |  2 +-
>   security/selinux/ss/sidtab.c   |  2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
> index e39990f494dd..a528b7f76280 100644
> --- a/security/selinux/ss/context.c
> +++ b/security/selinux/ss/context.c
> @@ -20,7 +20,7 @@ u32 context_compute_hash(const struct context *c)
>   	 * context struct with only the len & str set (and vice versa)
>   	 * under a given policy. Since context structs from different
>   	 * policies should never meet, it is safe to hash valid and
> -	 * invalid contexts differently. The context_cmp() function
> +	 * invalid contexts differently. The context_equal() function
>   	 * already operates under the same assumption.
>   	 */
>   	if (c->len)
> diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> index 7ccab2e6965f..e1307f6f7f50 100644
> --- a/security/selinux/ss/context.h
> +++ b/security/selinux/ss/context.h
> @@ -132,8 +132,8 @@ static inline int mls_context_glblub(struct context *dst,
>   	return rc;
>   }
>   
> -static inline int mls_context_cmp(const struct context *c1,
> -				  const struct context *c2)
> +static inline bool mls_context_equal(const struct context *c1,
> +				     const struct context *c2)
>   {
>   	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
>   		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&

Should the same logic in this patch be applied to ebitmap_cmp as well?

-Daniel

