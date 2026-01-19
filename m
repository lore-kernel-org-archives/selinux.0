Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F027FD48
	for <selinux@vger.kernel.org>; Mon, 19 Jan 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800452; cv=none; b=OXzsYpFAljeUg7D071638OiBkSEj7XVp9HjG0qP7ezKhizdX3pbqrc0eBv6aMJHZX3nTTb0EcuRDfPp8WL+fsc3XcZ1nnih+f0YqX6BwBGltWFglLD8+kGp7RIybNZ2Jm8a8k6bkZmGgVeK6wBJEY3lqUKHeKg7z9tl6VmNFH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800452; c=relaxed/simple;
	bh=GQyIKVnUIV+o89ZaVPW/6Orx8v9FcnDa0Oajgp1SONE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XUco5NkqQiyYdrdfim6K8M7pKeZSYq2hGzyzuV1OTOV7C2MPDHSzT3sYLaajicfKv2RA67i+hNVOPuiJ9GOvvyHB/cb9Lc/Mp0RpZRPc59vep7DsrAVWfbzCejfZ9aE+LQLwfBighPipoQq7aEJ2kaNL4+oM/Y3s87n4GM4R6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3XZ9bED; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3XZ9bED"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so21323425e9.2
        for <selinux@vger.kernel.org>; Sun, 18 Jan 2026 21:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768800449; x=1769405249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcHNJUeHYBB6SOgT0QQnF8ZJgMw39mShpamAL4iiy6o=;
        b=U3XZ9bED9kW2q5ElW4AXCLhN9XrwCQ0AIRSB7FLxYso+CehkA+vIVj0IhafFfkuJfa
         v6ae3tdjRTRIr9zEdj6TDIxwbNh9KAECU7twr9w32djVXG5eg+cXk1YfwXE6bfI1oWda
         2dSOmn3EodaxxgPQztU4qTwpxrl9yvnoK/yd6ibxEILhJ8APe76F8iXt0+zFnnJ/zUjM
         5o43ghGzW9tsoXay+12ldeWOT6EM1K9tAMIvzP/wj8vsAkdJC6SEu/l5XPfDLxUxXBjn
         E/kCm9qy7ETduHRr/h54rMDq/MTjqf6O2QeAP5YsjPSb+Yo5IA4sPv5ZR0y9AWpOicc/
         EskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768800449; x=1769405249;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcHNJUeHYBB6SOgT0QQnF8ZJgMw39mShpamAL4iiy6o=;
        b=cAsky1nFCPw2dGu0fgyPmqxDVRxoKfup7zlLQUBqnto69W9QoHWBevuuNK4bvqeFay
         H9a5tAUfGAlmHBUG7zNoYCykWYUKw2uIsUJBU6ZUhTGr/y7TJ+481+/YP75onhzs3JVP
         U/ZbM79A1819KBPO/pyvgA21S3h32jFBfjQukpotM6elvZKxNPA1YyZGr5DA2C92SI0t
         eS87e+92K8vVNL4jOmp6eXDLVC6z77Tlxb5JBuCc0a8yPo3haHuLluzGVQYCrEwpdrm1
         BdzwM7etmngcbEb+fThd/FpiPDgpJh4AsN+3SkDVm6aFUop9WPa9bOK3iAOybaXAVhwc
         6TUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeSwvu04UON0piV41t2Iyr3vb7V871d+ZauWwoDtlYikT8ud/Ztbyc+Dolb9EVEtJ28UEHE08Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqf0GqTusLzMm98L/DTQ8lttMvEKeytguAGDWjTV4ul3Ald/D/
	QvRZUJPojzYY3I3U6KeBvJa+Y3GTJ5/Vpa8hK7s4oBkXSgs1vFoqmIf9RzeQXE1hnVc=
