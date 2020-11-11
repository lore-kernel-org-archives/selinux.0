Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68768C388F9
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 04:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF4F216C4
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 04:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgKKEqI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Nov 2020 23:46:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:6225 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKKEqI (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 10 Nov 2020 23:46:08 -0500
IronPort-SDR: jxwp3XoxBuX/j7JDmBhpcN6ypaN3DDbGxgKesEBR+9MfhfKiuUlWczejePNBRYlfsp33RVakG+
 6CxXEi9Kz+/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157874127"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="gz'50?scan'50,208,50";a="157874127"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 20:46:07 -0800
IronPort-SDR: 6OvFVp05xGRSksP/f/KDm9csjhU0yXoxUPGzAypmb+GzYfwwDmZH02rlDo2FdzBIbYutccABqh
 kz72E53FG+bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="gz'50?scan'50,208,50";a="531497363"
Received: from lkp-server02.sh.intel.com (HELO 14a21f3b7a6a) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Nov 2020 20:46:04 -0800
Received: from kbuild by 14a21f3b7a6a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kci1D-00003J-9Q; Wed, 11 Nov 2020 04:46:03 +0000
Date:   Wed, 11 Nov 2020 12:45:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
Subject: Re: [PATCH v22 20/23] Audit: Add new record for multiple process LSM
  attributes
Message-ID: <202011111201.tleMU64S-lkp@intel.com>
References: <20201105004924.11651-21-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20201105004924.11651-21-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on nf-next/master]
[also build test ERROR on nf/master linus/master v5.10-rc3 next-20201110]
[cannot apply to security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Casey-Schaufler/LSM-Module-stacking-for-AppArmor/20201105-091817
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git master
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3fc93335d8a4090601fe221c305017ca73c23c61
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Module-stacking-for-AppArmor/20201105-091817
        git checkout 3fc93335d8a4090601fe221c305017ca73c23c61
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/ptrace/ptrace.c:20:
   include/linux/audit.h:585:1: error: expected identifier or '(' before '+' token
     585 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
>> include/linux/audit.h:261:13: error: 'audit_log_lsm' defined but not used [-Werror=unused-function]
     261 | static void audit_log_lsm(struct audit_context *context)
         |             ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/audit_log_lsm +261 include/linux/audit.h

   216	
   217	#else /* CONFIG_AUDIT */
   218	static inline __printf(4, 5)
   219	void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
   220		       const char *fmt, ...)
   221	{ }
   222	static inline struct audit_buffer *audit_log_start(struct audit_context *ctx,
   223							   gfp_t gfp_mask, int type)
   224	{
   225		return NULL;
   226	}
   227	static inline __printf(2, 3)
   228	void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
   229	{ }
   230	static inline void audit_log_end(struct audit_buffer *ab)
   231	{ }
   232	static inline void audit_log_end_local(struct audit_buffer *ab,
   233					       struct audit_context *context)
   234	{ }
   235	static inline void audit_log_n_hex(struct audit_buffer *ab,
   236					   const unsigned char *buf, size_t len)
   237	{ }
   238	static inline void audit_log_n_string(struct audit_buffer *ab,
   239					      const char *buf, size_t n)
   240	{ }
   241	static inline void  audit_log_n_untrustedstring(struct audit_buffer *ab,
   242							const char *string, size_t n)
   243	{ }
   244	static inline void audit_log_untrustedstring(struct audit_buffer *ab,
   245						     const char *string)
   246	{ }
   247	static inline void audit_log_d_path(struct audit_buffer *ab,
   248					    const char *prefix,
   249					    const struct path *path)
   250	{ }
   251	static inline void audit_log_key(struct audit_buffer *ab, char *key)
   252	{ }
   253	static inline void audit_log_path_denied(int type, const char *operation)
   254	{ }
   255	static inline int audit_log_task_context(struct audit_buffer *ab)
   256	{
   257		return 0;
   258	}
   259	static inline void audit_log_task_info(struct audit_buffer *ab)
   260	{ }
 > 261	static void audit_log_lsm(struct audit_context *context)
   262	{ }
   263	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/9DWx/yDrRhgMJTb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--/9DWx/yDrRhgMJTb--
