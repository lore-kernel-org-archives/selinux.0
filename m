Subject: Re: labeling of compilers etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: James Morris <jmorris@namei.org>, SELinux-dev@tresys.com,
   SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <200602032215.44188.russell@coker.com.au>
References: <200601291156.13076.russell@coker.com.au>
	 <200602021027.16336.russell@coker.com.au>
	 <1138883552.18268.114.camel@moss-spartans.epoch.ncsc.mil>
	 <200602032215.44188.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 08:26:12 -0500
Message-Id: <1138973172.18268.332.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-03 at 22:15 +1100, Russell Coker wrote:
> How would they get that precompiled code to be executed?  We want to make such 
> things as difficult as possible.  One of the first aims of such work is to 
> make all debuggers etc unavailable to such processes.

LD_PRELOAD=evil.so bash

Now, I suppose that would fail if you are truly restricting execute
access for the user to a minimal set of programs and not giving them
execute to anything they can write (which btw eliminates the concern
about compilers, because they can then generate all the code they want
but they can't get it to execute, nor should any other domain be allowed
to execute anything they can write).

> The shell is no easier to control via debuggers etc than any other process.

My point was simply that if you are running the shell in the same domain
as other user processes, you have no isolation/protection guarantees for
the shell, and thus it can't truly be trusted to enforce any access
controls on the user.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
