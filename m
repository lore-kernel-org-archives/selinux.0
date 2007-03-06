Subject: Re: Question about the process : share permission.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0703060815m5bbe83bdsed886eafe6dac00d@mail.gmail.com>
References: <e739902b0703060815m5bbe83bdsed886eafe6dac00d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 06 Mar 2007 11:34:33 -0500
Message-Id: <1173198873.15967.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-06 at 08:15 -0800, Ryan Bradetich wrote:
> Hello all,
> 
> I am trying to understand what the process : share permission does.
> In the SELinux by example book, it says the process : share permission
> allows state sharing with cloned or forked processes.
> 
> I looked looked through the refpolicy tree and only found one instance
> of the process : share permission, it is in the kernel_share_state
> interface.   This interface is only called by the system/init module.
> 
> At first I thought this permission had to do with shared libraries
> and/or forking processes, but I see there is also a process : fork
> permission and there is a libs_use_shared_libs interface function to
> allow the loading and execution of shared libraries.
> 
> I am just curious to understand what the process : share permission
> allows/prevents.

If you call clone() with certain flags (e.g. CLONE_FS, CLONE_FILES) to
cause sharing of certain portions of the task state and then perform a
context-changing execve, then the process share permission is checked
between the old and new contexts.  This is generally unsafe, as it
allows the caller to influence/control the callee.  It happens naturally
when the kernel starts init, which is why it is allowed there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
