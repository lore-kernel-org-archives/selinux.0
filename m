Subject: Re: Red Hat's passwd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Colin Walters <walters@verbum.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <42F3B900.1090700@tresys.com>
References: <42F3904F.5080401@tresys.com>
	 <1123261941.20237.9.camel@nexus.verbum.private>
	 <42F3ACF2.9050905@tresys.com> <42F3B235.3080701@redhat.com>
	 <42F3B900.1090700@tresys.com>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 11:00:51 -0400
Message-Id: <1123772451.7810.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patches to rename checkPasswdAccess (while temporarily retaining the
old symbol for compatibility) were merged as of libselinux 1.25.1.  So
if/when people convert all users of it over to the new name, we can wait
a bit and then drop the old symbol altogether.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
