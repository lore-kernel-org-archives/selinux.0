Message-ID: <1346767543.30701.39.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Segmentation fault in context_type_get()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Gaurav Kumar <gk@pivotalsecurity.com>
Cc: SELinux@tycho.nsa.gov
Date: Tue, 04 Sep 2012 10:05:43 -0400
In-Reply-To: <CAFUy1Tx+=Og3PnkE+GoyrDXRXsAJ-X9Qk2zaf0GPfSSFix7ggQ@mail.gmail.com>
References: 
	<CAFUy1Txwvm+iSt1-1qeZDckWPhMH_D3_UwkGPFHp+cS-ub8zKg@mail.gmail.com>
	 <CAFUy1Tx+=Og3PnkE+GoyrDXRXsAJ-X9Qk2zaf0GPfSSFix7ggQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2012-09-02 at 06:41 -0700, Gaurav Kumar wrote:
> Nevermind, I think it is Ubuntu issue. Code works just fine on Fedora
> & Redhat. I think selinux support in Ubuntu is limited and the library
> could be buggy- I'll file a bug at launchpad.

Running it under valgrind might be helpful.

> 
> Cheers,
> Gaurav
> 
> On Sun, Sep 2, 2012 at 4:42 AM, Gaurav Kumar <gk@pivotalsecurity.com>
> wrote:
>         Hi, 
>         
>         
>         When I try to compile this
>         program http://pastebin.com/VY958hLD (refer http://www.internet-goods.com/?p=42 for original code)  I get segmentation fault. Seems to be an issue with context_type_get
>         
>         
>         root@devUbuntu:/home/user1/dev# gdb ./a.out
>         GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2) 7.4-2012.04
>         Copyright (C) 2012 Free Software Foundation, Inc.
>         License GPLv3+: GNU GPL version 3 or later
>         <http://gnu.org/licenses/gpl.html>
>         This is free software: you are free to change and redistribute
>         it.
>         There is NO WARRANTY, to the extent permitted by law.  Type
>         "show copying"
>         and "show warranty" for details.
>         This GDB was configured as "x86_64-linux-gnu".
>         For bug reporting instructions, please see:
>         <http://bugs.launchpad.net/gdb-linaro/>...
>         Reading symbols from /home/user1 /dev/a.out...done.
>         (gdb) run
>         Starting program: /home/user1 /dev/a.out
>         Checking if selinux is enabled…
>         this program is not running on a SELinux kernel
>         getting this program’s current context…
>         this program's security_context_t is: = unconfined
>         
>         
>         Calling context_type_get
>         
>         
>         Program received signal SIGSEGV, Segmentation fault.
>         0x00007ffff7bc5a20 in context_type_get ()
>         from /lib/x86_64-linux-gnu/libselinux.so.1
>         (gdb)
>         
>         
>         
>         
>         I am compiling code as "gcc tmp.c -lselinux -ggdb" on Ubuntu
>         12.04.
>         
>         
>         Is this an issue with selinux on Ubuntu? If not, can you
>         please provide an example of how to call context_type_get()
>         
>         
>         Thanks,
>         Gaurav
>         
>         
>         
>         
>         
>         
> 
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
