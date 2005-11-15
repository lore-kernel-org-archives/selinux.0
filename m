Subject: Re: [ SEMANAGE ] Stub pserver backend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil>
References: <437907D7.8090002@cornell.edu>
	 <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil>
	 <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 08:47:03 -0500
Message-Id: <1132062423.5415.354.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 06:58 -0500, Stephen Smalley wrote:
> Also, I think we need to think about priorities of tasks; policy server
> backend and runtime boolean manipulation via libsemanage seem fairly low
> to me right now.  Of greater importance would be:
> - Finalizing the refpolicy-based targeted policy package and getting it
> into rawhide,

Ok, I see that the new selinux-policy has appeared in rawhide.

> - Solving the default role problem in semanage/sepol,
> - Finalizing the genhomedircon rewrite and getting it upstreamed
> (depends on prior item),
> - Adding options to audit2allow to allow it to generate well-formed
> source policy modules (including module statement and all necessary
> required statements) so that users can continue using audit2allow on
> managed systems for local additions to rules.  Likely separate options
> to allow generation of a complete module versus generation of additional
> require and allow rules to append to an existing module.
> - Creating a utility for managing seusers via libsemanage so that users
> don't need to directly edit the sandbox copy and then run semodule -B to
> force a rebuild,
> - Finishing the ports functionality and exporting those interfaces,
> - Creating utilities for managing the other policy components via
> libsemanage.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
