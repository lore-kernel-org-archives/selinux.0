Subject: Re: Denials from newest kernel
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joy Latten <latten@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <4526A11E.2060101@tresys.com>
References: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>
	 <1160148117.12253.106.camel@moss-spartans.epoch.ncsc.mil>
	 <4526A11E.2060101@tresys.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 15:04:27 -0400
Message-Id: <1160161467.2905.31.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 14:31 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Fri, 2006-10-06 at 11:11 -0400, Venkat Yekkirala wrote:
> >   
> > <snip>
> > More importantly:
> > - We need to fix real bug (e.g. incorrect source or target context for a
> > given check, incorrect set of checks applied on some operation/code
> > path).
> > - We need to document what the checks mean and how they are applied so
> > that policy writers can understand them.
> >
> > Renaming them doesn't really help.  Classes have always been a fairly
> > artificial construct, and you can see that already in the existing
> > checks prior to this work
> 
> Ok, after loading up some secmark rules (the ones from targeted in 
> rawhide) the packets are labeled things like httpd_client_packet_t and 
> httpd_server_packet_t and so on. Here are the denials I get: (this is 
> with no associations)

Ok, with secmark rules and an association:

client side (domain is semanage_t)

allow client_packet_t self:packet flow_out;
        #TYPE=AVC  MSG=  COMM="client"   : flow_out
allow client_packet_t unlabeled_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="client"   : flow_out
allow isakmp_client_packet_t unlabeled_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="racoon"   : flow_out

I think these are expected from the initial request to use no
association (which then fails), right?

allow semanage_t client_packet_t:packet { flow_in flow_out };
        #TYPE=AVC  MSG=   : flow_in
        #TYPE=AVC  MSG=  COMM="client"   : flow_out

This looks good

allow semanage_t ipsec_spd_t:association polmatch;
        #TYPE=AVC  MSG=  COMM="client"   : polmatch

Also looks good

allow semanage_t self:association sendto;
        #TYPE=AVC  MSG=  COMM="client"   : sendto

Not so good, the client side SA should have the context of the server
side socket, right? (which would have been unconfined_t)

allow semanage_t self:packet recv;
        #TYPE=AVC  MSG=   : recv

This is probably the association (though you can't tell, another symptom
of object class confusion..)


Server side:

allow semanage_t ipsec_spd_t:association polmatch;
        #TYPE=AVC  MSG=   : polmatch

This is interesting, the client is running as semanage_t but the server
is running as unconfined_t. Is it expected that the client socket
context would be used in the polmatch check?

allow semanage_t server_packet_t:packet { flow_in flow_out };
        #TYPE=AVC  MSG=   : flow_in
        #TYPE=AVC  MSG=  COMM="server"   : flow_out
allow unconfined_t semanage_t:packet recv;

allow unconfined_t semanage_t:association { sendto };

All these look correct..

allow server_packet_t self:packet flow_out;

not sure...

so the server side is fairly reasonable except for the first and last
rules, not sure if those are intentional or not. So it looks like the
main outstanding issue now is the fact that the server context is not
correctly propagated to the client side.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
