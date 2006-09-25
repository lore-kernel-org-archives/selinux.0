Subject: RE: Labeled networking packets
From: Joshua Brindle <jbrindle@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1159209686.4741.46.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
	 <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1159202108.4252.4.camel@localhost.localdomain>
	 <1159207486.15305.60.camel@moss-spartans.epoch.ncsc.mil>
	 <1159208755.3169.47.camel@twoface.columbia.tresys.com>
	 <1159209686.4741.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 14:53:20 -0400
Message-Id: <1159210400.3169.56.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 14:41 -0400, Karl MacMillan wrote:
> On Mon, 2006-09-25 at 14:25 -0400, Joshua Brindle wrote:
> > On Mon, 2006-09-25 at 14:04 -0400, Stephen Smalley wrote:
> 
> <snip>
> 
> > > > The remote socket is probably good enough, though, and as Josh points
> > > > out policy can enforce that the socket type matches the current process
> > > > domain type (or at least a domain type).
> > > 
> > > It doesn't need to do that, and setsockcreatecon() wouldn't exist if we
> > > always wanted that relationship to be fixed.
> > > 
> > 
> > what was the use case behind adding setsockcreatecon? For guards its
> > helpful so that you don't have to alternate ipc mechanisms in the
> > pipeline but for client server relationships.. not sure. 
> > 
> 
> xinetd was one - it allows the creation of sockets with the "correct"
> label (e.g., telnetd_t) so that all processes spawned by xinetd to have
> to have permissions on all xinetd sockets.
> 
> Any time sockets are going to be created by one process and passed to
> another it is useful to have setsockcreatecon.
> 

Fair enough, this was my trusted proxy example below that you removed :)

I admit that trusted proxies should be able to do this and that's fine,
it doesn't change what I want, which is the domain that we'll be doing
access control on. 

If there is a case where a proxy changes the context of the socket
before connecting to the policy server that doesn't violate my goals. I
guess I probably didn't make that clear before. 

Since the policy controls how socket contexts can be changed that isn't
an issue.

What I was adverse to is the transformation with secmark which I believe
should be used for access control on the packets and not network
labeling.

> Karl
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
