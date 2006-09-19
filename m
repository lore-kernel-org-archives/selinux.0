Subject: Re: ipsec, netlabels, secmark- How about a little usability?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158698123.26420.183.camel@sgc>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
	 <1158249777.8442.13.camel@code.and.org>
	 <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
	 <1158254695.8442.30.camel@code.and.org>
	 <1158263103.25629.207.camel@moss-spartans.epoch.ncsc.mil>
	 <1158696824.15306.12.camel@localhost.localdomain>
	 <1158698123.26420.183.camel@sgc>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 17:12:26 -0400
Message-Id: <1158700346.15306.47.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-19 at 16:35 -0400, Christopher J. PeBenito wrote:
> On Tue, 2006-09-19 at 16:13 -0400, Karl MacMillan wrote:
> > On Thu, 2006-09-14 at 15:45 -0400, Stephen Smalley wrote:
> > > On Thu, 2006-09-14 at 13:24 -0400, James Antill wrote:
> > > > On Thu, 2006-09-14 at 12:49 -0400, Stephen Smalley wrote:
> > > > > On Thu, 2006-09-14 at 12:02 -0400, James Antill wrote:
> > > > 
> > > > > The iptables rule only deals with labeling the packet with a type.  The
> > > > > policy deals with what domains can send/recv a given packet via allow
> > > > > rules like:
> > > > > 	allow httpd_t http_client_packet_t:packet { send recv };
> > > > > encapsulated in interfaces like:
> > > > > 	corenet_sendrecv_http_client_packet(httpd_t)
> > > > > 
> > > > > But the problem I see with the above example is that refpolicy already
> > > > > generates a netfilter contexts entry that maps _everything_ going to
> > > > > port 80 with http_client_packet_t, so we would need to delete that entry
> > > > > to make the above work, or use a different type
> > > > > (http_client_packet_lo_t) and only allow httpd_t to send it, not the
> > > > > generic http_client_packet_t.  All of which gets back to proper
> > > > > integration.
> > > > 
> > > >  The problem is you can't just use "send recv", because httpd_t needs to
> > > > call send on sockets it receives from all over the place. So you need an
> > > > interface specifically for connect (which, I understood, was called 
> > > > something like name_bind)?
> > > 
> > > name_connect is just a pairwise check between the socket and the port.
> > > It has nothing to do with secmark.
> > > 
> > 
> > [Trying to restart this conversation again]
> > 
> > Yes, but it is not clear (at least to me) how to allow apache to connect
> > to certain hosts but send and receive to all other hosts using secmark.
> > The mention of name_connect was just asking for something similar with
> > secmark I believe.
> 
> Lets make the example more concrete.  From what I understand what we're
> trying to distinguish is from requests made to apache (incoming from
> anywhere), and outgoing apache connections (say a php script is
> connecting to a mysql server).  This can be done, and is currently done
> by the refpolicy rules.  From the perspective of the server, incoming
> requests are all httpd_server_packet_t connections.  New connections
> made to mysql from the apache server would be mysql_client_packet_t.
> The default refpolicy rule already handles labeling incoming connections
> to port 80 from everywhere as httpd_server_packet_t.  If we only wanted
> to allow mysql client connections to be to 1.2.3.4:3306, then the
> mysql_client_packet_t netfilter rule would have to be changed to include
> that as the destination ip/port.  Connections to mysql on another ip
> would fall through to client_packet_t.
> 

I assume that you mean these two rules (reverting back to Dan's example
- only allow apache to initiate connections to port 80 over localhost
but otherwise send and receive on port 80):

-A selinux_new_output -p tcp --dport 80 -j SECMARK --selctx
system_u:object_r:http_client_packet_t:s0
-A selinux_new_input -p tcp --dport 80 -j SECMARK --selctx
system_u:object_r:http_server_packet_t:s0

And the difference is which chain based set up at the top, which
differentiates betweein incoming and outgoing packets, correct?

-A selinux_input -m state --state NEW -j selinux_new_input
-A selinux_output -m state --state NEW -j selinux_new_output

I guess the real magic, though, is the following which means that a
packet associated with an established connections gets labeled the same
as the initial connection:

-A selinux_input -m state --state RELATED,ESTABLISHED -j CONNSECMARK
--restore
-A selinux_output -m state --state RELATED,ESTABLISHED -j CONNSECMARK
--restore

So the initial packet comes in as http_server_packet_t because it is on
the incoming chain and, even though the reply packet goes through the
output side, it is connection tracked and labeled http_server_packet_t,
correct? I can only assume that this is obvious to an iptables admin.

Good so far - I can then add:

-A selinux_new_output -p tcp --dport 80 --out-interface lo -j SECMARK
--selctx system_u:object_r:http_local_client_packet_t:s0

So assuming that I only allow send and receive for http_server_packet_t
and http_local_client_packet_t (and not http_client_packet_t) then this
seems to solve Dan's original question.

Now we just need to figure out how add the policy and iptables rules in
a manageable way.

Thanks Chris,

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
