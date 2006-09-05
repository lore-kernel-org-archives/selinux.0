Message-ID: <36282A1733C57546BE392885C061859201512F14@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley
	 <sds@tycho.nsa.gov>
Cc: Paul Moore <paul.moore@hp.com>, Joy Latten <latten@austin.ibm.com>,
        latten@us.ibm.com, Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        selinux@tycho.nsa.gov
Subject: RE: ipsec and getpeercon()
Date: Tue, 5 Sep 2006 16:04:39 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Yes, I'm getting the local socket context. I don't know whether its
> netlabel or ipsec, it only happens when i have an spd policy 
> specifying
> the context for ipsec, without an sa set up i get 
> 
Did you mean to post any results here?

Are you sure you are seeing the socket context as opposed to the
label associated with the outgoing SA? Are you running racoon to negotiate
SAs?
Are you using labels on SPD entries? Can you get us your latest
configeration?

Can you perform the following steps and let us know what you see:

- setkey -DP
- setkey -D
- Run server proc that accepts, does getpeercon and then sleeps for a few
minutes.
- While the server is sleeping, display label on the server proc.
- setkey -DP
- setkey -D

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
