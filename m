Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C03A63FB;
	Sat, 15 Aug 2026 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786804188; cv=none; b=fiYj+g4/swFinHyrcDgWJt9qWRSvMLY8tCBDYQxUJY+oAxNbhxhy1Hha4yKnDTtZYCdj6xVeLEn2Pj091EEokVZMk174CQNcpZFOD2ylj7ubxxCcf/RX+Oky6kROfcH3dVwamH7aB2h5bQP52M3YWGHeI9ATSdQjixSDLpmKmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786804188; c=relaxed/simple;
	bh=6y8Gr/WlB6mLCbCAdElve4bMuKDDKbBLVCv2aCN/XBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxOz2wIsE3xkpk1mhlNZu4gj+K5DoBErLQBHYz84BvvA/8V7iFQJCX25OvLxBV8yEarLdVAtVyavZjEmrGktCF+RqNDW+plOi7/sqxxesHkQPY7kQOlhkaPyaj1wWXl7eOMxbhZzTqxMdUOk55B/+4ErkTq6NNjPHBXJ8F9OTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx2kEsrH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lx2kEsrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786804185; x=1818340185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6y8Gr/WlB6mLCbCAdElve4bMuKDDKbBLVCv2aCN/XBs=;
  b=lx2kEsrHFfhqYQ9j7baj4t0J8lS23uFrei3VyGa+L+yyerXxPtEGsK4B
   q1CRNXEqQ5xKtZU09/Fmuf2Q1YtwsnZbJqw6dg6EZEgff566/C3fb3HfA
   Rdh0wuzNzCHR9m4uAd3pYaeYXE/3Z8Pgp01SeRCVsryWRoPB/ljo3sWa+
   RT9ne2N3OGU6OUP44dAK00lNCq2U1ADff6XQ0kuHEqv0XBS2CAT596q8X
   bCTBTg6oKolHFv37npiJ9Xm6Apaus+osQlm7QZMi4D+zJyFa0WdlVL5Ud
   n6+A0qOFj+m8mdFUyfUoEMnzpeDLCBatRQPd+qLmDs3c4aCjAIRF241wq
   w==;
X-CSE-ConnectionGUID: Inx5mECNTl2py+buyk57VQ==
X-CSE-MsgGUID: bu2P6WmeS16HJ6syxIZJgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87372559"
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="87372559"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 07:29:44 -0700
X-CSE-ConnectionGUID: fKLPjuKEQkSDM8hLCVZNSA==
X-CSE-MsgGUID: +mqvG+yESUWpUf86fNtqpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="265095324"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Aug 2026 07:29:43 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvFOG-00000000cCk-2LD3;
	Sat, 15 Aug 2026 14:29:40 +0000
Date: Sat, 15 Aug 2026 22:23:52 +0800
From: kernel test robot <lkp@intel.com>
To: Yugansh Mittal <mittalyugansh1@gmail.com>, paul@paul-moore.com,
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
	omosnace@redhat.com, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Yugansh Mittal <mittalyugansh1@gmail.com>
Subject: Re: [PATCH v2] [V2] selinux: restore sleepable revalidation; keep
 fast no-sleep check
Message-ID: <202608152259.U1jKjeeX-lkp@intel.com>
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
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260815/202608152259.U1jKjeeX-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260815/202608152259.U1jKjeeX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608152259.U1jKjeeX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/init.h:5,
                    from security/selinux/hooks.c:24:
   security/selinux/hooks.c: In function '__inode_security_revalidate':
>> security/selinux/hooks.c:294:29: error: implicit declaration of function 'is_label_invalid' [-Wimplicit-function-declaration]
     294 |         if (likely(isec && !is_label_invalid(isec))) {
         |                             ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^


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
