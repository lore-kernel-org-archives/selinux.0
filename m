Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: antoine <antoine@nagafix.co.uk>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200506100057.36525.blaisorblade@yahoo.it>
References: <1118280325.10107.124.camel@localhost>
	 <1118340278.10190.112.camel@localhost>
	 <1118346349.30110.192.camel@moss-spartans.epoch.ncsc.mil>
	 <200506100057.36525.blaisorblade@yahoo.it>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 09:35:27 -0400
Message-Id: <1118410527.3774.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 00:57 +0200, Blaisorblade wrote:
> However, since UML is a virtual kernel, between its task there is executing 
> programs, in the memory of the virtual guest; this memory is represented by a 
> host file, because it must be shareable by different threads (each of them 
> matches one process/thread executed inside UML; actually there are 
> complications but this is the base idea).

Shared anon mapping?

> A note: this file is later deleted to avoid it being touched by the host; what 
> I was thinking was if this could be extended to deleting the directory it's 
> in (it could, and this would work); then, maybe the execute permission could 
> be given only to the directory, and the creation of such directories could be 
> restricted to UML (well, given that you make UML put his files not in /tmp 
> but in a reserved place). I.e.:

It is already the case that a separate type (um_tmp_t) is being applied
to the file, and I presume that the policy only allows um_kernel_t to
create/modify files with this type, so policy should ensure that no
other process can touch the file and that no other process can trick uml
into using a different file (because um_kernel_t will lack execute
permission to any other xxx_tmp_t type, and thus the mmap would fail).

> only the UML "role" (I don't know SELinux so please correct me) can create a 
> folder under /chroot/mem; those folders become of a different role
> with auto_trans, inside those folders you get execute permission with "allow 
> um_kernel_t um_tmp_t:file execute;", and those folders get deleted as soon as 
> the file has been created, opened and deleted, so only UML can create an 
> mmap'able file; race condition to check here if the attacker creates a file 
> while the directory exists but not difficult to solve; I guess this is 
> possible with SELinux.

Moving from /tmp to a dedicated location with its own type or using a
shared anon mapping would make it clear that we are dealing with
something other than a normal /tmp file, as well as fixing the
noexec /tmp problem.  As far as an attacker creating a file, policy
should prevent them from being able to create a file in the necessary
type to allow execution, so that shouldn't be a problem.  Naturally, if
uml itself is subverted, it may be induced to execute arbitrary code
from the memory.

> I don't understand the domain concept... however, by "indirect execution" you 
> mean simply running /lib/ld.so <fileName>, don't you? In this case, since the 
> kernel must just mmap() ld.so and not execve() it, couldn't we deny 
> execve("/lib/ld-linux.so") via the checks you mentioned above?

Yes, execute_no_trans would also apply there.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
