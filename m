Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBGDeli8027789
 for <selinux@tycho.nsa.gov>; Fri, 16 Dec 2016 08:40:47 -0500
Date: Fri, 16 Dec 2016 11:40:40 -0200
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Richard Haines'" <richard_c_haines@btinternet.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] kernel: Add SELinux SCTP protocol support
Message-ID: <20161216134039.GD4731@localhost.localdomain>
References: <20161214133959.3078-1-richard_c_haines@btinternet.com>
 <063D6719AE5E284EB5DD2968C1650D6DB023F752@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB023F752@AcuExch.aculab.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 14, 2016 at 02:01:35PM +0000, David Laight wrote:
> From: Richard Haines
> > Sent: 14 December 2016 13:40
> > Add SELinux support for the SCTP protocol. The SELinux-sctp.txt document
> > describes how the patch has been implemented with an example policy and
> > tests using lkstcp-tools.
> ...
> > +SCTP_SOCKOPT_BINDX_ADD - Allows additional bind addresses to be
> > +                         associated after (optionally) calling bind(2)
> > +                         if given the "bind_add" permission.
> 
> Does restricting bindx make any sense at all?
> The only addresses than can be specified are those of local interfaces.
> If bindx isn't called then the default is to include the addresses of
> all local interfaces.
> So bindx only actually removes local addresses, it doesn't add them.

You could bind the socket while on a priviledged process and then drop
the priviledges, like daemons do for binding on lower ports. Then the
application wouldn't be able to bind on another address that it's not
expected to.

  Marcelo
