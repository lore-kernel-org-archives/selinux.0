Subject: RE: SELinux Networking Enhancements
From: Joshua Brindle <jbrindle@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
In-Reply-To: <000d01c6f2c7$8c1e2f80$cc0a010a@tcssec.com>
References: <000d01c6f2c7$8c1e2f80$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 12:09:51 -0400
Message-Id: <1161187791.30986.54.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-18 at 10:10 -0500, Venkat Yekkirala wrote:
<snip>
> >
> > first, getpeercon() returning something that isn't an
> > external label is
> > not good, how are applications to cope with this behavior?
> 
> I thought you had a point there, so I did offer to have it return
> only a true peer.
> 

Right, ok :)

> >
> > Second, MLS implementations work this way because they are hard coded
> > to. We aren't hard coded to do anything, there is no "default" in this
> > case, you'd have to specify defaults with iptables and I question how
> > scalable that is anyway. You either have really course
> > grained secmarks
> > (one per interface with 1 type and an MLS range) or if you start
> > breaking it down into protocol, port, etc you have a full set
> > for every
> > interface with a different type and the mls range.
> 
> based on your needs...
> > There
> > doesn't seem to
> > be alot of flexibility here.
> 
> From an MLS point of view, more flexibility than is needed; for example,
> you would still have fine-grained rules down to port, etc., but where you
> need to treat all the traffic as secret, you would just have secret on
> each one of those rules.
> 

Fine.. if MLS doesn't need the flexibility we should consider it a done
deal and try to address the flexibility necessary for TE.

> >
> > > Also, don't we deem all data on a filesystem that doesn't
> > support individual
> > > file labeling to be at the label it's mounted at?
> > >
> >
> > no, it gets a label based on genfscon (eg., cd's get
> > iso9660_t no matter
> > where it is mounted)
> 
> The mechanism doesn't matter. The fact still remains you have
> a "default" label (or you could in the future) where all the
> files on a filesystem that don't have an explicit label would
> assume that label.
> 

no, all files on that filesystem get that label regardless. Your
proposal has fallbacks on a per-packet basis, not analogous to an entire
filesystem being labeled something. (eg., when a filesystem has a mount
label there is no possiblity of 'refining' the label if present, which
is what you are trying to do. 

> >
<snip>
> > >
> >
> > So I never heard about this requirement until now.
> 
> I am very sorry to say this, but that's because you weren't paying
> enough attention. I mentioned this as one of the drawbacks as recently
> as this past weekend in this very same thread, but it was also a part
> of my original design proposal for labeled networking pointed out from
> time to time in the conversations we had the past several months.
> 

I know this, what I meant was it was never added as a requirement on the
old system or the conference call or for a couple weeks after the call,
it was added last week as a justification for the new design. 

Which is fine, most of my arguments until now haven't taken it into
account because it was new, I have no problem trying to facilitate that
in the design but the fact that secpoint covers it doesn't automatically
make it good. 

> > I'll grant
> > that it is
> > an interesting problem but if it is truly a requirement why wasn't it
> > part of prior conversations? Perhaps we can come up with a
> > good solution
> > that addresses it as well.
> 
> Which secpoint set out to solve (remember: it allowed for all the
> security goals that were possible in secmark and then some. Now if people
> are getting confused that they don't find a steering wheel in the airplane
> and simply refuse to use the yoke, it's not my problem).
> 

see above.

> >
> > > > You'll get a flow_out for the domain->socket->secmark->(any other
> > > > secmark that we happen to hit which is non-ideal)->association.
> > >
> > > Have you never gone thru multiple security check points at airports
> > > and such?
> > >
> >
> > Yes, and my name stays the same after each one.
> 
> But you could also be "labeled" differently if there were a trustworthy
> mechanism to carry the label and have fine-grained security points where
> they woould process only "transferring passengers" as opposed to those
> that are initially boarding. I am not saying they couldn't also use your
> name (in addition to the label), the question is what would you objectively
> need to satisfy the particular set of security goals at hand.
> 

fine, I don't have a problem with the additional checks but the
implementation now is strange. With secpeer I start out as Joshua, then
change to passed_first_secpoint then passed_second_secpoint and finally
passed_plane_gate and the access checks are implemented that way:

allow joshua passed_first_secpoint flow_out
allow passed_first_secpoint passed_second_secpoint flow_out
allow passed_second_secpoint passed_plane_gate flow_out

What needs to happen is that I'm Joshua the entire time..

allow joshua passed_first_secpoint flow_out
allow joshua passed_second_secpoint flow_out
allow joshua passed_plane_gate flow_out

this maintains me as the subject, which is appropriate.


> >
> > > >
> > > > There is not an intuitive way of binding a domain to an
> > association.
> > >
> > > I think we have mixup on terminology here. An "association"
> > is traditionally
> > > used to refer to an IPSec SA and it has nothing innately to do with
> > > flow-control.
> > >
> >
> > It does, the association has a label, policy should allow me to say
> > "this domain can write data to only this association". That puts the
> > ability to enforce confidentiality at the network level inside SELinux
> > policy, where we want it.
> 
> FYI- associations don't operate entirely the way you like them to. For
> example,
> ALL traffic between 2 machines ordinarily shares the same association.
> This is because of the nature of the association (encryption,
> authentication,
> compress). You could also specify that each and every communication between
> a
> pair of machines use a different association, but that would be a
> performance bummer.
> What we have done is to make sure apache_t traffic can only use the apache_t
> association.
> So both the DNS queries and http service replies going to the SAME machine
> would use
> the SAME association with the context apache_t (rightfully so since it's ALL
> apache traffic).
> But if the DNS traffic is going to a different machine then it would use a
> different
> association, but still labeled apache_t. Unless ofcourse you set it up to
> use a unique
> association for each communication channel.
> 
> Also, as mentioned in the past, the netfilter hooks come into play AFTER the
> xfrms are chosen. So, one couldn't base the association on the netfilter
> context.

Right, I'm aware of this limitation and it's very inconvenient (I
believe its what Chris is mainly objecting to)

> >
> > Meaning, for policy analysis we need to show that certain domains can
> > only speak to domains on other machines via certain associations.
> 
> You can ONLY show what associations a proc can recv from in your policy.
> Whether a remote domain can receive your traffic or not is dictated on
> the remote machine.
> 

I think this seriously limits the usefulness of this. I *must* be able
to specify locally who can talk to me from a remote machine. Without
being able to do this I implicitly have to trust the remote entirely (no
possibility of limited trust)

> >
> >
> > I see that James responded on LSPP yesterday with same basic
> > requirements that I'm trying to allude to here so I'll just wrap this
> > up..
> 
> A natural result when people (sadly a couple or so) refuse to objectively
> assess a design based on what it can accomplish. I have the satisfaction of
> knowing though that I gave it my best shot.
> 

That doesn't mean we can't come up with a design that addresses the
limitations and still does what we want, hopefully... 

I know this is frustrating but a better model in the end is better for
everyone, please don't give up :( .. I wish I knew more about the actual
implementation, it feels like I might be missing some subtle details
because of this.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
