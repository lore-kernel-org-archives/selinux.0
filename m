Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7ADq13Z004424
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 09:52:01 -0400
Received: from tachyon.snu.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7ADppmM006500
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 13:51:51 GMT
Date: Thu, 10 Aug 2006 08:51:58 -0500 (CDT)
From: kmacmillan@mentalrootkit.com
To: Jim Meyering <jim@meyering.net>
cc: selinux@tycho.nsa.gov
Subject: Re: does mv need a --context=CTX (-Z) option, too?
In-Reply-To: <87hd0kc308.fsf@rho.meyering.net>
Message-ID: <Pine.LNX.4.64.0608100843530.4511@tachyon.snu.edu>
References: <87hd0kc308.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Aug 2006, Jim Meyering wrote:

> It might make sense to add a --context=CTX (-Z) option to mv.  Currently,
> cp, install, mkdir, mknod, mkfifo all have that option, but not mv.
> Most of the time, mv would have no need, since it simply calls rename.
> But when that fails, it reverts to using the very same copying code
> (copy.c) that cp uses.  It is trivial to add this option to mv, with the
> understanding that it'd take effect solely for e.g., cross-device moves.
> I.e., if you want to simulate a cross device move, you'd have to use
> cp -pr and rm -rf, so if it makes sense for cp to have the --context=CTX
> (-Z) option, then it follows that mv must accept it as well.
>

I think that mv should have that option. Actually, I think that the more 
pressing option is --preserve so that users can simulate the rename case 
across devices.

> This brings up another minor inconsistency: should the other
> named-file-creation programs (dd, ln, link, touch) in coreutils also
> accept the --context=CTX (-Z) option?
>
> With that only partly rhetorical question, you should see why I'd like
> an selinux/kernel hook that'd let me set the default fscreate context
> for the upcoming execve.  Then I could simply add one option to runcon
> and forget about all of these "-Z CTX" options.  IMHO, requiring all of
> these tools to add an option like "-Z CTX" to perform the same simple
> function is almost prohibitively onerous.
>

As Steve explained, this option is not safe. Trivial example: with this 
mechanism I could potentially cause passwd to create /etc/shadow with any 
context (well, passwd explicitly requests that context so that wouldn't 
work, but I think you get the idea). SELinux goes to great lengths to 
make execve safe for gaining privileges - this would go against that 
goal.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
