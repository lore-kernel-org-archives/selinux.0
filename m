Subject: Re: writing zero bytes in bash
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au,
   Development discussions related to Fedora Core <fedora-devel-list@redhat.com>
Cc: Miloslav Trmac <mitr@volny.cz>, SELinux@tycho.nsa.gov
In-Reply-To: <200502262147.55747.russell@coker.com.au>
References: <200502261832.16337.russell@coker.com.au>
	 <20050226103915.GB28440@chrys.ms.mff.cuni.cz>
	 <200502262147.55747.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 14:00:30 -0500
Message-Id: <1109617230.28470.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-02-26 at 21:47 +1100, Russell Coker wrote:
> Interesting comment.  I'm replying with the SE Linux list CC'd so everyone 
> who's involved can comment.
> 
> Maybe a change to make "\n" equivalent to "" in the SE Linux kernel interfaces 
> in question would be appropriate then?  For the SE Linux interfaces in 
> question a '\n' character is not valid in any part of the input and the input 
> must contain three fields separated by colons, so a special case of "\n" 
> being equivalent to "" can not cause any confusion.
> 
> Also as a side note, in the normal use only libselinux.so has any code which 
> does such zero byte writes.  Doing it from bash is only needed for testing, 
> debugging, and educational purposes.

Pity no one pointed out this deviation from POSIX when we originally
redesigned the SELinux API to address the kernel developers' comments on
the original syscall-based API.  In any event, write(fd, NULL, 0); does
work on /proc/pid/attr/<name> nodes despite what the write(2) man page
says, and the SELinux kernel API is obviously specific to Linux anyway
(although libselinux could be ported to SEBSD), and this API is never
suitable for use by scripts regardless of whether or not this particular
aspect is changed.   

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
