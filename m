Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95336C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 06:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594C3218E2
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 06:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfCVG5U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:57:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38091 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCVG5U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 02:57:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id e80so1052687ote.5
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 23:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjDW3bmJ1XYLNODNXrRHkmcuRZs4niG8Mcm4Ix5Inqo=;
        b=A5q6MQLcf4JETUthTbFVBoUDUbD91YjUJze0H9Jl4W5KOqrEaSOwAjkZ0nWB9H5FXr
         0LBuqN9dGM84/sTbEmG8KzWVeHeJuUEU7SO57F7H/tNwfiavmCiPfoTX3o0PGVqvdLJH
         f3mpQuNrO566Bw7w3G4OFeoGwZw7BqkRETou5yFMvR0aJsNu8qz4v0oqjLr9sFZlgvcV
         IU8BsdIY/DuBi9928zi457VcdJ/N//ImoF7xsVCqD5pNkCWyNLGD+71yD7XoR5sdjJ7+
         LguQ/HQo/d1mTB/VASp1164KYdbNRek9SK8I7SBfCkjDIQl7n9+QCfiLAxO/rommdQuB
         xxQg==
X-Gm-Message-State: APjAAAX7Gv3Av75WKBY/qFavtiJH/llXYVaQLR/EOAnV88fZ+ZAnq5Zc
        Jt0SRjuP5i0Ha3O+iTPeuQom42YWuD66VNjO2fVe3g8qZ02gGQ==
X-Google-Smtp-Source: APXvYqyu3Ox+Q9H69KqZDyYIEmYr1AYSJ0HGAZrRwqp/uMt2r7wpVXP2wU9TvoGbYw+keH3BsKfTRs6TmBbM/eG7WVM=
X-Received: by 2002:a9d:4e10:: with SMTP id p16mr5814256otf.65.1553237839469;
 Thu, 21 Mar 2019 23:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <201903211834.Qtb0LJ32%lkp@intel.com>
In-Reply-To: <201903211834.Qtb0LJ32%lkp@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 Mar 2019 07:57:07 +0100
Message-ID: <CAFqZXNtK0wVHWn7jQrv0JkM1Lpi17s5ZVgCp_GgqnW3Vv5-jSg@mail.gmail.com>
Subject: Re: [pcmoore-selinux:next 8/10] htmldocs: include/linux/lsm_hooks.h:1814:
 warning: Function parameter or member 'kernfs_init_security' not described in 'security_list_options'
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 22, 2019 at 4:12 AM kbuild test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
> head:   e19dfdc83b60f196e0653d683499f7bc5548128f
> commit: b230d5aba2d1a7b0636408889a75bf9eae6b8bc7 [8/10] LSM: add new hook for kernfs node initialization
> reproduce: make htmldocs
>
> All warnings (new ones prefixed by >>):
>
>    include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
>    include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
>    include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
>    include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
>    include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
>    drivers/gpu/drm/scheduler/sched_main.c:376: warning: Excess function parameter 'bad' description in 'drm_sched_stop'
>    drivers/gpu/drm/scheduler/sched_main.c:377: warning: Excess function parameter 'bad' description in 'drm_sched_stop'
>    drivers/gpu/drm/scheduler/sched_main.c:420: warning: Function parameter or member 'full_recovery' not described in 'drm_sched_start'
>    drivers/gpu/drm/i915/i915_vma.h:50: warning: cannot understand function prototype: 'struct i915_vma '
>    drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
>    drivers/gpu/drm/i915/intel_guc_fwif.h:536: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
>    drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'hw_id' not described in 'komeda_component'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'max_active_outputs' not described in 'komeda_component'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'supported_outputs' not described in 'komeda_component'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:142: warning: Function parameter or member 'output_port' not described in 'komeda_component_output'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'component' not described in 'komeda_component_state'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'crtc' not described in 'komeda_component_state'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'plane' not described in 'komeda_component_state'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'wb_conn' not described in 'komeda_component_state'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'changed_active_inputs' not described in 'komeda_component_state'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'affected_inputs' not described in 'komeda_component_state'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'n_layers' not described in 'komeda_pipeline'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'layers' not described in 'komeda_pipeline'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'n_scalers' not described in 'komeda_pipeline'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'scalers' not described in 'komeda_pipeline'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'compiz' not described in 'komeda_pipeline'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'wb_layer' not described in 'komeda_pipeline'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'improc' not described in 'komeda_pipeline'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'ctrlr' not described in 'komeda_pipeline'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'funcs' not described in 'komeda_pipeline'
>    drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:321: warning: Function parameter or member 'pipe' not described in 'komeda_pipeline_state'
>    drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'dev' not described in 'komeda_dev'
>    drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'reg_base' not described in 'komeda_dev'
>    drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'chip' not described in 'komeda_dev'
>    drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'mclk' not described in 'komeda_dev'
>    drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'n_pipelines' not described in 'komeda_dev'
>    drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'pipelines' not described in 'komeda_dev'
>    drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h:1: warning: no structured comments found
>    drivers/gpu/drm/arm/display/komeda/komeda_crtc.c:1: warning: no structured comments found
>    drivers/gpu/drm/arm/display/komeda/komeda_plane.c:1: warning: no structured comments found
>    include/linux/interconnect.h:1: warning: no structured comments found
>    include/linux/skbuff.h:899: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'list' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
>    include/linux/skbuff.h:899: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
>    include/net/sock.h:238: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
>    include/net/sock.h:513: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
>    include/net/sock.h:513: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
>    include/net/sock.h:513: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
>    include/net/sock.h:513: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
>    include/net/sock.h:513: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
>    include/linux/netdevice.h:2064: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
>    include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
>    include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
> >> include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'kernfs_init_security' not described in 'security_list_options'

