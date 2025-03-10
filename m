Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDBD1DE899;
	Mon, 10 Mar 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591757; cv=none; b=iBHGGE0tydyzSl1vd/kZlET8zVq5qegN6owI8kk6sIGDzFd1HfAJmIlWgwtxz3tZR1scXkfXcHotK9D6V6rVDbiEiwArCFBhca7DMAhPbfi/heNV8JQuB7o2e44aK+MRmR1D+hrMhpFp+f2uiBji5h8HlQTeJ2zCLelR8AYx938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591757; c=relaxed/simple;
	bh=Qak3hDPimj5StjXL2unXWZ3LseUEHQB49RxyNvafENM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGpV7Sab2Z78RauVW0Kx8uIQ3OJidXFABVUOLLg6p8hBMfTzaHuqDQTuzIPWVliVQQfZH+L8LM1SVGvZzjWZtkZo5vj+eDsB3Z1ucSct/EFRtgBmlZ85pZTUKiCJ72TPBEPlAtriC1N8916et5rRzGobhIEBuBWu7bAg3BX6YHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HadvyXvv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HadvyXvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741591755; x=1773127755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qak3hDPimj5StjXL2unXWZ3LseUEHQB49RxyNvafENM=;
  b=HadvyXvvzoE0kE8JZcP18RnX40MQ6mHSsBUe8hpJdwzuq0YTovPJa7e5
   NuuyJX1iCQemm9wDxy/JdrbgLDLyZVPhFmsck9caNhNdT82+Db0ByPhVE
   iJ+VbtM9VVPSMr/vqlLlZRlrVUKNQ/AvXdQmbI85XbIFbtrNDQRsBauFS
   69xIQdLYGSeN+YJhQ5Hapo33tekH1UKp7dGpxarzvPbp1YpegpTG7W0gP
   jx2bI1K+Pd+oSCvfEFmS2LRTsUEt9BfmOWVzk+PTXQYd1k6zWPZ9xG1RJ
   p3StqCNrxbqxd536hjoxghcJTxEjGzcZoRajAF/W2mA7xIdKey8RyG99X
   g==;
X-CSE-ConnectionGUID: AnpRggNnRaKzY/YQmgNdWg==
X-CSE-MsgGUID: PgsmNOmEStOKOvk6YzCyig==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42708309"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42708309"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:29:14 -0700
X-CSE-ConnectionGUID: 5XQOV+CbTGWX4IlFp3+DGQ==
X-CSE-MsgGUID: odNCYfjnQouvfxfLHhZOqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="157120741"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 10 Mar 2025 00:29:11 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trXZK-0003wM-0q;
	Mon, 10 Mar 2025 07:29:01 +0000
Date: Mon, 10 Mar 2025 15:26:35 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
	eparis@redhat.com, linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jmorris@namei.org, serge@hallyn.com,
	keescook@chromium.org, john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Audit: Add record for multiple object contexts
Message-ID: <202503101524.XYSVbXHw-lkp@intel.com>
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
[also build test ERROR on linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/Audit-Create-audit_stamp-structure/20250308-024950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20250307183701.16970-7-casey%40schaufler-ca.com
patch subject: [PATCH v2 6/6] Audit: Add record for multiple object contexts
config: s390-randconfig-r073-20250310 (https://download.01.org/0day-ci/archive/20250310/202503101524.XYSVbXHw-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503101524.XYSVbXHw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503101524.XYSVbXHw-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390x-linux-ld: kernel/audit.o: in function `audit_log_object_context':
>> kernel/audit.c:2312:(.text+0x2da6): undefined reference to `lsm_objctx_cnt'
>> s390x-linux-ld: kernel/audit.c:2329:(.text+0x30d2): undefined reference to `lsm_active_cnt'
   s390x-linux-ld: kernel/audit.c:(.text+0x3108): undefined reference to `lsm_active_cnt'
>> s390x-linux-ld: kernel/audit.c:2330:(.text+0x313e): undefined reference to `lsm_idlist'
>> s390x-linux-ld: kernel/audit.c:2312:(.text+0x32f2): undefined reference to `lsm_objctx_cnt'
   s390x-linux-ld: kernel/audit.c:2312:(.text+0x330a): undefined reference to `lsm_objctx_cnt'
   s390x-linux-ld: kernel/audit.c:2329:(.text+0x33a4): undefined reference to `lsm_active_cnt'
   s390x-linux-ld: kernel/audit.c:2329:(.text+0x33bc): undefined reference to `lsm_active_cnt'


vim +2312 kernel/audit.c

  2303	
  2304	int audit_log_object_context(struct audit_buffer *ab, struct lsm_prop *prop)
  2305	{
  2306		int i;
  2307		int rc;
  2308		int error = 0;
  2309		char *space = "";
  2310		struct lsm_context context;
  2311	
> 2312		if (lsm_objctx_cnt < 2) {
  2313			error = security_lsmprop_to_secctx(prop, &context,
  2314							   LSM_ID_UNDEF);
  2315			if (error < 0) {
  2316				if (error != -EINVAL)
  2317					goto error_path;
  2318				return error;
  2319			}
  2320			audit_log_format(ab, " obj=%s", context.context);
  2321			security_release_secctx(&context);
  2322			return 0;
  2323		}
  2324		audit_log_format(ab, " obj=?");
  2325		error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
  2326		if (error)
  2327			goto error_path;
  2328	
> 2329		for (i = 0; i < lsm_active_cnt; i++) {
> 2330			if (!lsm_idlist[i]->objctx)
  2331				continue;
  2332			rc = security_lsmprop_to_secctx(prop, &context,
  2333							lsm_idlist[i]->id);
  2334			if (rc < 0) {
  2335				audit_log_format(ab, "%sobj_%s=?", space,
  2336						 lsm_idlist[i]->name);
  2337				if (rc != -EINVAL)
  2338					audit_panic("error in audit_log_object_context");
  2339				error = rc;
  2340			} else {
  2341				audit_log_format(ab, "%sobj_%s=%s", space,
  2342						 lsm_idlist[i]->name, context.context);
  2343				security_release_secctx(&context);
  2344			}
  2345			space = " ";
  2346		}
  2347	
  2348		audit_buffer_aux_end(ab);
  2349		return error;
  2350	
  2351	error_path:
  2352		audit_panic("error in audit_log_object_context");
  2353		return error;
  2354	}
  2355	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
