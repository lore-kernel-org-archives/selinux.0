Subject: Re: 2.6.0-test3
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200308222321.21113.russell@coker.com.au>
References: <1061468940.1665.16.camel@kusturica>
	 <20030822045320.GD15441@snoopy.apana.org.au>
	 <1061557334.28086.71.camel@moss-spartans.epoch.ncsc.mil>
	 <200308222321.21113.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1061561820.28086.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Aug 2003 10:17:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-22 at 09:21, Russell Coker wrote:
> I get the impression that no-one at the NSA has the time to spare for 
> back-porting the xattr handler, and it seems that everyone else who could do 
> it is also focussed on 2.6.0.  So it looks like this isn't going to happen.

It really wouldn't be difficult to do, and certainly doesn't require any
deep SELinux or xattr knowledge.  Just copy fs/ext3/xattr_security.c and
the related changes to fs/ext3/{Makefile,super.c} and fs/Config.in from
the new 2.4-based SELinux to the old 2.4-based SELinux.  Of course, you
do need to merge the EA patch from acl.bestbits.at as well, but that
also shouldn't be too difficult.

> Also just writing the xattr handler would not be enough, you would need a 
> program that can read SIDs and then write equivalent xattrs, it shouldn't be 
> difficult but it's another thing that has to be done.

If you simply want to set the xattrs from the file contexts
configuration, you can just run the new setfiles program.  If you want
to set the xattrs from the persistent label mapping, then you would need
to restore the psid code to the new setfiles program and adjust it to
get the value from the mapping and set the xattr from it.  Not
difficult, but a little bit of work.

> Finally you would need wrapper programs for login, sshd, etc that check which 
> version of SE Linux is running and execute the correct version of the program 
> to match (but this is easy to do).

Not clear if this is necessary, unless you want to be able to switch
back and forth.  If you just want to upgrade, you should be able to just
install the new versions while running the old kernel (since this won't
affect already running instances) and then immediately boot the new
kernel.

> SUSE developed the ReiserFS xattr patches.  However they will not be merged 
> into the main ReiserFS tree, Hans recommends waiting for ReiserFS v4 for 
> xattr support.  :-#

I'm not sure about this guidance, as reiser4 isn't in mainline yet, and
last I looked at the reiser4 code, it did NOT include any xattr support
or handlers.  Using the SuSE xattr patches for reiser seems to be the
only real option for current reiser users.

> NB  In my kernel patch package for Debian I have ported the LSM patch to 
> operate with the ACL patch, and installing the LSM patch will also get the 
> ACL patch.  So Debian users who build a kernel with a version of my patch 
> package of 2003.07.11-2 (Aug 5) or later will be able to boot from their 2.4 
> kernel if the upgrade fails.

It should then be a very easy task to transfer over the xattr_security.c
handlers and the corresponding changes from the new 2.4-based SELinux to
your patch so that the older SELinux can access the xattrs.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
