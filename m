Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Michael Alexander S Contr OO-ALC/YPVS <Alexander.Michael@HILL.af.mil>,
        "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: Re: Errors in SELinux compile
Date: Mon, 2 Dec 2002 20:25:23 +0100
References: <1C693F61F78ADA449B9FDAE7737665E001A0157C@fskrsm41.hill.af.mil>
In-Reply-To: <1C693F61F78ADA449B9FDAE7737665E001A0157C@fskrsm41.hill.af.mil>
MIME-Version: 1.0
Message-Id: <200212022025.23834.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Dec 2002 19:51, Michael Alexander S Contr OO-ALC/YPVS wrote:
> make[2]: Entering directory '/home/Alex/lsm-2.4/fs'
> gcc -D__KERNEL__ -I/home/Alex/lsm-2.4/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -02 -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -pipe -mpreferred-stack-boundary=2 -march=i686    -nostdinc -I
> /usr/lib/gcc-lib/i386-redhat-linux/3.2/include -DKBUILD_BASENAME=namei   -c
> -o namei.o namei.c
> namei.c: In function 'getname':
> namei.c: 142: (Each undeclared identifier is reported only once
> namei.c: 142: for each function is appears in.)
> namei.c: 142: warning: passing arg 2 of pointer to function from
> incompatible pointer type

I've just quickly checked the patch from the latest NSA release and it doesn't 
have any code at that point in namei.c.  Are you certain that the compilation 
failure was because of SE Linux?

Do you have any other kernel patches applied that might have caused a problem?  
The LSM kernel patch changes many things, there are lots of patches that 
conflict with it to varying degrees...

> Are these errors critical to the install?  I just wanted to make sure
> before I finished the install and found out I needed to change some other
> option in one of my files.

You can install the utilities etc without having compiled the kernel.

The web site http://sourceforge.net/projects/selinux/ appears to have kernel 
packages for 2.4.19 available which should mean that the latest version of 
the policydb is supported.  So you could download one of those kernel RPMs 
for experimenting.

I recommend compiling your own kernel for serious use, but for your first 
install it might be best to just use a kernel rpm.  Once you get it up and 
running lots of things become much easier to understand.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
