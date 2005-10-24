Subject: Re: [ SEPOL ] Context interface cleanup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4359547D.3050001@cornell.edu>
References: <43595049.2@cornell.edu>  <4359547D.3050001@cornell.edu>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 08:47:59 -0400
Message-Id: <1130158079.17609.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-21 at 16:50 -0400, Ivan Gyurdiev wrote:
> > - removes the sepol_ prefix, which I use to indicate whether a 
> > function is exported or not
> Actually, can that still create a namespace conflict during static linking?

Yes.  That is why I added sepol_ prefixes for functions used by
audit2why, since it also needed to use libselinux and I wanted to avoid
conflicts and confusion between the respective interfaces.

> Would it make a difference if it was marked 'static' ?

It is good practice to use 'static' as widely as possible, but you
obviously cannot use either for functions that are actually used by
users of the static libsepol.  If they are only used internally by the
library, you can make them static or (if not all users are within a
single file) mark them "hidden".  Need to bring over dso.h and create a
sepol_internal.h in libsepol ala libselinux.

> What should I name all those things...
> I want sepol_context_* to be reserved for the record that represents a 
> context..
> I wanted context_* for the internal structure, for consistency with 
> other code (but the other code is static_inline...).

Note that libselinux provides context_* interfaces for context string
manipulation by security-aware applications (man context_new).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
