Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9UInR9P019975
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 13:49:27 -0500
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9UIlnoD009150
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 18:47:50 GMT
Date: Mon, 30 Oct 2006 13:49:24 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Joshua Brindle <jbrindle@tresys.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, gcwilson@us.ibm.com,
        Paul Moore <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158851478D@exchange.columbia.tresys.com>
Message-ID: <Pine.LNX.4.64.0610301348540.8249@d.namei>
References: <6FE441CD9F0C0C479F2D88F959B0158851478D@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Oct 2006, Joshua Brindle wrote:

> > From: James Morris [mailto:jmorris@namei.org] 
> > 
> > On Mon, 30 Oct 2006, Joshua Brindle wrote:
> > 
> > > I don't think this is enough. For end-to-end control via 
> > MAC we need 
> > > to bind domain to socket (already done), socket to SA, SA to peer, 
> > > peer to SA, SA to socket, and socket to domain. The way to do this 
> > > "simply" is unclear but I think the common case for using labeled 
> > > IPSec will be to get end to end control (else why is it useful?)
> > 
> > I think this can be managed via IPsec policy, where the admin 
> > binds the SA to the peer with SPD/SADB rules so that the SA 
> > label is the same as the process label.
> > 
> 
> AH! No, it needs to be MAC, not MAC + SPD.

SPD becomes part of the MAC labeling infrastructure, like the SECMARK 
target.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
