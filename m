Message-ID: <36282A1733C57546BE392885C061859201513AA0@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle
	 <jbrindle@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, jmorris@namei.org
Subject: RE: ipsec, netlabels, secmark- How about a little usability?
Date: Thu, 14 Sep 2006 18:52:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > > 1.  By default httpd has to be able to talk to itself 
> in order to do 
> > > > gracefull shutdown,
> > > > service httpd graceful.
> > > >
> > > > So I end up adding a rule allowing httpd to name_connect to the 
> > > > httpd_port_t.    But I really only want to allow this 
> for localhost.  
> > > > IE I don't want to allow my httpd to name_connect to 
> other machines 
> > > > httpd ports?  I can't do this now.
> > > >
> > > you can with secmark can't you?
> > > iptables -I -p tcp -d localhost -s localhost -i lo 
> --dport 80 -j SECMARK 
> > > --selctx system_u:object_r:httpd_client_packet_t
> > 
> >  This one rule, both allows httpd_t to connect to localhost:80 and
> > disallows it from connecting to anything-else:80 ?
> > 
> >  From the documentation --selctx just sets the "SELinux security
> > context" ... so you presumably _also_ need some bit of 
> policy code that
> > says "httpd_t can only name_bind(?) with httpd_client_packet_t"?
> 
> The iptables rule only deals with labeling the packet with a 
> type.  The
> policy deals with what domains can send/recv a given packet via allow
> rules like:
> 	allow httpd_t http_client_packet_t:packet { send recv };
> encapsulated in interfaces like:
> 	corenet_sendrecv_http_client_packet(httpd_t)
> 
> But the problem I see with the above example is that refpolicy already
> generates a netfilter contexts entry that maps _everything_ going to
> port 80 with http_client_packet_t, so we would need to delete 
> that entry
> to make the above work, or use a different type
> (http_client_packet_lo_t) and only allow httpd_t to send it, not the
> generic http_client_packet_t.  All of which gets back to proper
> integration.

In the secid patch sent to netdev last week, all packets leaving httpd
would be labeled with the label of the source socket (httpd_t). This
label is currently overridable by the above "secmark" rule, but we could
alternatively allow a packet to retain the label if it already has one,
in which case, the allow rule would be like:

allow httpd_t httpd_t:packet { send recv};

Comments?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
