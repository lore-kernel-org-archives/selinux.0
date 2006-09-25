Subject: RE: Labeled networking packets
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
	 <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 11:55:59 -0400
Message-Id: <1159199759.3169.29.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 11:35 -0400, Stephen Smalley wrote:
> On Sat, 2006-09-23 at 10:13 -0400, Joshua Brindle wrote:
> > > From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> > > Let's go back to the drawing board, first of all define the 
> > > problems we are trying to solve, and come up with a design.
> > > 
> > 
> > My single requirement is that getpeercon() returns the full context of
> > the remote process (or some translation negotiated by racoon). 
> 
> That single requirement is bogus - you'll never get it.  At most, you'll
> get the full context of the remote socket endpoint.  Which might be the
> same as the process, but not necessarily.
> 

That's fine, it matches the semantics of getpeercon() locally. Policy
can dictate that the socket endpoint is necessarily the domain context.
Nonetheless, if I can't get something that represents the exact domain
(not an SA that can be used by lots of domains) I can't do access
control on network clients (at least not with getpeercon().. there would
have to be oob transfer of the context which is additional complication
and infrastructure). 

Additionally, though this is farther in the future, getpeercon() might
need to return something that represents the remote domain but in a way
that the local machine can understand. For example, if one machine is
running targeted and one is running strict, there will have to be a
translation from a local context to a remote context that is negotiated.
(that is the "or some translation negotiated by racoon" in my original
response) 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
