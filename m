Subject: Re: MLS F11: why not use execute_no_trans? user_t transitions to
 itself!
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <A266A75C-BDE1-4C8A-A8D6-309E8F9905AD@gmail.com>
References: <A266A75C-BDE1-4C8A-A8D6-309E8F9905AD@gmail.com>
Content-Type: text/plain
Date: Mon, 03 Aug 2009 07:46:04 -0400
Message-Id: <1249299964.31481.3.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-07-31 at 14:09 +0200, Sebastian Pfaff wrote:
> hello,
> 
> when i start sleep(1) as user_t f11 with mls policy does this:
> 
> [root@localhost ~]# sesearch --allow -s user_t -t bin_t
> Found 3 semantic av rules:
>     allow user_t bin_t : file { ioctl read getattr lock execute  
> entrypoint open } ;
> ...
> 
> and this:
> 
> [root@localhost ~]# sesearch --allow -s user_t -c process
> Found 24 semantic av rules:
> ...
>     allow user_t user_t : process { fork transition sigchld sigkill  
> sigstop signull signal ptrace getsched setsched getsession getpgid  
> setpgid getcap setcap share getattr setfscreate noatsecure siginh  
> rlimitinh dyntransition setkeycreate setsockcreate } ;
> 
> ...
> 
> it seems that user_t transitions to itself. Why not use  
> execute_no_trans? Like it is handel in f10 targeted. Has this "style"  
> any deeper sense?

user_t transition to self gets checked when some other component of the
context changes, e.g. user, role, or level.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