X-Gm-Gg: AY/fxX7gldM0XqoTPMz89EMRn46PjkyiaOVkly0VD6kYKgxmxA6lgMdOImem5wN1f8f
	l8J9qYkSqOAFupBKk8Deq1+c3uOuTbooSJHPrwYqJdFEGnmASHsTbUQ2gz7/ISXTLJTzsuwyZtE
	u8epSvfgOSZ1Olw5P3GlkP0SAMoOWhOLw0DDP74F1uZ+o08NiMqaXkHxC0T5zEdgjhKGC8tqokz
	0DEYLwNzE2poGCs4du0K9Inped6ysChcesXi9MRHHEgJP7ruLdSTsU5bsmHUmEIHFsjK2up4UEy
	dUtL4hDJPdxvT3QNT3feP2PTrh9Mqag4xFPiDiKJopztnHV71HTagodSP0zlYQ61SdhtpB2hK0t
	E26Y0pANJGO6GF9JssL/uf1V4+A98IWr+mLN8CeopPTe9PY2hrgTsm/BKR/xT4yE5mIFe3Di4Xb
	XKwdNJBMLc+wmFDhRF
X-Received: by 2002:a05:600c:4f8a:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-4801e2f90camr128220315e9.6.1768800449052;
        Sun, 18 Jan 2026 21:27:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699980e5sm20818492f8f.41.2026.01.18.21.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 21:27:28 -0800 (PST)
Date: Mon, 19 Jan 2026 08:27:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH ipsec-next v2 4/4] xfrm: add XFRM_MSG_MIGRATE_STATE for
 single SA migration
Message-ID: <202601190605.ZVkgcUYl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony@secunet.com>

