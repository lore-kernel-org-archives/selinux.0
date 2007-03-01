Subject: Re: Failed write to /selinux/context in
	selinux_trans_to_raw_contex()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 07:12:30 -0500
Message-Id: <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-28 at 23:57 -0800, Ryan Bradetich wrote:
> Hello all,
> 
> I have tracked down a problem that prevents me from logging into my
> system when I build a policy that only has the base modules defined.
> All the notes below are using revision 2202 of the reference policy
> (sorry for the length of the email, these are my notes while  tracking
> down the problem... hopefully something in them will offer some
> insight to the problem).   This problem is very reproducible for me:
> 
>    base-only policy:
>        1. make bare
>        2. make conf
>        3. vi policy/modules.conf (:1,$s/= module/= off/g)

Um, why do you expect this to work?  Looking at a modules.conf here,
that would exclude userdomain from the build, and thus no user domains
at all.  Which is fine from a dependency view (hence not in base) but
not if you want users to login...

>        4. make policy
>        5. make load
>        6. sync
>        7. reboot
> 
>    everything policy:
>        1. make bare
>        2. make conf
>        3. make policy
>        4. make load
>        5. sync
>        6. reboot
> 
>     kernel version: 2.6.20
> 
> I am really hoping for a description of what is supposed to happen, so
> I better understand how the security server works.   My end goal is to
> continue stripping down the reference policy to the bare minimum so I
> can build a custom security policy for my embedded research project.
> 
> The problem I am seeing now is when I attempt to log into the system
> with SELinux enabled, but in permissive mode the get_default_context()
> in libselinux1 returns an error.  This error prevents me for logging
> into the system, but when I boot the system with the selinux=0 kernel
> parameter I am able to log into the system fine.
> 
> Here are my notes:
> 
> 1. The login busybox applet makes a call to get_default_context() in
> the libselinux1 library.  It passes the following arguments:
>       user: "root"
>       fromcon:  NULL,
>       newcon: &user_sid;
> 
> 2. get_default_context() calls the get_ordered_context_list(), also in
> the libselinux1 library.  This function returns -1.
> 
> 3. get_ordered_context_list()  calls the security_compute_user(), also
> in the libselinux1
> library.  This function returns 0.
> 
> 4. In security_compute_user()
>       The following check is passed: selinux_trans_to_raw_context()
> 
> 5. check_compute_user() calls the security_compute_user_raw() function.
>       The selinux_mnt is defined.
>       Was able to open /selinux/user
>       Was able to allocate memory.
>       Was able to write to /selinux/user
>       Was able to read from /selinux/user
>       nel = 0
> 
> At this point the security_compute_user_raw() and check_compute_user()
> both fall through and drop back to the get_ordered_context_list().
> The nreach variable is calculated and ends up 0, where it goes jumps
> to the failsafe label.
> 
> [NOTE: why are we in the failsafe?  Seems like I am missing something
> that would avoid this step].

Yes, this means that there were no reachable contexts for the user from
the login app's context in the policy.  Or no defined contexts for the
user at all in the policy.  So it bails and tries the failsafe one as a
fallback for recovery.

> Tracing down into the failsafe label  I found the following:
> 
> 6.  Makes a call to the get_failsafe_context.
>      Open the selinux_failsafe_context_path()
>      Perform a fgets_unlocked from the file descriptor
>      Allocate a new conn using information from the
> selinux_failsafe_context_path.
>      Call the security_check_context()
> 
> 7. The security_check_context() calls the selinux_trans_to_raw_context().
> 
> 8.  The selinux_trans_to_raw_context does the following:
>       opens /selinux/context
>       writes to /selinux/context
> 
> 
> This write system call is the difference between the everything policy
> and the base-only policy files.   With the everything policy, this
> write command successfully writes 23 bytes.   In the base-only policy,
> the write command fails and sets errno to 22.

Yes, because even the failsafe context wouldn't be defined if you
excluded userdomain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
