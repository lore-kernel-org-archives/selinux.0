Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4FAKwgA012625
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 06:20:58 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4FAHZsN006458
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 10:17:36 GMT
Date: Sun, 15 May 2005 11:27:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: ls -Z on non-SE machine
Message-ID: <20050515102704.GA16326@lkcl.net>
References: <200505151921.23171.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200505151921.23171.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

how about just silently ignoring the -Z option if selinux is
detected to not be enabled?

or placing dummy information in its place which any selinux-aware
shell scripts can pick up on.

On Sun, May 15, 2005 at 07:21:20PM +1000, Russell Coker wrote:
> Currently "ls -Z" refuses to operate if it detects that SE Linux is not 
> enabled on the machine.
> 
> This makes no sense to me.  Files that are labelled when running SE Linux keep 
> their labels (and the values of such labels may still be read) when not 
> running SE Linux.  It seems quite reasonable to me that an administrator may 
> want to take a disk out of a SE Linux machine and mount it on a non-SE 
> machine for debugging problems or forensics.  The current behavior of ls 
> works against such operations.
> 
> I believe that the best thing to do is to have ls not be linked against 
> libselinux and instead just call the XATTR api for reading the file contexts.  
> Ideally I think that such functionality should be enabled unconditionally so 
> that any administrator who receives a disk that was used on a SE Linux system 
> will have the ability to conveniently view all the data on it.
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
