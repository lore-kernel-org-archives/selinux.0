Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA4318EF4;
	Sun, 16 Aug 2026 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786904466; cv=none; b=ZwNvyzGtqzF0TOx6I7MnY+73eNK3YWTst4MfMRNTi0if9WnBR/r9P0Wyvv3mA7pKh8iBMFcpN/Ege4gYMnel2H3F61zrsxb/GRY2G8UvdCKi+Q3/07c18Vi1Wdvu7dsXlY/fVT3WBThcECVdqBQ1LnhkcS14A5nu8sKpYO3FYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786904466; c=relaxed/simple;
	bh=EuHVefwtjg53ScVh3sYMU/Te2KnENN8lApsA4bRFlDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V73tfwt6kw4fDM49+ru+YZ/kkKISox2fl4qoV4+pHFGkCyFZhPqWoDfM8xMJqiqKtO6KD/suNLTQ+DJAF5FmC9CkP1fYue6WWsRAT9eFU0BDXId3NYjZjVVWi6re/KnsUUPpBlAXliWbrrqvocPA8qfOpY80aCMhdAsP7tQ0f2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKUoCiO+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKUoCiO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786904464; x=1818440464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EuHVefwtjg53ScVh3sYMU/Te2KnENN8lApsA4bRFlDk=;
  b=RKUoCiO+3e31sA9zwewqVHAAX7dGpvwTc/Z8qjCi0eMNp32kTQP/VO9g
   BDwd0Md1geDK/Z8V8GkKm2B1K28q92UpWcMT9Sdzah1EHqoY6tRU2lhjh
   izMi2MZzdqYhbp0A5lCEMw+gj+v08m7b6VUlljHL+ioqmG57iLo7NEoDL
   z5A8vhnIMioGN8AfWJ74HZF3eITudrJAAQePriN9nhQdMkMUcZw6YguFv
   UMvWeLSmPu1fKVU0NnlhXnWSlJakP7lWSIuAfN+TFOptbixglJJrHlH+Q
   4aDjkxYALz8f80vJhpVQ5755oFFvXDGFZj6F2YeKGD9d/W9DQoPolGk/m
   g==;
X-CSE-ConnectionGUID: Qvp27kjOSXew+oGF/o4UEw==
X-CSE-MsgGUID: PFF5yIOySgSJh50DOjBzog==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="112937094"
X-IronPort-AV: E=Sophos;i="6.25,227,1779174000"; 
   d="scan'208";a="112937094"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 11:21:03 -0700
X-CSE-ConnectionGUID: 1YN10mGgT5OHw+PZJ2mrzQ==
X-CSE-MsgGUID: CHTrOzLMQDStzYHihkUBSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,227,1779174000"; 
   d="scan'208";a="294628037"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Aug 2026 11:21:02 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvfTf-00000000d2c-0hAT;
	Sun, 16 Aug 2026 18:20:59 +0000
Date: Mon, 17 Aug 2026 02:20:47 +0800
From: kernel test robot <lkp@intel.com>
To: Yugansh Mittal <mittalyugansh1@gmail.com>, paul@paul-moore.com,
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
	omosnace@redhat.com, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Yugansh Mittal <mittalyugansh1@gmail.com>
Subject: Re: [PATCH v2] [V2] selinux: restore sleepable revalidation; keep
 fast no-sleep check
Message-ID: <202608170230.r0g7wOIb-lkp@intel.com>
References: <20250826172330.44006-1-mittalyugansh1@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826172330.44006-1-mittalyugansh1@gmail.com>

Hi Yugansh,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on linus/master v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yugansh-Mittal/selinux-restore-sleepable-revalidation-keep-fast-no-sleep-check/20260815-164746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20250826172330.44006-1-mittalyugansh1%40gmail.com
patch subject: [PATCH v2] [V2] selinux: restore sleepable revalidation; keep fast no-sleep check
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260817/202608170230.r0g7wOIb-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 844a18e753e822736c9805ab779144b647a2c186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260817/202608170230.r0g7wOIb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608170230.r0g7wOIb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/selinux/hooks.c:294:22: error: call to undeclared function 'is_label_invalid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     294 |         if (likely(isec && !is_label_invalid(isec))) {
         |                             ^
   1 error generated.


vim +/is_label_invalid +294 security/selinux/hooks.c

   275	
   276	/*
   277	 * Try reloading inode security labels that have been marked as invalid.  The
   278	 * @may_sleep parameter indicates when sleeping and thus reloading labels is
   279	 * allowed; when set to false, returns -ECHILD when the label is
   280	 * invalid.  The @dentry parameter should be set to a dentry of the inode.
   281	 */
   282	static int __inode_security_revalidate(struct inode *inode,
   283					       struct dentry *dentry,
   284					       bool may_sleep)
   285	{
   286		struct inode_security_struct *isec;
   287	
   288		if (!selinux_initialized())
   289			return 0;
   290	
   291		/* Fast, non-blocking validity check first */
   292		rcu_read_lock();
   293		isec = selinux_inode(inode);
 > 294		if (likely(isec && !is_label_invalid(isec))) {
   295			rcu_read_unlock();
   296			return 0;   /* valid and no sleeping done */
   297		}
   298		rcu_read_unlock();
   299	
   300		/*
   301		* Label looks invalid. If we can't sleep, signal caller that a
   302		* retry in a sleepable context is required. Only contexts like
   303		* RCU path walk are expected to propagate -ECHILD.
   304		*/
   305		if (!may_sleep)
   306		return -ECHILD;
   307	
   308		/*
   309		* Sleepable context: reload the label. This may block.
   310		* If @dentry is NULL and no dentry can be found we'll continue
   311		* using the old label, consistent with prior behavior.
   312		*/
   313		might_sleep();
   314		inode_doinit_with_dentry(inode, dentry);
   315		return 0;
   316	}
   317	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
