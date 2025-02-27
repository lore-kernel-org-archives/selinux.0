Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1951DE4C8;
	Thu, 27 Feb 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689231; cv=none; b=ngv66roNM1AniIGa4ZesLtaANj2SA7X+7Jrr8150XfuqGgQ6s9UiZJMabKVpASqPFPqEGJvRIUt259nTtAVACrR+p67zb2uAURCwCbN4LrVaDBxFS1vYWdnTfpqAvdFrZEICREFQFlo4Hk/+5xCouFUCR2jqBOePucE+b0qVcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689231; c=relaxed/simple;
	bh=utQVCfMq3XX4+WH1ud4ZibztAqFiiIfTgmuA4Y+wqLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwt0gPGk+xvlKcc9KN9opMWgo0jjd9YLXyEwm1yalkLdpPU2gLocq+n6APgSPAhAiKp06bAlZrWXVkq4lkM2H3NlDhGMCm/1l4N6PyyI68ySiLvoa8658qBiqFczXNpphcD6qvfux4OD1G6EUaAtlJjdZ9BwRKEXEiJRWS7mVXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHMEHhIL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHMEHhIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740689229; x=1772225229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=utQVCfMq3XX4+WH1ud4ZibztAqFiiIfTgmuA4Y+wqLA=;
  b=FHMEHhIL+4WQIZcNE7nb2fe7Ohcr53/hcOhl6cnBDSOJGeWwt2YnYAuj
   bY4CNP5mSr3ZvYLJY7tFjDBob5CFr6M81rjd+JUN74mFqcSfPPcIA7lii
   e9YAH8KrBqPea0tSSLvICGvNVR8P+ptQ6xCe/LY/v0JX3zC36xBuWSBlT
   /09Bjf+T3SZIbhLpkxaEtChz8Z5HCt/NC730XB74j/2hyiGbm0Dtjo/Jd
   lE0XA2wNYAk9zeSGlssCeiNyorxJRxt7tDQxuTDzb2ZL1CUFolr33ADMo
   Y5l1+WezXiY6RasquuXnZRYztdkeLOY5JJU0UMlCCkQ7/N0jq2jXVH99+
   Q==;
X-CSE-ConnectionGUID: osap7yFDS164lmwIYAnmmw==
X-CSE-MsgGUID: s4dX6GsqT8OGb+cCHKR3bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40844740"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="40844740"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 12:47:08 -0800
X-CSE-ConnectionGUID: rGYSMAJhT1+XTk4WV27ENA==
X-CSE-MsgGUID: SM0f+tdaRo2Ez/7u3JP6Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117160740"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Feb 2025 12:47:01 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnkmV-000E14-1N;
	Thu, 27 Feb 2025 20:46:56 +0000
Date: Fri, 28 Feb 2025 04:46:26 +0800
From: kernel test robot <lkp@intel.com>
To: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com, omosnace@redhat.com,
	shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org,
	bagasdotme@gmail.com, horms@kernel.org, tweek@google.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, selinux@vger.kernel.org, hridya@google.com
Cc: oe-kbuild-all@lists.linux.dev, smoreland@google.com, ynaffit@google.com,
	kernel-team@android.com
Subject: Re: [PATCH v15 2/3] binder: report txn errors via generic netlink
Message-ID: <202502280430.x785GFat-lkp@intel.com>
References: <20250226192047.734627-3-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226192047.734627-3-dualli@chromium.org>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Li/lsm-selinux-Add-setup_report-permission-to-binder/20250227-032351
base:   8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
patch link:    https://lore.kernel.org/r/20250226192047.734627-3-dualli%40chromium.org
patch subject: [PATCH v15 2/3] binder: report txn errors via generic netlink
config: arm-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250228/202502280430.x785GFat-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280430.x785GFat-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280430.x785GFat-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/android/binder.c: In function 'binder_nl_report_setup_doit':
>> drivers/android/binder.c:6479:15: error: implicit declaration of function 'security_binder_setup_report' [-Wimplicit-function-declaration]
    6479 |         ret = security_binder_setup_report(current_cred());
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/security_binder_setup_report +6479 drivers/android/binder.c

  6462	
  6463	/**
  6464	 * binder_nl_report_setup_doit() - netlink .doit handler
  6465	 * @skb:	the metadata struct passed from netlink driver
  6466	 * @info:	the generic netlink struct passed from netlink driver
  6467	 *
  6468	 * Implements the .doit function to process binder netlink commands.
  6469	 */
  6470	int binder_nl_report_setup_doit(struct sk_buff *skb, struct genl_info *info)
  6471	{
  6472		struct binder_context *context = NULL;
  6473		struct binder_device *device;
  6474		struct binder_proc *proc;
  6475		u32 flags, pid;
  6476		void *hdr;
  6477		int ret;
  6478	
> 6479		ret = security_binder_setup_report(current_cred());
  6480		if (ret < 0) {
  6481			NL_SET_ERR_MSG(info->extack, "Permission denied");
  6482			return ret;
  6483		}
  6484	
  6485		hlist_for_each_entry(device, &binder_devices, hlist) {
  6486			if (!nla_strcmp(info->attrs[BINDER_A_CMD_CONTEXT],
  6487					device->context.name)) {
  6488				context = &device->context;
  6489				break;
  6490			}
  6491		}
  6492	
  6493		if (!context) {
  6494			NL_SET_ERR_MSG(info->extack, "Unknown binder context");
  6495			return -EINVAL;
  6496		}
  6497	
  6498		pid = nla_get_u32(info->attrs[BINDER_A_CMD_PID]);
  6499		flags = nla_get_u32(info->attrs[BINDER_A_CMD_FLAGS]);
  6500	
  6501		if (!pid) {
  6502			/* Set the global flags for the whole binder context */
  6503			context->report_flags = flags;
  6504		} else {
  6505			/* Set the per-process flags */
  6506			proc = binder_find_proc(pid);
  6507			if (!proc) {
  6508				NL_SET_ERR_MSG_FMT(info->extack,
  6509						   "Invalid binder report pid %u",
  6510						   pid);
  6511				ret = -EINVAL;
  6512				goto err_exit;
  6513			}
  6514	
  6515			proc->report_flags = flags;
  6516		}
  6517	
  6518		skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
  6519		if (!skb) {
  6520			pr_err("Failed to alloc binder netlink reply message\n");
  6521			ret = -ENOMEM;
  6522			goto err_exit;
  6523		}
  6524	
  6525		hdr = genlmsg_iput(skb, info);
  6526		if (!hdr)
  6527			goto free_skb;
  6528	
  6529		if (nla_put_string(skb, BINDER_A_CMD_CONTEXT, context->name) ||
  6530		    nla_put_u32(skb, BINDER_A_CMD_PID, pid) ||
  6531		    nla_put_u32(skb, BINDER_A_CMD_FLAGS, flags))
  6532			goto cancel_skb;
  6533	
  6534		genlmsg_end(skb, hdr);
  6535	
  6536		if (genlmsg_reply(skb, info)) {
  6537			pr_err("Failed to send binder netlink reply message\n");
  6538			ret = -EFAULT;
  6539			goto err_exit;
  6540		}
  6541	
  6542		return 0;
  6543	
  6544	cancel_skb:
  6545		pr_err("Failed to add reply attributes to binder netlink message\n");
  6546		genlmsg_cancel(skb, hdr);
  6547	free_skb:
  6548		pr_err("Free binder netlink reply message on error\n");
  6549		nlmsg_free(skb);
  6550		ret = -EMSGSIZE;
  6551	err_exit:
  6552		return ret;
  6553	}
  6554	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
