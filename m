Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AD5C83F19
	for <selinux@archiver.kernel.org>; Tue, 29 Aug 2023 19:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjH2TM7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Aug 2023 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbjH2TMt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Aug 2023 15:12:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80B95
        for <selinux@vger.kernel.org>; Tue, 29 Aug 2023 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693336364; x=1724872364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ti9b0F3GGy9y4DVtVXWI/UR0f1DH4vbIFN59XWem554=;
  b=cDa2D8+oqsDcdZ9evcxfXt+8NF0EvZwn84BUYieIgB75Jcp0q4J2n6+x
   EQ92UVX0B3ILNMQZYzaFYUAdeEwGQaji6/APwGjCU24H/KCmyZbglCb6Q
   I02MFraXuWdmLwSOQnwNYYs2YYBYlJZEGO3cRzgYqa2QKjvmNxKIGS4+0
   DZNlTHBub2YC+FBB1RyQAQshMUarW7/U2qGQZKm2qRxYT4nxwZMFjTjol
   EsStoY18fH3roS6zeyVS38wSD4zHEj/4f35jqtq1Yle4ybD3NnFfkaDEo
   VgCh2RaOQx1p3q7daXsoB+6k3uWmsdh4j7Wv5Tl5VsaWMw4b7IdXEvY6V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406454489"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="406454489"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 12:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="741949827"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="741949827"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2023 12:12:43 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qb48m-00090t-2w;
        Tue, 29 Aug 2023 19:12:41 +0000
Date:   Wed, 30 Aug 2023 03:12:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     oe-kbuild-all@lists.linux.dev, selinux@vger.kernel.org
Subject: [pcmoore-selinux:main 1/1] README.orig: warning: ignored by one of
 the .gitignore files
Message-ID: <202308300357.yzGpfBQ9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git main
head:   50a510a78287c15cee644f345ef8bac8977986a7
commit: 50a510a78287c15cee644f345ef8bac8977986a7 [1/1] selinux: add a SELinux specific README.md and SECURITY.md
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230830/202308300357.yzGpfBQ9-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300357.yzGpfBQ9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308300357.yzGpfBQ9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> README.orig: warning: ignored by one of the .gitignore files
   tools/perf/util/bpf_skel/vmlinux/vmlinux.h: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
