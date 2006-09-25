Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1159202108.4252.4.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
	 <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1159202108.4252.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 14:04:46 -0400
Message-Id: <1159207486.15305.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 12:35 -0400, Karl MacMillan wrote:
> On Mon, 2006-09-25 at 11:35 -0400, Stephen Smalley wrote:
> > On Sat, 2006-09-23 at 10:13 -0400, Joshua Brindle wrote:
> > > > From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> > > > Let's go back to the drawing board, first of all define the 
> > > > problems we are trying to solve, and come up with a design.
> > > > 
> > > 
> > > My single requirement is that getpeercon() returns the full context of
> > > the remote process (or some translation negotiated by racoon). 
> > 
> > That single requirement is bogus - you'll never get it.  At most, you'll
> > get the full context of the remote socket endpoint.  Which might be the
> > same as the process, but not necessarily.
> > 
> 
> Just because it will be hard or impossible to get this data doesn't mean
> the requirement is bogus. It seems to me that getting the process
> context is helpful whenever the data stream is really some form of
> remote procedure call. So, are you really objecting to the requirement
> conceptually or just pointing out that it won't happen?

Conceptually.  There is always going to be a level of indirection here,
and the higher level security goal always has to be decomposed into
multiple relationships.

> The remote socket is probably good enough, though, and as Josh points
> out policy can enforce that the socket type matches the current process
> domain type (or at least a domain type).

It doesn't need to do that, and setsockcreatecon() wouldn't exist if we
always wanted that relationship to be fixed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
