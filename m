Subject: RE: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
In-Reply-To: <36282A1733C57546BE392885C061859201512DCE@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201512DCE@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 08:38:29 -0400
Message-Id: <1157373509.6716.2.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 16:35 -0400, Venkat Yekkirala wrote:
> <snip>
> > so you want to implicitly label the SA's?
> 
> No, these will be explicit/unique SAs negotiated by IKE. We would
> use the initiator's context in the negotiation (Joy, take note),
> as opposed to using, as we currently do, the spd context (with the
> mls portion taken from the initiator).
> 

Right, this still means many SA's per machine, possibly one per domain,
is this a problem? Would we expect production systems to be able to
handle large loads this way?

> > I'm doubtful that this will
> > help, unless applications are going to take on the burden of 
> > setting up
> > their own SA's, I'm not sure that will ever happen.
> 
> The above would be transparent to the apps (except that there's
> a general issue, unrelated to our changes, with connection requests
> failing the first time round while the negotiation is going on).
> 
> > 
> > > This way you could have just a set of domains that "polmatch"
> > > to a specific policy domain/Type, but they could all be using
> > > unique SAs based on the context of the connecting domain.
> > > 
> > 
> > Is there much overhead in having lots of SA's between 2 hosts?
> 
> I haven't had a chance to do any sort of performance analyses. But I would
> guess that the impact from the label portion would be pretty small as
> compared
> to the base ipsec obverhead (and there probably are figures available out
> there
> on this). I don't know if Trent, Joy et al performed any analyses
> in this regard for the original work.
> 
> > How can
> > you do things like RPC where the port will be dynamic with 
> > multiple SA's
> > in use?
> 
> The standard ipsec policy for rpc services should already be
> taking the dynamicity of port into account. The only difference
> will be that there will be a different SA for each connection
> when negotiated by IKE. Or did I miss something here?
> 
> IKE negotiation happens transparent to the apps (with the exception noted
> above).
> 

Not sure I understand, are you saying its possible to automatically
create an SA when you run a new application that needs one? How does
this work? 

> <snip>
> > > > 
> > > > Note that we may be sending contexts that aren't even valid 
> > > > on the local
> > > > machine, but would be valid on the destination machine. 
> > > 
> > > Could you please elaborate on this (a practical scenario).
> > > 
> > 
> > The most obvious scenario I have is 2 SELinux machines, one using MLS
> > and one not. The context on the client side 
> > (root:sysadm_r:admin_tool_t)
> > would be invalid on the destination.
> > 
> > We are also looking at how SELinux machines that are in different
> > administrative realms can interact, particularly when the policies are
> > disparate and they have no shared namespace and the context structure
> > may or may not be the same (as above).
> > 
> > We basically need to be able to send an opaque context to the
> > destination that is not verified locally (via a trusted proxy) 
> 
> Currently, there's an expectation of at least the IPSec portions of the
> policy namespace being shared between the machines (and also either all mls
> or no-mls), for racoon negotiation to work. An alternative might be using
> statically defined SAs where spi 0x001 would mean a_t on machine A and b_t
> on machine B.
> 
> Long term, we may want to build handling of IPSec DOIs into racoon/IKE.

How long term? 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
