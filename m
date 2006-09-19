Subject: Re: ipsec, netlabels, secmark- How about a little usability?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Antill <jantill@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158263103.25629.207.camel@moss-spartans.epoch.ncsc.mil>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
	 <1158249777.8442.13.camel@code.and.org>
	 <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
	 <1158254695.8442.30.camel@code.and.org>
	 <1158263103.25629.207.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 16:13:44 -0400
Message-Id: <1158696824.15306.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-14 at 15:45 -0400, Stephen Smalley wrote:
> On Thu, 2006-09-14 at 13:24 -0400, James Antill wrote:
> > On Thu, 2006-09-14 at 12:49 -0400, Stephen Smalley wrote:
> > > On Thu, 2006-09-14 at 12:02 -0400, James Antill wrote:
> > 
> > > The iptables rule only deals with labeling the packet with a type.  The
> > > policy deals with what domains can send/recv a given packet via allow
> > > rules like:
> > > 	allow httpd_t http_client_packet_t:packet { send recv };
> > > encapsulated in interfaces like:
> > > 	corenet_sendrecv_http_client_packet(httpd_t)
> > > 
> > > But the problem I see with the above example is that refpolicy already
> > > generates a netfilter contexts entry that maps _everything_ going to
> > > port 80 with http_client_packet_t, so we would need to delete that entry
> > > to make the above work, or use a different type
> > > (http_client_packet_lo_t) and only allow httpd_t to send it, not the
> > > generic http_client_packet_t.  All of which gets back to proper
> > > integration.
> > 
> >  The problem is you can't just use "send recv", because httpd_t needs to
> > call send on sockets it receives from all over the place. So you need an
> > interface specifically for connect (which, I understood, was called 
> > something like name_bind)?
> 
> name_connect is just a pairwise check between the socket and the port.
> It has nothing to do with secmark.
> 

[Trying to restart this conversation again]

Yes, but it is not clear (at least to me) how to allow apache to connect
to certain hosts but send and receive to all other hosts using secmark.
The mention of name_connect was just asking for something similar with
secmark I believe.

> Are you aware of the CONNSECMARK target?  See
> http://james-morris.livejournal.com/11010.html
> 
> >  Think of the difference between something coming to port X:80 from Y:Z,
> > being accepted, processed and a response being sent against some
> > attacker in httpd_t doing a connect from X:80 to Y:Z as part of some
> > botnet.
> 
> Yes, that can be distinguished.   The issue is not send/recv, but the
> labels of the packets, as initially established via secmark and
> propagated via connsecmark to all traffic on the connection.
> 

I never saw a working example of sorting this all out - I'd be
interested if someone with more iptables experience could demonstrate
how this can be achieved.

Even if it can be achieved I'm concerned that it will be overly complex
and not idiomatic for iptables rules. One of the main advantages to
using iptables is that it is familiar to admins, but if it must be used
in strange new ways much of that advantage might be lost.

> > > > 1. httpd_t on one machine is only allowed to connect to mysqld_t(?) on
> > > > one of these 3 machines.
> > > > 
> > > > ...AIUI secmark doesn't know the label of the proc. on the other
> > > > machines, even when using ipsec/netlabel.
> > > 
> > > Yes, but you can label the output packet via secmark with one type if it
> > > is destined for the mysql port on one of the "good" machines and a
> > > different type otherwise, and only allow httpd_t to send the "good"
> > > type.   On the internal machines, you can ensure that only mysqld_t can
> > > bind to that port.  That doesn't really require a network labeling
> > > mechanism like ipsec or netlabel per se.
> > 
> >  That works, but is significantly more interdependent. From a useability
> > POV it would be much nicer to just be able to say something like
> > "httpd_t can only connect to mysqld_t, and also only on these
> > machines/networks".
> 
> That's your high level goal - you can implement it in different ways.
> Not sure why it is more interdependent.  
> 

Leaving aside interdependence, I'm having a lot of trouble connecting
high level goals to implementations using _any_ of the new networking
controls. I'd like to see some examples where this is done so that we
can:

a) smooth out the process using tools,
b) document things sufficiently,
c) or (least desirable) change the implementation

So much of the discussion until now has centered around implementation
issues and use cases that I don't think are as interesting as unmodified
networking applications (selinux aware apps and MLS).

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
