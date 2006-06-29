Subject: RE: [PATCH] remove te rule conflict checking from parser
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015882980C6@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015882980C6@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 12:54:47 -0400
Message-Id: <1151600087.6999.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-29 at 12:37 -0400, Joshua Brindle wrote:
> Are those duplicates in the same scope? If so they are correctly being
> dropped silently (they are just redundant), if they are in different
> scopes a dupe is fatal. 

Yes, that was it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
