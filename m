Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i141HERb009307
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 20:17:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i141HB1I022529
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 01:17:11 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i141H9bs022526 for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 01:17:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Dave Gilbert (Home)" <gilbertd@treblig.org>, selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Date: Wed, 4 Feb 2004 12:16:54 +1100
References: <401FF280.8070301@treblig.org>
In-Reply-To: <401FF280.8070301@treblig.org>
Cc: bam@snoopy.apana.org.au
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402041216.54927.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Feb 2004 06:12, "Dave Gilbert (Home)" <gilbertd@treblig.org> wrote:
> I'm using Debian Woody and the 'stable' set of tools from Brian May
> (www.microcomaustralia.com.au)

It appears that the "stable" repository on Brian's site is for old SE Linux 
and "unstable" is for new SE Linux.  I've updated my web site to describe 
this.

Brian, what are your plans for this?  Do you plan to make the new SE Linux 
packages migrate to "stable" on your site?

> An strace of 'id' shows:
>
> SYS_223(0xf97cff8c, 0xc, 0, 0x400135cc) = -1 ENOSYS (Function not
> implemented)

SYS_223 is the LSM system call from the old SE Linux.

> OK - so that doesn't work; and I'm thinking I need to try a different
> kernel patch set.
> So I download the patches from www.coker.com.au/newselinux/kern
>
> and after battling through adding the ea, acl and nfsacl patches
> I then patch the coker lsm patches on.
>
> This has two problems:
>    1) A minor reject in tcp_ipv4.c that appears easy to fix
>    2) Line 666 (gulp!) of ip_output.c has:
>
>    security_ip_fragment(skb2, skb);
>
>    but there doesn't appear to be an skb2 in that context.

Sounds like you aren't applying the patches to the Debian kernel source.  If 
you get kernel-patch-debian-2.4.24 and apply it first then everything should 
be fine.

Regarding the skb2, that's because the patch gets applied to the wrong 
function.  Look at the context after the added line and it should be easy to 
manually put in.

But using 2.6.1 is probably easier.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
