Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6VD1VDW021919
	for <selinux@tycho.nsa.gov>; Fri, 31 Jul 2009 09:01:31 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6VD2Qnu016683
	for <selinux@tycho.nsa.gov>; Fri, 31 Jul 2009 13:02:26 GMT
Message-ID: <4A72EB27.8040006@redhat.com>
Date: Fri, 31 Jul 2009 09:01:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: MLS F11: why not use execute_no_trans? user_t transitions to
 itself!
References: <A266A75C-BDE1-4C8A-A8D6-309E8F9905AD@gmail.com>
In-Reply-To: <A266A75C-BDE1-4C8A-A8D6-309E8F9905AD@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/31/2009 08:09 AM, Sebastian Pfaff wrote:
> hello,
> 
> when i start sleep(1) as user_t f11 with mls policy does this:
> 
> [root@localhost ~]# sesearch --allow -s user_t -t bin_t
> Found 3 semantic av rules:
>    allow user_t bin_t : file { ioctl read getattr lock execute
> entrypoint open } ;
> ...
> 
> and this:
> 
> [root@localhost ~]# sesearch --allow -s user_t -c process
> Found 24 semantic av rules:
> ...
>    allow user_t user_t : process { fork transition sigchld sigkill
> sigstop signull signal ptrace getsched setsched getsession getpgid
> setpgid getcap setcap share getattr setfscreate noatsecure siginh
> rlimitinh dyntransition setkeycreate setsockcreate } ;
> 
> ...
> 
> it seems that user_t transitions to itself. Why not use
> execute_no_trans? Like it is handel in f10 targeted. Has this "style"
> any deeper sense?
> 
> -- 
> Sebastian Pfaff
> 
> 
> 
> PS: No execute_no_trans, look here:
> 
> [root@localhost ~]# sesearch --allow -s user_t -t bin_t -p execute_no_trans
> 
> [root@localhost ~]# echo $?
> 0
> 
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
I forget exactly why, but some tool is doing a setcon/setexecon to the current context

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
