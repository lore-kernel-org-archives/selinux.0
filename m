Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2B9C433E6
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F6D6522E
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 17:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCIRzy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:55:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:59903 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhCIRzk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 9 Mar 2021 12:55:40 -0500
IronPort-SDR: zVfztSlB/E0Px/tIt0uGeLgIGjHsnNFPJPVnpUS+RtzbmMux4USPqS14c6x0wkuNdLMEpMzaOX
 OvUuEJEqqTXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273323823"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="gz'50?scan'50,208,50";a="273323823"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 09:55:36 -0800
IronPort-SDR: ebS28Gwqfoj+661i26OgbsrjmgQdXYrsy+bONBSZU2ZDD74Qsp+nFcc5ODtd6xB/vaIrEEdLAn
 gMipA4yD+IJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="gz'50?scan'50,208,50";a="437990532"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2021 09:55:33 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJgZw-0001ku-TI; Tue, 09 Mar 2021 17:55:32 +0000
Date:   Wed, 10 Mar 2021 01:55:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
Subject: Re: [PATCH v25 21/25] audit: add support for non-syscall auxiliary
 records
Message-ID: <202103100154.IVuu8FMi-lkp@intel.com>
References: <20210309144243.12519-22-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20210309144243.12519-22-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on nf/master]
[also build test ERROR on linus/master v5.12-rc2 next-20210309]
[cannot apply to pcmoore-audit/next nf-next/master security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Casey-Schaufler/LSM-Infrastructure-management-of-the-sock-security/20210309-234224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git master
config: h8300-randconfig-r026-20210308 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/96082b2d5d5bc80fd3dafdf8a737ba8961568067
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Infrastructure-management-of-the-sock-security/20210309-234224
        git checkout 96082b2d5d5bc80fd3dafdf8a737ba8961568067
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/tty/n_tty.c:46:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
--
   In file included from include/linux/rcupdate.h:24,
                    from include/linux/init_task.h:5,
                    from init/init_task.c:2:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:137:2: note: in expansion of macro 'BUG_ON'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:137:10: note: in expansion of macro 'virt_addr_valid'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from init/init_task.c:12:
   include/linux/audit.h: At top level:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
--
   In file included from arch/h8300/kernel/ptrace.c:14:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
   In file included from include/linux/kernel.h:10,
                    from arch/h8300/kernel/ptrace.c:11:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:137:2: note: in expansion of macro 'BUG_ON'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:137:10: note: in expansion of macro 'virt_addr_valid'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   arch/h8300/kernel/ptrace.c: At top level:
   arch/h8300/kernel/ptrace.c:172:17: warning: no previous prototype for 'do_syscall_trace_enter' [-Wmissing-prototypes]
     172 | asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   arch/h8300/kernel/ptrace.c:191:17: warning: no previous prototype for 'do_syscall_trace_leave' [-Wmissing-prototypes]
     191 | asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   arch/h8300/kernel/ptrace.c: In function 'h8300_put_reg':
   arch/h8300/kernel/ptrace.c:61:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
      61 |   task->thread.usp = data - sizeof(long)*2;
         |   ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   arch/h8300/kernel/ptrace.c:62:2: note: here
      62 |  case PT_CCR:
         |  ^~~~
--
   In file included from kernel/module.c:58:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
   kernel/module.c:4675:6: warning: no previous prototype for 'module_layout' [-Wmissing-prototypes]
    4675 | void module_layout(struct module *mod,
         |      ^~~~~~~~~~~~~
--
   In file included from include/asm-generic/bug.h:5,
                    from arch/h8300/include/asm/bug.h:8,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from kernel/fork.c:16:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:137:2: note: in expansion of macro 'BUG_ON'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:137:10: note: in expansion of macro 'virt_addr_valid'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from kernel/fork.c:63:
   include/linux/audit.h: At top level:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
   kernel/fork.c:161:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     161 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:746:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     746 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:836:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     836 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/exit.c:49:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
   In file included from include/asm-generic/bug.h:5,
                    from arch/h8300/include/asm/bug.h:8,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from kernel/exit.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:137:2: note: in expansion of macro 'BUG_ON'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:137:10: note: in expansion of macro 'virt_addr_valid'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   kernel/exit.c: At top level:
   kernel/exit.c:1763:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1763 | __weak void abort(void)
         |             ^~~~~
--
   In file included from include/asm-generic/bug.h:5,
                    from arch/h8300/include/asm/bug.h:8,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from kernel/signal.c:14:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:137:2: note: in expansion of macro 'BUG_ON'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:137:10: note: in expansion of macro 'virt_addr_valid'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from kernel/signal.c:48:
   include/linux/audit.h: At top level:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
   kernel/signal.c:4645:6: warning: no previous prototype for 'kdb_send_sig' [-Wmissing-prototypes]
    4645 | void kdb_send_sig(struct task_struct *t, int sig)
         |      ^~~~~~~~~~~~
--
   In file included from include/asm-generic/bug.h:5,
                    from arch/h8300/include/asm/bug.h:8,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from mm/nommu.c:20:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:137:2: note: in expansion of macro 'BUG_ON'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:137:10: note: in expansion of macro 'virt_addr_valid'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from mm/nommu.c:37:
   include/linux/audit.h: At top level:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
   In file included from arch/h8300/include/asm/page.h:5,
                    from arch/h8300/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:58,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/h8300/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from mm/nommu.c:20:
   mm/nommu.c: In function 'kobjsize':
   include/asm-generic/page.h:89:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   mm/nommu.c:81:16: note: in expansion of macro 'virt_addr_valid'
      81 |  if (!objp || !virt_addr_valid(objp))
         |                ^~~~~~~~~~~~~~~
   mm/nommu.c: At top level:
   mm/nommu.c:1658:15: warning: no previous prototype for 'arch_get_unmapped_area' [-Wmissing-prototypes]
    1658 | unsigned long arch_get_unmapped_area(struct file *file, unsigned long addr,
         |               ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from fs/pipe.c:23:
>> include/linux/audit.h:557:1: error: expected identifier or '(' before '+' token
     557 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
   In file included from include/asm-generic/bug.h:5,
                    from arch/h8300/include/asm/bug.h:8,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from fs/pipe.c:8:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:137:2: note: in expansion of macro 'BUG_ON'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:137:10: note: in expansion of macro 'virt_addr_valid'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~


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

--bp/iNruPH9dso1Pn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
yf8Bw679dJksAQA=

--bp/iNruPH9dso1Pn--
