Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: <jbrindle@tresys.com>
Cc: <selinux@tycho.nsa.gov>, <jmorris@namei.org>, <sds@tycho.nsa.gov>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 19 Oct 2006 10:06:56 -0500
Message-ID: <000f01c6f390$3845da60$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1161187791.30986.54.camel@twoface.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[My apoligies for the nearly unnavigable post but had to keep context]

> > > Second, MLS implementations work this way because they
> are hard coded
> > > to. We aren't hard coded to do anything, there is no
> "default" in this
> > > case, you'd have to specify defaults with iptables and I
> question how
> > > scalable that is anyway. You either have really course
> > > grained secmarks
> > > (one per interface with 1 type and an MLS range) or if you start
> > > breaking it down into protocol, port, etc you have a full set
> > > for every
> > > interface with a different type and the mls range.
> >
> > based on your needs...
> > > There
> > > doesn't seem to
> > > be alot of flexibility here.
> >
> > From an MLS point of view, more flexibility than is needed;
> for example,
> > you would still have fine-grained rules down to port, etc.,
> but where you
> > need to treat all the traffic as secret, you would just
> have secret on
> > each one of those rules.
> >
>
> Fine.. if MLS doesn't need the flexibility we should consider
> it a done
> deal and try to address the flexibility necessary for TE.

You would have just as many "secpoints" as you currently
would "secmarks". No difference there. Same level of flexibility
and scalability. Nothing more, nothing less.

Example:

1. An outbound connection to port 80 on machine 10.0.0.1

SECMARK:
-A OUTPUT -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
SECMARK --selctx system_u:object_r:http_client_packet_t:s2

SECPOINT:
-A OUTPUT -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
SECMARK --selctx system_u:object_r:httpd_t:s0

Reason for the change in Type from http_client_packet_t to httpd_t:

All incoming packets on this connection would be from a web-server so should
be carrying httpd_t as opposed to http_client_packet_t. Also, all outbound
traffic on this connection carries the originating socket context
(firefox_t)
which would be flow-controlled against httpd_t.

So, just a change in semantics. Whereas you formerly had
allow firefox_t http_client_packet_t:packet { send recv }

you would now have:

allow firefox_t httpd_t:packet { recv }
allow firefox_t httpd_t:packet { flow_out }

For the forwarding case:

-A PREROUTING -p tcp -s 10.0.0.5  -j SECMARK --selctx
system_u:object_r:webonly_t:s0

-A FORWARD -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
SECMARK --selctx system_u:object_r:httpd_t:s0
-A PREROUTING -p tcp -s 10.0.0.1 --sport 80 -j SECMARK --selctx
system_u:object_r:httpd_t:s0
(can also use CONNSECMARK to save from FORWARD and restore it at PREROUTING
to label all traffic back from
the webserver)

allow webonly_t httpd_t:packet { flow_out }
allow httpd_t webonly_t:packet { flow_out }

I have only given the main rules and there are ofcourse other supporting
rules required
to get things going.

>
> > >
> > > > Also, don't we deem all data on a filesystem that doesn't
> > > support individual
> > > > file labeling to be at the label it's mounted at?
> > > >
> > >
> > > no, it gets a label based on genfscon (eg., cd's get
> > > iso9660_t no matter
> > > where it is mounted)
> >
> > The mechanism doesn't matter. The fact still remains you have
> > a "default" label (or you could in the future) where all the
> > files on a filesystem that don't have an explicit label would
> > assume that label.
> >
>
> no, all files on that filesystem get that label regardless. Your
> proposal has fallbacks on a per-packet basis, not analogous
> to an entire
> filesystem being labeled something. (eg., when a filesystem
> has a mount
> label there is no possiblity of 'refining' the label if present, which
> is what you are trying to do.

And who says you can't have a sophisticated filesystem that would allow
for such a refining? I am not an expert on Linux filesystems, but this
can be a nice feature for the future :)

>
> > >
> <snip>
> > > >
> > >
> > > So I never heard about this requirement until now.
> >
> > I am very sorry to say this, but that's because you weren't paying
> > enough attention. I mentioned this as one of the drawbacks
> as recently
> > as this past weekend in this very same thread, but it was
> also a part
> > of my original design proposal for labeled networking
> pointed out from
> > time to time in the conversations we had the past several months.
> >
>
> I know this, what I meant was it was never added as a
> requirement on the
> old system or the conference call or for a couple weeks after
> the call,
> it was added last week as a justification for the new design.

Forwarding was what started me off several months ago. See:
https://www.redhat.com/archives/redhat-lspp/2006-June/msg00011.html
https://www.redhat.com/archives/redhat-lspp/2006-June/msg00012.html

>
> Which is fine, most of my arguments until now haven't taken it into
> account because it was new, I have no problem trying to
> facilitate that
> in the design but the fact that secpoint covers it doesn't
> automatically
> make it good.

True. And this is why the design has undergone several refinements
and simplifications (no trasitions for example) and we already were
looking at another refinement for getpeercon in the past couple days.

>
> > > I'll grant
> > > that it is
> > > an interesting problem but if it is truly a requirement
> why wasn't it
> > > part of prior conversations? Perhaps we can come up with a
> > > good solution
> > > that addresses it as well.
> >
> > Which secpoint set out to solve (remember: it allowed for all the
> > security goals that were possible in secmark and then some.
> Now if people
> > are getting confused that they don't find a steering wheel
> in the airplane
> > and simply refuse to use the yoke, it's not my problem).
> >
>
> see above.

see above :)

