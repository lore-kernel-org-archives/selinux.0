Subject: Re: getfattr works, but getfilecon doesn't
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ncunningham@cyclades.com
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1112999252.3261.5.camel@desktop.cunningham.myip.net.au>
References: <1112999252.3261.5.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 12:06:13 -0400
Message-Id: <1113235573.22198.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-04-09 at 08:27 +1000, Nigel Cunningham wrote:
> Thanks for the responses to my email the other day.

Hmmm...did you get a response?  I think that the ramfs security xattr
patches weren't upstreamed because there wasn't a real demand for them
at the time, unlike the tmpfs security xattr support.

> I've made further progress, such that I now know that the labels are
> properly stored and accessible through the getfattr command, but not
> through getfilecon.
> 
> I added printks to the kernel, and see them activated in the case of
> getfattr, but not for getfilecon. The return code that getfilecon
> received back from its getxattr call is -1.

And what errno?  What does an strace should in terms of the actual
arguments passed to getxattr(2) by getfattr vs. getfilecon?  Different
sized buffers?

> I can keep working through this myself, but if someone knows the answer
> offhand, I'd really appreciate hearing it.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
