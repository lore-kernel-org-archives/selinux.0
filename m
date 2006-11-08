Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, "Paul Moore" <paul.moore@hp.com>
Cc: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>, <jmorris@namei.org>
Subject: RE: [PATCH 3/3] mlsxfrm: Various fixes
Date: Wed, 8 Nov 2006 08:34:34 -0600
Message-ID: <000601c70343$02fa9fe0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1162932520.3009.58.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Such duplication can occur among the initial SIDs.

For some reason I thought that could happen between an initial SID
and a non-initial SID.

>  Not sure 
> though when
> that would apply here,

It could apply to xfrms if they happen to be using the context
represented by any of the initial SIDs.

> and it would only apply if both SIDs 
> were initial
> SIDs.

OK. Will narrow the full context comparison to just this case.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
