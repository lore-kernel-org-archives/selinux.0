Subject: Re: policycoreutils build error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kovacsics =?ISO-8859-1?Q?R=F3bert?= <kovirobi@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <CABPkNKmB6ZdGtT1Avy64sFxce1y1WqAzD73uwZTqF8ij6c4t0w@mail.gmail.com>
References: 
	 <CABPkNKmB6ZdGtT1Avy64sFxce1y1WqAzD73uwZTqF8ij6c4t0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Feb 2012 15:33:39 -0500
Message-ID: <1329856419.12501.78.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2012-02-11 at 13:13 +0000, Kovacsics Róbert wrote:
> Hello all!
> 
> I would like to ask for assistance on compiling SELinux (particularly
> policycoreutils 2.1.0)
> 
> Here is my setup:
> *Linux from scratch running kernel 3.2.5
> *Installed libsepol
> *Installed libselinux
> *Installed libsemanage
> *Installed sepolgen
> *Installed checkpolicy
> 
> Error on installing policycoreutils-2.1.0
> Error:
> make[1]: Entering directory
> `/blfs-sources/selinux/policycoreutils-2.1.0/sandbox'
> cc  -I/usr/include -DPACKAGE="\"policycoreutils\""   -c -o seunshare.o
> seunshare.c
> seunshare.c: In function ‘main’:
> seunshare.c:242:21: error: ‘CLONE_NEWNS’ undeclared (first use in this function)
> seunshare.c:242:21: note: each undeclared identifier is reported only
> once for each function it appears in
> make[1]: *** [seunshare.o] Error 1
> make[1]: Leaving directory `/blfs-sources/selinux/policycoreutils-2.1.0/sandbox'
> make: *** [all] Error 1

$ grep CLONE_NEWNS /usr/include/*/*.h
/usr/include/bits/sched.h:# define CLONE_NEWNS   0x00020000 /* Set to create new namespace.  */
/usr/include/linux/sched.h:#define CLONE_NEWNS	0x00020000	/* New namespace group? */

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
