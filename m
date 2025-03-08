Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC051C84B7;
	Sat,  8 Mar 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449223; cv=none; b=bGhHJkqUmCYtmrkH5TXCRBi8bDgDDHEZVyC4M6sRakWR0WcP6HhzbECsJPJudxbq0Tn+X3l/1EqNF2QV7GpZJGln1V1ugyJIZm3BNqwjO95uHhdX56UgSUK0OyWX/llfk9o2VgGbYduKaf1iP1Zosxq/XDwN2BOqkN6EZ0txtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449223; c=relaxed/simple;
	bh=H0xu7XTq50Pp5KSTU53AH0lpxzg7OI20PdHhdWAhQAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reOD8y+e/GgfnVsfG3pQRk/mWI+66JERG1ngJHESiNA02PY2g3cKbs1yRYOIZy6cng6TQZunblcOJhIILleljU85dw5PtoxZjMGiri6i6u7Kx76hx9NKTmi04kjEtgJN1dMRoEjkk2+o+mnEHMZZHlA6qxcCWJ8xdp3iwRUHFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8G9l3va; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8G9l3va"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741449221; x=1772985221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H0xu7XTq50Pp5KSTU53AH0lpxzg7OI20PdHhdWAhQAo=;
  b=E8G9l3vaKFXIR57U3x3SkTFb7qXmJ9bftjYzDaMdTe+XsE4rakK2XsEo
   rOs1CZArrUUQzjVXyJkZzCYUzpussrmRJh/DEdcMm9oozvfbDi2tiRdgg
   Cc7vjX9nd6NGw3tv6VUrOOEI29Pi6iapJi57RzUH/Nm+iBKmA5nItaH4A
   534JLUPzvGAMPZJUl4q1r2L4boFzbzd1xlvU0jhUe/+JEpI55f61uAdro
   3x3hS2y7V5lTbL30MbDaZmhiS5gwJkFcc1XgWJKr2GkS7aWzMQCuhzwqs
   rBz6WFp2bKbZ3kjGf+bNiYzU/0BgzKVJyzOm97ocutDYEXZfCMMJ4If/S
   A==;
X-CSE-ConnectionGUID: mR4YCJ15Tey6AN04A1kdhg==
X-CSE-MsgGUID: xAzWqXsQQdC1wtp0UwMdGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="53876622"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="53876622"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 07:53:39 -0800
X-CSE-ConnectionGUID: wQMy5iDLQReFQZ1t/9edSA==
X-CSE-MsgGUID: u5ylFMGuQTWse5DCLRW5cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="119576770"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2025 07:53:35 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqwUW-000216-32;
	Sat, 08 Mar 2025 15:53:32 +0000
Date: Sat, 8 Mar 2025 23:52:59 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
	eparis@redhat.com, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jmorris@namei.org, serge@hallyn.com,
	keescook@chromium.org, john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 3/6] LSM: security_lsmblob_to_secctx module selection
Message-ID: <202503082328.C7GyGU63-lkp@intel.com>
References: <20250307183701.16970-4-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307183701.16970-4-casey@schaufler-ca.com>

