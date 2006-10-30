MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux Networking Enhancements
Date: Mon, 30 Oct 2006 13:34:54 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158851478A@exchange.columbia.tresys.com>
In-Reply-To: <Pine.LNX.4.64.0610301237530.7342@d.namei>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "James Morris" <jmorris@namei.org>,
        "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
Cc: <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>, "Paul Moore" <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: James Morris [mailto:jmorris@namei.org] 
> 
> On Tue, 24 Oct 2006, Venkat Yekkirala wrote:
>  
> Let's start with the common case for non-MLS general use 
> scenarios, then once we have that nailed down, look at what 
> else is needed to meaningfully support MLS (and possibly 
> concurrent CIPSO).
> 
> What are we currently missing, in terms of being able to 
> label SAs, authorize their use, enforce flow policy, and 
> allow applications to determine peer labels ?
> 
> For flow enforcement, I would like to see this done as simply 
> as possible.  
> e.g.:
> 
> # Server policy
> allow httpd_server_t httpd_client_t:peer { recv send };
> 
> # Client policy
> allow httpd_client_t httpd_server_t:peer { recv send };
> 

I don't think this is enough. For end-to-end control via MAC we need to
bind domain to socket (already done), socket to SA, SA to peer, peer to
SA, SA to socket, and socket to domain. The way to do this "simply" is
unclear but I think the common case for using labeled IPSec will be to
get end to end control (else why is it useful?)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
