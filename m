Subject: Re: [PATCH] transaction rollback in lock
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43564695.1050900@tresys.com>
References: <43564695.1050900@tresys.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 12:12:39 -0400
Message-Id: <1129738359.2375.206.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 09:13 -0400, Joshua Brindle wrote:
> This patch moves the transaction rollback into the commit lock.

Both locking patches merged as of libsemanage 1.3.24.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
