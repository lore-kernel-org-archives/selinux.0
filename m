Message-ID: <451A7151.3000800@tresys.com>
Date: Wed, 27 Sep 2006 08:40:49 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C061859201573917@chaos.tcs.tcs-sec.com> <Pine.LNX.4.64.0609261835060.5342@d.namei> <1159357078.32075.20.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1159357078.32075.20.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>
> On Tue, 2006-09-26 at 18:43 -0400, James Morris wrote:
> > On Tue, 26 Sep 2006, Venkat Yekkirala wrote:
> >
> > > FOR "INCOMING" CONNECTIONS TO HTTPD (define the client peer):
> > >
> > > # Create a chain for connection setup and security point labeling
> > > # for http client peers.
> > > iptables -t mangle -N SEL_HTTP
> > >
> > > # Accept incoming connections from, and define and save the 
> security point
> > > for
> > > # http client peers.
> > > iptables -t mangle -A INPUT -p tcp --dport 80 -m state --state NEW -j
> > > SEL_HTTP
> > > iptables -t mangle -A SEL_HTTP -j SECPOINT --selctx
> > > system_u:object_r:http_client_t:s0
> > > iptables -t mangle -A SEL_HTTP -j CONNSECPOINT --save
> > > iptables -t mangle -A SEL_HTTP -j ACCEPT
> > >
> > > # Common rules which restore security points for established
> > > # and related packets.
> > > iptables -t mangle -A INPUT -m state --state ESTABLISHED,RELATED -j
> > > CONNSECPOINT --restore
> > > iptables -t mangle -A OUTPUT -m state --state ESTABLISHED,RELATED -j
> > > CONNSECPOINT --restore
> > >
> > > FOR "OUTGOING" CONNECTIONS TO POSTGRES (define the postgres server 
> peer):
> > >
> > > iptables -t mangle -N SEL_PGRESD
> > > iptables -t mangle -A OUTPUT -p tcp --dport <postgres-port> -m 
> state --state
> > > NEW -j SEL_POSTGRESD
> > > iptables -t mangle -A SEL_PGRESD -j SECPOINT --selctx
> > > system_u:object_r:postgresd_t:s0
> > > iptables -t mangle -A SEL_PGRESD -j CONNSECPOINT --save
> > > iptables -t mangle -A SEL_PGRESD -j ACCEPT
> >
> > This just seems the same as SECMARK and CONNSECMARK but with different
> > naming.  What problem is this solving?
>
> The name isn't important (Venkat just views the "secpoint" and "peer"
> names as more intuitive).  The issue is how we label the packets -
> Venkat is assigning labels that correspond to domains (potentially
> generic placeholder domains when we don't actually know a specific one),
> like http_client_t (or mozilla_t) and httpd_t versus object types like
> http_client_packet_t and http_server_packet_t.
>
> We could leave the secmark and packet names alone.
>
I'd rather change the packet name as that could lead to some serious 
confusion when reconciliation happens. "packet" has a connotation of 
being a discrete visible thing so overriding its label with something 
more abstract (eg., an ipsec tunnel) will be confusing. Since "peer" is 
a more abstract object it can, more understandably, represent more than 
1 kind of network labeling.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
