Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6G2MoZd030076
 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2014 22:22:50 -0400
From: Paul Moore <pmoore@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v2] selinux: fix the default socket labeling in
 sock_graft()
Date: Tue, 15 Jul 2014 22:22:48 -0400
Message-ID: <2249358.85v8CiTYWS@sifl>
In-Reply-To: <53C4AE5B.9070906@gmail.com>
References: <20140714133613.12269.69088.stgit@localhost>
 <53C4AE5B.9070906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, July 15, 2014 06:30:19 AM Milan Broz wrote:
> On 07/14/2014 03:36 PM, Paul Moore wrote:
> > The sock_graft() hook has special handling for AF_INET, AF_INET, and
> > AF_UNIX sockets as those address families have special hooks which
> > label the sock before it is attached its associated socket.
> > Unfortunately, the sock_graft() hook was missing a default approach
> > to labeling sockets which meant that any other address family which
> > made use of connections or the accept() syscall would find the
> > returned socket to be in an "unlabeled" state.  This was recently
> > demonstrated by the kcrypto/AF_ALG subsystem and the newly released
> > cryptsetup package (cryptsetup v1.6.5 and later).
> > 
> > This patch preserves the special handling in selinux_sock_graft(),
> > but adds a default behavior - setting the sock's label equal to the
> > associated socket - which resolves the problem with AF_ALG and
> > presumably any other address family which makes use of accept().
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moore <pmoore@redhat.com>
> 
> I tested v2 patch for the cryptsetup use case (ALG_IF crypto subsystem)
> and it fixes the problem in enforcing mode.
> 
> So, if you wish, add
> Tested-by: Milan Broz <gmazyland@gmail.com>

Thanks for your help, since there have been no further comments I'll add your 
"Tested-by" and push this upstream.

-- 
paul moore
security and virtualization @ redhat
