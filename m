Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6J7R0os001758
 for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2014 03:27:00 -0400
Date: Sat, 19 Jul 2014 17:26:57 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 3.17
In-Reply-To: <3135081.Nfbulyq9MG@sifl>
Message-ID: <alpine.LRH.2.11.1407191726350.26264@namei.org>
References: <3135081.Nfbulyq9MG@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 18 Jul 2014, Paul Moore wrote:

> Hi James,
> 
> Here are the SELinux patches for 3.17.  A total of eight patches, none 
> particularly controversial: a few cleanups, a few bug fixes, and a minor tweak 
> to reduce the SELinux overhead during boot.  One nice thing is that we remove 
> more code than we add in 3.17, so if nothing else we're doing our part to 
> fight code bloat :)
> 
> All the patches pass the SELinux testsuite and apply cleanly on top of linux-
> security #next.

Thanks for testing!  Pulled.


-- 
James Morris
<jmorris@namei.org>
