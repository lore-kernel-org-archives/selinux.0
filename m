Message-ID: <4526A11E.2060101@tresys.com>
Date: Fri, 06 Oct 2006 14:31:58 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joy Latten <latten@us.ibm.com>, Joshua Brindle <jbrindle@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: Denials from newest kernel
References: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com> <1160148117.12253.106.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160148117.12253.106.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-10-06 at 11:11 -0400, Venkat Yekkirala wrote:
>   
> <snip>
> More importantly:
> - We need to fix real bug (e.g. incorrect source or target context for a
> given check, incorrect set of checks applied on some operation/code
> path).
> - We need to document what the checks mean and how they are applied so
> that policy writers can understand them.
>
> Renaming them doesn't really help.  Classes have always been a fairly
> artificial construct, and you can see that already in the existing
> checks prior to this work

Ok, after loading up some secmark rules (the ones from targeted in 
rawhide) the packets are labeled things like httpd_client_packet_t and 
httpd_server_packet_t and so on. Here are the denials I get: (this is 
with no associations)

allow avahi_t self:packet recv;
        #TYPE=AVC  MSG=  COMM="avahi-daemon"   : recv
 - so the packet somehow got the domain label, this was the same as the 
pre-secmark case so its an expected error I think.

allow avahi_t client_packet_t:packet flow_out;
 - based on the conversation this seems correct (whatever port it used 
for an outgoing connection was not a port specified in refpolicy, thus 
the generic client_packet_t)

allow avahi_t unlabeled_t:packet flow_out;
- So this is why I don't like the object class mixing. This could either 
be the mislabeled association (expected) or an unlabled packet (which 
should not happen, with the refpolicy netfilter_context all packets have 
some label, the fallbacks are client_packet_t and server_packet_t)

allow client_packet_t dns_client_packet_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="rpc.statd"   : flow_out
        #TYPE=AVC  MSG=  COMM="sshd"   : flow_out
allow client_packet_t howl_client_packet_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="avahi-daemon"   : flow_out
allow client_packet_t portmap_client_packet_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="rpc.statd"   : flow_out
allow client_packet_t unlabeled_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="avahi-daemon"   : flow_out
 - I don't even know what these mean. client_packet_t flowing out 
dns_client_packet_t?

And some others at the bottom that have unlabeled (i assume association)

I'd like to document somewhere the set of rules (selinux policy and 
other) necessary for simple things:
1) secmark rules w/ no ipsec
2) ipsec label propagation w/ no secmark  (this will be useful on rhel5 
since secmark will be disabled)
3) secmark and ipsec
4) the complex example with different labels on the sockets than the 
domain (I don't think this is possible right now)

The security properties that this should give us: (with all options in use)
1) Bind a domain (or socket) to a packet label to specify very precisely 
how a domain can communicate on the network
2) Bind a domain to a specific spd rule to specify the encryption 
properties needed for said domain
3) Bind a packet type to an association (labeled via the remote socket) 
to specify how packets can flow on the network (and to whom)
4) Bind a domain to an association (labeled via the remote socket) to 
specify how domains on remote machines can interact

All together this allows a very precise definition of both local network 
access and domain interaction between machines, which is very good :). 
Now if we can tell people how to accomplish this we all win, I'm still 
trying to fight through how to accomplish this. I'm posting this to 
ensure that my impression of the capabilities that should be present is 
accurate before I start lying to people :)

----

allow cupsd_t dns_client_packet_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="cupsd"   : flow_out
allow dns_client_packet_t unlabeled_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="rpc.statd"   : flow_out
        #TYPE=AVC  MSG=  COMM="cupsd"   : flow_out
allow howl_client_packet_t unlabeled_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="avahi-daemon"   : flow_out
        #TYPE=AVC  MSG=  COMM="avahi-daemon"   : flow_out
allow portmap_client_packet_t unlabeled_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="rpc.statd"   : flow_out
allow portmap_t portmap_client_packet_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="portmap"   : flow_out
allow rpcd_t client_packet_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="rpc.statd"   : flow_out
allow rpcd_t dns_client_packet_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="rpc.statd"   : flow_out
allow ssh_server_packet_t self:packet flow_out;
        #TYPE=AVC  MSG=   : flow_out
allow ssh_server_packet_t unlabeled_t:packet flow_out;
        #TYPE=AVC  MSG=   : flow_out
allow unlabeled_t avahi_t:packet flow_in;
        #TYPE=AVC  MSG=  COMM="avahi-daemon"   : flow_in
allow unlabeled_t client_packet_t:packet flow_out;
        #TYPE=AVC  MSG=  COMM="avahi-daemon"   : flow_out
allow unlabeled_t dhcpc_server_packet_t:packet flow_in;
        #TYPE=AVC  MSG=   : flow_in
        #TYPE=AVC  MSG=   : flow_in
allow unlabeled_t dns_client_packet_t:packet flow_in;
        #TYPE=AVC  MSG=   : flow_in
        #TYPE=AVC  MSG=   : flow_in
        #TYPE=AVC  MSG=  COMM="sshd"   : flow_in
allow unlabeled_t howl_server_packet_t:packet flow_in;
        #TYPE=AVC  MSG=  COMM="avahi-daemon"   : flow_in
allow unlabeled_t ssh_server_packet_t:packet flow_in;
        #TYPE=AVC  MSG=   : flow_in

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
