Message-ID: <45B0B5DC.2000401@nagafix.co.uk>
Date: Fri, 19 Jan 2007 12:13:16 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
To: vin@netwosix.org
CC: SELinux@tycho.nsa.gov
Subject: Re: installation from scratch problems
References: <1169207960.8700.19.camel@zeroKnowledge>
In-Reply-To: <1169207960.8700.19.camel@zeroKnowledge>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Looks like a glibc issue, which version do you have and does it have tls 
support? (LFS is going to be similar to Gentoo)
FYI:
http://www.nsa.gov/selinux/list-archive/0605/15487.cfm


Vincenzo Ciaglia wrote:
> Hello, i'm Vincenzo Ciaglia. 
> 
> I'm the main developer of Linux Netwosix, a server and security oriented
> GNU/Linux LFS distribution. I was really impressed to the power of
> SELinux so I'd like to give to the next releases the complete support to
> SELinux, for this reason i'm already working on that. I have a good
> knowledge in selinux policy writing but no experiences with "from
> scratch installation".
> 
> So, i have compiled the latest kernel with "Socket and Networking
> Security Hooks" and other "Security Models". Of course with the Ext[3]
> extended attributes and Ext[3] Security Labels options. 
> Everything is ok.
> 
> After that, i have downloaded the userland packages from the NSA
> website.
> 
> I succesfully compiled the "libsepol-1.14". 
> 
> So i tried to compile the "libselinux-1.32" but i get these errors:
> 
> --------------
> matchpathcon.lo: In function `set_matchpathcon_flags':
> matchpathcon.c:(.text+0x187): undefined reference to `___tls_get_addr'
> matchpathcon.lo: In function `.L183':
> matchpathcon.c:(.text+0x13c1): undefined reference to `___tls_get_addr'
> matchpathcon.lo: In function `matchpathcon_init_prefix':
> matchpathcon.c:(.text+0x15f3): undefined reference to `___tls_get_addr'
> matchpathcon.lo: In function `matchpathcon':
> matchpathcon.c:(.text+0x2005): undefined reference to `___tls_get_addr'
> matchpathcon.lo: In function `selinux_file_context_verify':
> matchpathcon.c:(.text+0x2417): undefined reference to `___tls_get_addr'
> matchpathcon.lo:matchpathcon.c:(.text+0x246e): more undefined references
> to `___tls_get_addr' follow
> collect2: ld returned 1 exit status
> make[1]: *** [libselinux.so.1] Error 1
> make[1]: Leaving directory `/root/selinux/libselinux-1.32/src'
> make: *** [all] Error 2
> --------------
> 
> Of course i can't go ahead because "checkpolicy" needs the libselinux:
> 
> --------------
> /usr/bin/ld: cannot find -lselinux
> collect2: ld returned 1 exit status
> make[1]: *** [dispol] Error 1
> make[1]: Leaving directory `/root/selinux/checkpolicy-1.32/test'
> make: *** [all] Error 2
> --------------
> 
> And these are the errors of "libsemanage".
> 
> --------------
> booleans_activedb.c: In function 'bool_commit_list':
> booleans_activedb.c:94: error: 'SELboolean' undeclared (first use in
> this function)
> booleans_activedb.c:94: error: (Each undeclared identifier is reported
> only once
> booleans_activedb.c:94: error: for each function it appears in.)
> booleans_activedb.c:94: error: 'blist' undeclared (first use in this
> function)
> booleans_activedb.c:113: warning: implicit declaration of function
> 'security_set_boolean_list'
> make[1]: *** [booleans_activedb.o] Error 1
> make[1]: Leaving directory `/root/selinux/libsemanage-1.8/src'
> make: *** [all] Error 2
> --------------
> 
> These are the "policycoreutils" ones:
> 
> --------------
> setfiles.c:516: error: 'MATCHPATHCON_VALIDATE' undeclared (first use in
> this function)
> setfiles.c:516: error: 'MATCHPATHCON_NOTRANS' undeclared (first use in
> this function)
> setfiles.c:549: error: 'MATCHPATHCON_BASEONLY' undeclared (first use in
> this function)
> setfiles.c:643: warning: implicit declaration of function
> 'set_matchpathcon_canoncon'
> setfiles.c:656: warning: implicit declaration of function
> 'matchpathcon_init'
> setfiles.c:740: warning: implicit declaration of function
> 'set_matchpathcon_printf'
> setfiles.c:741: warning: implicit declaration of function
> 'matchpathcon_filespec_eval'
> setfiles.c:745: warning: implicit declaration of function
> 'matchpathcon_filespec_destroy'
> setfiles.c:751: warning: implicit declaration of function
> 'matchpathcon_checkmatches'
> make[1]: *** [setfiles.o] Error 1
> make[1]: Leaving directory `/root/selinux/policycoreutils-1.32/setfiles'
> make: *** [all] Error 1
> --------------
> 
> Additional informations:
> 
> # gcc -v
> Using built-in specs.
> Target: i686-pc-linux-gnu
> Configured with: ../gcc-4.0.3/configure --prefix=/usr
> --libexecdir=/usr/lib --enable-languages=c,c++,objc
> --enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu
> --enable-shared --disable-nls --with-x=no
> Thread model: posix
> gcc version 4.0.3
> 
> # uname -a
> Linux netwosix 2.6.19.2 #2 SMP Fri Jan 19 13:05:53 UTC 2007 i686
> athlon-4 i386 GNU/Linux
> 
> Of course i can't go ahead and start working on relabeling the system. 
> Someone can tell me what i'm missing?
> 
> That's all. Excuse me for the long mail.
> Thank you so much! Looking forward to discuss with you.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
