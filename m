Subject: Re: SELinux and LFS
From: Vincenzo Ciaglia <vin@netwosix.org>
Reply-To: vin@netwosix.org
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171476502.20576.35.camel@sgc.columbia.tresys.com>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171476502.20576.35.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 23:10:48 +0100
Message-Id: <1171491048.3017.5.camel@desk.netwosix.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il giorno mer, 14/02/2007 alle 18.08 +0000, Christopher J. PeBenito ha
scritto:

> > 4) I still haven't patched packages like coreutils and sons.
> 
> You need a patched init to load the policy.  If no policy is loaded,
> SELinux is disabled:

Hi, i tried to re-configure sysvinit with this patch (the fedora's one):
http://www.netwosix.org/selinux/sysvinit-selinux.patch (is the only one
needed?)

But i get these outputs:

# patch -Np1 -i sysvinit-selinux.patch 
patching file src/init.c
Hunk #1 succeeded at 42 (offset -6 lines).
Hunk #2 succeeded at 2607 (offset 92 lines).
Hunk #3 succeeded at 2573 (offset -6 lines).
patching file src/Makefile
Hunk #1 succeeded at 57 with fuzz 1 (offset 25 lines).
Hunk #2 FAILED at 75.
1 out of 2 hunks FAILED -- saving rejects to file src/Makefile.rej
patching file src/sulogin.c
Hunk #1 FAILED at 28.
Hunk #2 succeeded at 338 (offset 3 lines).
1 out of 2 hunks FAILED -- saving rejects to file src/sulogin.c.rej

# make -C src
make: Entering directory `/home/vciaglia/sysvinit-2.86/src'
gcc -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE   -c -o mountpoint.o
mountpoint.c
gcc -s -o mountpoint mountpoint.o
gcc -c -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE init.c
init.c: In function 're_exec':
init.c:1889: warning: missing sentinel in function call
gcc -c -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE -DINIT_MAIN utmp.c
-o init_utmp.o
gcc -s  -o init init.o init_utmp.o -lsepol -lselinux
gcc -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE   -c -o halt.o halt.c
gcc -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE   -c -o ifdown.o
ifdown.c
gcc -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE   -c -o hddown.o
hddown.c
gcc -c -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE utmp.c
gcc -s -o halt halt.o ifdown.o hddown.o utmp.o
gcc -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE   -c -o dowall.o
dowall.c
gcc -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE   -c -o shutdown.o
shutdown.c
gcc -s -o shutdown dowall.o shutdown.o utmp.o
gcc -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE   -c -o runlevel.o
runlevel.c
gcc -s -o runlevel runlevel.o
gcc -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE  -s  killall5.c   -o
killall5
gcc -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE   -c -o sulogin.o
sulogin.c
sulogin.c: In function 'sushell':
sulogin.c:338: error: 'is_selinux_enabled' undeclared (first use in this
function)
sulogin.c:338: error: (Each undeclared identifier is reported only once
sulogin.c:338: error: for each function it appears in.)
sulogin.c:339: error: 'security_context_t' undeclared (first use in this
function)
sulogin.c:339: error: expected ';' before 'scon'
sulogin.c:342: warning: implicit declaration of function
'getseuserbyname'
sulogin.c:343: warning: implicit declaration of function
'get_default_context_with_level'
sulogin.c:343: error: 'scon' undeclared (first use in this function)
sulogin.c:344: warning: implicit declaration of function 'setexeccon'
sulogin.c:346: warning: implicit declaration of function 'freecon'
make: *** [sulogin.o] Error 1
make: Leaving directory `/home/vciaglia/sysvinit-2.86/src'
# 

What is going wrong ? Maybe i'm missing something? I get the same
"errors" when i try to patch the coreutils.

Thank you a lot,

-- 
Vincenzo Ciaglia, <vin(at)netwosix(dot)org>
Linux Netwosix, <http://www.netwosix.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
