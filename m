Message-ID: <36282A1733C57546BE392885C0618592015CF3C8@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov
Subject: RE: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
Date: Sun, 1 Oct 2006 17:30:42 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> >>In the case above I am concerned about the situation where the
> >>skb->secmark == 0 and there is a IPv4 option (i.e. it is NetLabel
> >>labeled) on the packet.
> 
> It's unfortunate that you cut out the code in your reply.

It's even more unfortunate that you should say this. The proper
thing to do is to simply repaste portions that you feel like you
need to.

Remember, we aren't opponents standing for election this season. :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
