Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>, "Paul Moore" <paul.moore@hp.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>
Subject: RE: [PATCH 00/11] The _entire_ secid reconciliation patchset (tada!)
Date: Wed, 11 Oct 2006 14:20:07 -0500
Message-ID: <001101c6ed6a$43ae71e0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0610091612140.31187@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From an initial review of this patchset, it doesn't look 
> quite ready to 
> queue for 2.6.20 (which I plan to to via git once it is).
> 
> Outstanding items include resolving the igmp skb hook issue 
> generally, 
> testing to verify both the design and implementation, and 
> ensuring that 
> all the related policy changes are merged upstream first.
> 
Regarding the igmp hook issue, we could do a generic hook
like Paul suggested. Would that be more palatable you think?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
