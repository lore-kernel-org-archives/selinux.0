Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s72CoS5A031428
 for <selinux@tycho.nsa.gov>; Sat, 2 Aug 2014 08:50:29 -0400
Date: Sat, 2 Aug 2014 22:50:29 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 3.17
In-Reply-To: <25128076.T1yg0xqlTP@sifl>
Message-ID: <alpine.LRH.2.11.1408022250150.17575@namei.org>
References: <3135081.Nfbulyq9MG@sifl> <25128076.T1yg0xqlTP@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 1 Aug 2014, Paul Moore wrote:

> On Friday, July 18, 2014 03:37:19 PM Paul Moore wrote:
> > Hi James,
> > 
> > Here are the SELinux patches for 3.17.  A total of eight patches, none
> > particularly controversial: a few cleanups, a few bug fixes, and a minor
> > tweak to reduce the SELinux overhead during boot...
> 
> Hi James,
> 
> A late addition to the SELinux patches for 3.17.  Normally I would just wait 
> for the next release, but these patches are pretty significant (marked for 
> stable as well) so I think they merit the late add.  I just posted the patches 
> yesterday with an explanation so I won't bother repeating myself here since 
> they are still likely fresh in your inbox.
> 
> I did a quick test pull and everything applies cleanly on top of the linux-
> security #next tree.

Thanks, pulled.

-- 
James Morris
<jmorris@namei.org>
