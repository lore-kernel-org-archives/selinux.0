Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D3350A07
	for <selinux@vger.kernel.org>; Mon, 19 Jan 2026 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812964; cv=none; b=b7JG/0Ta29KBZIGjpOXbxZ7wHhmzZFkqEPp1sD7bXZ7wGT5UCqCKvxwSkrvhdIonqmHZV3OzqNsl164rZnjlZBMgE8cMl9Aa278mnPWiqV04VNu4ouGBXpuVO1V+PXydEQtczIUIiDECG/yhE8+E52ewVJChmyO0L3yA3sgQiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812964; c=relaxed/simple;
	bh=yuzk4HCkmCLSzrI3p4aqbiLdRuxIs3CtoWGhU33hNLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B39pT0dmfUCYlCgWIz/bHlKeNG1H2cJuvr+4fEfHa730eE0tOTKQl4gRpyTjCTz5DakREGMR2aBifrzbFNaDmz7jlNmyDJ7K8ZT0qmG3ElLs0ZJ4d6C1i0txcQVzDc/00g+0lmO1LYgOuMgSf3w4CVR4IXxyUOROuFXUPcKkYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jREKgKp9; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jREKgKp9"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-430f57cd471so2010320f8f.0
        for <selinux@vger.kernel.org>; Mon, 19 Jan 2026 00:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768812959; x=1769417759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltjz/smMzvjpsohpXR7hQ21/EDxVXQBbnheqC1Ei6f0=;
        b=jREKgKp9y4zTiFW8cccqbZNoPIVQvJhR25Pszp4fDzBSkaMiB21jnwH7P9FiTGyWNm
         bZ46rld7gHxo/V2TZoHi7UEY6PnLLNY1WcjF+UIQco6zCr2XiD9kzyUfidq26isC6C5k
         SL9yP4KtbHkUSqsl4Yxu/W9CzoAWE7IbyoV6GZN4F6S6TJ0WOkYBUYBNvyqE1WyjIH7f
         orIrq7B5apQjM4eNVW232WP6uQZkF09H64VSwSf2J9GRFYCHDKCltXPVy4Nt337YfIt/
         JurLeGEszWUkjuNhkEoP5Knol62Ok8XAmDnaZ/p7MC2YzIFB1v8GbGQ9T6qkwaQTl0NI
         bQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768812959; x=1769417759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ltjz/smMzvjpsohpXR7hQ21/EDxVXQBbnheqC1Ei6f0=;
        b=mK2zc0siCBNr2fFE/t7vRmaZ55F6bCgktwj98LOrYWU5eLV15YklclUWtdFpeUZPzT
         vJY9DEdlk+/ZZI87RXHNyTUL0ttTads1v35gSF7pKOFQRm/mRDZxH+P4sayPaLUGBgLc
         eXsCHQfJU1b2NOlfo3Gs2vh9UeZ27EnvqA1xKEVMgREYv+nf6gmGXKf4otV6uVQJChcX
         iHfbI0+Tx0usApgWLxVEuhy7dkuo19KFRFx6Si2MpKuMHl3TV77rs9V/YlNFp8VYvavf
         soFPfgOAgBBEpKZVv8nynlS92cjH7Rlp9b8OXSwP8mK4z9TMG3ig9fBpco44WO6Neza4
         cPLg==
X-Forwarded-Encrypted: i=1; AJvYcCV9segpEeNUQDzi6VAGlCdwCdcLK45wh8YTiIF17BKlh77UGRYAgpNvqZxpP0H3gz/QEA3YmbO4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1UaBUImaKLGwP3Q5Mck5RTGF1DgC32PlpY3xayEgltPoQsaM
	IP/UBQeq36ZiM1ZMh8AWPthZnl7KNtlNFi6KE79TPwuqYs/dbFWJVm6kCYcIJzglPQ8=
