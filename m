Subject: Re: API man pages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200401020027.31265.russell@coker.com.au>
References: <200401020027.31265.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1073312322.17089.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 05 Jan 2004 09:18:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-01 at 08:27, Russell Coker wrote:
> I have written some man pages for the new SE Linux API.
> 
> Please check them out and let me know what you think.  I'll submit them to 
> Howard for inclusion in the next release once I'm happy with them.

Thanks for working on these man pages.  I expect we'll want to add them
to the libselinux package once they are ready.  Note that the
selinux-doc PORTING file includes some useful information that might be
incorporated into some of these man pages, and we may be able to adapt
some descriptions from the old man pages from the old SELinux, e.g. to
flesh out the details of certain calls such as security_compute_av. Some
specific comments on your man pages are below:

- freeconary is also used to free the result of
get_ordered_context_list.  You can likely just drop 'by
security_compute_user' and leave the description general as with
freecon.

- getcon, getprevcon, and getpidcon return 0 on success, not the length
of the context.

- getexeccon returns 0 on success, and the returned context should be
freed with freecon if non-NULL.  "used for executing a new process"
isn't really accurate, as execve does not create a new process, just
transforms the current one; possibly replace with "used for the next
execve call".  The man page should note that getexeccon sets *con to
NULL if no exec context has been explicitly set by the program (i.e.
using the default policy behavior), and that NULL can be passed to
setexeccon to reset to the default policy behavior.  It should also note
that the exec context is automatically reset after the next execve, so a
program doesn't need to explicitly sanitize it upon startup.  The man
page should note that setexeccon() can be applied prior to library
functions that internally perform an execve, e.g. execl*, execv*, popen,
in order to set an exec context for that operation.  It should include a
warning that signal handlers that perform an execve must take care to
save, reset, and restore the exec context to avoid unexpected behaviors.

- Similarly for getfscreatecon and setfscreatecon.  Further,
fscreate context applies to all subsequent file creation operations
until reset explicitly by the program or automatically upon an execve.

- getfilecon man page should mention need to free with freecon.
errno values are incorrect; ENODATA is returned if the attribute
has not been assigned to the file yet, EOPNOTSUPP is returned if
the attribute is not supported.  Access denials should produce
EACCES.  May want to mention that this is just a wrapper for
getxattr calls that provides automatic context buffer allocation
and encapsulates the attribute name used for SELinux.

- get_ordered_context_list / get_default_context can be used for more
than user login sessions, e.g. it is also used for cron jobs.
default_contexts files are only used to determine ordering; the possible
roles and domains are determined from the policy itself.

- In the current CVS tree, is_selinux_enabled can return -1 upon errors
in attempting to determine whether SELinux is enabled, e.g. unable to
access /proc/filesystems to check for selinuxfs or unable to allocate
buffer for reading from it.  Proper way for applications to handle this
is unclear.

- security_check_context (and all other security*) calls should have
errno ENOENT if selinuxfs is not mounted.

- security_compute_av man page still has a legacy mention of "SID
pair".  Contexts returned by the other compute* functions need to
be freed via freecon or freeconary.

- security_load_policy man page should likely explain the arguments,
i.e. data is pointer to memory containing binary policy image, and len
is the size of the binary policy in bytes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
