Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033351DE8B4
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744457649; cv=none; b=C6GknuoyVfJWTGxIIATa4sRupRdgNSxUsFTH5KjrDEjUpr876w25cmTTXAD8hCF0+yhro2xwALLg7SvNFDj+7TUcOnE5GRsvPFrTOCzntJwS5r1ULiaQ1Ehybyie6mftv/OhJ7sFjib68YP0pTo9H+/ANKC+ZxDY07zGGhhP8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744457649; c=relaxed/simple;
	bh=ZN98UHKVVUzW+/n9/vrgjso6VCJ7xO19LQkMlGV9dVI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hBKG6zamAvjBQwuJoJD/PR6VoJiCgH8+cXP9pUet6A4aF8547Q0KkGvkSxvdJB7c3vHiY7EaJjHAXD8mnjNDTXQKcSazhVbacbS/MFgHH35l2EhUFmKEC+bE8C+nY5hvAAHOLcgVfTyDL0q7zeRdT1A67i7fsqeVvrzYyUb/6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkOcXH+M; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkOcXH+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744457648; x=1775993648;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZN98UHKVVUzW+/n9/vrgjso6VCJ7xO19LQkMlGV9dVI=;
  b=jkOcXH+Mw5/hoR6eSj2GNUaEYgQbQyMcIIGneT3SlIO5YX9v4SBj/gBZ
   Yel44xA1SM9xJNXEpzGwZtpFqKRvYwhzTdGYE12Rt8DJ6e6fzw+6+AfiN
   TN6nGaE9XFdr0w5XeG3xTOL4OzuB16nJP7KwwPtpKvXTSQ8MOCQoD8jEp
   3WUOAcVPZOy7PAZJ53UFvSpYA1IW8fEdGgGtCxR2SW99kUdaP7Wn+0QxC
   Ppre6dzXZUh78HzaK6XfWoBGm17lLG4DYsGCP4lsyfTaNqMrWCbICg9aE
   bOolGGj6O++YPH0Yhgr1jTXBVsTbb/UN165tEDcP8WV3EdMHkKGBizDfY
   Q==;
X-CSE-ConnectionGUID: znzfTq+5S6Kc0WGESKZY8A==
X-CSE-MsgGUID: lW2NdhkiRBCRmhKJVeSb5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45233192"
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="45233192"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 04:34:07 -0700
X-CSE-ConnectionGUID: RRdfwpekSZiDbBQAuqyY7Q==
X-CSE-MsgGUID: ZO0gu/joStOzw+4WI2E6mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="134265560"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Apr 2025 04:34:06 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3Z7b-000BlU-2t;
	Sat, 12 Apr 2025 11:34:03 +0000
Date: Sat, 12 Apr 2025 19:33:52 +0800
From: kernel test robot <lkp@intel.com>
To: Takaya Saeki <takayas@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, selinux@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [pcmoore-selinux:next 6/7] security/selinux/ss/services.c:
 linux/parser.h is included more than once.
Message-ID: <202504121945.Q0GDD0sG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
head:   5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f
commit: 8716451a4e57cc82f3656d7a71b67d3b5831ef3f [6/7] selinux: support wildcard match in genfscon
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504121945.Q0GDD0sG-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> security/selinux/ss/services.c: linux/parser.h is included more than once.

vim +49 security/selinux/ss/services.c

  > 49	#include <linux/parser.h>
    50	#include <linux/vmalloc.h>
    51	#include <linux/lsm_hooks.h>
  > 52	#include <linux/parser.h>
    53	#include <net/netlabel.h>
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
