Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBJM9Sth009605
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 17:09:30 -0500
Received: by mail-qa0-f51.google.com with SMTP id k15so1189698qaq.38
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 14:09:27 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Some of our customers are looking to turn on SELinux but they
 also want to use CSP from Symantec
Date: Fri, 19 Dec 2014 17:09:24 -0500
Message-ID: <4832821.yddJfOeLLT@sifl>
In-Reply-To: <54946769.4030107@schaufler-ca.com>
References: <54945543.7090706@redhat.com> <54946769.4030107@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: LSM <linux-security-module@vger.kernel.org>,
 SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, December 19, 2014 09:59:05 AM Casey Schaufler wrote:
> On 12/19/2014 8:41 AM, Daniel J Walsh wrote:
> > Currently Symantec requires SELinux be disabled, claiming there is
> > conflicts in the kernel modules.
> > 
> > http://www.symantec.com/connect/forums/does-scsp-agent-support-selinux
> 
> Based on the fact they are also disparaging AppArmor and a couple of
> out-of-tree security modules, and that SELinux=permissive is not sufficient
> I'm assuming it's an out-of-tree security module.

I don't ever recall seeing a SCSP patchset.  I also couldn't find much in the 
way of Linux integration details on their website, mostly just marketing 
materials.

> > As the customer wants to take advantage of certain SELinux features
> > like sVirt for VMs and Docker Containers, this conflict is coming to a
> > head.
> > 
> > Is anyone familiar with whether or not this is a real conflict or just
> > something assumed by Symantec?

Other than Symantec saying you can't have both running at the same time, I 
don't even know what the conflict is ... I'm sure we can offer some guesses, 
but that isn't very helpful.

> > The customer like Symantec's ability to do intrusion detection and
> > remote logging and configuration of CSB.
> > 
> > Bottom line the customer wants both.
> 
> It would help if someone from the SELinux community would comment on
> the v18 concurrent security modules patches. Moving that work forward
> is your best step toward getting what you need. Of course, v18 doesn't
> get you all the way, but it gets closer.

This assumes that the issue is due to LSM hook conflicts; not an unreasonable 
assumption, but still just a guess.

As for the LSM stacking patches, it's on my list, along with a mountain of 
other things (now with more audit, which is horrible in its own special way).  
I can promise you that I'm not ignoring your patches any worse than I'm 
ignoring anyone else's patches :)

-- 
paul moore
www.paul-moore.com
