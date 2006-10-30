Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9UIeimp019658
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 13:40:44 -0500
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9UIdsZZ013270
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 18:39:55 GMT
Date: Mon, 30 Oct 2006 13:40:37 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Joshua Brindle <jbrindle@tresys.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, gcwilson@us.ibm.com,
        Paul Moore <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158851478A@exchange.columbia.tresys.com>
Message-ID: <Pine.LNX.4.64.0610301339080.7904@d.namei>
References: <6FE441CD9F0C0C479F2D88F959B0158851478A@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Oct 2006, Joshua Brindle wrote:

> I don't think this is enough. For end-to-end control via MAC we need to
> bind domain to socket (already done), socket to SA, SA to peer, peer to
> SA, SA to socket, and socket to domain. The way to do this "simply" is
> unclear but I think the common case for using labeled IPSec will be to
> get end to end control (else why is it useful?)

I think this can be managed via IPsec policy, where the admin binds the SA 
to the peer with SPD/SADB rules so that the SA label is the same as the 
process label.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
