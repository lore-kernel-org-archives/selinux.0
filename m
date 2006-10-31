Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>
Cc: <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>,
        "Paul Moore" <paul.moore@hp.com>
Subject: RE: SELinux Networking Enhancements
Date: Tue, 31 Oct 2006 14:54:49 -0600
Message-ID: <000601c6fd2e$ceea6ab0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0610301237530.7342@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > and I don't believe we need to wait for that to implement 
> protected 
> > > paths for host to host networking.
> > 
> > Can you please lay out the kind of controls you have in mind
> > for "protected paths for host to host networking". I want to
> > see what (modified) portions I can present for upstreaming.
> 
> Let's start with the common case for non-MLS general use 
> scenarios, then
> once we have that nailed down, look at what else is needed to 
> meaningfully
> support MLS (and possibly concurrent CIPSO).
> 
> What are we currently missing, in terms of being able to label SAs, 
> authorize their use, enforce flow policy, and allow applications to 
> determine peer labels ?
> 
> For flow enforcement, I would like to see this done as simply 
> as possible.  
> e.g.:
> 
> # Server policy
> allow httpd_server_t httpd_client_t:peer { recv send };

This is already effectively covered in the following checks:

allow httpd_server_t httpd_client_t:association { recvfrom };

allow httpd_server_t http_client_packet_t:packet { send };

> 
> # Client policy
> allow httpd_client_t httpd_server_t:peer { recv send };
> 

In the "peer" abstraction above, the problem is how would we define a
peer? A "peer" is only available when you receive something. A peer
isn't available currently when you are sending to the peer. We can't
use SAs for this purpose since an SA is a unidirectional thing. The
now-dead secpoint attempted to define peer secpoints.

There's the main issue of what "peers" (external labels) can enter
the system.

Implementation issues aside, lately I have been wondering about doing
something in the filter table using something we could call secfilter
or so.

You would still use secmark to label the packets, but they (along with
any external labels) could get filtered in the secfilter module. This
way we could control what external labels could come thru from what peers.
For internal labels it would be more of an assurance thing. This would also
automatically take care of forwarding controls.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
