Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s71FiEw9031670
 for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2014 11:44:14 -0400
From: Paul Moore <pmoore@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 0/4] Fix the NetLabel LSM category mappings
Date: Fri, 01 Aug 2014 11:43:53 -0400
Message-ID: <2162573.KyEhY0bOD3@sifl>
In-Reply-To: <53DAC781.3010502@schaufler-ca.com>
References: <20140731212856.4991.49396.stgit@localhost>
 <53DAC781.3010502@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, July 31, 2014 03:47:29 PM Casey Schaufler wrote:
> On 7/31/2014 2:44 PM, Paul Moore wrote:
> > As you will see in the patch descriptions below, the NetLabel LSM
> > category mappings are very badly broken.  This patchset should repair
> > things and make life better in the future.  The first three patches
> > are straight-up bug fixes; the fourth patch doesn't actually fix any
> > faulty logic in the code, but rather shortens some stupidly long
> > function and structure names relating to the NetLabel category
> > mappings.  I should probably do something similar with a lot of other
> > NetLabel APIs, but that is for another time.
> > 
> > Thanks to Christian Evans for pointing out one of the original
> > problems.  I don't think he realized how many problems there really
> > were, but I still owe him one for getting me to revisit this ugly,
> > nasty code.  I apologize it took so long to get a fix out and that
> > things were broken this badly in the first place.
> > 
> > Casey, I'm CC'ing you here because this patchset does touch some of
> > the Smack code, but as you can see the changes are trivial.  I will
> > be very surprised if you find anything objectionable in there.
> > However, if you do, let me know and I'll fix it.
> 
> The code passes my tests. I'll mark the patches "Tested-by:".

Great, thanks for testing.

-- 
paul moore
security and virtualization @ redhat
