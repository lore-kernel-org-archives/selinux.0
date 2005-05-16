From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: ls -Z on non-SE machine
Date: Mon, 16 May 2005 21:48:33 +1000
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
References: <200505151921.23171.russell@coker.com.au> <1116243084.28782.12.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1116243084.28782.12.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505162148.38650.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 16 May 2005 21:31, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > I believe that the best thing to do is to have ls not be linked against
> > libselinux and instead just call the XATTR api for reading the file
> > contexts. Ideally I think that such functionality should be enabled
> > unconditionally so that any administrator who receives a disk that was
> > used on a SE Linux system will have the ability to conveniently view all
> > the data on it.
>
> I disagree with this.  ls can be linked against libselinux and use
> getfilecon and friends and still work fine on a non-SELinux enabled
> system.

It's true that libselinux functionality required by ls can work on a non-SE 
machine.  However in that case when coreutils is compiled for non-SE systems 
ls will not have such functionality.  I believe that it would be best to have 
the "ls -Z" functionality on systems without libselinux.

> If you look at getfilecon's implementation in libselinux, 
> you'll see that it will work on fine on any kernel that provides the
> xattr API and includes the security namespace for xattrs.  Using the
> libselinux getfilecon(3) function has the following advantages:
> 1) It internally handles allocation of the context buffers, simplifying
> the application code, unlike getxattr.

There is already code in coreutils to manage xattrs, can some of that be 
re-used?

> Instead of changing ls to use getxattr, we should just remove the
> is_selinux_enabled() check from ls and allow use of -Z at any time
> (worst case is that we'll end up with an error return from getfilecon,
> which is possible anyway and already being handled for the case where
> the filesystem doesn't support xattrs).

The MLS issue is compelling, this change will do.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