>
> > >
> > > > > You'll get a flow_out for the
> domain->socket->secmark->(any other
> > > > > secmark that we happen to hit which is
> non-ideal)->association.
> > > >
> > > > Have you never gone thru multiple security check points
> at airports
> > > > and such?
> > > >
> > >
> > > Yes, and my name stays the same after each one.
> >
> > But you could also be "labeled" differently if there were a
> trustworthy
> > mechanism to carry the label and have fine-grained security
> points where
> > they woould process only "transferring passengers" as
> opposed to those
> > that are initially boarding. I am not saying they couldn't
> also use your
> > name (in addition to the label), the question is what would
> you objectively
> > need to satisfy the particular set of security goals at hand.
> >
>
> fine, I don't have a problem with the additional checks but the
> implementation now is strange. With secpeer I start out as
> Joshua, then
> change to passed_first_secpoint then passed_second_secpoint
> and finally
> passed_plane_gate and the access checks are implemented that way:
>
> allow joshua passed_first_secpoint flow_out
> allow passed_first_secpoint passed_second_secpoint flow_out
> allow passed_second_secpoint passed_plane_gate flow_out
>
> What needs to happen is that I'm Joshua the entire time..
>
> allow joshua passed_first_secpoint flow_out
> allow joshua passed_second_secpoint flow_out
> allow joshua passed_plane_gate flow_out
>
> this maintains me as the subject, which is appropriate.
>

This is what I set out to do and couldn't due to constraints.
My argument has been that you could manage it in the policy
and Chris seemed to agree (see
http://marc.theaimsgroup.com/?l=selinux&m=116075228014626&w=2).
But since this keeps coming up we will try to explore some "bad"
options and see what happens. Stay tuned on this, but I doubt
we can get this currently.

>
> > >
> > > > >
> > > > > There is not an intuitive way of binding a domain to an
> > > association.
> > > >
> > > > I think we have mixup on terminology here. An "association"
> > > is traditionally
> > > > used to refer to an IPSec SA and it has nothing
> innately to do with
> > > > flow-control.
> > > >
> > >
> > > It does, the association has a label, policy should allow
> me to say
> > > "this domain can write data to only this association".
> That puts the
> > > ability to enforce confidentiality at the network level
> inside SELinux
> > > policy, where we want it.
> >
> > FYI- associations don't operate entirely the way you like
> them to. For
> > example,
> > ALL traffic between 2 machines ordinarily shares the same
> association.
> > This is because of the nature of the association (encryption,
> > authentication,
> > compress). You could also specify that each and every
> communication between
> > a
> > pair of machines use a different association, but that would be a
> > performance bummer.
> > What we have done is to make sure apache_t traffic can only
> use the apache_t
> > association.
> > So both the DNS queries and http service replies going to
> the SAME machine
> > would use
> > the SAME association with the context apache_t (rightfully
> so since it's ALL
> > apache traffic).
> > But if the DNS traffic is going to a different machine then
> it would use a
> > different
> > association, but still labeled apache_t. Unless ofcourse
> you set it up to
> > use a unique
> > association for each communication channel.
> >
> > Also, as mentioned in the past, the netfilter hooks come
> into play AFTER the
> > xfrms are chosen. So, one couldn't base the association on
> the netfilter
> > context.
>
> Right, I'm aware of this limitation and it's very inconvenient (I
> believe its what Chris is mainly objecting to)

Yes. I believe so as well and unfortunately we can't do anything here.

>
> > >
> > > Meaning, for policy analysis we need to show that certain
> domains can
> > > only speak to domains on other machines via certain associations.
> >
> > You can ONLY show what associations a proc can recv from in
> your policy.
> > Whether a remote domain can receive your traffic or not is
> dictated on
> > the remote machine.
> >
>
> I think this seriously limits the usefulness of this. I *must* be able
> to specify locally who can talk to me from a remote machine.

Yes and this is indeed what you can acomplish what "remote" domains
a sock can recv.

If this isn't what you meant, please give me an example and we will try
again.

> Without
> being able to do this I implicitly have to trust the remote
> entirely (no
> possibility of limited trust)

No, you aren't trusting the remote entirely. Your local policy
is deciding whether you can receive packets from a such and such
remote peer.

>
> > >
> > >
> > > I see that James responded on LSPP yesterday with same basic
> > > requirements that I'm trying to allude to here so I'll
> just wrap this
> > > up..
> >
> > A natural result when people (sadly a couple or so) refuse
> to objectively
> > assess a design based on what it can accomplish. I have the
> satisfaction of
> > knowing though that I gave it my best shot.
> >
>
> That doesn't mean we can't come up with a design that addresses the
> limitations and still does what we want, hopefully...

We would need to first understand the specific limitations though
and these are what I have been trying to understand, but in vain.

>
> I know this is frustrating but a better model in the end is better for
> everyone, please don't give up :( .. I wish I knew more about
> the actual
> implementation, it feels like I might be missing some subtle details
> because of this.
>

The biggest shift in the design is coming from here:
If you want to flow control forwarded traffic, you would necessarily
have to look at the current secmarking points for the outbound as
flowcontrol points (which I have sought to characterize as secpoints
to mark the distinction). And when you do look at the outbound secmarking
points as flow-control points, you would then want to look at the inbound
ones as flow-control points as well for consistency. Everything else pretty
much draws from here.

Hope that helps.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
