Subject: RE: SELinux Networking Enhancements
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: James Morris <jmorris@namei.org>,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com, Paul Moore <paul.moore@hp.com>
In-Reply-To: <000c01c6fdce$8b49fcd0$cc0a010a@tcssec.com>
References: <000c01c6fdce$8b49fcd0$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 12:55:35 -0500
Message-Id: <1162403736.4095.12.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-01 at 09:58 -0600, Venkat Yekkirala wrote:
> > On Mon, 2006-10-30 at 13:27 -0500, James Morris wrote:
> > > # Server policy
> > > allow httpd_server_t httpd_client_t:peer { recv send };
> > >
> > > # Client policy
> > > allow httpd_client_t httpd_server_t:peer { recv send };
> >
> > Since we're talking about how policy, here is how I think the policy
> > should look like ideally, using the server side as example:
> >
> > # service http requests (ipsec):
> > allow apache_t self:tcp_socket create_stream_socket_perms;
> > allow apache_t http_server_packet_t:packet { send recv };
> > allow apache_t http_spd_t:association polmatch;
> > allow apache_t mozilla_t:association { sendto recvfrom };
> 
> Since an association is a uni-directional object and since having
> mozilla_t as the label on associations in BOTH directions would
> mess-up the getpeercon semantics (it would return mozilla_t when
> invoked by the client as well as the server which isn't what we want)
> the above rule will have to be broken into:

It wouldn't break the getpeercon semantics.  The association would be
labeled mozilla_t on the apache machine, and apache_t on the mozilla
machine.

> allow apache_t mozilla_t:association { recvfrom };
> allow apache_t self:association { sendto };
> 
> with the client having the following rules:
> 
> allow mozilla_t apache_t:association { recvfrom };
> allow mozilla_t self:association { sendto };

This doesn't cut it because you have no control who you are sending to.

> > allow http_server_packet_t mozilla_t:association { flow_in flow_out };
> 
> This won't always work since at least from the MLS standpoint, an
> association
> could be looked at as being more fine-grained than a packet type.

I don't understand what the problem is.  MLS constraints still apply.

> As may have been noticed, I am currently thinking of a separate generic
> filtering module in the filter table that would filter packets based on
> the label (internal as well as external) on the packet and the label on
> the filtering point. So you would still happily secmark packets, but also
> have control over what labels (be they internal or external) can come into
> or leave the system. Being a generic mechanism this would also seemlessly
> cover the forwarding case.

This is not acceptable for SELinux because the rules would be in
netfilter instead of MAC policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
