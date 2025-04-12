Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B10719CC34
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744471292; cv=none; b=s27NoGq0NPtIxj0s47pLeQYkRff89d4TmZO/bMqp5smVC9JUCb/Un4zS3yLgKM9VZS876WJBoEYlCpM4WYzTRTIkFH9fyEnC8NkE/fWGTmWceMgYPx/NxRZFmNzD+lZUhL3s7TReg5NYoeO7StJ4j8aU2Ey2Wu+NN7nu/CzC1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744471292; c=relaxed/simple;
	bh=GjAmbx4+3OF0nu94aqax2/FqFb/9eWhRE4jjPMDFVF0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YXU/oOb1Ux/iiioE2WQx9HL1XvuFi+cVloWruN2FoVm8vETvpfnSSF56+oGi3IAjRuxO1rSM8Mz+0hNIaZAk9LmD4N+jj+7dLHn+He5AHhPlp0/R3QNJ2T3sYwqblcl5fhsnkOjVLmROLqKOboOuRQzJZLjSrhNmE2/OFmnVJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MluxLLuC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MluxLLuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744471291; x=1776007291;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GjAmbx4+3OF0nu94aqax2/FqFb/9eWhRE4jjPMDFVF0=;
  b=MluxLLuCCoBHh5lFU4jlsMeNlW+89n4BXg/Lz1g4rKPdFfcGhcKZ+iII
   hHLHqB8WmdwfHCOzFzjqN81pjQaPnLGZXknm4W/YTJRmLOOkTqjbQw9FD
   4HcsMQzGKDBBCbr93XwA67swZdoa0wcgAnZsPV73BmHpp2D5DpHHP32OA
   oqM6OhcNOZuT+BO21InglMIkJCRWYsZiQJgaSQr43RmBry5/3C23CRlYl
   ugPVErRNUXqEykmSVEnVFZ2xkqTt5VvmX6MWSYB1/8vxGuLe/DfqydcXR
   tYSGVr6qvD7ZUCMfvn1C0lIyawI78afvB/rxyHjN0CRfGpLc4BWVHxnql
   Q==;
X-CSE-ConnectionGUID: KLc1IFXZRKOyYJffrMFDKw==
X-CSE-MsgGUID: r35odkYfQNGffSfAEGntmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="71384994"
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="71384994"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 08:21:30 -0700
X-CSE-ConnectionGUID: wLvR/RbcTqy1MgixeGozlA==
X-CSE-MsgGUID: A64WAPyvRtaldUoFrA9rdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="134292792"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Apr 2025 08:21:28 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3cfd-000Bsw-1W;
	Sat, 12 Apr 2025 15:21:25 +0000
Date: Sat, 12 Apr 2025 23:20:39 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Moore <paul@paul-moore.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	selinux@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [pcmoore-selinux:next 7/7] security/selinux/hooks.c:3173: warning:
 Function parameter or struct member 'avd' not described in
 'task_avdcache_update'
Message-ID: <202504122308.Ch8PzJdD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
head:   5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f
commit: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f [7/7] selinux: reduce path walk overhead
config: i386-buildonly-randconfig-003-20250412 (https://download.01.org/0day-ci/archive/20250412/202504122308.Ch8PzJdD-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504122308.Ch8PzJdD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504122308.Ch8PzJdD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/selinux/hooks.c:3173: warning: Function parameter or struct member 'avd' not described in 'task_avdcache_update'
>> security/selinux/hooks.c:3173: warning: Excess function parameter 'avdc' description in 'task_avdcache_update'


vim +3173 security/selinux/hooks.c

  3158	
  3159	/**
  3160	 * task_avdcache_update - Update the task's AVD cache
  3161	 * @tsec: the task's security state
  3162	 * @isec: the inode associated with the cache entry
  3163	 * @avdc: the AVD info to cache
  3164	 * @audited: the permission audit bitmask to cache
  3165	 *
  3166	 * Update the AVD cache in @tsec with the @avdc and @audited info associated
  3167	 * with @isec.
  3168	 */
  3169	static inline void task_avdcache_update(struct task_security_struct *tsec,
  3170						struct inode_security_struct *isec,
  3171						struct av_decision *avd,
  3172						u32 audited)
> 3173	{
  3174		int spot;
  3175	
  3176		/* focused on path walk optimization, only cache directories */
  3177		if (isec->sclass != SECCLASS_DIR)
  3178			return;
  3179	
  3180		/* update cache */
  3181		spot = (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_SIZE - 1);
  3182		tsec->avdcache.dir_spot = spot;
  3183		tsec->avdcache.dir[spot].isid = isec->sid;
  3184		tsec->avdcache.dir[spot].audited = audited;
  3185		tsec->avdcache.dir[spot].allowed = avd->allowed;
  3186		tsec->avdcache.dir[spot].permissive = avd->flags & AVD_FLAGS_PERMISSIVE;
  3187	}
  3188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
