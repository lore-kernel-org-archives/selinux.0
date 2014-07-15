Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6F4ULOt022085
 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2014 00:30:23 -0400
Received: by mail-we0-f180.google.com with SMTP id k48so4102440wev.25
 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2014 21:30:22 -0700 (PDT)
Message-ID: <53C4AE5B.9070906@gmail.com>
Date: Tue, 15 Jul 2014 06:30:19 +0200
From: Milan Broz <gmazyland@gmail.com>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH v2] selinux: fix the default socket labeling in
 sock_graft()
References: <20140714133613.12269.69088.stgit@localhost>
In-Reply-To: <20140714133613.12269.69088.stgit@localhost>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/14/2014 03:36 PM, Paul Moore wrote:
> The sock_graft() hook has special handling for AF_INET, AF_INET, and
> AF_UNIX sockets as those address families have special hooks which
> label the sock before it is attached its associated socket.
> Unfortunately, the sock_graft() hook was missing a default approach
> to labeling sockets which meant that any other address family which
> made use of connections or the accept() syscall would find the
> returned socket to be in an "unlabeled" state.  This was recently
> demonstrated by the kcrypto/AF_ALG subsystem and the newly released
> cryptsetup package (cryptsetup v1.6.5 and later).
> 
> This patch preserves the special handling in selinux_sock_graft(),
> but adds a default behavior - setting the sock's label equal to the
> associated socket - which resolves the problem with AF_ALG and
> presumably any other address family which makes use of accept().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moore <pmoore@redhat.com>

I tested v2 patch for the cryptsetup use case (ALG_IF crypto subsystem)
and it fixes the problem in enforcing mode.

So, if you wish, add
Tested-by: Milan Broz <gmazyland@gmail.com>

Thanks!
Milan
