Message-ID: <36282A1733C57546BE392885C061859201512B64@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: James Morris <jmorris@namei.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Chad Hanson
	 <chanson@TrustedCS.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [PATCH 0/3] secid reconciliation-v01: Repost patchset with up
	 dates
Date: Thu, 31 Aug 2006 10:08:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> My main concern with these patches is that moving the 
> NetLabel check out
> of selinux_socket_sock_rcv_skb() and into 
> selinux_skb_policy_check() (as
> it is currently written) would force us to compare a packet's NetLabel
> with either the IPsec label or the secmark label

Yes you would do these checks (while using a netlabel based off of the
secmark at that point) to enforce flow control and when they succeed,
you will copy netlabel into secmark.

> and not the socket's
> label.

The socket Vs. secmark check that happens later in rcv_skb will in fact be
looking at the cipso label that is by then a part of the secmark context.

>  The ability to make access decisions based on the process
> consuming the data and the data itself it one of the nicer 
> qualities of
> NetLabel in my opinion.

This nicer quality ends up being preserved as explained above :)

We just need to get out of the mindset of viewing netlabel separately
once we are past the reconciliation point.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
