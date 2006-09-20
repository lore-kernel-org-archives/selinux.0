Subject: Re: ipsec, netlabels, secmark- How about a little usability?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158698831.15306.27.camel@localhost.localdomain>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
	 <1158249777.8442.13.camel@code.and.org>
	 <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
	 <1158698831.15306.27.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:30:05 -0400
Message-Id: <1158759005.26420.198.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-19 at 16:47 -0400, Karl MacMillan wrote:
> On Thu, 2006-09-14 at 12:49 -0400, Stephen Smalley wrote:
> > On Thu, 2006-09-14 at 12:02 -0400, James Antill wrote:
> > > On Thu, 2006-09-14 at 09:50 -0400, Joshua Brindle wrote:
> > > > Daniel J Walsh wrote:
> > > > > 1.  By default httpd has to be able to talk to itself in order to do 
> > > > > gracefull shutdown,
> > > > > service httpd graceful.
> > > > >
> > > > > So I end up adding a rule allowing httpd to name_connect to the 
> > > > > httpd_port_t.    But I really only want to allow this for localhost.  
> > > > > IE I don't want to allow my httpd to name_connect to other machines 
> > > > > httpd ports?  I can't do this now.
> > > > >
> > > > you can with secmark can't you?
> > > > iptables -I -p tcp -d localhost -s localhost -i lo --dport 80 -j SECMARK 
> > > > --selctx system_u:object_r:httpd_client_packet_t
> > > 
> > >  This one rule, both allows httpd_t to connect to localhost:80 and
> > > disallows it from connecting to anything-else:80 ?
> > > 
> > >  From the documentation --selctx just sets the "SELinux security
> > > context" ... so you presumably _also_ need some bit of policy code that
> > > says "httpd_t can only name_bind(?) with httpd_client_packet_t"?
> > 
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
> > 
> 
> I'm beginning to think that this integration is a mistake, which is one
> of the reasons it has not been enabled in rawhide. The problems are:
> 
> 1) This generates _many_ rules - most of which are unnecessary - that
> are going to have an adverse effect on performance. This is made worse
> by the fact they are mangle rules and will be run even if the other
> iptables rules ultimately drop the packet.

I don't agree with the first part of this point.  This isn't really any
different than the old networking where you hand to look up the context
of the ports, nodes, and netif (the ports being the one with a similar
amount entries) on every packet.  Second, the cost of going through the
chain with all of the rules is only on new connections.  Established
connections will skip that and just get the connection tracking label
w/CONNSECMARK --restore.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
