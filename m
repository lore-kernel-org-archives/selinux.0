From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-devel-list@redhat.com
Subject: Re: writing zero bytes in bash
Date: Sat, 26 Feb 2005 21:47:52 +1100
Cc: Miloslav Trmac <mitr@volny.cz>, SELinux@tycho.nsa.gov
References: <200502261832.16337.russell@coker.com.au> <20050226103915.GB28440@chrys.ms.mff.cuni.cz>
In-Reply-To: <20050226103915.GB28440@chrys.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502262147.55747.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Interesting comment.  I'm replying with the SE Linux list CC'd so everyone 
who's involved can comment.

Maybe a change to make "\n" equivalent to "" in the SE Linux kernel interfaces 
in question would be appropriate then?  For the SE Linux interfaces in 
question a '\n' character is not valid in any part of the input and the input 
must contain three fields separated by colons, so a special case of "\n" 
being equivalent to "" can not cause any confusion.

Also as a side note, in the normal use only libselinux.so has any code which 
does such zero byte writes.  Doing it from bash is only needed for testing, 
debugging, and educational purposes.

On Saturday 26 February 2005 21:39, Miloslav Trmac <mitr@volny.cz> wrote:
> On Sat, Feb 26, 2005 at 06:32:13PM +1100, Russell Coker wrote:
> > To unset the fscreate or exec context you have to write zero bytes
> > to /proc/self/attr/fscreate or /proc/self/attr/exec respectively.
>
> I personally think this is the problem - no interface should require
> writing 0 bytes.
>
> To quote the POSIX spec:
> | Before  any  action described below is taken, and if nbyte is zero and
> | the file is a regular file, the write() function may detect and return
> | errors  as  described  below.  In  the  absence of errors, or if error
> | detection is not performed, the write() function shall return zero and
> | have no other results.  If nbyte is zero and the file is not a regular
> | file, the results are unspecified.
>
> Files in /proc _are_ regular files, as far as stat() is concerned, so
> I don't think you can require that portable programs give you the
> possibility to write 0 bytes to these files.
>  Mirek

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
