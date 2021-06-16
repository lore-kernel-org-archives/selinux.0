Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECCFC48BE8
	for <selinux@archiver.kernel.org>; Wed, 16 Jun 2021 14:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D47461075
	for <selinux@archiver.kernel.org>; Wed, 16 Jun 2021 14:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhFPO5z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:57:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:37998 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234220AbhFPO5z (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 16 Jun 2021 10:57:55 -0400
IronPort-SDR: UIn+Hz56874cW7XSzEmSIaO4XECAD1lPer84bWaFJBqXJz41jVSUKFHWcNMhyipiJpzSFXxCEY
 iDTRvbg8qnvg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206148799"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="gz'50?scan'50,208,50";a="206148799"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 07:55:48 -0700
IronPort-SDR: MqYQL2oLDJym2bYC1jVBaILfRJejsAJdm1zZv48r6f+mL5N9noPrMjjYLr7/nXgu121ogIyO2l
 ImgI2b/77gLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="gz'50?scan'50,208,50";a="404593835"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2021 07:55:44 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltWxE-0001GK-2E; Wed, 16 Jun 2021 14:55:44 +0000
Date:   Wed, 16 Jun 2021 22:54:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
Subject: Re: [PATCH v27 21/25] audit: add support for non-syscall auxiliary
 records
Message-ID: <202106162222.NKRvIRiX-lkp@intel.com>
References: <20210611000435.36398-22-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20210611000435.36398-22-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on nf/master]
[also build test ERROR on linus/master v5.13-rc6]
[cannot apply to security/next-testing pcmoore-audit/next nf-next/master next-20210616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Casey-Schaufler/LSM-Infrastructure-management-of-the-sock-security/20210616-133254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git master
config: m68k-randconfig-r021-20210615 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c6c28a65377a02c1aa05846e32c56cb015da9904
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Infrastructure-management-of-the-sock-security/20210616-133254
        git checkout c6c28a65377a02c1aa05846e32c56cb015da9904
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/fsnotify.h:16,
                    from fs/configfs/dir.c:14:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
--
   In file included from include/linux/fsnotify.h:16,
                    from fs/cachefiles/namei.c:12:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
   fs/cachefiles/namei.c: In function 'cachefiles_walk_to_object':
   fs/cachefiles/namei.c:499:16: warning: variable 'start' set but not used [-Wunused-but-set-variable]
     499 |  unsigned long start;
         |                ^~~~~
   fs/cachefiles/namei.c: In function 'cachefiles_get_directory':
   fs/cachefiles/namei.c:768:16: warning: variable 'start' set but not used [-Wunused-but-set-variable]
     768 |  unsigned long start;
         |                ^~~~~
   fs/cachefiles/namei.c: In function 'cachefiles_check_active':
   fs/cachefiles/namei.c:879:16: warning: variable 'start' set but not used [-Wunused-but-set-variable]
     879 |  unsigned long start;
         |                ^~~~~
--
   In file included from fs/pipe.c:23:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
   fs/pipe.c:741:15: warning: no previous prototype for 'account_pipe_buffers' [-Wmissing-prototypes]
     741 | unsigned long account_pipe_buffers(struct user_struct *user,
         |               ^~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:747:6: warning: no previous prototype for 'too_many_pipe_buffers_soft' [-Wmissing-prototypes]
     747 | bool too_many_pipe_buffers_soft(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:754:6: warning: no previous prototype for 'too_many_pipe_buffers_hard' [-Wmissing-prototypes]
     754 | bool too_many_pipe_buffers_hard(unsigned long user_bufs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:761:6: warning: no previous prototype for 'pipe_is_unprivileged_user' [-Wmissing-prototypes]
     761 | bool pipe_is_unprivileged_user(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:1231:5: warning: no previous prototype for 'pipe_resize_ring' [-Wmissing-prototypes]
    1231 | int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
         |     ^~~~~~~~~~~~~~~~


vim +557 include/linux/audit.h

   553	
   554	extern int audit_n_rules;
   555	extern int audit_signals;
   556	#else /* CONFIG_AUDITSYSCALL */
 > 557	+static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
   558	{
   559		return NULL;
   560	}
   561	static inline void audit_free_context(struct audit_context *context)
   562	{ }
   563	static inline int audit_alloc(struct task_struct *task)
   564	{
   565		return 0;
   566	}
   567	static inline void audit_free(struct task_struct *task)
   568	{ }
   569	static inline void audit_syscall_entry(int major, unsigned long a0,
   570					       unsigned long a1, unsigned long a2,
   571					       unsigned long a3)
   572	{ }
   573	static inline void audit_syscall_exit(void *pt_regs)
   574	{ }
   575	static inline bool audit_dummy_context(void)
   576	{
   577		return true;
   578	}
   579	static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
   580	{ }
   581	static inline struct audit_context *audit_context(void)
   582	{
   583		return NULL;
   584	}
   585	static inline struct filename *audit_reusename(const __user char *name)
   586	{
   587		return NULL;
   588	}
   589	static inline void audit_getname(struct filename *name)
   590	{ }
   591	static inline void audit_inode(struct filename *name,
   592					const struct dentry *dentry,
   593					unsigned int aflags)
   594	{ }
   595	static inline void audit_file(struct file *file)
   596	{
   597	}
   598	static inline void audit_inode_parent_hidden(struct filename *name,
   599					const struct dentry *dentry)
   600	{ }
   601	static inline void audit_inode_child(struct inode *parent,
   602					     const struct dentry *dentry,
   603					     const unsigned char type)
   604	{ }
   605	static inline void audit_core_dumps(long signr)
   606	{ }
   607	static inline void audit_seccomp(unsigned long syscall, long signr, int code)
   608	{ }
   609	static inline void audit_seccomp_actions_logged(const char *names,
   610							const char *old_names, int res)
   611	{ }
   612	static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
   613	{ }
   614	static inline void audit_ipc_set_perm(unsigned long qbytes, uid_t uid,
   615						gid_t gid, umode_t mode)
   616	{ }
   617	static inline void audit_bprm(struct linux_binprm *bprm)
   618	{ }
   619	static inline int audit_socketcall(int nargs, unsigned long *args)
   620	{
   621		return 0;
   622	}
   623	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HlL+5n6rz5pIUxbD
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HlL+5n6rz5pIUxbD--
