Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6VCA1q9015515
	for <selinux@tycho.nsa.gov>; Fri, 31 Jul 2009 08:10:01 -0400
Received: from mail-bw0-f222.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6VC9YGA017277
	for <selinux@tycho.nsa.gov>; Fri, 31 Jul 2009 12:09:35 GMT
Received: by bwz22 with SMTP id 22so1199701bwz.18
        for <selinux@tycho.nsa.gov>; Fri, 31 Jul 2009 05:09:59 -0700 (PDT)
Message-Id: <A266A75C-BDE1-4C8A-A8D6-309E8F9905AD@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: MLS F11: why not use execute_no_trans? user_t transitions to itself!
Date: Fri, 31 Jul 2009 14:09:56 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello,

when i start sleep(1) as user_t f11 with mls policy does this:

[root@localhost ~]# sesearch --allow -s user_t -t bin_t
Found 3 semantic av rules:
    allow user_t bin_t : file { ioctl read getattr lock execute  
entrypoint open } ;
...

and this:

[root@localhost ~]# sesearch --allow -s user_t -c process
Found 24 semantic av rules:
...
    allow user_t user_t : process { fork transition sigchld sigkill  
sigstop signull signal ptrace getsched setsched getsession getpgid  
setpgid getcap setcap share getattr setfscreate noatsecure siginh  
rlimitinh dyntransition setkeycreate setsockcreate } ;

...

it seems that user_t transitions to itself. Why not use  
execute_no_trans? Like it is handel in f10 targeted. Has this "style"  
any deeper sense?

--
Sebastian Pfaff



PS: No execute_no_trans, look here:

[root@localhost ~]# sesearch --allow -s user_t -t bin_t -p  
execute_no_trans

[root@localhost ~]# echo $?
0



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
