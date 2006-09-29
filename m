Message-ID: <36282A1733C57546BE392885C0618592015CF2BA@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Joshua Brindle <method@gentoo.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: RE: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
Date: Fri, 29 Sep 2006 12:22:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> That's fine by me, I just wanted to make sure something like 
> that would
> be acceptable.  So, in summary, we would do the normal flow_in checks
> for both IPsec and NetLabel and then set the secmark using the IPsec
> label as the "base sid" for the NetLabel's generated SID?

That's correct (in short you won't care if IPSec was in use or not, you
would just use the secmark at that point as the base sid in coming up
with the NetLabel sid, and if it flow controls fine vis a vis the secmark
you would replace secmark with the NetLabel sid. The logic flow is quite
natural and intuitive for the users as well).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