Hi Casey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-selinux/next]
[also build test WARNING on linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/Audit-Create-audit_stamp-structure/20250308-024950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20250307183701.16970-4-casey%40schaufler-ca.com
patch subject: [PATCH v2 3/6] LSM: security_lsmblob_to_secctx module selection
config: arc-randconfig-001-20250308 (https://download.01.org/0day-ci/archive/20250308/202503082328.C7GyGU63-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250308/202503082328.C7GyGU63-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503082328.C7GyGU63-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/security.c:4325: warning: Excess function parameter 'lsmid' description in 'security_secid_to_secctx'
>> security/security.c:4344: warning: Function parameter or struct member 'lsmid' not described in 'security_lsmprop_to_secctx'


vim +4325 security/security.c

746df9b59c8a5f1 David Quigley   2013-05-22  4310  
e261301c851aee4 Paul Moore      2023-02-16  4311  /**
e261301c851aee4 Paul Moore      2023-02-16  4312   * security_secid_to_secctx() - Convert a secid to a secctx
e261301c851aee4 Paul Moore      2023-02-16  4313   * @secid: secid
2d470c778120d3c Casey Schaufler 2024-10-23  4314   * @cp: the LSM context
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4315   * @lsmid: which security module to report
e261301c851aee4 Paul Moore      2023-02-16  4316   *
2d470c778120d3c Casey Schaufler 2024-10-23  4317   * Convert secid to security context.  If @cp is NULL the length of the
2d470c778120d3c Casey Schaufler 2024-10-23  4318   * result will be returned, but no data will be returned.  This
e261301c851aee4 Paul Moore      2023-02-16  4319   * does mean that the length could change between calls to check the length and
2d470c778120d3c Casey Schaufler 2024-10-23  4320   * the next call which actually allocates and returns the data.
e261301c851aee4 Paul Moore      2023-02-16  4321   *
2d470c778120d3c Casey Schaufler 2024-10-23  4322   * Return: Return length of data on success, error on failure.
e261301c851aee4 Paul Moore      2023-02-16  4323   */
2d470c778120d3c Casey Schaufler 2024-10-23  4324  int security_secid_to_secctx(u32 secid, struct lsm_context *cp)
20510f2f4e2dabb James Morris    2007-10-16 @4325  {
2d470c778120d3c Casey Schaufler 2024-10-23  4326  	return call_int_hook(secid_to_secctx, secid, cp);
20510f2f4e2dabb James Morris    2007-10-16  4327  }
20510f2f4e2dabb James Morris    2007-10-16  4328  EXPORT_SYMBOL(security_secid_to_secctx);
20510f2f4e2dabb James Morris    2007-10-16  4329  
6f2f724f0e116d9 Casey Schaufler 2024-10-09  4330  /**
6f2f724f0e116d9 Casey Schaufler 2024-10-09  4331   * security_lsmprop_to_secctx() - Convert a lsm_prop to a secctx
6f2f724f0e116d9 Casey Schaufler 2024-10-09  4332   * @prop: lsm specific information
2d470c778120d3c Casey Schaufler 2024-10-23  4333   * @cp: the LSM context
6f2f724f0e116d9 Casey Schaufler 2024-10-09  4334   *
2d470c778120d3c Casey Schaufler 2024-10-23  4335   * Convert a @prop entry to security context.  If @cp is NULL the
2d470c778120d3c Casey Schaufler 2024-10-23  4336   * length of the result will be returned. This does mean that the
2d470c778120d3c Casey Schaufler 2024-10-23  4337   * length could change between calls to check the length and the
2d470c778120d3c Casey Schaufler 2024-10-23  4338   * next call which actually allocates and returns the @cp.
6f2f724f0e116d9 Casey Schaufler 2024-10-09  4339   *
2d470c778120d3c Casey Schaufler 2024-10-23  4340   * Return: Return length of data on success, error on failure.
6f2f724f0e116d9 Casey Schaufler 2024-10-09  4341   */
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4342  int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4343  			       int lsmid)
6f2f724f0e116d9 Casey Schaufler 2024-10-09 @4344  {
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4345  	struct lsm_static_call *scall;
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4346  
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4347  	lsm_for_each_hook(scall, lsmprop_to_secctx) {
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4348  		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4349  			continue;
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4350  		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4351  	}
c6b93968f3f6d88 Casey Schaufler 2025-03-07  4352  	return LSM_RET_DEFAULT(lsmprop_to_secctx);
6f2f724f0e116d9 Casey Schaufler 2024-10-09  4353  }
6f2f724f0e116d9 Casey Schaufler 2024-10-09  4354  EXPORT_SYMBOL(security_lsmprop_to_secctx);
6f2f724f0e116d9 Casey Schaufler 2024-10-09  4355  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
