Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1159208755.3169.47.camel@twoface.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>
	 <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1159202108.4252.4.camel@localhost.localdomain>
	 <1159207486.15305.60.camel@moss-spartans.epoch.ncsc.mil>
	 <1159208755.3169.47.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 14:49:18 -0400
Message-Id: <1159210158.15305.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 14:25 -0400, Joshua Brindle wrote:
> On Mon, 2006-09-25 at 14:04 -0400, Stephen Smalley wrote:
> > On Mon, 2006-09-25 at 12:35 -0400, Karl MacMillan wrote:
> > > On Mon, 2006-09-25 at 11:35 -0400, Stephen Smalley wrote:
> > > > On Sat, 2006-09-23 at 10:13 -0400, Joshua Brindle wrote:
> > > > > > From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> > > > > > Let's go back to the drawing board, first of all define the 
> > > > > > problems we are trying to solve, and come up with a design.
> > > > > > 
> > > > > 
> > > > > My single requirement is that getpeercon() returns the full context of
> > > > > the remote process (or some translation negotiated by racoon). 
> > > > 
> > > > That single requirement is bogus - you'll never get it.  At most, you'll
> > > > get the full context of the remote socket endpoint.  Which might be the
> > > > same as the process, but not necessarily.
> > > > 
> > > 
> > > Just because it will be hard or impossible to get this data doesn't mean
> > > the requirement is bogus. It seems to me that getting the process
> > > context is helpful whenever the data stream is really some form of
> > > remote procedure call. So, are you really objecting to the requirement
> > > conceptually or just pointing out that it won't happen?
> > 
> > Conceptually.  There is always going to be a level of indirection here,
> > and the higher level security goal always has to be decomposed into
> > multiple relationships.
> > 
> 
> Why is it conceptually bogus to want the context of the domain talking
> to you? You are saying there is indirection, and there is, but that
> doesn't mean there isn't a legitimate need to know the remote domain
> rather than the socket, data, packet, whatever. getpeercon() acted this
> way for years before the option to label sockets came around (which has
> no users afaik). 

getpeercon and its predecessors have always returned the context of the
peer socket, not the context of a process.  That provides a well-defined
result.  Which process would you choose as the peer?  There could be
zero or many at the time the connection is established.  Data could flow
from any of them.  The socket may get inherited or passed around.  

> I know flask specified impersonation, and that is what the socket
> labeling does for us. Is this why you are saying there shouldn't be an
> option to get access to the remote domain while ignoring the
> intermediate indirection?

It is less about impersonation than the inherent network protocol
implementation's architecture, but yes, if you are going to provide
impersonation, you'd like it to be fully transparent.

> what was the use case behind adding setsockcreatecon? For guards its
> helpful so that you don't have to alternate ipc mechanisms in the
> pipeline but for client server relationships.. not sure. 

xinetd was given as one use case, to label the sockets to reflect the
actual services.  I don't know if anyone has implemented the change to
xinetd.  But in general, being able to label any object with a specified
context at creation time is consistent with SELinux.

> Trusted proxies are one use case but I'm not sure how compelling that
> is. Another is context translation but at that point setsockcreatecon
> won't work anyway since the remote context isn't valid on the local
> system.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
