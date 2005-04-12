Subject: Re: getfattr works, but getfilecon doesn't
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ncunningham@cyclades.com
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1113257683.3645.1039.camel@desktop.cunningham.myip.net.au>
References: <1112999252.3261.5.camel@desktop.cunningham.myip.net.au>
	 <1113235573.22198.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1113257683.3645.1039.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 08:38:17 -0400
Message-Id: <1113309497.25217.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-12 at 08:14 +1000, Nigel Cunningham wrote:
> Here's the output. (I have a few extra printfs in there from before I
> cross compiled strace).
> 
> I have seen, talking with Russell last night, that my policy install
> wasn't working quite right. I'm wondering now whether these issues will
> go away once I get the install right. It looks to me at the moment like
> the getfilecon is just not giving a helpful error from things it does as
> side-effects, rather than that the xattr call itself is failing.
> (Indeed, it must be this because the xattr call isn't even made!)

Hmm...this sounds familiar to me.  An obvious question is does the libc
on the target platform provide the xattr functions.  glibc built against
older kernel headers would leave them as null functions that just
returned -1 with errno set to something appropriate (ENOTSUPP, ENOSYS,
something like that), while glibc built against newer kernel headers
would provide the real wrapper functions that invoked the kernel
syscalls.  Hence, we used to have to link against libattr to pick up the
real xattr functions, but dropped that when we moved to a modern glibc.
That would explain why you aren't seeing any real call to getxattr(2),
even though getfilecon(3) does nothing more than malloc(3) a buffer and
call getxattr().

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
