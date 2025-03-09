Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37014D2BB;
	Sun,  9 Mar 2025 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741529981; cv=none; b=Kp7ikBZl5lNDhhphKsxF1nfhZlpHC6Oux8yC+SGzXmIrrv34/ZrUhI1bhbbFI6EhJq8ELDJPa8Qr9cKZUt1IaihH5nqlpIAawXixs9ZyQqophGeWKY7yGOvrr3b7jj5W0lbbm3GfG8FyFbMc+K8mr7l+goGF5s+0LKUWhpB6wns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741529981; c=relaxed/simple;
	bh=dgmnH3jivN7gBSE9ew8+WzchO37Kp9I0JWQg3tBMeRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T14d/0qBPL/mMpfiANt0K+0WoJd3Ot1P0MQbdEAjFMubL4q1iJcSyWqkSJZ+SzRDMvqGieKeolOuPkaNGPJml5k7FFTKKbptZuxQTTaUfp7ZG8MByFjnTCoUj2eVurrvB5milC7SitXusczwokadyDNcblZ42MYb2cU+Pq+FADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxNC00Xq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxNC00Xq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741529979; x=1773065979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dgmnH3jivN7gBSE9ew8+WzchO37Kp9I0JWQg3tBMeRw=;
  b=CxNC00XqB36xH3tER6VeebLEn8qwsamyKhW09Uiz5mrbUf+wkN2/iA0+
   i0Spgsb5rsDk/803CGOaEu9v4bIugvslX8lTVnmCpgdxm8ho5MDdhapHs
   InXgVRDHfD1iXiegousSyZBlbEfKB1tUjqrHXFIrJFUHMoAwQo5WkKKxC
   1PChPYPCzu+BYDyW98xBZU3FsPZYq2vL9BXEjD9l/0L2kmYQUyggRnoGJ
   4cy0QXN2V/UL5TFVbxSsxUN5jDcpodAgTiUHAGYuM26Bd77zc+5qg8UPS
   hyMbS1sf+I0igrcGFl4YaPvAzx6vfUOBtVPwfXlua3HZjN8nXZrTYrg/u
   Q==;
X-CSE-ConnectionGUID: Xo3X5dVJT+eTLSwBSQUZzQ==
X-CSE-MsgGUID: yiyKIoJPS/WBllnawuHWkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42643655"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42643655"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 07:19:38 -0700
X-CSE-ConnectionGUID: BNvV+1E6QbGX8CO5DjlLYQ==
X-CSE-MsgGUID: knhpWfGvQTiTukVADQAlmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120286375"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 09 Mar 2025 07:19:35 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trHV3-0003Aq-0U;
	Sun, 09 Mar 2025 14:19:30 +0000
Date: Sun, 9 Mar 2025 22:18:58 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
	eparis@redhat.com, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
	serge@hallyn.com, keescook@chromium.org,
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Audit: Add record for multiple object contexts
Message-ID: <202503092246.du8fixfZ-lkp@intel.com>
References: <20250307183701.16970-7-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307183701.16970-7-casey@schaufler-ca.com>

Hi Casey,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/Audit-Create-audit_stamp-structure/20250308-024950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20250307183701.16970-7-casey%40schaufler-ca.com
patch subject: [PATCH v2 6/6] Audit: Add record for multiple object contexts
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250309/202503092246.du8fixfZ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503092246.du8fixfZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503092246.du8fixfZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: lsm_objctx_cnt
   >>> referenced by audit.c:2312 (kernel/audit.c:2312)
   >>>               vmlinux.o:(audit_log_object_context)
--
>> ld.lld: error: undefined symbol: lsm_active_cnt
   >>> referenced by audit.c:2329 (kernel/audit.c:2329)
   >>>               vmlinux.o:(audit_log_object_context)
   >>> referenced by audit.c:2329 (kernel/audit.c:2329)
   >>>               vmlinux.o:(audit_log_object_context)
--
>> ld.lld: error: undefined symbol: lsm_idlist
   >>> referenced by audit.c:2330 (kernel/audit.c:2330)
   >>>               vmlinux.o:(audit_log_object_context)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
