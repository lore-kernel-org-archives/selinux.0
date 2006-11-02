Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>
Cc: "'Paul Moore'" <paul.moore@hp.com>, <jbrindle@tresys.com>,
        <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 11:10:43 -0600
Message-ID: <001601c6fea1$d54115c0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0611021144520.23444@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > Let's say you secmark a packet coming from a certain host with
> > > webonly_packet_t.
> > >
> > > You could have a filter point defined as:
> > >
> > > iptables -t filter -A FORWARD -d webserver -dport 80 -j
> SECFILTER --selctx
> > > "system_u:object_r:webserver_t:s4-s5"
> > >
> > > Your policy could say:
> > >
> > > allow webonly_t webserver_t:secfilter { flow_out }
> >
> > Is this contstruct needed for anything other than the
> forwarding case?

One could certainly find uses for it in the non-forwarding case as
well. e.g.:

secmark all incoming packets destined for port 80 with http_server_packet_t
regardless of source.

Define a filter point with all incoming from interface eth1 with eth1_t (or
a group of clients or whatever).

allow http_server_packet_t eth1_t:secfilter { flow_in };

Essentially, the flexibility offered by an additional layer of indirection.

>
> In fact, this appears to be entirely indepdent to xfrm labeling...

Correct. This is really labeling-mechanism-agnostic in that it filters
all.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
