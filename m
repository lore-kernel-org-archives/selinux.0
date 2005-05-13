Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4DFxEgA004013
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 11:59:29 -0400 (EDT)
Received: from web31605.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j4DFuA7F024818
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 15:56:10 GMT
Message-ID: <20050513155622.31532.qmail@web31605.mail.mud.yahoo.com>
Date: Fri, 13 May 2005 08:56:22 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Busted by constraints.
To: Stephen Smalley <sds@tycho.nsa.gov>,
   Casey Schaufler <casey@schaufler-ca.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

 
> audit2why/libsepol actually acts on the binary
> policy file, and libsepol
> has the same policy engine code as the kernel, but I
> understand your
> concern about matching up with the policy that was
> in effect at the time
> of the denial.

Since the policy is a variable in the security
lattice it needs to be included in the audit 
information.

> However, keep in mind that:
> a) keeping a versioned repository of your policies
> is a good idea
> independent of this issue,

Sure, just as versioned repositories of your
users and system installation is a good idea.

> b) we are only trying to identify what component of
> the policy caused a
> denial (e.g. Type Enforcement, RBAC, or constraint),
> and this is not
> likely to be highly variable across policy
> changes/upgrades for a given
> denial.

The likelyhood of change does not discount the
threat of change.

> It might be useful if the kernel audit messages
> included some kind of
> policy identifier / hash that could be used in
> correlating against a
> versioned repository of policies.   That wouldn't be
> difficult.

Your audit message should explicitly identify
what policy resulted in any failure.
 
> > Enjoy. It's pretty pointless.
> 
> To the contrary, it specifically addresses Dan's
> problem

OKay, it's a valuable debug tool until such
time as you repair the audit records.


Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
