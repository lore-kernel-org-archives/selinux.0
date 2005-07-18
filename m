Subject: Re: [PATCH] Makefile fixes and cleanups for selinux-usr
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1121353750.11005.3.camel@localhost>
References: <1121353750.11005.3.camel@localhost>
Content-Type: text/plain
Date: Mon, 18 Jul 2005 10:28:01 -0400
Message-Id: <1121696881.32546.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-14 at 11:09 -0400, Joshua Brindle wrote:
> This patch makes the repository able to be built with DESTDIR set and
> also adds the ability to define DEBUG to get debug CFLAGS enabled for
> the entire repository as well as some misc fixes and cleanups.

Thanks, merged, along with a few other changes.

Let me know if these Makefile changes cause problems for anyone...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
