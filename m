From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: draper7@ziplip.com, SELinux@tycho.nsa.gov
Subject: Re: spasswd.c
Date: Sun, 16 Feb 2003 22:51:40 +0100
References: <DTCOIKAKKNB3NWCMMKNXKJCDHTEAEFP3JRHWOJAF@ziplip.com>
In-Reply-To: <DTCOIKAKKNB3NWCMMKNXKJCDHTEAEFP3JRHWOJAF@ziplip.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302162251.40417.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 16 Feb 2003 22:36, Dusty Hall wrote:
>   Thanks for the fix, it worked like a champ.  Although now I'm having
> problems compiling disk-utils, specifically raw.c.  The following is the
> error message:
>
> cc -O -pipe -O2 -m486 -fomit-frame-pointer -I../lib -Wall
> -Wmissing-prototypes -Wstrict-prototypes -I/usr/include/ncurses -DNCH=0
> -I/usr/include/slang -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\"
> -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\"
> -DLOCALEDIR=\"/usr/share/locale\"  -s  raw.c   -o raw raw.c:22:
> linux/raw.h: No such file or directory

It seems that your system doesn't have the latest headers.  Login to my play 
machine and copy the headers you need.  The login details are in my SE Linux 
web site.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
