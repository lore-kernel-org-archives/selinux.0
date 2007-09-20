Message-ID: <27C0723414C58546B4084C2F17BE052A36655B@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: James Morris <jmorris@namei.org>, Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley
	 <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Karl MacMillan
	 <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: RE: [RFC] [PATCH 4/4] SELinux changes
Date: Thu, 20 Sep 2007 14:50:55 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I agree performance could be an issue. I would suggest these checks are
performed based on value /counter instead of the presence of labeled
networking.

I agree it may not be intersting for most, thus the conditional check, but
certainly some people would like to make sure that traffic labeled via
fallback measures is validated per interface controls.  Venkat's example of
forwarding unlabeled packets is prime example of something that should be
enforced. 

-Chad
> 
> > Just for clarification James, what is the motivation for making the 
> > permission checks conditional?  Performance?  Compatibility?
> 
> Performance -- per packet checks which are not doing anything 
> for the vast majority of users are undesirable.
> 
> 
> -- 
> James Morris
> <jmorris@namei.org>
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
