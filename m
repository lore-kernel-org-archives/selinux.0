Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6CF29A2;
	Sun,  7 Sep 2025 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757219536; cv=none; b=HZ9H7YdZNeSD1H0Jubz+YZaa9hRS+Nz9z1OZAnhcrhMyf2yppFxgg+z8J51wm4C1vhuARQMdvlw3WFnJuq/Ja7zMLNFMROin9PFfvjW5yj0lg2OT2LpOwFBgm0W/q2sCDEFlAVipxBjXWClbP0fA6C/JsFo4iXnEyg8GS0V9oWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757219536; c=relaxed/simple;
	bh=+8yI6fgJ5qXRBIy4nAJK63uggFckulfZtEQH+td3NO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI7BYqVwoTKzfKv0D0RnbmgIjoYpDMhn8QbqV/3YjDYRxkzEyUHf/w8rWC5R6hsUYipehtPIq/fE9ijh0qk4ACQhrhdnmXvI4oiqNiDvCiSE638skNjc+YKzgQLi5xghpVum4FSNm2FLR05PaP3ehR13KF4WYcoWWyJ7X5/oWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwbpFKb4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwbpFKb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757219535; x=1788755535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+8yI6fgJ5qXRBIy4nAJK63uggFckulfZtEQH+td3NO0=;
  b=EwbpFKb4wIELtU+A746UlnzfvN45cjOSBntz48Ss1VSAH2zf+fwAxUEA
   iaDVUgwQwZnllBC/I8XMy/1QO7Np10UPPW/2v3n8B8Ad6o8GphnkK0dXY
   eisY0Hz45Xcg0JgZi6L1PCtAfs3xJ3WDQsBSE89Ru3gBpbOj2+iB5xCAe
   +hRPoKYPEqt+j/aZXacc7gwPLTVi0NOOJapldceB8ARfEEe80o/3ZjgBK
   PYcFpiMRKcHfOu7LJwwDLY5MyKDuxFf3MrDObL90tRFvXOUcjMMxENtjx
   vdT/WC4NXLkO9NVix1+7PVYvb2Oeite5awuBzOc9TTHeLWJJZv9nWvenC
   w==;
X-CSE-ConnectionGUID: hWtn2WjzS32tV7fcvOIlvA==
X-CSE-MsgGUID: 2/lZ6kvoSAiJAFOu6e1BNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="47082792"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="47082792"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 21:32:14 -0700
X-CSE-ConnectionGUID: UEUAutZoTamiLqUEzDzCKg==
X-CSE-MsgGUID: eIAw2afWROWQEf3aazZtwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="172599663"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Sep 2025 21:32:11 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv74T-00021v-2A;
	Sun, 07 Sep 2025 04:32:09 +0000
Date: Sun, 7 Sep 2025 12:31:34 +0800
From: kernel test robot <lkp@intel.com>
To: Hongru Zhang <zhanghongru06@gmail.com>, paul@paul-moore.com,
	stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, Hongru Zhang <zhanghongru@xiaomi.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during
 boot
Message-ID: <202509071211.k5n864Gr-lkp@intel.com>
References: <20250905100454.685866-1-zhanghongru@xiaomi.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905100454.685866-1-zhanghongru@xiaomi.com>

Hi Hongru,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-selinux/next]
[also build test WARNING on linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongru-Zhang/selinux-Make-avc-cache-slot-size-configurable-during-boot/20250905-180729
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20250905100454.685866-1-zhanghongru%40xiaomi.com
patch subject: [PATCH] selinux: Make avc cache slot size configurable during boot
config: i386-randconfig-063-20250907 (https://download.01.org/0day-ci/archive/20250907/202509071211.k5n864Gr-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509071211.k5n864Gr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509071211.k5n864Gr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> security/selinux/avc.c:37:5: sparse: sparse: symbol 'avc_cache_slots' was not declared. Should it be static?

vim +/avc_cache_slots +37 security/selinux/avc.c

    36	
  > 37	int avc_cache_slots __ro_after_init = 512;
    38	#define AVC_DEF_CACHE_THRESHOLD		512
    39	#define AVC_CACHE_RECLAIM		16
    40	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
