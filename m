Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBDFNaBh009148
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 10:23:37 -0500
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBDFO7Cl008137
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 15:24:08 GMT
Date: Wed, 13 Dec 2006 10:24:04 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        "'Paul Moore'" <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Subject: RE: Labeling traffic over loopback
In-Reply-To: <000e01c71ec3$245ab990$cc0a010a@tcssec.com>
Message-ID: <XMMS.LNX.4.64.0612131022230.32018@d.namei>
References: <000e01c71ec3$245ab990$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Dec 2006, Venkat Yekkirala wrote:

> I wasn't specific initially, but later in the thread I clarified
> that we were actually looking at a union to take the place of sp
> which isn't used for loopback any way and when it is, the label
> would come from the SA anyway.

I guess you could ask on netdev, using some psuedo-code to illustrate.
All existing direct references to sp may need to be encpauslated with 
static inlines which assert the correct state.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
