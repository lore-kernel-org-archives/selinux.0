From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: labeling of compilers etc
Date: Tue, 31 Jan 2006 18:47:46 +1100
Cc: SELinux-dev@tresys.com, SELinux List <selinux@tycho.nsa.gov>
References: <200601291156.13076.russell@coker.com.au> <1138631347.7076.32.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138631347.7076.32.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200601311847.56015.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 31 January 2006 01:29, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sun, 2006-01-29 at 11:56 +1100, Russell Coker wrote:
> > In many discussions about hardening systems the idea is suggested that
> > machines should not have compilers unless they are development machines.
> >
> > It would not be difficult to label compilers as compiler_exec_t and only
> > permit user domains the ability to execute files of such type (daemons
> > don't need to compile software).  What do you think of this idea?  Maybe
> > we would want to have a more generic type such as devel_exec_t and label
> > programs such as gdb with it as well.
>
> The other option would be to instead only label files that you want to
> be executable by such users with a distinct type (e.g.
> user_executable_t), and then remove access to the other types (bin_t,
> sbin_t, *_exec_t, ...) from the user domains for such systems.  I
> suspect that in such environments, you not only want to prohibit use of
> the development toolchain, but also want to limit users to only
> executing a specific set of approved programs.

That sounds reasonable and fits with the SE Linux design philosophy of 
default-deny.  Of course it'll be more fiddly to get it going acceptably.

> > Also interpreters could be modified to provide similar benefits. 
> > Currently many (most?) shell interpreters try to detect and prevent
> > setuid operation with code roughly equivalent to if(getuid() !=
> > geteuid()) seteuid(getuid). Bash currently has such code (just done a
> > quick test) and other shells had such cost in place last time I tested
> > them.  I believe that this establishes a precedent for shell interpreters
> > to check for and prevent insecure modes of operation.
> >
> > A logical extension of this precedent to SE Linux would be to have it
> > check the type of a file to be executed and confirm that the current
> > domain is permitted to execute scripts of the type in question, for a
> > regular file it would get the context (after opening it) and ask SE Linux
> > whether the current context has execute access for the file class.
>
> This is a policy issue at the kernel level, not something the shell
> should get involved in.

If the shell can read two files but should only "execute" one of them then 
it's something that can only be enforced by the shell itself.

> If the policy author has decided to allow a 
> domain transition and to mark a script with an entrypoint type, then
> that is their choice,

However it may not be their choice!  At any time a new version of some 
software could replace an executable with a shell script.

> and it may be a perfectly valid choice in specific 
> cases (e.g. shedding of permissions where subversion by the caller would
> not yield any security risk since the caller already has more
> permissions than the callee or where the caller is trusted).

True.  The case of scripts escalating permissions is the one we are concerned 
with.

> The 
> current policy does make use of such transitions (e.g. init_t ->
> initrc_t), so we certainly do not want to break them.

Naturally we would not break them.  My proposal would still support such 
things with a little extra policy.

Below the line "domain_auto_trans(init_t,initrc_exec_t,initrc_t)" we would 
merely have to add "domain_trans(init_t, shell_exec_t, initrc_t)".  The 
policy changes would be introduced before the changes to shells so no 
breakage would occur.

> It would make 
> sense for a policy lint/checker tool (like sechecker) to check the
> file_contexts configuration or filesystem state for scripts that have
> entrypoint types and report on such transitions, flagging in particular
> cases where the calling domain is not already more privileged than the
> new domain for review by the policy writer or admin.  But I don't think
> we want a blanket prohibition enforced by the shell.

I did not suggest a blanket prohibition, but merely a prohibition controlled 
by policy.  The number of instances where you really want to have a 
domain_auto_trans() based on a shell script is very small so this should not 
be difficult (absolutely no work at all when compared to the C coding needed 
to get the shells all working with it).

> >   For a character device node
> > (IE stdin but let's not assume that's the only device to be used) it
> > would check for execute access of class chr_file for the context in
> > question.  Does it even make sense to execute a block device node as a
> > shell script?
>
> No.  open_exec() in the kernel rejects anything that isn't a regular
> file.

open_exec() is not used when bash decides to execute a script:
# cat > /dev/sda1
echo test
exit 1
^D
# chmod 644 /dev/sda1
#

$ bash /dev/sda1
test
$

I executed code on a block device.  Incidentally the device I used for testing 
was a USB flash device.  It seems to me that we want such devices to be 
removable_device_t not fixed_disk_device_t (as is currently the case).  Using 
removable_device_t will fix some usability cases but also make it more of an 
issue to control executing code from it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
