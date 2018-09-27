Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8RNJgKq001525
 for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2018 19:19:42 -0400
From: "Schaufler, Casey" <casey.schaufler@intel.com>
To: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>
CC: "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
 "Dock, Deneen T" <deneen.t.dock@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "arjan@linux.intel.com" <arjan@linux.intel.com>
Date: Thu, 27 Sep 2018 23:19:28 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC67321463CE3@ORSMSX107.amr.corp.intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-6-casey.schaufler@intel.com>
 <alpine.LRH.2.21.1809280744560.8410@namei.org>
 <025d4742-5947-545e-f603-502a0c5ee03f@schaufler-ca.com>
 <alpine.LRH.2.21.1809280846280.8410@namei.org>
In-Reply-To: <alpine.LRH.2.21.1809280846280.8410@namei.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: RE: [PATCH v5 5/5] sidechannel: Linux Security Module for sidechannel
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> -----Original Message-----
> From: James Morris [mailto:jmorris@namei.org]
> Sent: Thursday, September 27, 2018 3:47 PM
> To: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Schaufler, Casey <casey.schaufler@intel.com>; kristen@linux.intel.com;
> kernel-hardening@lists.openwall.com; Dock, Deneen T
> <deneen.t.dock@intel.com>; linux-kernel@vger.kernel.org; Hansen, Dave
> <dave.hansen@intel.com>; linux-security-module@vger.kernel.org;
> selinux@tycho.nsa.gov; arjan@linux.intel.com
> Subject: Re: [PATCH v5 5/5] sidechannel: Linux Security Module for sidechannel
> 
> On Thu, 27 Sep 2018, Casey Schaufler wrote:
> 
> > On 9/27/2018 2:45 PM, James Morris wrote:
> > > On Wed, 26 Sep 2018, Casey Schaufler wrote:
> > >
> > >> +	/*
> > >> +	 * Namespace checks. Considered safe if:
> > >> +	 *	cgroup namespace is the same
> > >> +	 *	User namespace is the same
> > >> +	 *	PID namespace is the same
> > >> +	 */
> > >> +	if (current->nsproxy)
> > >> +		ccgn = current->nsproxy->cgroup_ns;
> > >> +	if (p->nsproxy)
> > >> +		pcgn = p->nsproxy->cgroup_ns;
> > >> +	if (ccgn != pcgn)
> > >> +		return -EACCES;
> > >> +	if (current->cred->user_ns != p->cred->user_ns)
> > >> +		return -EACCES;
> > >> +	if (task_active_pid_ns(current) != task_active_pid_ns(p))
> > >> +		return -EACCES;
> > >> +	return 0;
> > > I really don't like the idea of hard-coding namespace security semantics
> > > in an LSM.  Also, I'm not sure if these semantics make any sense.
> >
> > Checks on namespaces where explicitly requested.
> 
> By whom and what is the rationale?

The rationale is to protect containers. Since those closest thing
there is to a definition of containers is "uses namespaces" that
becomes the focus. Separating them out does not make too much
sense as I would expect someone concerned with one to be concerned
with all.
 
