Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F0165F0B;
	Fri, 30 Aug 2024 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725058186; cv=none; b=oNWRoDn2UtxdhOZxjvKYE4bQn4vQpy5kcxjY5lixcisIOXoolj+WcXrbBighb0Ko6D267O8m/TrZ9ty8pOmDNeXzqyZ42YDpcY3pVsUCpCugkrUNMoq4GELoBaSvJ+cuhYx3UosxKp2h6f75BalJ+A0+qp8w4FVkS15bj+T4zo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725058186; c=relaxed/simple;
	bh=YdoudeZMIVGlTDb8GaVCvxc2lVcjIsy/gQvNRtIy2IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX+NPLeeklQCCQgcsJ6sPARcMy0un1R4he5jB/ebua8+xZqYnS7pLmo4dnzDPfUOOpR6cEKyPSeX2MJjLLmivB23eNbidDGCBi/HfPRVejVqRF1v1kHpvLojpSV/AdowF/EY0z2MbqGDSXdDeQo+mtlPQK51Lb3J29e0irz68G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTj5kP8/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTj5kP8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725058185; x=1756594185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YdoudeZMIVGlTDb8GaVCvxc2lVcjIsy/gQvNRtIy2IE=;
  b=gTj5kP8/FY1x/kzyYK+cqthnoMFNgaUF4CR+j10WUezgmIPY+oZo/KDv
   /KcrqjS9u0W/LDWzepEIf1TjSU5Tzm7tBDZ9TRnuBqZGrd/hO8sDrqxB5
   lFNPFdLWmLcA7QBYJYTkrNMc+pp+tfBN6xmpfaOIu2iMA5Ecwa6xowoYx
   jfizAOGSyPwrDK8DNWhgZJxkgRDbVzfVderQi5x1ULZzNWyIO863+olKF
   zvzcxVGAySUXFL5KiLNhz/vH1dS+FpXAoGIXYM4V5TYaJQNEHtaJS3YcF
   lVjjg4ZfPoI6dr6uYrvtF7m1ZEWk+kTpe9fFfiDQ3wrkzrgDtD/Nr+d5s
   w==;
X-CSE-ConnectionGUID: nIcBzIAAT92NCGo8B5BC1A==
X-CSE-MsgGUID: CpnDN6HOQEeD+FJfjtP5mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="41212547"
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="41212547"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 15:49:44 -0700
X-CSE-ConnectionGUID: 7GywkkJLTieA60AVSeBarg==
X-CSE-MsgGUID: oijJLkmGQAKb44d2pmCD3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="64217870"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Aug 2024 15:49:41 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skAR1-0002Bi-08;
	Fri, 30 Aug 2024 22:49:39 +0000
Date: Sat, 31 Aug 2024 06:48:48 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jmorris@namei.org, serge@hallyn.com,
	keescook@chromium.org, john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	mic@digikod.net
Subject: Re: [PATCH v2 02/13] LSM: Use lsmblob in security_audit_rule_match
Message-ID: <202408310649.X413mMQP-lkp@intel.com>
References: <20240830003411.16818-3-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830003411.16818-3-casey@schaufler-ca.com>

