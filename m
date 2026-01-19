Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD08A33C53B;
	Mon, 19 Jan 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810927; cv=none; b=IsVuj/pANu0TC6wVInSO9I0Ag0LQdr41l9eVT4UtA6Uylnkz56POKYPIlclxQTmMB2IkpTlLYWTNS5s1LkZn6S8XO3l8eMx5pvoRnq5QPDQ480ANJjkSqHyMohJiWHVkxf15Ynlgib26X1CSj/SkZbPspDzYN1lxWnHwoiblhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810927; c=relaxed/simple;
	bh=Vt6zzwhGmWGRlCON3k9Se5L8LPU5Mhj929pi5nO8VUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAobs8Hf+IfoXkcoN7Aj6iiiamjult1qH7sGDX6P3zFHLQIhRjllSt11dQQ7qAabd/DlTAwRpZ7/YVjekFWMvml3JaoyPq4hZWjqiFiXlCVV530hq6O5o/5gyAxC521YQCcgjcRKdRCGS4GhfmjR29YxPRp2gu2eqAXiM5Caoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=NAAnz7RE; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="NAAnz7RE"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1768810915; x=1769674916; bh=Vt6z
	zwhGmWGRlCON3k9Se5L8LPU5Mhj929pi5nO8VUQ=; b=NAAnz7REg1si4QP/1x/c
	WeY1UjLtSpPzJyPldLuPbHO2/R1X82PKbCcz/di6pFCNmdMZD6x430y2nrPhzlrU
	qsEEUFF81sLyCR+p813+F4XggXREayDJHDcJeahXNWm3zawoTwRgWF4ILTvSfiQC
	BtKeFfvlk7z0QeBe1p4PzdIxYF5NVpgbf414bnCNP+GyLYz+2Zv2QRj7RMV1aNK8
	GVOIvtRvSCHBZLB5eBZzhZsA3tnNYzDA3SVz7wliJivbjGYMWReq17NEKHMrqx/D
	bNkyobyOxaPZOQs9agvyimqPb4bqtYehqfS9j0QSaG4ZiP0WLxk+DYAixmcgMEET
	/g==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Mon, 19 Jan 2026 09:21:53 +0100 (CET)
Date: Mon, 19 Jan 2026 09:21:51 +0100
From: Antony Antony <antony@phenome.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
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
Message-ID: <aW3pnybMNWNlIRH7@Antony2201.local>
References: <951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony@secunet.com>
 <202601190605.ZVkgcUYl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202601190605.ZVkgcUYl-lkp@intel.com>

Hi Dan,

