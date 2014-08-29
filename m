From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] file: replace 'ls -Z' with 'ls -lZ' for consistent results
Date: Fri, 29 Aug 2014 14:06:26 -0400
Message-ID: <34383342.uMCSToNaW6@sifl>
In-Reply-To: <5400987A.7000406@tycho.nsa.gov>
References: <20140828204738.10801.34505.stgit@localhost>
 <5782178.DNEPL1ls2l@sifl> <5400987A.7000406@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Serge Hallyn <serge.hallyn@ubuntu.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, August 29, 2014 11:12:58 AM Stephen Smalley wrote:
> On 08/29/2014 10:37 AM, Paul Moore wrote:
> > In the meantime, using '-l' doesn't hurt anything, and it works.
> 
> ...on rawhide, maybe.  It breaks the test on Fedora 20, and presumably
> on every older Fedora and RHEL release.

Just to add a follow-up to the list ... we dug into this a bit more off-list 
and it appears that when Fedora Rawhide moved to coreutils-8.23 from 8.22 they 
adopted the upstream coreutils output formatting.

-- 
paul moore
security and virtualization @ redhat
