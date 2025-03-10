Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6611953A1;
	Mon, 10 Mar 2025 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741575290; cv=none; b=b3OY5O43U84CPkJHXCSz3DQ8YIpe1rZow2KSLigBPLOsTSjWYw2qJ8yUvR/Ud0BQWo5yX6Eznttng0ZEafQMTbWpmPOh8V/Ertx5NUeezAFZP1C/6Luff4G7ej5qPUmGQoCypCn96LGg6tIUpYFKngxTv1X4JHHu8ck2gX58kWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741575290; c=relaxed/simple;
	bh=bpYGyaGm/SuFsNipmVP3FIxSqKF/tOnmVKu6dRAU/sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKsheW3Z5GbfokLbR6jsMQQhRYevSPS9bI1qKs+m73Rc8pmjv8uAJZWDnm7Ft113gXOEKem00m9zqYWI2AfQTd7wCKaNLj9l5rkaPQktzGRGSDukJ6WWtPzBBiDoxkA1Hf1y8ungB6ir/lMALLCrJda9Dr8eBQg7X+nitaFmBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5IHhKpz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5IHhKpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741575289; x=1773111289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bpYGyaGm/SuFsNipmVP3FIxSqKF/tOnmVKu6dRAU/sA=;
  b=d5IHhKpz6yit7EePOYfXX8jR/NiN8Kz5D58utxHHe0VDsSJ+6v8Sznto
   hH3JVTICrkxoSWUsDYQ0s86S8rDuH9vQUZiS59GFVy7r85y1WdQK+y12j
   4S6zLWstkWkeou4ok7Trq8ZYSL4XMPv/7NRvSSlDRtUaslm7DnAE2uJKU
   TnXg5iMS5diaoDZTzYN3Vo55snZ/euZHCao/EXEsDw5Y7BuPIeJmaqDTx
   6Bu4M5FvtRN7+xqDQkKMauuaKA8vPEpaCygx3xjjwEuVEpZAPGM0G+tO7
   oFwA2pLUaxCoRn+hG+mWQ520YK1hNVYhX9XsnVzxjcH4hHqMmNNjlpjBh
   Q==;
X-CSE-ConnectionGUID: VJxSskBfSEmB3rbuurqFzw==
X-CSE-MsgGUID: GJAShM/vSAiOoyFAdoz6xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42266057"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42266057"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:54:48 -0700
X-CSE-ConnectionGUID: zBiG5oFZRCGvFY9BSb2WHw==
X-CSE-MsgGUID: Efzbl33CRtmJ58/i+iQZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124776590"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 09 Mar 2025 19:54:46 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trTHv-0003kM-1e;
	Mon, 10 Mar 2025 02:54:43 +0000
Date: Mon, 10 Mar 2025 10:54:13 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+00c633585760c05507c3@syzkaller.appspotmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, omosnace@redhat.com,
	paul@paul-moore.com, selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] selinux: read and write sid under lock
Message-ID: <202503101039.wURTMnYj-lkp@intel.com>
References: <tencent_0BEE86CD3878D26D402DDD6F949484E96E0A@qq.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0BEE86CD3878D26D402DDD6F949484E96E0A@qq.com>

Hi Edward,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/selinux-read-and-write-sid-under-lock/20250309-130846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/tencent_0BEE86CD3878D26D402DDD6F949484E96E0A%40qq.com
patch subject: [PATCH] selinux: read and write sid under lock
config: i386-defconfig (https://download.01.org/0day-ci/archive/20250310/202503101039.wURTMnYj-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503101039.wURTMnYj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503101039.wURTMnYj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/selinux/hooks.c:4718:21: error: no member named 'lock' in 'struct sk_security_struct'
    4718 |                 spin_lock(&sksec->lock);
         |                            ~~~~~  ^
   security/selinux/hooks.c:4721:23: error: no member named 'lock' in 'struct sk_security_struct'
    4721 |                 spin_unlock(&sksec->lock);
         |                              ~~~~~  ^
   security/selinux/hooks.c:5198:20: error: no member named 'lock' in 'struct sk_security_struct'
    5198 |         spin_lock(&sksec->lock);
         |                    ~~~~~  ^
   security/selinux/hooks.c:5200:22: error: no member named 'lock' in 'struct sk_security_struct'
    5200 |         spin_unlock(&sksec->lock);
         |                      ~~~~~  ^
   4 errors generated.


vim +4718 security/selinux/hooks.c

  4695	
  4696	static int selinux_socket_post_create(struct socket *sock, int family,
  4697					      int type, int protocol, int kern)
  4698	{
  4699		const struct task_security_struct *tsec = selinux_cred(current_cred());
  4700		struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
  4701		struct sk_security_struct *sksec;
  4702		u16 sclass = socket_type_to_security_class(family, type, protocol);
  4703		u32 sid = SECINITSID_KERNEL;
  4704		int err = 0;
  4705	
  4706		if (!kern) {
  4707			err = socket_sockcreate_sid(tsec, sclass, &sid);
  4708			if (err)
  4709				return err;
  4710		}
  4711	
  4712		isec->sclass = sclass;
  4713		isec->sid = sid;
  4714		isec->initialized = LABEL_INITIALIZED;
  4715	
  4716		if (sock->sk) {
  4717			sksec = selinux_sock(sock->sk);
> 4718			spin_lock(&sksec->lock);
  4719			sksec->sclass = sclass;
  4720			sksec->sid = sid;
  4721			spin_unlock(&sksec->lock);
  4722			/* Allows detection of the first association on this socket */
  4723			if (sksec->sclass == SECCLASS_SCTP_SOCKET)
  4724				sksec->sctp_assoc_state = SCTP_ASSOC_UNSET;
  4725	
  4726			err = selinux_netlbl_socket_post_create(sock->sk, family);
  4727		}
  4728	
  4729		return err;
  4730	}
  4731	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
