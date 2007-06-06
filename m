Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>, "KaiGai Kohei" <kaigai@kaigai.gr.jp>
Cc: "KaiGai Kohei" <kaigai@ak.jp.nec.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, "Joe Nall" <joe@nall.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>, <ewalsh@tycho.nsa.gov>
Subject: RE: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Wed, 6 Jun 2007 13:32:04 -0500
Message-ID: <000701c7a868$fbdc6a60$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200706061342.15348.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Is it possible to apply onto TE label, not only MLS label?
> >
> > Domain transition via packet class is a bit hard to understand.

IMHO, this would be true if we were introducing the concept of
domain transitions new into SELinux in this connection. But we aren't.
We are already used todomain transitions elsewhere. If someone has policy
already using secmark, it doesn't seem like much of a leap to utilize
transitions.

> > It's preferable, if we can configure the fallbacked client context
> > directly, as follows:
> >     192.168.1.0/24 --> system_u:system_r:sepgsql_client_t
> >     192.168.2.0/24 -->
> > system_u:system_r:sepgsql_trusted_client_t:SystemLow-SystemHigh
>
> That is exactly what I am intending to implement; the system
> administrator
> would specify a interface/address/netmask that would match to
> a _full_
> SELinux context as you have described above.

I see 2 drawbacks with this approach:

1. We aren't leveraging secmark (and the fine-grained policy that it
   can offer) which was supposed to move us away from individual/stand-alone
   netif/node labels here.

2. Redundant labeling (atleast MLS-wise) and the potential for
inconsistency.
   Imagine the above saying s2 and secmark saying s3.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
