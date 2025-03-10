Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9FBEC5;
	Mon, 10 Mar 2025 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741567241; cv=none; b=uA/3zfH+hbDT02mXK3/btYEmUSGSDtvKOoj9BdHFsFuxdsDhgaGkH9QVvzHAzvdl6IrioOmJM1QCt90NuRp9OcXtAl1/etjI3x+FJqBhjsQ3j5SHsrZQTKB1QKKslJQgFNrtMjfIJFfhFXeuhCH+1epzmvYHkPik6BaFjjzW348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741567241; c=relaxed/simple;
	bh=fPofR83G5HoqBX7vZ1BWgiPYfrVXcgXiDr0FAZchcbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2RzIFWa19yBjqWqYTk8oDG3z78ILoOhVOfnafrbNJj2tv6+M3oWnzTnChfPbG0OguuVoON5Lcz5ElB9mLPj0rP+tFiDcrsSI1RDgqTTrPVbBhe2CaRYvDvMy6AIQBaD19mAu1gOHxJr8e/lhTS8XTtcr4TkVFUd//7F20qlWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOax1CPG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOax1CPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741567239; x=1773103239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fPofR83G5HoqBX7vZ1BWgiPYfrVXcgXiDr0FAZchcbQ=;
  b=WOax1CPGsHU0ZFiTTkPRXzeqD+250Ur3jDXc5/kU/do5lmd2jS/oOGVl
   AUwHe/zhdzV22a1ZImJqREtwD1YkCKQau4WfPjtDLeH6tYqRHBX58h0EC
   FekTVaTOphZY1aUelLBGM+BLN1bBfRTkfASqxvDvK6x158CR/gGqrJFSf
   oNkVa4Yjdsssj0ZP2IYqsBw2mQcNqqMrAFbIy1uaiftvxGECcpmkV5Jm3
   /0gavqAD0mhPDa3mOrP1o4IgYBimgfa5heewojnrM0DXkEVT3XAtYshfX
   XgxlZXdRPDgK/loIczPYVtQ5Wk6suqBlq34Qn/3AJR2BTYtT4+HAwwt4m
   A==;
X-CSE-ConnectionGUID: lxMIGI0BSwe5f1XBATNU3w==
X-CSE-MsgGUID: GHuBd0EmSA2NsYaNuI82YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="41714245"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="41714245"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 17:40:38 -0700
X-CSE-ConnectionGUID: RfyAm9ZERT+WHRxQxCfycw==
X-CSE-MsgGUID: x/99IQEgQi6esqtqzMfHnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="157037843"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 09 Mar 2025 17:40:31 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trRC0-0003b2-28;
	Mon, 10 Mar 2025 00:40:28 +0000
Date: Mon, 10 Mar 2025 08:39:28 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+00c633585760c05507c3@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	omosnace@redhat.com, paul@paul-moore.com, selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] selinux: read and write sid under lock
Message-ID: <202503100821.PtEmEm7K-lkp@intel.com>
References: <tencent_0BEE86CD3878D26D402DDD6F949484E96E0A@qq.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0BEE86CD3878D26D402DDD6F949484E96E0A@qq.com>

Hi Edward,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/selinux-read-and-write-sid-under-lock/20250309-130846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/tencent_0BEE86CD3878D26D402DDD6F949484E96E0A%40qq.com
patch subject: [PATCH] selinux: read and write sid under lock
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250310/202503100821.PtEmEm7K-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503100821.PtEmEm7K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503100821.PtEmEm7K-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/selinux/hooks.c: In function 'selinux_socket_post_create':
>> security/selinux/hooks.c:4718:33: error: 'struct sk_security_struct' has no member named 'lock'
    4718 |                 spin_lock(&sksec->lock);
         |                                 ^~
   security/selinux/hooks.c:4721:35: error: 'struct sk_security_struct' has no member named 'lock'
    4721 |                 spin_unlock(&sksec->lock);
         |                                   ^~
   security/selinux/hooks.c: In function 'selinux_socket_sock_rcv_skb':
   security/selinux/hooks.c:5198:25: error: 'struct sk_security_struct' has no member named 'lock'
    5198 |         spin_lock(&sksec->lock);
         |                         ^~
   security/selinux/hooks.c:5200:27: error: 'struct sk_security_struct' has no member named 'lock'
    5200 |         spin_unlock(&sksec->lock);
         |                           ^~


vim +4718 security/selinux/hooks.c

  4695	
  4696	static int selinux_socket_post_create(struct socket *sock, int family,
  4697					      int type, int protocol, int kern)
  4698	{
  4699		const struct task_security_struct *tsec = selinux_cred(current_cred());
  4700		struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
  4701		struct sk_security_struct *sksec;
  4702		u16 sclass = socket_type_to_security_class(family, type, protocol);
  4703		u32 sid = SECINITSID_KERNEL;
  4704		int err = 0;
  4705	
  4706		if (!kern) {
  4707			err = socket_sockcreate_sid(tsec, sclass, &sid);
  4708			if (err)
  4709				return err;
  4710		}
  4711	
  4712		isec->sclass = sclass;
  4713		isec->sid = sid;
  4714		isec->initialized = LABEL_INITIALIZED;
  4715	
  4716		if (sock->sk) {
  4717			sksec = selinux_sock(sock->sk);
> 4718			spin_lock(&sksec->lock);
  4719			sksec->sclass = sclass;
  4720			sksec->sid = sid;
  4721			spin_unlock(&sksec->lock);
  4722			/* Allows detection of the first association on this socket */
  4723			if (sksec->sclass == SECCLASS_SCTP_SOCKET)
  4724				sksec->sctp_assoc_state = SCTP_ASSOC_UNSET;
  4725	
  4726			err = selinux_netlbl_socket_post_create(sock->sk, family);
  4727		}
  4728	
  4729		return err;
  4730	}
  4731	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
