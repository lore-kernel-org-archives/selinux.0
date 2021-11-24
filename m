Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ED8C43219
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 13:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349339AbhKXNpM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 08:45:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:17145 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353750AbhKXNoB (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 24 Nov 2021 08:44:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="235517874"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="235517874"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 05:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="538625513"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2021 05:40:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpsVz-0004qw-Dp; Wed, 24 Nov 2021 13:40:47 +0000
Date:   Wed, 24 Nov 2021 21:40:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
Subject: Re: [PATCH v30 26/28] Audit: Add record for multiple object security
 contexts
Message-ID: <202111242114.1WN6oSkW-lkp@intel.com>
References: <20211124014332.36128-27-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124014332.36128-27-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on nf-next/master]
[also build test ERROR on nf/master linus/master v5.16-rc2]
[cannot apply to pcmoore-audit/next jmorris-security/next-testing next-20211124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20211124-104307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git master
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20211124/202111242114.1WN6oSkW-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3054c600afec9a016902ed6ed5de86c76d6b0105
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20211124-104307
        git checkout 3054c600afec9a016902ed6ed5de86c76d6b0105
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/ptrace/ptrace.c:20:
   include/linux/audit.h:262:1: error: expected identifier or '(' before '{' token
     262 | { }
         | ^
>> include/linux/audit.h:260:20: error: 'audit_log_object_context' declared 'static' but never defined [-Werror=unused-function]
     260 | static inline void audit_log_object_context(struct audit_buffer *ab,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +260 include/linux/audit.h

   220	
   221	#else /* CONFIG_AUDIT */
   222	static inline __printf(4, 5)
   223	void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
   224		       const char *fmt, ...)
   225	{ }
   226	static inline struct audit_buffer *audit_log_start(struct audit_context *ctx,
   227							   gfp_t gfp_mask, int type)
   228	{
   229		return NULL;
   230	}
   231	static inline __printf(2, 3)
   232	void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
   233	{ }
   234	static inline void audit_log_end(struct audit_buffer *ab)
   235	{ }
   236	static inline void audit_log_n_hex(struct audit_buffer *ab,
   237					   const unsigned char *buf, size_t len)
   238	{ }
   239	static inline void audit_log_n_string(struct audit_buffer *ab,
   240					      const char *buf, size_t n)
   241	{ }
   242	static inline void  audit_log_n_untrustedstring(struct audit_buffer *ab,
   243							const char *string, size_t n)
   244	{ }
   245	static inline void audit_log_untrustedstring(struct audit_buffer *ab,
   246						     const char *string)
   247	{ }
   248	static inline void audit_log_d_path(struct audit_buffer *ab,
   249					    const char *prefix,
   250					    const struct path *path)
   251	{ }
   252	static inline void audit_log_key(struct audit_buffer *ab, char *key)
   253	{ }
   254	static inline void audit_log_path_denied(int type, const char *operation)
   255	{ }
   256	static inline int audit_log_task_context(struct audit_buffer *ab)
   257	{
   258		return 0;
   259	}
 > 260	static inline void audit_log_object_context(struct audit_buffer *ab,
   261						    struct lsmblob *blob);
   262	{ }
   263	static inline void audit_log_task_info(struct audit_buffer *ab)
   264	{ }
   265	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
