MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux Networking Enhancements
Date: Mon, 30 Oct 2006 13:43:25 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158851478D@exchange.columbia.tresys.com>
In-Reply-To: <Pine.LNX.4.64.0610301339080.7904@d.namei>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "James Morris" <jmorris@namei.org>
Cc: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>,
        "Paul Moore" <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: James Morris [mailto:jmorris@namei.org] 
> 
> On Mon, 30 Oct 2006, Joshua Brindle wrote:
> 
> > I don't think this is enough. For end-to-end control via 
> MAC we need 
> > to bind domain to socket (already done), socket to SA, SA to peer, 
> > peer to SA, SA to socket, and socket to domain. The way to do this 
> > "simply" is unclear but I think the common case for using labeled 
> > IPSec will be to get end to end control (else why is it useful?)
> 
> I think this can be managed via IPsec policy, where the admin 
> binds the SA to the peer with SPD/SADB rules so that the SA 
> label is the same as the process label.
> 

AH! No, it needs to be MAC, not MAC + SPD.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
