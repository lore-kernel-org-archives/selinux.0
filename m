Message-ID: <36282A1733C57546BE392885C0618592015CF3B7@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>, Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle
	 <method@gentoo.org>,
        netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        kmacmillan@mentalrootkit.com
Subject: RE: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
Date: Fri, 29 Sep 2006 17:54:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Venkat,
> 
> With xfrm labeling, the external packets are always going to 
> be protocol 
> ESP or AH, and we can't connection track the inner protocols.  So, 

Are you sure? This doesn't compare to what my limited testing seems
to have turned up (normal netfiltering of inner protos followed by xfrms,
interspersed with their own netfiltering).

> external labeling when using xfrm labeling seems somewhat 
> superfluous, 
> except for the case of setting a label based on the interface 
> the packets 
> arrived on.  Correct?  If so, all you can realistically do 
> with the flow 
> permissions is bind the ESP/AH packets to types of interfaces 
> (which does 
> seem useful for some folk).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
