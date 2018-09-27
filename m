Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8RLjP52021203
 for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2018 17:45:25 -0400
Date: Fri, 28 Sep 2018 07:45:00 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey.schaufler@intel.com>
cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 dave.hansen@intel.com, deneen.t.dock@intel.com,
 kristen@linux.intel.com, arjan@linux.intel.com
In-Reply-To: <20180926203446.2004-6-casey.schaufler@intel.com>
Message-ID: <alpine.LRH.2.21.1809280744560.8410@namei.org>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-6-casey.schaufler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH v5 5/5] sidechannel: Linux Security Module for sidechannel
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 26 Sep 2018, Casey Schaufler wrote:

> +	/*
> +	 * Namespace checks. Considered safe if:
> +	 *	cgroup namespace is the same
> +	 *	User namespace is the same
> +	 *	PID namespace is the same
> +	 */
> +	if (current->nsproxy)
> +		ccgn = current->nsproxy->cgroup_ns;
> +	if (p->nsproxy)
> +		pcgn = p->nsproxy->cgroup_ns;
> +	if (ccgn != pcgn)
> +		return -EACCES;
> +	if (current->cred->user_ns != p->cred->user_ns)
> +		return -EACCES;
> +	if (task_active_pid_ns(current) != task_active_pid_ns(p))
> +		return -EACCES;
> +	return 0;

I really don't like the idea of hard-coding namespace security semantics 
in an LSM.  Also, I'm not sure if these semantics make any sense.

It least make it user configurable.


-- 
James Morris
<jmorris@namei.org>
