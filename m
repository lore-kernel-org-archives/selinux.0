Message-ID: <36282A1733C57546BE392885C0618592015CF2B9@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>, Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle
	 <method@gentoo.org>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: RE: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
Date: Fri, 29 Sep 2006 12:17:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Unless I'm confusing something, there still may be a need 
> for transitions
> > if we want to support both IPsec and NetLabel labeling on the same
> > connection.
> 
> I'd prefer not to support this, as it's too complicated,

Actually, from my vantage point, it actually seems "natural".

> and 
> CIPSO is a 
> legacy protocol.

Sure.

> 
> Normal IPsec protection applied to CIPSO: yes, but not IPsec 
> labeling and 
> CIPSO labeling on the same connection.

One use case example can be one SA for Secret in combination with
any/all/none of the compartments. And another SA for Top Secret ...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
