Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAAFSuIi000216
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 10:28:56 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAAFRXBa026131
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 15:27:33 GMT
Subject: Re: [RFC][PATCH] Control ability to have a writable executable
	mapping
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <41914F8B.3060102@tresys.com>
References: <1100025603.408.203.camel@moss-spartans.epoch.ncsc.mil>
	 <41914F8B.3060102@tresys.com>
Content-Type: text/plain
Message-Id: <1100100302.1972.187.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 10 Nov 2004 10:25:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-09 at 18:15, Joshua Brindle wrote:
> That said, I know the current implementation breaks the current domain 
> source, target object type model, and it would be better to make it the 
> same for no better reason than consistancy.

Abstractly, you want to control what code can be executed by a given
domain.  Basing your check on the main executable file type (which may
not in fact even be the actual file that required a writable executable
mapping, as that can be triggered by loading a DSO) means that you have
to perform separate analysis of what domains can execute that file type
if you want to know what domains can execute runtime generated code. 
I'm also not entirely clear that it is necessarily a property of an
application under every usage scenario, e.g. if the application
dlopen()'s a shared object that requires executable stack, but only does
so for a certain mode of operation, you could possibly distinguish that
in policy.  As many applications use a single executable for multiple
purposes, it seems preferable to allow for this.

> out of curiousity, is revocation handled?

This doesn't change the status of revocation support in SELinux, i.e. we
revalidate upon certain operations, including mmap/mprotect/read/write,
but we do not presently revoke existing mappings upon a policy change or
file relabel.

> It seems like the whole purpose of this is to enforce a consistancy 
> between filesystem permissions and mmaped files in memory?

No, we already apply checking on mmap/mprotect for file-based mappings. 
The new check is just an attempt to provide policy control over creation
of executable mappings that wouldn't be covered by file permission
checks, e.g. anonymous mappings or private file mappings that are
writable or previously written.  Note that the patch didn't fully
address these cases; I'll post a new version shortly based on some other
feedback.

> Does this fall into the same category as PaX where denying the flag 
> actually causes a less secure default?

No, failure to grant this permission leads to an inability to perform
the mmap/mprotect (for the cases covered by the permission).  But note
that I had to include a change to general_domain_access() in the policy
patch to remove the permission by default, as most domains use that
macro and that macro typically gives all but a specific set of excluded
permissions for task->self:process.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
