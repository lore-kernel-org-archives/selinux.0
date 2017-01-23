Date: Mon, 23 Jan 2017 16:58:02 -0200
From: marcelo.leitner@gmail.com
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 linux-sctp@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul@paul-moore.com
Subject: Re: [RFC PATCH 1/1] kernel: Add SELinux SCTP protocol support
Message-ID: <20170123185802.GD3781@localhost.localdomain>
References: <20161214133959.3078-1-richard_c_haines@btinternet.com>
 <1481740459.9065.35.camel@tycho.nsa.gov>
 <1485177542.4077.2.camel@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1485177542.4077.2.camel@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jan 23, 2017 at 01:19:02PM +0000, Richard Haines wrote:
> On Wed, 2016-12-14 at 13:34 -0500, Stephen Smalley wrote:
> > On Wed, 2016-12-14 at 13:39 +0000, Richard Haines wrote:
<snip>
> > > +   3) SCTP sockets inherit their labels from the creating process
> > > (unless
> > > +      there are policy rules to change this). They do NOT follow
> > > the
> > > TCP
> > > +      labeling method even for TCP-style sockets. For reference:
> > > TCP
> > > child
> > > +      sockets take the TE information from the parent server
> > > socket,
> > > but the
> > > +      MLS/MCS information from the connection when CIPSO is
> > > enabled.
> > 
> > This seems problematic, given that the TCP child socket behavior was
> > specifically introduced to allow MLS connections to operate
> > correctly.
> > Why diverge?  At some point, it would be useful to rework that to use
> > security_transition_sid() or similar to derive the child socket label
> > and let policy dictate h
> > that's a separate change.
> I'll attempt to fix this, currently I've tested against equivalent in
> the SELinux test suite:
> CIPSO loopback full-labeling - ok
> CIPSO - fails some tests
> CALIPSO - fails some tests
> NetLabel Fallback labeling - ok
> iptables - ok
> IPSEC - fails probably because rfc3554 (sctp/ipsec support) has
> not been implemented yet.

FWIW, the kernel side for SCTP/IPSEC is there, but the userspace bits
aren't. There is an initiative to do it in libreswan but it's just on
papers yet. And sure, bugs might be uncovered during so..

  Marcelo
