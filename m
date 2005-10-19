Subject: Re: [PATCH] stack overflow in module parser
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1129744223.15338.10.camel@twoface.columbia.tresys.com>
References: <1129744223.15338.10.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 15:35:10 -0400
Message-Id: <1129750510.2375.292.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 13:50 -0400, Joshua Brindle wrote:
> This patch fixes the recursion in avrule declarations and require
> declarations which cause a stack overflow in the parser with very large
> modules.

Ok, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
