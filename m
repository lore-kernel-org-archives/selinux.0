From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: 2.6.0-test3
Date: Fri, 22 Aug 2003 23:21:21 +1000
References: <1061468940.1665.16.camel@kusturica> <20030822045320.GD15441@snoopy.apana.org.au> <1061557334.28086.71.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1061557334.28086.71.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308222321.21113.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Aug 2003 23:02, Stephen Smalley wrote:
> Upgrading a production system running the old SELinux is complicated by
> the fact that you would like to be able to upgrade the system while
> still in enforcing mode, and immediately transition to the new SELinux
> (also in enforcing mode) so that the system remains in a secure state
> throughout.  To do this, you would need to set the xattr values before
> you first boot the new SELinux kernel if you want it to successfully
> boot in enforcing mode, but you cannot set the xattr values until you
> have a kernel that includes the xattr handler. So you would need to back
> port the xattr handler to the old SELinux kernel (and merge the EA patch
> from acl.bestbits.at into it) so that you can set the values while still
> running the old SELinux code.  This is possible, but would take a little
> work by someone.

I get the impression that no-one at the NSA has the time to spare for 
back-porting the xattr handler, and it seems that everyone else who could do 
it is also focussed on 2.6.0.  So it looks like this isn't going to happen.

Also just writing the xattr handler would not be enough, you would need a 
program that can read SIDs and then write equivalent xattrs, it shouldn't be 
difficult but it's another thing that has to be done.

Finally you would need wrapper programs for login, sshd, etc that check which 
version of SE Linux is running and execute the correct version of the program 
to match (but this is easy to do).

> There are also the usual policy issues with upgrading
> a live system and the issues created by the API incompatibility between
> the old and new SELinux.

I think I've solved the policy issues.  I've got a policy tree which should 
work on both old-style and new-style SE Linux.  It's only tested on old-style 
however, but if there are any bugs then I expect them to be small.

> relabeling of ptys.  If you are using another filesystem type, e.g.
> reiserfs, you'll need to apply the reiser xattr patches developed by
> others and add a specific handler for the security namespace.  Also,

SUSE developed the ReiserFS xattr patches.  However they will not be merged 
into the main ReiserFS tree, Hans recommends waiting for ReiserFS v4 for 
xattr support.  :-#

> 2) We have found that vanilla 2.4 kernels will no longer boot after you
> have assigned the SELinux EAs to the root filesystem.  2.4 kernels
> patched with the EA patch from acl.bestbits.at will boot fine and
> vanilla 2.6 kernels will boot fine.  The underlying cause is still being
> investigated.  You may want to have a 2.4+EA kernel or a vanilla 2.6
> kernel (with EA support enabled) available as a fallback to perform
> emergency recovery and manual correction of xattr values.

NB  In my kernel patch package for Debian I have ported the LSM patch to 
operate with the ACL patch, and installing the LSM patch will also get the 
ACL patch.  So Debian users who build a kernel with a version of my patch 
package of 2003.07.11-2 (Aug 5) or later will be able to boot from their 2.4 
kernel if the upgrade fails.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
