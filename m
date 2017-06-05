Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v55HKlPV004729
 for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2017 13:20:47 -0400
Date: Mon, 5 Jun 2017 18:20:28 +0100
From: Huw Davies <huw@codeweavers.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] net/ipv6: Fix CALIPSO causing GPF with datagram support
Message-ID: <20170605172028.GA2513@merlot.physics.ox.ac.uk>
References: <20170605154440.2434-1-richard_c_haines@btinternet.com>
 <CAHC9VhRwzC=XTRj5gNfd11T=XzpYSrVfu-jnx9f4__duMAji1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhRwzC=XTRj5gNfd11T=XzpYSrVfu-jnx9f4__duMAji1Q@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 05, 2017 at 11:55:34AM -0400, Paul Moore wrote:
> On Mon, Jun 5, 2017 at 11:44 AM, Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > When using CALIPSO with IPPROTO_UDP it is possible to trigger a GPF as the
> > IP header may have moved.
> >
> > Also update the payload length after adding the CALIPSO option.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  net/ipv6/calipso.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Signed-off-by: Huw Davies <huw@codeweavers.com>
