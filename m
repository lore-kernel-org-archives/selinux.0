Subject: Re: Trouble with /lib/libselinux and linking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: Mario Fanelli <mario.fanelli@gmail.com>,
        SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <200605311023.k4VANUAJ022907@turing-police.cc.vt.edu>
References: <447d6259.4bf9ee2d.48c3.ffff96ac@mx.gmail.com>
	 <200605311023.k4VANUAJ022907@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Wed, 31 May 2006 09:01:53 -0400
Message-Id: <1149080513.524.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-31 at 06:23 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 31 May 2006 11:30:58 +0200, Mario Fanelli said:
> 
> (Nothing here is SELinux-specific, it's all generic info for developing
> software under Linux...)
> 
> > I have written a simple program that uses SELinux API but when I try to
> > compile it, gcc gives me an error says that it's unable to resolve reference
> > to getcon() function.
> 
> > The only way is to link statically the library and thus if I use "gcc
> > -lselinux program.c" all works...
> 
> In general, if it isn't in libc.so, you'll have to supply a -l parameter
> so gcc can find it.  There's a *lot* of other libraries in /lib and /usr/lib
> that work the same way.
> 
> Your program is almost certainly not linked statically - it's probably got
> a runtime shared library reference.  You can tell which it is with the 'ldd'
> command:
> 
> % ldd /usr/bin/chcon
>         linux-gate.so.1 =>  (0xb7f31000)
>         libselinux.so.1 => /lib/libselinux.so.1 (0xb7f05000)
>         libc.so.6 => /lib/libc.so.6 (0xb7dd2000)
>         libdl.so.2 => /lib/libdl.so.2 (0xb7dce000)
>         libsepol.so.1 => /lib/libsepol.so.1 (0xb7d8b000)
>         /lib/ld-linux.so.2 (0xb7f32000)
> 
> The 'chcon' command is linked against the selinux and sepol shared libraries,
> and a number of other things as well.
> 
> % ldd /sbin/lvm.static 
>         not a dynamic executable
> 
> Now *this* one is statically linked. Creating a static binary requires
> special compile and linking flags - so you probably would *know* it if
> you had done it.
> 
> In general, the only things that need to be statically linked are binaries
> needed in *very* early system boot (such as on an initrd or initramfs image)
> that need to run before the root filesystem is mounted (LVM, commands to spin
> up a RAID disk, etc).  Once the system gets far enough to be able to find its
> /lib directory, you can run programs that use those libraries...
> 
> > Moreover if I use nm on libselinux.so, I don't receive any output..Isn't it
> > unusual?
> 
> That just means the library has been fed to the 'strip' command.
> 
> % file /lib/libselinux.so.1 
> /lib/libselinux.so.1: ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV), stripped
> 
> 'man strip' for the details, but basically it trims out a lot of auxillary
> information not needed for execution (like the info that 'nm' uses for its
> output). The resulting file is often much smaller.  This also causes problems
> when debugging (the 'gdb' debugger will show "??" for function names, etc).  At
> least on Fedora, for every 'foo' RPM, there is usually also a 'foo-debuginfo'
> RPM that includes a separate copy of that information so you can debug
> problems.

Note that you can display the dynamic symbol table via any of:
	nm -D /lib/libselinux.so.1
	objdump -T /lib/libselinux.so.1
	readelf -s /lib/libselinux.so.1
	eu-readelf -s /lib/libselinux.so.1

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
