Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "James Morris" <jmorris@namei.org>
Cc: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>, <jbrindle@tresys.com>,
        <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>, "Paul Moore" <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
Date: Wed, 1 Nov 2006 09:58:15 -0600
Message-ID: <000c01c6fdce$8b49fcd0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1162389729.31675.157.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Mon, 2006-10-30 at 13:27 -0500, James Morris wrote:
> > # Server policy
> > allow httpd_server_t httpd_client_t:peer { recv send };
> >
> > # Client policy
> > allow httpd_client_t httpd_server_t:peer { recv send };
>
> Since we're talking about how policy, here is how I think the policy
> should look like ideally, using the server side as example:
>
> # service http requests (ipsec):
> allow apache_t self:tcp_socket create_stream_socket_perms;
> allow apache_t http_server_packet_t:packet { send recv };
> allow apache_t http_spd_t:association polmatch;
> allow apache_t mozilla_t:association { sendto recvfrom };

Since an association is a uni-directional object and since having
mozilla_t as the label on associations in BOTH directions would
mess-up the getpeercon semantics (it would return mozilla_t when
invoked by the client as well as the server which isn't what we want)
the above rule will have to be broken into:

allow apache_t mozilla_t:association { recvfrom };
allow apache_t self:association { sendto };

with the client having the following rules:

allow mozilla_t apache_t:association { recvfrom };
allow mozilla_t self:association { sendto };

> allow http_server_packet_t mozilla_t:association { flow_in flow_out };

This won't always work since at least from the MLS standpoint, an
association
could be looked at as being more fine-grained than a packet type.

As may have been noticed, I am currently thinking of a separate generic
filtering module in the filter table that would filter packets based on
the label (internal as well as external) on the packet and the label on
the filtering point. So you would still happily secmark packets, but also
have control over what labels (be they internal or external) can come into
or leave the system. Being a generic mechanism this would also seemlessly
cover the forwarding case.

People can look at "Chapter 6. Traversing of tables and chains" at:
http://iptables-tutorial.frozentux.net/iptables-tutorial.html#TRAVERSINGOFTA
BLES
to see where the filtering happens for the input, output and forward cases.

>
> # do dns lookups (non ipsec):
> allow apache_t self:tcp_socket create_stream_socket_perms;
> allow apache_t dns_client_packet_t:packet { send recv };
> allow apache_t no_extlabel_t:association { sendto recvfrom };

This currently would be (as you also indicate later):
allow apache_t unlabeled_t:association { sendto recvfrom };

> allow dns_client_packet_t no_extlabel_t:association { flow_in
> flow_out };
>
> This has the requirement that the type of the association is
> the same as
> the type of the domain on the other side

For recvfrom this is how it is; the association is the same as
the type of the domain on the OTHER side. For sendto, we would
currently allow use of the same association as the sending socket.

So, "sendto" is more like a "use" permission.

> and no_extlabel_t (or
> unlabeled_t) for unencrypted communications.
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
