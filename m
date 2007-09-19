Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkatesh Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, <paul.moore@hp.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <method@manicmethod.com>
Subject: RE: [RFC] [PATCH 4/4] SELinux changes
Date: Wed, 19 Sep 2007 16:22:24 -0500
Message-ID: <009801c7fb03$2c298260$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Xine.LNX.4.64.0709191412170.31778@us.intercode.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: James Morris [mailto:jmorris@namei.org]
> Sent: Wednesday, September 19, 2007 4:13 PM
> To: Stephen Smalley
> Cc: Venkat Yekkirala; selinux@tycho.nsa.gov; paul.moore@hp.com; Karl
> MacMillan; Joshua Brindle
> Subject: Re: [RFC] [PATCH 4/4] SELinux changes
> 
> 
> On Wed, 19 Sep 2007, Stephen Smalley wrote:
> 
> > We thought we were eliminating the need for these per-packet
> > per-node/netif checks by way of secmark, but I guess not if we are
> > keeping secmark separate from labeled networking.
> 
> The checks should only be made if labeled networking is active.

Actually even when we aren't using labeled networking, we would
want to prevent packets arriving on a top-secret interface from
being forwarded onto a secret interface. So, the checks would be
in order here as well.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
