Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>, "Paul Moore" <paul.moore@hp.com>
Cc: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>, <jbrindle@tresys.com>,
        <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>
Subject: RE: SELinux Networking Enhancements
Date: Wed, 1 Nov 2006 14:59:27 -0600
Message-ID: <000e01c6fdf8$9ee6a430$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0611011059190.6253@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Wed, 1 Nov 2006, Paul Moore wrote:
>
> > > Ok, so, there'd be an iptables match which looked up the
> security context
> > > on the SA the packet arrives/departs on?  Sounds like it
> could work.
> > > Perhaps call it xfrmlabel ?
> >
> > What we name it probably isn't that important, but I sorta
> prefer Venkat's
> > original suggestion of secfilter (or secidfilter, or
> <generic security
> > token>filter) since it sounds like this new component would
> be strictly for
> > filtering and not labeling.
>
> Well, it's matching labels on xfrms.  The filtering concept
> is implicit in
> it being an iptables match, and secid/sec is vague.

Actually I meant for the filtering to be explicit as in the following
example:

Label filter points:

iptables -t filter -A INPUT -s client1 -j SECFILTER --selctx
"system_u:object_r:client1_t:s4-s5"
iptables -t filter -A OUTPUT -s client1 -j SECFILTER --selctx
"system_u:object_r:client1_t:s4-s5"

Policy rules:

allow mozilla_t client1_t:secfilter { flow_in };
allow apache_t client1_t:secfilter { flow_out };

If you are also using secmark:

Labeling:
<Normal secmark rules to mark http_server_packet_t and dns_client_packet_t>

Additional Policy rules:
allow http_server_packet_t client1_t:secfilter { flow_in flow_out };
allow dns_client_packet_t dns_server_t:secfilter { flow_in flow_out };

You could just as easily define rules for forwarded traffic.

This essentially parallels secmark from an implementation standpoint,
only here we are labeling filter points while still enforcing in the
SELinux module/policy.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
