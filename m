Subject: Re: [Patch 1/3] Loadable policy module infrastructure
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1117562414.28924.217.camel@moss-spartans.epoch.ncsc.mil>
References: <1117128423.3483.19.camel@localhost>
	 <1117562414.28924.217.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 31 May 2005 14:15:14 -0400
Message-Id: <1117563314.9783.70.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-31 at 14:00 -0400, Stephen Smalley wrote:
> 
> 
> $ grep FIX 01-module.patch
> +        /* FIX ME: do the alternate read here for modules */
> +                        /* FIX ME: policy-server will need the SID
> +/* FIX ME: do policycon write here */
> +                /* FIX ME: write module version here */
> 


They were excluded in an effort to make these patches smaller. They will
be included in the patches that implement that module language and
linking code.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
