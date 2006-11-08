Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>
Cc: <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Subject: RE: [PATCH 2/3] mlsxfrm: Various fixes
Date: Wed, 8 Nov 2006 08:31:00 -0600
Message-ID: <000501c70342$83b9df70$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0611071536300.20855@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Fix SO_PEERSEC for tcp sockets to return the security context of
> > the peer (as represented by the SA from the peer) as opposed to the
> > SA used by the local/source socket.
>
> What about the case of a localhost TCP connection not using
> xfrm labeling?
>
> Joe Nall raised this as an important requirement.

Yes. We need to come up with some new ideas on this (the failed
secid-recon patchset sought to do this using the secmark field
on the skb).

The scope of this patchset is to strictly fix things related to
labeled-xfrm.
>
>
>
> (Also, 'mlsxfrm' is MLS-specific).

Will switch to "labeled-ipsec".


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
