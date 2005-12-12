Subject: Re: Interesting reading on exec* access checks.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
In-Reply-To: <4398A5AD.2010701@redhat.com>
References: <4398A5AD.2010701@redhat.com>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 10:22:15 -0500
Message-Id: <1134400935.7305.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-08 at 16:29 -0500, Daniel J Walsh wrote:
> http://people.redhat.com/drepper/selinux-mem.html

The description of execmem says:
"The solution for the anonymous case is to create the memory region
without execution permission and then, when the wanted content is
created, change the permission to include PROT_EXEC but not PROT_WRITE."

But this will still trigger an execmem check, as the check is applied
upon mmap or mprotect for anonymous mappings with PROT_EXEC,
irrespective of PROT_WRITE, in order to control the ability to execute
arbitrary memory (not just to control the ability to execute currently
writable memory).  In the case of private file mappings, it is handled
differently, with execmem only applied upon mmap or mprotect with
PROT_EXEC and PROT_WRITE simultaneously, and execmod applied upon
PROT_EXEC by itself after a prior modification.

> We are planning on turning off allow_execmem, allow_execmod, 
> allow_execheap for unconfined_t in targeted policy.  We are working to 
> clean up any problems this might cause.  This will add additional 
> security features to Userspace, but might cause headaches.
> 
> If you have the latest policy installed on Rawhide
> 
> selinux-policy-targeted-2.1.0-3 or later you can try it out by running
> 
> setsebool -P allow_execmem=0 allow_execmod=0 allow_execheap=0

There is no allow_execheap, but there is an allow_execstack.  Note that
turning off allow_execmem should also disable execstack; execmem covers
a superset of what execstack covers.  If you need runtime code
generation, you can enable execmem while disabling execstack to retain
protection of the stack while permitting generation of code to other
anonymous memory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
