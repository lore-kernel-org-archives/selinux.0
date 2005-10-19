Subject: Re: [PATCH] declare then require
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1129744289.15338.13.camel@twoface.columbia.tresys.com>
References: <1129744289.15338.13.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 15:36:26 -0400
Message-Id: <1129750586.2375.295.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 13:51 -0400, Joshua Brindle wrote:
> This patch allows one to declare a symbol and subsequently require it.
> This is necessary for reference policy so that interfaces which require
> symbols don't cause errors if the symbol was declared in that module.
> This happens on modules that have interfaces that affect all domains,
> for example.
> 
> Note, the opposite, requiring and then declaring does not work, further
> the declaration must be 'in scope' when the require is called, if the
> declaration is not in scope this is an error because the symbol may not
> exist after linking, and it is not possible to tell at compile time.

Ok, merged.  Implies that declarations should always go first in a
module for safety, prior to using any external interfaces?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
