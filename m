Message-ID: <36282A1733C57546BE392885C061859201513067@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Joy Latten <latten@austin.ibm.com>, paul.moore@hp.com, latten@us.ibm.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: RE: ipsec and getpeercon()
Date: Wed, 6 Sep 2006 12:20:46 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Might I also reiterate that the peer_sid on the tcp sock will
be set to the reconciled secmark, and getpeercon will
return this.

> -----Original Message-----
> From: Venkat Yekkirala 
> Sent: Wednesday, September 06, 2006 11:19 AM
> To: 'Joshua Brindle'
> Cc: Joy Latten; paul.moore@hp.com; latten@us.ibm.com; 
> sds@tycho.nsa.gov;
> selinux@tycho.nsa.gov
> Subject: RE: ipsec and getpeercon()
> 
> 
> > Actually I think I'm finally getting the expected results, 
> the context
> > for the outgoing (which is incorrect but expected?) SPD entry on the
> > local machine.
> 
> Good. We are all on the same page so far.
> > 
> > This, however, is not what I'd expect. I guess when I heard "labeled
> > network over ipsec" I thought the labels (from the source 
> > domain) would
> > traverse the wire and be readable on the destination. 
> 
> This can very much be accomplished by appropriate policy 
> rules as explained
> further down.
> 
> > 
> > I don't know how useful or even usable the current setup is, 
> > what is the
> > use case you guys are going for?
> > 
> 
> Source machine:
> 
> - a_t polmatch'es spd entry that's associated with spd1_t
> - racoon negotiates/creates sa with a_t (currently it creates
> 	sa with spd1_t but I am going to change this).
> - packet gets encrypted with spi 0x001 (which by now maps to
> 	a_t on both the source and destination)
> 
> Destination machine:
> 
> - packet with spi 0x001 received
> - packet initially gets secmark'ed with iptables context (ip_t)
> 	like it currently does.
> - secid reconciliation will reconcile a_t (that spi 0x001 maps to)
> 	with ip_t using the transition sid mechanism and arrives at:
> 		a. a_t (default when no transition rule exists).
> 		b. trans_t (which can very well be ip_t or ip_a_t or
> 			a_ip_t or whatever)
> - you now have a packet that has a_t (default) or a local policy
> 	interpretation (using transition rules).
> - Socket Vs. packet.secmark checks and others will follow as they
>   currently do.
> 
> We essentially leverage the spi on ipsec packets to denote its
> context.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
