Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB7C433FE
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 13:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349059AbhKXNhw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 08:37:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:53981 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347864AbhKXNfv (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 24 Nov 2021 08:35:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="234001083"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="234001083"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 05:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="457035789"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2021 05:20:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpsCd-0004p3-10; Wed, 24 Nov 2021 13:20:47 +0000
Date:   Wed, 24 Nov 2021 21:19:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
Subject: Re: [PATCH v30 06/28] LSM: Use lsmblob in security_audit_rule_match
Message-ID: <202111242150.wktMJDSN-lkp@intel.com>
References: <20211124014332.36128-7-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124014332.36128-7-casey@schaufler-ca.com>
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
config: riscv-randconfig-r042-20211124 (https://download.01.org/0day-ci/archive/20211124/202111242150.wktMJDSN-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4d65fc1987e5710b2911159149f0de12d2202631
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20211124-104307
        git checkout 4d65fc1987e5710b2911159149f0de12d2202631
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/android/ kernel/ net/bridge/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:50:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   kernel/fork.c:161:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     161 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:763:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     763 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:59,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exec_domain.c:19:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
--
   In file included from include/linux/perf_event.h:59,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/exit.c:42:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   kernel/exit.c:1817:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1817 | __weak void abort(void)
         |             ^~~~~
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/linux/if_vlan.h:10,
                    from include/linux/filter.h:19,
                    from kernel/kallsyms.c:25:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   kernel/kallsyms.c:586:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
     586 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
         |            ^~~~~~~~~~~~~~~~
   kernel/kallsyms.c:874:30: warning: 'kallsyms_proc_ops' defined but not used [-Wunused-const-variable=]
     874 | static const struct proc_ops kallsyms_proc_ops = {
         |                              ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:59,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from kernel/audit.c:44:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   kernel/audit.c: In function 'audit_log_vformat':
   kernel/audit.c:1926:9: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1926 |         len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args);
         |         ^~~
   kernel/audit.c:1935:17: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1935 |                 len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
         |                 ^~~
--
   In file included from include/linux/audit.h:14,
                    from kernel/auditfilter.c:12:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   kernel/auditfilter.c: In function 'audit_filter':
>> kernel/auditfilter.c:1376:50: error: implicit declaration of function 'security_audit_rule_match'; did you mean 'security_audit_rule_free'? [-Werror=implicit-function-declaration]
    1376 |                                         result = security_audit_rule_match(
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                  security_audit_rule_free
   cc1: some warnings being treated as errors
--
   In file included from include/linux/audit.h:14,
                    from kernel/auditsc.c:45:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   kernel/auditsc.c: In function 'audit_filter_rules':
>> kernel/auditsc.c:674:42: error: implicit declaration of function 'security_audit_rule_match'; did you mean 'security_audit_rule_free'? [-Werror=implicit-function-declaration]
     674 |                                 result = security_audit_rule_match(&blob,
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          security_audit_rule_free
   cc1: some warnings being treated as errors
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/linux/etherdevice.h:21,
                    from net/bridge/br_netlink_tunnel.c:11:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   net/bridge/br_netlink_tunnel.c:29:6: warning: no previous prototype for 'vlan_tunid_inrange' [-Wmissing-prototypes]
      29 | bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
         |      ^~~~~~~~~~~~~~~~~~
   net/bridge/br_netlink_tunnel.c:196:5: warning: no previous prototype for 'br_vlan_tunnel_info' [-Wmissing-prototypes]
     196 | int br_vlan_tunnel_info(const struct net_bridge_port *p, int cmd,
         |     ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/linux/if_vlan.h:10,
                    from include/linux/filter.h:19,
                    from kernel/bpf/core.c:21:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   kernel/bpf/core.c:1368:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1368 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/net/scm.h:8,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/linux/if_vlan.h:10,
                    from include/linux/filter.h:19,
                    from include/linux/bpf_verifier.h:9,
                    from kernel/bpf/btf.c:19:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   kernel/bpf/btf.c: In function 'btf_seq_show':
   kernel/bpf/btf.c:5888:29: warning: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    5888 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
         |                             ^~~~~~~~
   kernel/bpf/btf.c: In function 'btf_snprintf_show':
   kernel/bpf/btf.c:5925:9: warning: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    5925 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
         |         ^~~
--
   In file included from kernel/sched/sched.h:62,
                    from kernel/sched/core.c:13:
>> include/linux/security.h:1974:66: error: expected ';', ',' or ')' before 'secid'
    1974 | static inline int security_audit_rule_match(struct lsmblob *blob secid,
         |                                                                  ^~~~~
   kernel/sched/core.c:3439:6: warning: no previous prototype for 'sched_set_stop_task' [-Wmissing-prototypes]
    3439 | void sched_set_stop_task(int cpu, struct task_struct *stop)
         |      ^~~~~~~~~~~~~~~~~~~
..


vim +1974 include/linux/security.h

  1973	
> 1974	static inline int security_audit_rule_match(struct lsmblob *blob secid,
  1975						    u32 field, u32 op,
  1976						    struct audit_rules *lsmrules)
  1977	{
  1978		return 0;
  1979	}
  1980	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
