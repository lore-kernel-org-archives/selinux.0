Subject: Re: Bug in 2.6.18: read of /proc/$PID/exe triggers ptrace check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20060927165234.GA5448@warschau.cip.ifi.lmu.de>
References: <20060927165234.GA5448@warschau.cip.ifi.lmu.de>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 13:34:44 -0400
Message-Id: <1159378484.2260.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-27 at 18:52 +0200, Thomas Bleher wrote:
> It seems like there's a bug in the linux kernel, v2.6.18.
> Whenever a process wants to read the /proc/$PID/exe symlink of a process
> in another domain, SELinux checks for the ptrace permission.
> 
> That's very unfortunate, as SUSE uses a program called killproc to shut
> down system services, which reads this symlink before doing anything.
> SUSE's mingetty also fails because of this, which means that the system
> is practically unusable.
> With 2.6.17 (or any earlier kernel), the system works fine.
> 
> I think this change should be reverted. The right to read this symlink
> is already covered by the check on read permission; also,
> /proc/$PID/cmdline contains the same information, most of the time.

See
http://marc.theaimsgroup.com/?l=git-commits-head&m=115134544830164&w=2 and
http://marc.theaimsgroup.com/?l=git-commits-head&m=115134545732646&w=2

proc has been getting an overhaul by the containers people, but this is
just a continuation of what has already happened in the past (e.g. the
prior change to likewise apply ptrace checking on environ).  The
file-based checks aren't quite sufficient, as the inode label only gets
revalidated on open.

One option would be to define a ptrace_may_read() function to
distinguish reading process state from full ptrace attach, and then
change proc_fd_access_allowed() and proc_pid_environ() to call the new
function instead of ptrace_may_attach().  Internally, that function
would apply the usual ptrace-related DAC checking, but call a different
security hook, so that SELinux could distinguish it and possibly remap
it to another permission check, even emulating the file-based one if
desired so that policy would look the same.  Want to make a patch?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
