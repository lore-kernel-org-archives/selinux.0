Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: "'Paul Moore'" <paul.moore@hp.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Subject: RE: Labeling traffic over loopback
Date: Wed, 13 Dec 2006 08:29:46 -0600
Message-ID: <000e01c71ec3$245ab990$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <XMMS.LNX.4.64.0612122232080.26917@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I tend to agree with Casey, in that it's generally bad to 
> re-use pointers.
> 
> I think it's unlikely to be accepted upstream.

I wasn't specific initially, but later in the thread I clarified
that we were actually looking at a union to take the place of sp
which isn't used for loopback any way and when it is, the label
would come from the SA anyway.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