On Mon, Jan 19, 2026 at 08:27:25AM +0300, Dan Carpenter via Devel wrote:
> Hi Antony,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Antony-Antony/xfrm-remove-redundant-assignments/20260118-041031
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
> patch link:    https://lore.kernel.org/r/951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony%40secunet.com
> patch subject: [PATCH ipsec-next v2 4/4] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
> config: hexagon-randconfig-r072-20260118 (https://download.01.org/0day-ci/archive/20260119/202601190605.ZVkgcUYl-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
> smatch version: v0.5.0-8985-g2614ff1a
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202601190605.ZVkgcUYl-lkp@intel.com/
> 
> New smatch warnings:
> net/xfrm/xfrm_user.c:3299 xfrm_do_migrate_state() warn: missing error code? 'err'

Looking at this more closely, xfrm_user_state_lookup() always sets *errp 
when it returns NULL.

> Old smatch warnings:
> net/xfrm/xfrm_user.c:1024 xfrm_add_sa() warn: missing error code? 'err'
> net/xfrm/xfrm_user.c:2248 xfrm_add_policy() warn: missing error code? 'err'
> net/xfrm/xfrm_user.c:3018 xfrm_add_acquire() warn: missing error code 'err'

Also, as the "Old smatch warnings" show, this same pattern exists elsewhere
in the file, most of the calls to xfrm_user_state_lookup().

I'm inclined to leave it as is rather than change a pattern that's 
consistent throughout the file. Does smatch follow the code doing
cross-function analysis? In this case, look into xfrm_user_state_lookup()
and further down to see that *errp is set when NULL is returned?

Thanks
-antony

> vim +/err +3299 net/xfrm/xfrm_user.c
> 
> d3019c1db87425 Antony Antony 2026-01-17  3240  static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
> d3019c1db87425 Antony Antony 2026-01-17  3241  				 struct nlattr **attrs, struct netlink_ext_ack *extack)
> d3019c1db87425 Antony Antony 2026-01-17  3242  {
> d3019c1db87425 Antony Antony 2026-01-17  3243  	int err = -ESRCH;
> d3019c1db87425 Antony Antony 2026-01-17  3244  	struct xfrm_state *x;
> d3019c1db87425 Antony Antony 2026-01-17  3245  	struct net *net = sock_net(skb->sk);
> d3019c1db87425 Antony Antony 2026-01-17  3246  	struct xfrm_encap_tmpl *encap = NULL;
> d3019c1db87425 Antony Antony 2026-01-17  3247  	struct xfrm_user_offload *xuo = NULL;
> d3019c1db87425 Antony Antony 2026-01-17  3248  	struct xfrm_migrate m = { .old_saddr.a4 = 0,};
> d3019c1db87425 Antony Antony 2026-01-17  3249  	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
> d3019c1db87425 Antony Antony 2026-01-17  3250  
> d3019c1db87425 Antony Antony 2026-01-17  3251  	if (!um->id.spi) {
> d3019c1db87425 Antony Antony 2026-01-17  3252  		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
> d3019c1db87425 Antony Antony 2026-01-17  3253  		return -EINVAL;
> d3019c1db87425 Antony Antony 2026-01-17  3254  	}
> d3019c1db87425 Antony Antony 2026-01-17  3255  
> d3019c1db87425 Antony Antony 2026-01-17  3256  	err = copy_from_user_migrate_state(&m, um);
> d3019c1db87425 Antony Antony 2026-01-17  3257  	if (err)
> d3019c1db87425 Antony Antony 2026-01-17  3258  		return err;
> d3019c1db87425 Antony Antony 2026-01-17  3259  
> d3019c1db87425 Antony Antony 2026-01-17  3260  	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
> d3019c1db87425 Antony Antony 2026-01-17  3261  
> d3019c1db87425 Antony Antony 2026-01-17  3262  	if (x) {
> d3019c1db87425 Antony Antony 2026-01-17  3263  		struct xfrm_state *xc;
> d3019c1db87425 Antony Antony 2026-01-17  3264  
> d3019c1db87425 Antony Antony 2026-01-17  3265  		if (!x->dir) {
> d3019c1db87425 Antony Antony 2026-01-17  3266  			NL_SET_ERR_MSG(extack, "State direction is invalid");
> d3019c1db87425 Antony Antony 2026-01-17  3267  			err = -EINVAL;
> d3019c1db87425 Antony Antony 2026-01-17  3268  			goto error;
> d3019c1db87425 Antony Antony 2026-01-17  3269  		}
> d3019c1db87425 Antony Antony 2026-01-17  3270  
> d3019c1db87425 Antony Antony 2026-01-17  3271  		if (attrs[XFRMA_ENCAP]) {
> d3019c1db87425 Antony Antony 2026-01-17  3272  			encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]),
> d3019c1db87425 Antony Antony 2026-01-17  3273  					sizeof(*encap), GFP_KERNEL);
> d3019c1db87425 Antony Antony 2026-01-17  3274  			if (!encap) {
> d3019c1db87425 Antony Antony 2026-01-17  3275  				err = -ENOMEM;
> d3019c1db87425 Antony Antony 2026-01-17  3276  				goto error;
> d3019c1db87425 Antony Antony 2026-01-17  3277  			}
> d3019c1db87425 Antony Antony 2026-01-17  3278  		}
> d3019c1db87425 Antony Antony 2026-01-17  3279  		if (attrs[XFRMA_OFFLOAD_DEV]) {
> d3019c1db87425 Antony Antony 2026-01-17  3280  			xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> d3019c1db87425 Antony Antony 2026-01-17  3281  				      sizeof(*xuo), GFP_KERNEL);
> d3019c1db87425 Antony Antony 2026-01-17  3282  			if (!xuo) {
> d3019c1db87425 Antony Antony 2026-01-17  3283  				err = -ENOMEM;
> d3019c1db87425 Antony Antony 2026-01-17  3284  				goto error;
> d3019c1db87425 Antony Antony 2026-01-17  3285  			}
> d3019c1db87425 Antony Antony 2026-01-17  3286  		}
> d3019c1db87425 Antony Antony 2026-01-17  3287  		xc = xfrm_state_migrate(x, &m, encap, net, xuo, extack);
> d3019c1db87425 Antony Antony 2026-01-17  3288  		if (xc) {
> d3019c1db87425 Antony Antony 2026-01-17  3289  			xfrm_state_delete(x);
> d3019c1db87425 Antony Antony 2026-01-17  3290  			xfrm_send_migrate_state(um, encap, xuo);
> d3019c1db87425 Antony Antony 2026-01-17  3291  			err = 0;
> d3019c1db87425 Antony Antony 2026-01-17  3292  		} else {
> d3019c1db87425 Antony Antony 2026-01-17  3293  			if (extack && !extack->_msg)
> d3019c1db87425 Antony Antony 2026-01-17  3294  				NL_SET_ERR_MSG(extack, "State migration clone failed");
> d3019c1db87425 Antony Antony 2026-01-17  3295  			err = -EINVAL;
> d3019c1db87425 Antony Antony 2026-01-17  3296  		}
> d3019c1db87425 Antony Antony 2026-01-17  3297  	} else {
> d3019c1db87425 Antony Antony 2026-01-17  3298  		NL_SET_ERR_MSG(extack, "Can not find state");
> d3019c1db87425 Antony Antony 2026-01-17 @3299  		return err;
> 
> s/err/-ESRCH/.  err is zero/success here.
> 
> d3019c1db87425 Antony Antony 2026-01-17  3300  	}
> d3019c1db87425 Antony Antony 2026-01-17  3301  error:
> d3019c1db87425 Antony Antony 2026-01-17  3302  	xfrm_state_put(x);
> d3019c1db87425 Antony Antony 2026-01-17  3303  	kfree(encap);
> d3019c1db87425 Antony Antony 2026-01-17  3304  	kfree(xuo);
> d3019c1db87425 Antony Antony 2026-01-17  3305  	return err;
> d3019c1db87425 Antony Antony 2026-01-17  3306  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> -- 
> Devel mailing list -- devel@lists.linux-ipsec.org
> To unsubscribe send an email to devel-leave@lists.linux-ipsec.org

