Message-ID: <36282A1733C57546BE392885C061859201512E82@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle
	 <jbrindle@tresys.com>,
        Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        selinux@tycho.nsa.gov
Subject: RE: ipsec and getpeercon()
Date: Tue, 5 Sep 2006 12:14:55 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> What would you propose the proper behavior for when there is 
> no xfrm or
> node sid?

The netif sid and in it's absense, the unlabeled init sid.

>  It seems to be much more consistent (and desirable) to pull
> the TE bits from a single source.

If the single source were the correct source, then yes. :)

>  Also, from a practical 
> point of view
> I suspect it to be very unlikely that anyone would be using more than
> one form of network labeling for a connection.  Meaning that I would
> expect the common case for NetLabel to be no xfrm or node sid.

Well, a node/netif could be used to constrain the range of cipso labels
that can come/leave thru to the node/interface. Example: Secret on one
netif, TS on another.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