X-Gm-Gg: AZuq6aKXYCNjCdqkVw3rG8szKJIirhlsJmyVeQVd8Shmc7brCR+lEHuoo3APvjg1JTK
	O5741q11io28LYLtvGUc8kXDd+5sutBBvBtIAx3+0Nj1p/LeX42xZhvxBZvChR3gIN5dfkcHTu3
	u5Uk5hhqmhe0JltecvdCAcSWBuH/3Fzt+x2tkeFWsT0ryS1mOmXiPKDb2f3VbxiwTT3evc/9Drz
	fgZjT+I2zTCCURImqpNY8Fv0g22BFOP5aueSTYkMq0WMcAvppYCSa+I+pZy9lMgTk3XrOIK1IZc
	pl63mCcwVd2IfLGp6WG2Q7gEhHVqWet9X7qffm9P+VXTyyIeTZE1ZrRtBevQ1o38TSWYs4k3m+7
	DOMIHefpXapUsPUjjsUELaQA4eURQhPDGvEDQRYBb9um3mMW2NDm3XDfyq2agKeQy5OzEtGh0bn
	SiX9nGyR0+e8SjMph9
X-Received: by 2002:a05:6000:2505:b0:42f:f627:3aa7 with SMTP id ffacd0b85a97d-4356a0298d8mr13122462f8f.16.1768812959229;
        Mon, 19 Jan 2026 00:55:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996e2d8sm21807525f8f.28.2026.01.19.00.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 00:55:58 -0800 (PST)
Date: Mon, 19 Jan 2026 11:55:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Antony Antony <antony@phenome.org>
Cc: oe-kbuild@lists.linux.dev, Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v2 4/4] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
Message-ID: <aW3xmwA9tTsWImwr@stanley.mountain>
References: <951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony@secunet.com>
 <202601190605.ZVkgcUYl-lkp@intel.com>
 <aW3pnybMNWNlIRH7@Antony2201.local>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW3pnybMNWNlIRH7@Antony2201.local>

On Mon, Jan 19, 2026 at 09:21:51AM +0100, Antony Antony wrote:
> Hi Dan,
> 
> On Mon, Jan 19, 2026 at 08:27:25AM +0300, Dan Carpenter via Devel wrote:
> > Hi Antony,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Antony-Antony/xfrm-remove-redundant-assignments/20260118-041031
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
> > patch link:    https://lore.kernel.org/r/951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony%40secunet.com
> > patch subject: [PATCH ipsec-next v2 4/4] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
> > config: hexagon-randconfig-r072-20260118 (https://download.01.org/0day-ci/archive/20260119/202601190605.ZVkgcUYl-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
> > smatch version: v0.5.0-8985-g2614ff1a
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202601190605.ZVkgcUYl-lkp@intel.com/
> > 
> > New smatch warnings:
> > net/xfrm/xfrm_user.c:3299 xfrm_do_migrate_state() warn: missing error code? 'err'
> 
> Looking at this more closely, xfrm_user_state_lookup() always sets *errp 
> when it returns NULL.
> 
> > Old smatch warnings:
> > net/xfrm/xfrm_user.c:1024 xfrm_add_sa() warn: missing error code? 'err'
> > net/xfrm/xfrm_user.c:2248 xfrm_add_policy() warn: missing error code? 'err'
> > net/xfrm/xfrm_user.c:3018 xfrm_add_acquire() warn: missing error code 'err'
> 
> Also, as the "Old smatch warnings" show, this same pattern exists elsewhere
> in the file, most of the calls to xfrm_user_state_lookup().
> 
> I'm inclined to leave it as is rather than change a pattern that's 
> consistent throughout the file. Does smatch follow the code doing
> cross-function analysis? In this case, look into xfrm_user_state_lookup()
> and further down to see that *errp is set when NULL is returned?
> 

Ah, right.  Sorry about that.  Yes, of course, it shouldn't be
changed.

The zero day bot can't do cross function analysis because it doesn't
scale for the number of trees the bot tests...

regards,
dan carpenter


