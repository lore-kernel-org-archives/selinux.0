Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3I2bhI4009538
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 22:37:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3I2bgVf001604
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 02:37:42 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
	by jazzswing.ncsc.mil  with ESMTP id h3I2be4D001601
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 02:37:41 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: auditallow
Date: Fri, 18 Apr 2003 12:37:45 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200304141822.43798.russell@coker.com.au> <1050416640.1051.12.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1050416640.1051.12.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304181237.45386.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Apr 2003 00:24, Stephen Smalley wrote:
> auditallow does not imply allow.  There are three kinds of access
> vectors:
> 1) allow - specifies the set of permissions that are granted, defaults
> to none (deny everything unless explicitly allowed by an allow rule),
> 2) auditallow - specifies the set of permissions that should be audited
> when granted, defaults to none (audit no grantings unless explicitly
> enabled by an auditallow rule),
> 3) auditdeny - specifies the set of permissions that should be audited
> when denied, defaults to all (audit all denials unless explicitly
> disabled by a dontaudit rule, formerly handled by the auditdeny rules
> with the complement).
>
> The policy compiler could automatically generate an allow vector for
> each auditallow rule, but I'd rather not.  Add a separate allow rule to
> the configuration.

Thanks for the explanation.  However I believe that the policy compiler is not 
behaving correctly in this regard.

I think that as a policy with auditallow rules and no matching allow rules 
makes no sense the policy compiler should flag a warning about this at least.  
Also an optional warning about auditdeny rules where there are matching allow 
rules would be good.

This could be an optional feature, a "-v" option or something similar.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
