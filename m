Subject: Re: ls -Z on non-SE machine
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200505151921.23171.russell@coker.com.au>
References: <200505151921.23171.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 16 May 2005 07:31:24 -0400
Message-Id: <1116243084.28782.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-05-15 at 19:21 +1000, Russell Coker wrote:
> Currently "ls -Z" refuses to operate if it detects that SE Linux is not 
> enabled on the machine.

This is a historical artifact of the time when ls --context relied on
the SELinux API, which was only present in SELinux-patched and enabled
kernels (prior to the 2.6 SELinux).  

> This makes no sense to me.  Files that are labelled when running SE Linux keep 
> their labels (and the values of such labels may still be read) when not 
> running SE Linux.  It seems quite reasonable to me that an administrator may 
> want to take a disk out of a SE Linux machine and mount it on a non-SE 
> machine for debugging problems or forensics.  The current behavior of ls 
> works against such operations.

I agree; this is just a historical artifact, although an admin can use
getfattr and similar utilities at present to get this information when
SELinux is disabled.

> I believe that the best thing to do is to have ls not be linked against 
> libselinux and instead just call the XATTR api for reading the file contexts.  
> Ideally I think that such functionality should be enabled unconditionally so 
> that any administrator who receives a disk that was used on a SE Linux system 
> will have the ability to conveniently view all the data on it.

I disagree with this.  ls can be linked against libselinux and use
getfilecon and friends and still work fine on a non-SELinux enabled
system.  If you look at getfilecon's implementation in libselinux,
you'll see that it will work on fine on any kernel that provides the
xattr API and includes the security namespace for xattrs.  Using the
libselinux getfilecon(3) function has the following advantages:
1) It internally handles allocation of the context buffers, simplifying
the application code, unlike getxattr.
2) It encapsulates the attribute name (security.selinux),
3) It allows the introduction of a transparent translation layer within
libselinux to translate MLS labels, as discussed previously (I have some
concerns with this, but it is the current approach by TCS and does save
a lot of engineering time on the individual utilities).

Instead of changing ls to use getxattr, we should just remove the
is_selinux_enabled() check from ls and allow use of -Z at any time
(worst case is that we'll end up with an error return from getfilecon,
which is possible anyway and already being handled for the case where
the filesystem doesn't support xattrs).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
