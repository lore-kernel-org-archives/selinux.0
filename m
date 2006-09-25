Subject: RE: Labeled networking packets
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1159203754.21540.156.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
	 <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1159199759.3169.29.camel@twoface.columbia.tresys.com>
	 <1159203754.21540.156.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 14:14:14 -0400
Message-Id: <1159208054.4741.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 13:02 -0400, Stephen Smalley wrote: 
> On Mon, 2006-09-25 at 11:55 -0400, Joshua Brindle wrote:
> > On Mon, 2006-09-25 at 11:35 -0400, Stephen Smalley wrote:
> > > On Sat, 2006-09-23 at 10:13 -0400, Joshua Brindle wrote:
> > > > > From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> > > > > Let's go back to the drawing board, first of all define the 
> > > > > problems we are trying to solve, and come up with a design.
> > > > > 
> > > > 
> > > > My single requirement is that getpeercon() returns the full context of
> > > > the remote process (or some translation negotiated by racoon). 
> > > 
> > > That single requirement is bogus - you'll never get it.  At most, you'll
> > > get the full context of the remote socket endpoint.  Which might be the
> > > same as the process, but not necessarily.
> > > 
> > 
> > That's fine, it matches the semantics of getpeercon() locally. Policy
> > can dictate that the socket endpoint is necessarily the domain context.
> 
> If we always wanted that, why would we have
> added /proc/self/attr/sockcreate?
> 
> > Nonetheless, if I can't get something that represents the exact domain
> > (not an SA that can be used by lots of domains) I can't do access
> > control on network clients (at least not with getpeercon()..
> 
> s/SA/socket/ above and think about what you just said.  It is no
> different.  Socket or SA - they are levels of indirection that are
> necessarily present because the relationship is indirect.  And as long
> as you have control over the relationships, you can establish the higher
> level security goal.
> 

You know - I have this blind spot in my mental model of how networking
works. Yes - sockets means that there is an additional level of
indirection which will make any attempt to treat these connections as
between two process break.

The ipc model I was using as a strawman sounds nice - I think it would
be more natural for server processes that act as surrogates for remote
processes to enforce access based on the process context (including the
ability to use the role for additional restrictions - e.g., when
exec'ing new processes based on an rpc call). I don't think that this
maps well to the socket model, however. In reality I think that the
current semantics of getpeercon must remain local only.

As to the ability to enforce higher level goals if you can control the
relationships, I don't disagree. I will note, however, that each level
of indirection makes it more difficult for many users to understand.
When I have taught SELinux classes most users have some amount of
difficulty with types (1 level of indirection). Most have more trouble
with attributes (2 levels of indirection) and some never make the leap.

So I am getting very concerned that our model has all of these layers
(process->sockets->SA combined with secmark rules via type_transition).

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
