Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBD3YG0M018943
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 22:34:16 -0500
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBD3YmI7003047
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 03:34:48 GMT
Date: Tue, 12 Dec 2006 22:34:46 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: "'Paul Moore'" <paul.moore@hp.com>,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: RE: Labeling traffic over loopback
In-Reply-To: <000d01c71e15$535d04e0$cc0a010a@tcssec.com>
Message-ID: <XMMS.LNX.4.64.0612122232080.26917@d.namei>
References: <000d01c71e15$535d04e0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Dec 2006, Venkat Yekkirala wrote:

> I would like to hear James' and others' thoughts
> before diving into code. James?

I tend to agree with Casey, in that it's generally bad to re-use pointers.

I think it's unlikely to be accepted upstream.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
