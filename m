Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: <selinux@tycho.nsa.gov>, <jmorris@namei.org>, <sds@tycho.nsa.gov>
Subject: RE: Labeling traffic over loopback
Date: Tue, 12 Dec 2006 11:45:33 -0600
Message-ID: <000d01c71e15$535d04e0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <457EE659.8050503@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Nope. Note "(no blob, so no lifecycle mgmt)".
> 
> True *sp is a blob, but it already has all the lifecycle mgmt 
> code

which we wouldn't want to invoke for loopback to avoid the
expense involved.

> in place so I
> don't think adding to it would be an 'evil' thing.  However, 
> I could be wrong.
> 
> > More specifically, we could use a union in place of sp and
> > when we are looking at a loopback packet and no xfrm in use
> > we could use the union to hold the secid.
> 
> Do you have some pseudo code for setting this value, i.e. 
> where are you thinking
> of setting it on the outbound packet?

I would like to hear James' and others' thoughts
before diving into code. James?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
