Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <43454A61.8010907@cornell.edu>
References: <43454A61.8010907@cornell.edu>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 15:27:55 -0400
Message-Id: <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-06 at 12:01 -0400, Ivan Gyurdiev wrote:
> The purpose of this patch is to resync against what I have here, which 
> is a lot closer to being correct. It might have bugs, but the patch 
> touches only unused code paths (the only code path that's used in the 
> init/release path for databases, which doesn't do much). The main piece 
> missing to make this testable/usable is commit() integration. I have 
> file integration sort of working (meaning you can parse files, and 
> hopefully modify them, and save the changes), but the changes aren't 
> applied to policy yet. I will do further testing and debugging tomorrow. 
> Until I've debugged and tested most of the merged code, commit() 
> integration will stay out.

Ok, merged as of libsepol 1.9.12 and libsemanage 1.3.9.

BTW, I'd like to wean libsemanage off of its dependence on the static
libsepol, so that users of libsemanage (like semodule) no longer need to
link with the static libsepol even when they are using the shared
libsemanage.  This means:
- exporting your new libsepol interfaces via libsepol.map so that
libsemanage can use them without depending on the static lib,
- encapsulating the policydb internal types and functions that are
currently used by libsemanage.

I think I'll push all of the policydb internal types and function
interfaces down to include/sepol/policydb/*.h, and we'll introduce
opaque types and interfaces where needed in include/sepol/*.h.  So we
can still have a include/sepol/policydb.h, but it will become the opaque
type definition there, with the internals in
include/sepol/policydb/policydb.h.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
