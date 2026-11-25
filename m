Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575019;
	b=RQGNNk2rZHMv68uuW5m5YRHzkCcsKneP0FXqSCUB3I9RiHL+WBfwQOUVqquJ6TyMpZ7j
	 xV17nJ3QQ19rAE/qrVk7BQ3mWd/JhID2cwPqr//hUZftVovlgOMdmh0STcG8gsVuvHT/x
	 /LodffQVV0tLXDr/qF8ySanoFISwW4hcNv2f/cKo3/+/o/w4I77bmnAQC497jNnq5ANLc
	 GOO7EsAzXnxHgKezdCxCmX0l1zOYVUEoS3F6/rkCsahSoPK9/XC3ckzQOHxhqlWjB7wLg
	 8X2bW7WnRG6budCG4NYxFk8Vak3uS0MJaQLdnZqNjv8QsNggI5cEkz2PYTcpG5+fzxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575019;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hjTsEiHsB3scrTtDDV5jrh4xR7hyZtuQPmXQXJ4G5oA=;
	b=o7gf6AXiI5IH7UkVZMkv2Glhpq1xjG+rB5lF42iefZ8fjBsu5PtBBz2BeGr+Vj1ydPMJ
	 spgzMCEtOFoHDKtTdVD0JzdF6HKdM2QG7jkEVYaqP1tiLG1LxV5XsjcIDabmZIblV/brP
	 sG7j6PwiE2Ha9hESSTop48DAkSi3xA2tSkitEgPtbL+uvA3vlO6Hksk55o21Us96Cn771
	 C6OYLIyEgm4WICIyWqYVLtS87oS3lXeAiYl3k5/XDWMChNQkChXXIMlMRYETlCYKdm1ju
	 qWOWug8kGBunYw3b2orVrTOovdR8mlioBMryhqC+awzd3gFTvU6ogw6mdyjVe9sENfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YqFq14zg;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FD606A69C;
	Wed, 25 Nov 2026 02:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 129FD606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YqFq14zg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795575019; x=1827111019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FMJRwqJHxhDPXVt+DDIaX5xHOfNnwmDVihBZyK76jyw=;
  b=YqFq14zgaQoW6sdIxFjmKVUmQswP7w+TU8pTEbz3pZhnes5nPpCXmeR3
   pcErAriQhH/ZFTUq7iNqtGQzKLjiWgxjJNN+CYTT4RzLi12tKQigk8Xpr
   0WeY4dLoOOPNh5Bf/apH9xSdy2umM2tBL+Lfr5CV3gxl1bPyrdOVl28Y2
   95qVxPVMSrxfAz5vqpTtzntXZtu5CZWVJk6wgOFmBzJdp0tPunAxFB8uv
   dszJb4UeKCo8ZYHU6/0WvSTn7IAXDo8DTFn76a1EJOrxNyOMyx4DhPJff
   TSvhqNuyZvdS4kMB177DwZBX0GyxJuir1U7ouIr3NDc5o9tDDtLQSvaMQ
   w==;
X-CSE-ConnectionGUID: 37lm8xUBRpuuj/ice43MqA==
X-CSE-MsgGUID: r3QSZk2wS86oRl4Zmhloig==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4312484"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4312484"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 18:50:18 -0800
X-CSE-ConnectionGUID: LGuQYm+xS0WWm+/cuAibYA==
X-CSE-MsgGUID: BbyHB66dR1+vA+YgeLPFng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11851290"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2026 18:50:16 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xW35I-00000001Qio-3vrh;
	Wed, 25 Nov 2026 02:50:12 +0000
Date: Wed, 25 Nov 2026 10:49:39 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
	keescook@chromium.org, john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
	selinux@vger.kernel.org
Subject: Re: [PATCH 1/1] LSM: infrastructure management of mount options
Message-ID: <20261125104210.ICeMgnNL-lkp@intel.com>
References: <20261124181522.30415-2-casey@schaufler-ca.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124181522.30415-2-casey@schaufler-ca.com>

Hi Casey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-selinux/next]
[also build test WARNING on linus/master v7.4-rc4 next-20261124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-infrastructure-management-of-mount-options/20261124-101522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20261124181522.30415-2-casey%40schaufler-ca.com
patch subject: [PATCH 1/1] LSM: infrastructure management of mount options
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20261125/20261125104210.ICeMgnNL-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 2012344e5da8e03ea4b8283ecd6fad6e13f09d64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261125/20261125104210.ICeMgnNL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125104210.ICeMgnNL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/selinux/hooks.c:2887:6: warning: variable 'opts' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    2887 |         if (!fc->security) {
         |             ^~~~~~~~~~~~~
   security/selinux/hooks.c:2903:2: note: uninitialized use occurs here
    2903 |         opts->initialized = true;
         |         ^~~~
   security/selinux/hooks.c:2887:2: note: remove the 'if' if its condition is always true
    2887 |         if (!fc->security) {
         |         ^~~~~~~~~~~~~~~~~~
   security/selinux/hooks.c:2878:31: note: initialize the variable 'opts' to silence this warning
    2878 |         struct selinux_mnt_opts *opts;
         |                                      ^
         |                                       = NULL
   1 warning generated.


vim +2887 security/selinux/hooks.c

  2873	
  2874	static int selinux_fs_context_submount(struct fs_context *fc,
  2875					   struct super_block *reference)
  2876	{
  2877		const struct superblock_security_struct *sbsec = selinux_superblock(reference);
  2878		struct selinux_mnt_opts *opts;
  2879	
  2880		/*
  2881		 * Ensure that fc->security remains NULL when no options are set
  2882		 * as expected by selinux_set_mnt_opts().
  2883		 */
  2884		if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
  2885			return 0;
  2886	
> 2887		if (!fc->security) {
  2888			int rc;
  2889	
  2890			rc = lsm_mnt_opts_alloc(&fc->security);
  2891			if (rc)
  2892				return rc;
  2893			opts = selinux_mnt_opts(fc->security);
  2894			opts->initialized = true;
  2895		}
  2896	
  2897		if (sbsec->flags & FSCONTEXT_MNT)
  2898			opts->fscontext_sid = sbsec->sid;
  2899		if (sbsec->flags & CONTEXT_MNT)
  2900			opts->context_sid = sbsec->mntpoint_sid;
  2901		if (sbsec->flags & DEFCONTEXT_MNT)
  2902			opts->defcontext_sid = sbsec->def_sid;
  2903		opts->initialized = true;
  2904		return 0;
  2905	}
  2906	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