Hi Antony,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antony-Antony/xfrm-remove-redundant-assignments/20260118-041031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony%40secunet.com
patch subject: [PATCH ipsec-next v2 4/4] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
config: hexagon-randconfig-r072-20260118 (https://download.01.org/0day-ci/archive/20260119/202601190605.ZVkgcUYl-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
smatch version: v0.5.0-8985-g2614ff1a

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202601190605.ZVkgcUYl-lkp@intel.com/

New smatch warnings:
net/xfrm/xfrm_user.c:3299 xfrm_do_migrate_state() warn: missing error code? 'err'

Old smatch warnings:
net/xfrm/xfrm_user.c:1024 xfrm_add_sa() warn: missing error code? 'err'
net/xfrm/xfrm_user.c:2248 xfrm_add_policy() warn: missing error code? 'err'
net/xfrm/xfrm_user.c:3018 xfrm_add_acquire() warn: missing error code 'err'

vim +/err +3299 net/xfrm/xfrm_user.c

d3019c1db87425 Antony Antony 2026-01-17  3240  static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
d3019c1db87425 Antony Antony 2026-01-17  3241  				 struct nlattr **attrs, struct netlink_ext_ack *extack)
d3019c1db87425 Antony Antony 2026-01-17  3242  {
d3019c1db87425 Antony Antony 2026-01-17  3243  	int err = -ESRCH;
d3019c1db87425 Antony Antony 2026-01-17  3244  	struct xfrm_state *x;
d3019c1db87425 Antony Antony 2026-01-17  3245  	struct net *net = sock_net(skb->sk);
d3019c1db87425 Antony Antony 2026-01-17  3246  	struct xfrm_encap_tmpl *encap = NULL;
d3019c1db87425 Antony Antony 2026-01-17  3247  	struct xfrm_user_offload *xuo = NULL;
d3019c1db87425 Antony Antony 2026-01-17  3248  	struct xfrm_migrate m = { .old_saddr.a4 = 0,};
d3019c1db87425 Antony Antony 2026-01-17  3249  	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
d3019c1db87425 Antony Antony 2026-01-17  3250  
d3019c1db87425 Antony Antony 2026-01-17  3251  	if (!um->id.spi) {
d3019c1db87425 Antony Antony 2026-01-17  3252  		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
d3019c1db87425 Antony Antony 2026-01-17  3253  		return -EINVAL;
d3019c1db87425 Antony Antony 2026-01-17  3254  	}
d3019c1db87425 Antony Antony 2026-01-17  3255  
d3019c1db87425 Antony Antony 2026-01-17  3256  	err = copy_from_user_migrate_state(&m, um);
d3019c1db87425 Antony Antony 2026-01-17  3257  	if (err)
d3019c1db87425 Antony Antony 2026-01-17  3258  		return err;
d3019c1db87425 Antony Antony 2026-01-17  3259  
d3019c1db87425 Antony Antony 2026-01-17  3260  	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
d3019c1db87425 Antony Antony 2026-01-17  3261  
d3019c1db87425 Antony Antony 2026-01-17  3262  	if (x) {
d3019c1db87425 Antony Antony 2026-01-17  3263  		struct xfrm_state *xc;
d3019c1db87425 Antony Antony 2026-01-17  3264  
d3019c1db87425 Antony Antony 2026-01-17  3265  		if (!x->dir) {
d3019c1db87425 Antony Antony 2026-01-17  3266  			NL_SET_ERR_MSG(extack, "State direction is invalid");
d3019c1db87425 Antony Antony 2026-01-17  3267  			err = -EINVAL;
d3019c1db87425 Antony Antony 2026-01-17  3268  			goto error;
d3019c1db87425 Antony Antony 2026-01-17  3269  		}
d3019c1db87425 Antony Antony 2026-01-17  3270  
d3019c1db87425 Antony Antony 2026-01-17  3271  		if (attrs[XFRMA_ENCAP]) {
d3019c1db87425 Antony Antony 2026-01-17  3272  			encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]),
d3019c1db87425 Antony Antony 2026-01-17  3273  					sizeof(*encap), GFP_KERNEL);
d3019c1db87425 Antony Antony 2026-01-17  3274  			if (!encap) {
d3019c1db87425 Antony Antony 2026-01-17  3275  				err = -ENOMEM;
d3019c1db87425 Antony Antony 2026-01-17  3276  				goto error;
d3019c1db87425 Antony Antony 2026-01-17  3277  			}
d3019c1db87425 Antony Antony 2026-01-17  3278  		}
d3019c1db87425 Antony Antony 2026-01-17  3279  		if (attrs[XFRMA_OFFLOAD_DEV]) {
d3019c1db87425 Antony Antony 2026-01-17  3280  			xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
d3019c1db87425 Antony Antony 2026-01-17  3281  				      sizeof(*xuo), GFP_KERNEL);
d3019c1db87425 Antony Antony 2026-01-17  3282  			if (!xuo) {
d3019c1db87425 Antony Antony 2026-01-17  3283  				err = -ENOMEM;
d3019c1db87425 Antony Antony 2026-01-17  3284  				goto error;
d3019c1db87425 Antony Antony 2026-01-17  3285  			}
d3019c1db87425 Antony Antony 2026-01-17  3286  		}
d3019c1db87425 Antony Antony 2026-01-17  3287  		xc = xfrm_state_migrate(x, &m, encap, net, xuo, extack);
d3019c1db87425 Antony Antony 2026-01-17  3288  		if (xc) {
d3019c1db87425 Antony Antony 2026-01-17  3289  			xfrm_state_delete(x);
d3019c1db87425 Antony Antony 2026-01-17  3290  			xfrm_send_migrate_state(um, encap, xuo);
d3019c1db87425 Antony Antony 2026-01-17  3291  			err = 0;
d3019c1db87425 Antony Antony 2026-01-17  3292  		} else {
d3019c1db87425 Antony Antony 2026-01-17  3293  			if (extack && !extack->_msg)
d3019c1db87425 Antony Antony 2026-01-17  3294  				NL_SET_ERR_MSG(extack, "State migration clone failed");
d3019c1db87425 Antony Antony 2026-01-17  3295  			err = -EINVAL;
d3019c1db87425 Antony Antony 2026-01-17  3296  		}
d3019c1db87425 Antony Antony 2026-01-17  3297  	} else {
d3019c1db87425 Antony Antony 2026-01-17  3298  		NL_SET_ERR_MSG(extack, "Can not find state");
d3019c1db87425 Antony Antony 2026-01-17 @3299  		return err;

s/err/-ESRCH/.  err is zero/success here.

d3019c1db87425 Antony Antony 2026-01-17  3300  	}
d3019c1db87425 Antony Antony 2026-01-17  3301  error:
d3019c1db87425 Antony Antony 2026-01-17  3302  	xfrm_state_put(x);
d3019c1db87425 Antony Antony 2026-01-17  3303  	kfree(encap);
d3019c1db87425 Antony Antony 2026-01-17  3304  	kfree(xuo);
d3019c1db87425 Antony Antony 2026-01-17  3305  	return err;
d3019c1db87425 Antony Antony 2026-01-17  3306  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