Hi Casey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-audit/next]
[also build test WARNING on pcmoore-selinux/next zohar-integrity/next-integrity linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Add-the-lsmblob-data-structure/20240830-085050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
patch link:    https://lore.kernel.org/r/20240830003411.16818-3-casey%40schaufler-ca.com
patch subject: [PATCH v2 02/13] LSM: Use lsmblob in security_audit_rule_match
config: i386-randconfig-061-20240830 (https://download.01.org/0day-ci/archive/20240831/202408310649.X413mMQP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310649.X413mMQP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310649.X413mMQP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> security/integrity/ima/ima_policy.c:654:53: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] secid @@     got struct lsmblob * @@
   security/integrity/ima/ima_policy.c:654:53: sparse:     expected unsigned int [usertype] secid
   security/integrity/ima/ima_policy.c:654:53: sparse:     got struct lsmblob *
   security/integrity/ima/ima_policy.c:663:53: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] secid @@     got struct lsmblob * @@
   security/integrity/ima/ima_policy.c:663:53: sparse:     expected unsigned int [usertype] secid
   security/integrity/ima/ima_policy.c:663:53: sparse:     got struct lsmblob *
   security/integrity/ima/ima_policy.c: note: in included file:
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   security/integrity/ima/ima_policy.c:1666:52: sparse: sparse: self-comparison always evaluates to false
   security/integrity/ima/ima_policy.c:1701:55: sparse: sparse: self-comparison always evaluates to false
   security/integrity/ima/ima_policy.c:1728:55: sparse: sparse: self-comparison always evaluates to false
   security/integrity/ima/ima_policy.c:1754:55: sparse: sparse: self-comparison always evaluates to false
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +654 security/integrity/ima/ima_policy.c

   553	
   554	/**
   555	 * ima_match_rules - determine whether an inode matches the policy rule.
   556	 * @rule: a pointer to a rule
   557	 * @idmap: idmap of the mount the inode was found from
   558	 * @inode: a pointer to an inode
   559	 * @cred: a pointer to a credentials structure for user validation
   560	 * @secid: the secid of the task to be validated
   561	 * @func: LIM hook identifier
   562	 * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
   563	 * @func_data: func specific data, may be NULL
   564	 *
   565	 * Returns true on rule match, false on failure.
   566	 */
   567	static bool ima_match_rules(struct ima_rule_entry *rule,
   568				    struct mnt_idmap *idmap,
   569				    struct inode *inode, const struct cred *cred,
   570				    u32 secid, enum ima_hooks func, int mask,
   571				    const char *func_data)
   572	{
   573		int i;
   574		bool result = false;
   575		struct ima_rule_entry *lsm_rule = rule;
   576		bool rule_reinitialized = false;
   577	
   578		if ((rule->flags & IMA_FUNC) &&
   579		    (rule->func != func && func != POST_SETATTR))
   580			return false;
   581	
   582		switch (func) {
   583		case KEY_CHECK:
   584		case CRITICAL_DATA:
   585			return ((rule->func == func) &&
   586				ima_match_rule_data(rule, func_data, cred));
   587		default:
   588			break;
   589		}
   590	
   591		if ((rule->flags & IMA_MASK) &&
   592		    (rule->mask != mask && func != POST_SETATTR))
   593			return false;
   594		if ((rule->flags & IMA_INMASK) &&
   595		    (!(rule->mask & mask) && func != POST_SETATTR))
   596			return false;
   597		if ((rule->flags & IMA_FSMAGIC)
   598		    && rule->fsmagic != inode->i_sb->s_magic)
   599			return false;
   600		if ((rule->flags & IMA_FSNAME)
   601		    && strcmp(rule->fsname, inode->i_sb->s_type->name))
   602			return false;
   603		if ((rule->flags & IMA_FSUUID) &&
   604		    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
   605			return false;
   606		if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
   607			return false;
   608		if (rule->flags & IMA_EUID) {
   609			if (has_capability_noaudit(current, CAP_SETUID)) {
   610				if (!rule->uid_op(cred->euid, rule->uid)
   611				    && !rule->uid_op(cred->suid, rule->uid)
   612				    && !rule->uid_op(cred->uid, rule->uid))
   613					return false;
   614			} else if (!rule->uid_op(cred->euid, rule->uid))
   615				return false;
   616		}
   617		if ((rule->flags & IMA_GID) && !rule->gid_op(cred->gid, rule->gid))
   618			return false;
   619		if (rule->flags & IMA_EGID) {
   620			if (has_capability_noaudit(current, CAP_SETGID)) {
   621				if (!rule->gid_op(cred->egid, rule->gid)
   622				    && !rule->gid_op(cred->sgid, rule->gid)
   623				    && !rule->gid_op(cred->gid, rule->gid))
   624					return false;
   625			} else if (!rule->gid_op(cred->egid, rule->gid))
   626				return false;
   627		}
   628		if ((rule->flags & IMA_FOWNER) &&
   629		    !rule->fowner_op(i_uid_into_vfsuid(idmap, inode),
   630				     rule->fowner))
   631			return false;
   632		if ((rule->flags & IMA_FGROUP) &&
   633		    !rule->fgroup_op(i_gid_into_vfsgid(idmap, inode),
   634				     rule->fgroup))
   635			return false;
   636		for (i = 0; i < MAX_LSM_RULES; i++) {
   637			int rc = 0;
   638			struct lsmblob blob = { };
   639	
   640			if (!lsm_rule->lsm[i].rule) {
   641				if (!lsm_rule->lsm[i].args_p)
   642					continue;
   643				else
   644					return false;
   645			}
   646	
   647	retry:
   648			switch (i) {
   649			case LSM_OBJ_USER:
   650			case LSM_OBJ_ROLE:
   651			case LSM_OBJ_TYPE:
   652				/* scaffolding */
   653				security_inode_getsecid(inode, &blob.scaffold.secid);
 > 654				rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
   655							   Audit_equal,
   656							   lsm_rule->lsm[i].rule);
   657				break;
   658			case LSM_SUBJ_USER:
   659			case LSM_SUBJ_ROLE:
   660			case LSM_SUBJ_TYPE:
   661				/* scaffolding */
   662				blob.scaffold.secid = secid;
   663				rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
   664							   Audit_equal,
   665							   lsm_rule->lsm[i].rule);
   666				break;
   667			default:
   668				break;
   669			}
   670	
   671			if (rc == -ESTALE && !rule_reinitialized) {
   672				lsm_rule = ima_lsm_copy_rule(rule, GFP_ATOMIC);
   673				if (lsm_rule) {
   674					rule_reinitialized = true;
   675					goto retry;
   676				}
   677			}
   678			if (!rc) {
   679				result = false;
   680				goto out;
   681			}
   682		}
   683		result = true;
   684	
   685	out:
   686		if (rule_reinitialized) {
   687			for (i = 0; i < MAX_LSM_RULES; i++)
   688				ima_filter_rule_free(lsm_rule->lsm[i].rule);
   689			kfree(lsm_rule);
   690		}
   691		return result;
   692	}
   693	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
