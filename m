Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5PEneU9015012
 for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2018 10:49:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id l12-v6so1895135lja.1
 for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2018 07:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180623.105706.385733107379565893.davem@davemloft.net>
 <20180623212626.GD30522@ZenIV.linux.org.uk>
 <20180623222106.GE30522@ZenIV.linux.org.uk>
 <20180624.164837.37612664745856114.davem@davemloft.net>
In-Reply-To: <20180624.164837.37612664745856114.davem@davemloft.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 25 Jun 2018 10:49:07 -0400
Message-ID: <CAHC9VhTS1_GxegDvktFriZTBEPzSQYHNWwa6RDB3HU9NJL9MRA@mail.gmail.com>
To: davem@davemloft.net
Cc: viro@zeniv.linux.org.uk, Paul Moore <pmoore@redhat.com>,
 netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jun 24, 2018 at 3:48 AM David Miller <davem@davemloft.net> wrote:
>
> From: Al Viro <viro@ZenIV.linux.org.uk>
> Date: Sat, 23 Jun 2018 23:21:07 +0100
>
> > BTW, I wonder if the life would be simpler with do_ipv6_setsockopt() doing
> > the copy-in and verifying ipv6_optlen(*hdr) <= newoptlen; that would've
> > simplified ipv6_renew_option{,s}() quite a bit and completely eliminated
> > ipv6_renew_options_kern()...
>
> I agree that this makes things a lot simpler.

I had looked at moving the userspace copy up, but feared it was a bit
too invasive.  It sounds like you are open to the idea so I'll code
something up.

> One thing that drives me crazy though is this inherit stuff:
>
> > +     ipv6_renew_option(newtype == IPV6_HOPOPTS ? newopt :
> > +                             opt ? opt->hopopt : NULL,
>
> Why don't we pass the type into ipv6_renew_option() and have it
> do this pointer dance instead?
>
> That's going to definitely be easier to read.

I agree, that struck me as a little odd.  I'll rework that too.  I'll
send you guys something this week to take a look at.

Thanks.

> I don't know enough about this code to give feedback about the
> option length handling wrt. copies, sorry.

-- 
paul moore
www.paul-moore.com