Hm, it looks like this is because I accidentally omitted the ":" at
the end of "@kernfs_init_security". I will send a patch when I get to
it (unless someone does it first).

>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'task_setioprio' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'task_getioprio' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'task_movememory' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'secmark_refcount_inc' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1814: warning: Function parameter or member 'secmark_refcount_dec' not described in 'security_list_options'
>    Documentation/core-api/index.rst:11: WARNING: toctree contains reference to nonexisting document u'core-api/flexible-arrays'
>    include/linux/list.h:211: WARNING: Inline strong start-string without end-string.
>    include/linux/xarray.h:232: ERROR: Unexpected indentation.
>    include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
>    include/linux/wait.h:113: ERROR: Unexpected indentation.
>    include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
>    kernel/time/hrtimer.c:1120: WARNING: Block quote ends without a blank line; unexpected unindent.
>    kernel/signal.c:346: WARNING: Inline literal start-string without end-string.
>    include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.
>    drivers/ata/libata-core.c:5960: ERROR: Unknown target name: "hw".
>    drivers/message/fusion/mptbase.c:5057: WARNING: Definition list ends without a blank line; unexpected unindent.
>    drivers/tty/serial/serial_core.c:1958: WARNING: Definition list ends without a blank line; unexpected unindent.
>    include/linux/mtd/rawnand.h:1184: WARNING: Inline strong start-string without end-string.
>    include/linux/mtd/rawnand.h:1186: WARNING: Inline strong start-string without end-string.
>    include/linux/regulator/driver.h:289: ERROR: Unknown target name: "regulator_regmap_x_voltage".
>    Documentation/driver-api/soundwire/locking.rst:50: ERROR: Inconsistent literal block quoting.
>    Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
>    Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
>    Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.
>    include/linux/spi/spi.h:376: ERROR: Unexpected indentation.
>    fs/posix_acl.c:635: WARNING: Inline emphasis start-string without end-string.
>    fs/debugfs/inode.c:386: WARNING: Inline literal start-string without end-string.
>    fs/debugfs/inode.c:465: WARNING: Inline literal start-string without end-string.
>    fs/debugfs/inode.c:497: WARNING: Inline literal start-string without end-string.
>    fs/debugfs/inode.c:584: WARNING: Inline literal start-string without end-string.
>    drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1856: WARNING: Inline emphasis start-string without end-string.
>    drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1858: WARNING: Inline emphasis start-string without end-string.
>    Documentation/networking/af_xdp.rst:319: WARNING: Literal block expected; none found.
>    Documentation/networking/af_xdp.rst:326: WARNING: Literal block expected; none found.
>    Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst:43: WARNING: Definition list ends without a blank line; unexpected unindent.
>    Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst:63: ERROR: Unexpected indentation.
>    include/linux/netdevice.h:3487: WARNING: Inline emphasis start-string without end-string.
>    include/linux/netdevice.h:3487: WARNING: Inline emphasis start-string without end-string.
>    net/core/dev.c:4981: ERROR: Unknown target name: "page_is".
>    Documentation/networking/snmp_counter.rst:416: WARNING: Title underline too short.
>
> vim +1814 include/linux/lsm_hooks.h
>
> 3c4ed7bd Casey Schaufler 2015-05-02 @1814
>
> :::::: The code at line 1814 was first introduced by commit
> :::::: 3c4ed7bdf5997d8020cbb8d4abbef2fcfb9f1284 LSM: Split security.h
>
> :::::: TO: Casey Schaufler <casey@schaufler-ca.com>
> :::::: CC: James Morris <james.l.morris@oracle.com>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
