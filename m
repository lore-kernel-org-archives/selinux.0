Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604A5C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 03:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB7C218FE
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 03:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCVDMQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:12:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:38946 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfCVDMQ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 23:12:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 20:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,255,1549958400"; 
   d="gz'50?scan'50,208,50";a="154041980"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2019 20:12:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h7AbN-0005LQ-B1; Fri, 22 Mar 2019 11:12:13 +0800
Date:   Thu, 21 Mar 2019 18:47:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     kbuild-all@01.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Subject: [pcmoore-selinux:next 8/10] htmldocs:
 include/linux/lsm_hooks.h:1814: warning: Function parameter or member
 'kernfs_init_security' not described in 'security_list_options'
Message-ID: <201903211834.Qtb0LJ32%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
head:   e19dfdc83b60f196e0653d683499f7bc5548128f
commit: b230d5aba2d1a7b0636408889a75bf9eae6b8bc7 [8/10] LSM: add new hook for kernfs node initialization
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   drivers/gpu/drm/scheduler/sched_main.c:376: warning: Excess function parameter 'bad' description in 'drm_sched_stop'
   drivers/gpu/drm/scheduler/sched_main.c:377: warning: Excess function parameter 'bad' description in 'drm_sched_stop'
   drivers/gpu/drm/scheduler/sched_main.c:420: warning: Function parameter or member 'full_recovery' not described in 'drm_sched_start'
   drivers/gpu/drm/i915/i915_vma.h:50: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:536: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
   drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'hw_id' not described in 'komeda_component'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'max_active_outputs' not described in 'komeda_component'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'supported_outputs' not described in 'komeda_component'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:142: warning: Function parameter or member 'output_port' not described in 'komeda_component_output'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'component' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'crtc' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'plane' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'wb_conn' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'changed_active_inputs' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'affected_inputs' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'n_layers' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'layers' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'n_scalers' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'scalers' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'compiz' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'wb_layer' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'improc' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'ctrlr' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'funcs' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:321: warning: Function parameter or member 'pipe' not described in 'komeda_pipeline_state'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'dev' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'reg_base' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'chip' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'mclk' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'n_pipelines' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'pipelines' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h:1: warning: no structured comments found
   drivers/gpu/drm/arm/display/komeda/komeda_crtc.c:1: warning: no structured comments found
   drivers/gpu/drm/arm/display/komeda/komeda_plane.c:1: warning: no structured comments found
   include/linux/interconnect.h:1: warning: no structured comments found
   include/linux/skbuff.h:899: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:238: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:513: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:513: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:513: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:513: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:513: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
>> include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'kernfs_init_security' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'task_setioprio' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'task_getioprio' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'task_movememory' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'secmark_refcount_inc' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'secmark_refcount_dec' not described in 'security_list_options'
   Documentation/core-api/index.rst:11: WARNING: toctree contains reference to nonexisting document u'core-api/flexible-arrays'
   include/linux/list.h:211: WARNING: Inline strong start-string without end-string.
   include/linux/xarray.h:232: ERROR: Unexpected indentation.
   include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:113: ERROR: Unexpected indentation.
   include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1120: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:346: WARNING: Inline literal start-string without end-string.
   include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.
   drivers/ata/libata-core.c:5960: ERROR: Unknown target name: "hw".
   drivers/message/fusion/mptbase.c:5057: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1958: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/mtd/rawnand.h:1184: WARNING: Inline strong start-string without end-string.
   include/linux/mtd/rawnand.h:1186: WARNING: Inline strong start-string without end-string.
   include/linux/regulator/driver.h:289: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   Documentation/driver-api/soundwire/locking.rst:50: ERROR: Inconsistent literal block quoting.
   Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
   Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
   Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.
   include/linux/spi/spi.h:376: ERROR: Unexpected indentation.
   fs/posix_acl.c:635: WARNING: Inline emphasis start-string without end-string.
   fs/debugfs/inode.c:386: WARNING: Inline literal start-string without end-string.
   fs/debugfs/inode.c:465: WARNING: Inline literal start-string without end-string.
   fs/debugfs/inode.c:497: WARNING: Inline literal start-string without end-string.
   fs/debugfs/inode.c:584: WARNING: Inline literal start-string without end-string.
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1856: WARNING: Inline emphasis start-string without end-string.
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1858: WARNING: Inline emphasis start-string without end-string.
   Documentation/networking/af_xdp.rst:319: WARNING: Literal block expected; none found.
   Documentation/networking/af_xdp.rst:326: WARNING: Literal block expected; none found.
   Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst:43: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst:63: ERROR: Unexpected indentation.
   include/linux/netdevice.h:3487: WARNING: Inline emphasis start-string without end-string.
   include/linux/netdevice.h:3487: WARNING: Inline emphasis start-string without end-string.
   net/core/dev.c:4981: ERROR: Unknown target name: "page_is".
   Documentation/networking/snmp_counter.rst:416: WARNING: Title underline too short.

vim +1814 include/linux/lsm_hooks.h

3c4ed7bd Casey Schaufler 2015-05-02 @1814  

:::::: The code at line 1814 was first introduced by commit
:::::: 3c4ed7bdf5997d8020cbb8d4abbef2fcfb9f1284 LSM: Split security.h

:::::: TO: Casey Schaufler <casey@schaufler-ca.com>
:::::: CC: James Morris <james.l.morris@oracle.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--vtzGhvizbBRQ85DL
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2aiBVEreZvwPD662H+JcAAA=

--vtzGhvizbBRQ85DL--
