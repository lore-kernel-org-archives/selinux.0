Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <42EE3879.2050409@tresys.com>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
	 <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
	 <42EE3879.2050409@tresys.com>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 11:04:15 -0400
Message-Id: <1122908655.6573.302.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-01 at 10:58 -0400, Joshua Brindle wrote:
> I know it won't affect the size but why not make all symbol value
> spaces 16 bits, just for consistency?

Hmm..well, I didn't actually change the datum types, as you may have
noticed, even for types (e.g. struct type_datum).   I only shrank the
avtab types.  We could certainly shrink them all, but the compatibility
code begins to get increasingly ugly...

> Also, here is a trivial patch to let audit2why compile with -Werror
> (which the Makefile in cvs does by default)

Ah, thanks - hadn't tried rebuilding that after the latest changes.
libsepol itself needs to be changed to be built with stricter warning
flags, and the resulting warnings need to be cleaned up.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
