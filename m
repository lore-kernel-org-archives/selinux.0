Subject: Re: ipsec, netlabels, secmark- How about a little usability?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158254695.8442.30.camel@code.and.org>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
	 <1158249777.8442.13.camel@code.and.org>
	 <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
	 <1158254695.8442.30.camel@code.and.org>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 15:45:03 -0400
Message-Id: <1158263103.25629.207.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-14 at 13:24 -0400, James Antill wrote:
> On Thu, 2006-09-14 at 12:49 -0400, Stephen Smalley wrote:
> > On Thu, 2006-09-14 at 12:02 -0400, James Antill wrote:
> 
> > The iptables rule only deals with labeling the packet with a type.  The
> > policy deals with what domains can send/recv a given packet via allow
> > rules like:
> > 	allow httpd_t http_client_packet_t:packet { send recv };
> > encapsulated in interfaces like:
> > 	corenet_sendrecv_http_client_packet(httpd_t)
> > 
> > But the problem I see with the above example is that refpolicy already
> > generates a netfilter contexts entry that maps _everything_ going to
> > port 80 with http_client_packet_t, so we would need to delete that entry
> > to make the above work, or use a different type
> > (http_client_packet_lo_t) and only allow httpd_t to send it, not the
> > generic http_client_packet_t.  All of which gets back to proper
> > integration.
> 
>  The problem is you can't just use "send recv", because httpd_t needs to
> call send on sockets it receives from all over the place. So you need an
> interface specifically for connect (which, I understood, was called 
> something like name_bind)?

name_connect is just a pairwise check between the socket and the port.
It has nothing to do with secmark.

Are you aware of the CONNSECMARK target?  See
http://james-morris.livejournal.com/11010.html

>  Think of the difference between something coming to port X:80 from Y:Z,
> being accepted, processed and a response being sent against some
> attacker in httpd_t doing a connect from X:80 to Y:Z as part of some
> botnet.

Yes, that can be distinguished.   The issue is not send/recv, but the
labels of the packets, as initially established via secmark and
propagated via connsecmark to all traffic on the connection.

> > > 1. httpd_t on one machine is only allowed to connect to mysqld_t(?) on
> > > one of these 3 machines.
> > > 
> > > ...AIUI secmark doesn't know the label of the proc. on the other
> > > machines, even when using ipsec/netlabel.
> > 
> > Yes, but you can label the output packet via secmark with one type if it
> > is destined for the mysql port on one of the "good" machines and a
> > different type otherwise, and only allow httpd_t to send the "good"
> > type.   On the internal machines, you can ensure that only mysqld_t can
> > bind to that port.  That doesn't really require a network labeling
> > mechanism like ipsec or netlabel per se.
> 
>  That works, but is significantly more interdependent. From a useability
> POV it would be much nicer to just be able to say something like
> "httpd_t can only connect to mysqld_t, and also only on these
> machines/networks".

That's your high level goal - you can implement it in different ways.
Not sure why it is more interdependent.  

>  Also I can pretty much guarantee that if the accepted practice is "just
> trust the port number on the other machines". The solution will be to
> just use iptables to REJECT packets without that port (as that works
> with or without SELinux).

Not sure I see that. You are using SELinux on the web server to enforce
the restriction that httpd can only initiate connections to the mysql
port of certain hosts, and you are using SELinux on those hosts to
enforce the restriction that only the approved mysqld can bind to that
port.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
