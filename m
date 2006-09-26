Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QM4RGp031216
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 18:04:27 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8QM3sXe002727
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 22:03:54 GMT
Message-ID: <36282A1733C57546BE392885C061859201573917@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: jmorris@namei.org
Cc: sds@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Karl MacMillan
	 <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle
	 <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
Date: Tue, 26 Sep 2006 18:04:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > In the example above, you would have "fine-grained security points"
> > as given below:
> > 
> > All new connections INTO port 80: http_client_t default domain, with
> > additional explicit "domains" fire_fox_t, rss_aggregator_t, etc.
> > 
> > allow httpd_t http_client_t:peer { sendto recvfrom }
> > allow httpd_t fire_fox_t:peer { sendto recvfrom }
> > ...
> > 
> > Now, a compromised httpd_t isn't able initiate OUTGOING connections
> > to port 80 (other than to itself for graceful shutdown in 
> conjunction
> > with additional policy).
> > 
> > For connections to postgres:
> > 
> > All new OUTGOING connections from port 80 to postgres-port: 
> postgres_t
> > default
> > 
> > allow httpd_t postgres_t:peer { sendto recvfrom }
> 
> What do the iptables rules look like for this?

FOR "INCOMING" CONNECTIONS TO HTTPD (define the client peer):

# Create a chain for connection setup and security point labeling
# for http client peers.
iptables -t mangle -N SEL_HTTP

# Accept incoming connections from, and define and save the security point
for
# http client peers.
iptables -t mangle -A INPUT -p tcp --dport 80 -m state --state NEW -j
SEL_HTTP
iptables -t mangle -A SEL_HTTP -j SECPOINT --selctx
system_u:object_r:http_client_t:s0
iptables -t mangle -A SEL_HTTP -j CONNSECPOINT --save
iptables -t mangle -A SEL_HTTP -j ACCEPT

# Common rules which restore security points for established
# and related packets.
iptables -t mangle -A INPUT -m state --state ESTABLISHED,RELATED -j
CONNSECPOINT --restore
iptables -t mangle -A OUTPUT -m state --state ESTABLISHED,RELATED -j
CONNSECPOINT --restore

FOR "OUTGOING" CONNECTIONS TO POSTGRES (define the postgres server peer):

iptables -t mangle -N SEL_PGRESD
iptables -t mangle -A OUTPUT -p tcp --dport <postgres-port> -m state --state
NEW -j SEL_POSTGRESD
iptables -t mangle -A SEL_PGRESD -j SECPOINT --selctx
system_u:object_r:postgresd_t:s0
iptables -t mangle -A SEL_PGRESD -j CONNSECPOINT --save
iptables -t mangle -A SEL_PGRESD -j ACCEPT

On the http clients and the postgres server, you would define the
httpd server peer and the postges client peer respectively, if they
are SELinux machines that is.

On the http server, you would additionally have rules to allow other
client labels such as:

allow firefox_t http_client_t:peer { equiv/from/flow_in }
allow rss_aggregator_t http_client_t:peer { equiv/from/flow_in }

> 
> > > 3) A single packet may have different types on the output 
> side and the
> > > input side.
> > 
> > This is very non-intuitive, as opposed to defining security 
> check points
> > with just the "domains" that can be received from and sent to.
> 
> What do the policy and labeling rules look like in this case 
> for secpoint?

See above.

> 
> > >  But you
> > > also lose the stateful benefits of secmark here,
> > 
> > Nope, you still are leveraging the stateful benefits of iptables.
> 
> Ditto.

Ditto :)

> 
> 
> > Votes? :)
> 
> It may seem more intuitive to people combining external and internal 
> labeling, but I'm concerned that the common case (internal 
> labeling only) 
> will be less understandable.

Looking at the actual rules above, does it appear so?

NOTE: If you meant the loopback traffic, it will reflect the "domain" of
the originating socket.
 
> A security point is an abstraction --

Exactly. And as you note above, abstractions go easy on common people.

> a 
> labeled packet is more concrete in that it is an actual 
> kernel object with 
> a label on it, which can be manipulated based upon the label.

Turns out the "object Type" nature of a packet label doesn't jive
well with the "domain Type" nature of the external labeling mechanisms
that are of interest to us here, apart from the shortcoming of not
being able to handle transient traffic in the forwarding case.

And the purpose of secmark (and more) is being served with secpoint
(ANYONE DISAGREE HERE?; IF SO EXAMPLES?). All made possible by the
secmark field on the skb you hard-earned for us :) Thanks!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
