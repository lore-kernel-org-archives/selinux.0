Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: "James Morris" <jmorris@namei.org>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>,
        "Paul Moore" <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 10:20:27 -0600
Message-ID: <001201c6fe9a$cfba9c90$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1162403736.4095.12.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Since an association is a uni-directional object and since having
> > mozilla_t as the label on associations in BOTH directions would
> > mess-up the getpeercon semantics (it would return mozilla_t when
> > invoked by the client as well as the server which isn't 
> what we want)
> > the above rule will have to be broken into:
> 
> It wouldn't break the getpeercon semantics.  The association would be
> labeled mozilla_t on the apache machine, and apache_t on the mozilla
> machine.

Yes, but the thing to realize with these SAs is that they are
uni-directional. So there's no mozilla_t SA involved when mozilla
is sending to apache (if you ignore the transport here).
IOW, using SAs you can broadly only control "who can talk to you",
not "who you can talk to". The latter can currently be achieved by
using secmark controls where you would mark the packet in a
fine-grained manner and see if the socket can send that Type of
packet.

> 
> > allow apache_t mozilla_t:association { recvfrom };
> > allow apache_t self:association { sendto };
> > 
> > with the client having the following rules:
> > 
> > allow mozilla_t apache_t:association { recvfrom };
> > allow mozilla_t self:association { sendto };
> 
> This doesn't cut it because you have no control who you are 
> sending to.

Secmark ouught to come to your rescue here as explained above.

> 
> > > allow http_server_packet_t mozilla_t:association { 
> flow_in flow_out };
> > 
> > This won't always work since at least from the MLS standpoint, an
> > association
> > could be looked at as being more fine-grained than a packet type.
> 
> I don't understand what the problem is.  MLS constraints still apply.

Yes MLS constraints apply. But consider the following:

secmark: s2-s4
SA: s3

> 
> > As may have been noticed, I am currently thinking of a 
> separate generic
> > filtering module in the filter table that would filter 
> packets based on
> > the label (internal as well as external) on the packet and 
> the label on
> > the filtering point. So you would still happily secmark 
> packets, but also
> > have control over what labels (be they internal or 
> external) can come into
> > or leave the system. Being a generic mechanism this would 
> also seemlessly
> > cover the forwarding case.
> 
> This is not acceptable for SELinux because the rules would be in
> netfilter instead of MAC policy.

The labeling rules (just like in the secmark case) will be in
netfilter, but policy and enforcement would still be in SELinux
(just like in the secmark case).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
