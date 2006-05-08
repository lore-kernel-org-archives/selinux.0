Subject: Re: Policycoreutils fixes/translations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <445F6406.6090401@redhat.com>
References: <1147100909.23640.59.camel@moss-spartans.epoch.ncsc.mil>
	 <445F6406.6090401@redhat.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 11:51:09 -0400
Message-Id: <1147103469.23640.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-08 at 11:30 -0400, Daniel J Walsh wrote:
> This adds some more translations and fixes the CHARSET Problem.  Also 
> big bug in genhomedircon was not reporting duplicate file_context.

Ok, merged, along with changes to po/Makefile and audit2allow/Makefile
to allow me to still do:
	make DESTDIR=~/obj install
and to also do:
	make install relabel
from top-level of policycoreutils and from selinux-usr.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
