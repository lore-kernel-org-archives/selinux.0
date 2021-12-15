Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E298C433F5
	for <selinux@archiver.kernel.org>; Wed, 15 Dec 2021 09:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhLOJO7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Dec 2021 04:14:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:54350 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241064AbhLOJO6 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 15 Dec 2021 04:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639559698; x=1671095698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZcRH6JYRSqZQ5XGTBMIbU967GQwZZfyY+KkVtbMFbxs=;
  b=FvMzqNWAV3iuPQsTTLDzqQTuLDzMstjgUKzaXUF4K4BvlMFk7cE4dNF6
   F+nEIIsS6v0JtLLCw1KXkfr2LCXApzGfshs5GCX8yugevrt2fRPLk1Jt7
   1GfqOMXwmlhux2yqY44wJ1X2mIMEwsUq5fn2hKiAiSCbt2w4mUHcr4vHD
   pFcUh3t5t7CsOiszo1QyukYfIVPe7YOIcyF/ohUIEPkbMw+fUW+Hs4dO6
   q/u8M1YaLU6uNldRNX7UvcEyDNS+9MwClWjzeQ+OKNMLY/PQcWaU43iAn
   5XIsizwetYUnf8SaVRYShFQ9jfABFnuu29WmdqyLLKBlcLkqphLxYzFaK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="239406384"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="239406384"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 01:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="465482545"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2021 01:14:55 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxQNC-0001XG-Dt; Wed, 15 Dec 2021 09:14:54 +0000
Date:   Wed, 15 Dec 2021 17:14:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
Subject: Re: [PATCH v31 13/28] LSM: Use lsmblob in security_cred_getsecid
Message-ID: <202112151753.otSGYmsF-lkp@intel.com>
References: <20211213234034.111891-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213234034.111891-14-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Casey,

I love your patch! Perhaps something to improve:

[auto build test WARNING on nf-next/master]
[also build test WARNING on nf/master linus/master v5.16-rc5]
[cannot apply to pcmoore-audit/next jmorris-security/next-testing next-20211214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20211214-084057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git master
config: microblaze-randconfig-s032-20211214 (https://download.01.org/0day-ci/archive/20211215/202112151753.otSGYmsF-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/e66d6e6a2f53e0b36b78003ee8399a554ae82e3c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20211214-084057
        git checkout e66d6e6a2f53e0b36b78003ee8399a554ae82e3c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/audit.c:128:25: sparse: sparse: symbol 'audit_sig_lsm' was not declared. Should it be static?
   kernel/audit.c:2181:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/audit.c:2181:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/audit.c:2181:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/audit.c:2184:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/audit.c:2184:40: sparse:     expected struct spinlock [usertype] *lock
   kernel/audit.c:2184:40: sparse:     got struct spinlock [noderef] __rcu *

vim +/audit_sig_lsm +128 kernel/audit.c

   124	
   125	/* The identity of the user shutting down the audit system. */
   126	static kuid_t		audit_sig_uid = INVALID_UID;
   127	static pid_t		audit_sig_pid = -1;
 > 128	struct lsmblob		audit_sig_lsm;
   129	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
