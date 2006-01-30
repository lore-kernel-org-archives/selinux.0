Subject: Re: labeling of compilers etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SELinux-dev@tresys.com, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <200601291156.13076.russell@coker.com.au>
References: <200601291156.13076.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 09:29:07 -0500
Message-Id: <1138631347.7076.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-01-29 at 11:56 +1100, Russell Coker wrote:
> In many discussions about hardening systems the idea is suggested that 
> machines should not have compilers unless they are development machines.
> 
> It would not be difficult to label compilers as compiler_exec_t and only 
> permit user domains the ability to execute files of such type (daemons don't 
> need to compile software).  What do you think of this idea?  Maybe we would 
> want to have a more generic type such as devel_exec_t and label programs such 
> as gdb with it as well.

The other option would be to instead only label files that you want to
be executable by such users with a distinct type (e.g.
user_executable_t), and then remove access to the other types (bin_t,
sbin_t, *_exec_t, ...) from the user domains for such systems.  I
suspect that in such environments, you not only want to prohibit use of
the development toolchain, but also want to limit users to only
executing a specific set of approved programs.

> Also interpreters could be modified to provide similar benefits.  Currently 
> many (most?) shell interpreters try to detect and prevent setuid operation 
> with code roughly equivalent to if(getuid() != geteuid()) seteuid(getuid).  
> Bash currently has such code (just done a quick test) and other shells had 
> such cost in place last time I tested them.  I believe that this establishes 
> a precedent for shell interpreters to check for and prevent insecure modes of 
> operation.
> 
> A logical extension of this precedent to SE Linux would be to have it check 
> the type of a file to be executed and confirm that the current domain is 
> permitted to execute scripts of the type in question, for a regular file it 
> would get the context (after opening it) and ask SE Linux whether the current 
> context has execute access for the file class.

This is a policy issue at the kernel level, not something the shell
should get involved in.  If the policy author has decided to allow a
domain transition and to mark a script with an entrypoint type, then
that is their choice, and it may be a perfectly valid choice in specific
cases (e.g. shedding of permissions where subversion by the caller would
not yield any security risk since the caller already has more
permissions than the callee or where the caller is trusted).  The
current policy does make use of such transitions (e.g. init_t ->
initrc_t), so we certainly do not want to break them.  It would make
sense for a policy lint/checker tool (like sechecker) to check the
file_contexts configuration or filesystem state for scripts that have
entrypoint types and report on such transitions, flagging in particular
cases where the calling domain is not already more privileged than the
new domain for review by the policy writer or admin.  But I don't think
we want a blanket prohibition enforced by the shell.

>   For a character device node 
> (IE stdin but let's not assume that's the only device to be used) it would 
> check for execute access of class chr_file for the context in question.  Does 
> it even make sense to execute a block device node as a shell script?

No.  open_exec() in the kernel rejects anything that isn't a regular
file.

> In some mailing lists related to SE Linux it's been mentioned that people 
> desire these features.  I believe that I have come up with a reasonable 
> design to solve the problems in question.  If it's considered worth-while 
> then I'm willing to write a policy patch for the first one and a bash patch 
> for the second one.
> 
> Also it should be noted that if the perl interpreter is setuid then it'll 
> happily do things as the EUID, this means that we have no good precedent to 
> rely on in this case.  This doesn't stop us, just means that the chance of 
> getting code accepted upstream is dramatically reduced.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
