Subject: Re: 2.6.0-test3
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Brian May <bam@snoopy.apana.org.au>
Cc: Russell Coker <russell@coker.com.au>, Dale Amon <amon@vnl.com>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20030822045320.GD15441@snoopy.apana.org.au>
References: <1061468940.1665.16.camel@kusturica>
	 <200308212337.59952.russell@coker.com.au> <20030821172554.GD4481@vnl.com>
	 <200308221204.56942.russell@coker.com.au>
	 <20030822045320.GD15441@snoopy.apana.org.au>
Content-Type: text/plain
Message-Id: <1061557334.28086.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Aug 2003 09:02:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-22 at 00:53, Brian May wrote:
> On Fri, Aug 22, 2003 at 12:04:56PM +1000, Russell Coker wrote:
> > However those of us who use different versions of the relevant applications, 
> > or who use alternate programs will have some coding to do.  Also the process 
> > of upgrading from old SE Linux to new SE Linux will be slightly more 
> > difficult than doing a fresh install of SE Linux...  :(
> 
> What is required to upgrade?
> 
> I assume the biggest problem will be the file labels?

The migration to xattr and the overhaul of the SELinux API make an
upgrade more complicated than a typical SELinux upgrade.  See the
selinux-doc README for detailed installation instructions for the new
SELinux, and the selinux-doc PORTING for notes on porting SELinux-aware
applications and SELinux policy configurations from the old SELinux. 
Also, the slides from the 2003 OLS SELinux BOF available from the NSA
site have some notes about the changes to SELinux.

Upgrading a production system running the old SELinux is complicated by
the fact that you would like to be able to upgrade the system while
still in enforcing mode, and immediately transition to the new SELinux
(also in enforcing mode) so that the system remains in a secure state
throughout.  To do this, you would need to set the xattr values before
you first boot the new SELinux kernel if you want it to successfully
boot in enforcing mode, but you cannot set the xattr values until you
have a kernel that includes the xattr handler. So you would need to back
port the xattr handler to the old SELinux kernel (and merge the EA patch
from acl.bestbits.at into it) so that you can set the values while still
running the old SELinux code.  This is possible, but would take a little
work by someone.  There are also the usual policy issues with upgrading
a live system and the issues created by the API incompatibility between
the old and new SELinux.

Some caveats about upgrading to the new SELinux, also noted in the
selinux-doc files:
1) It relies on xattr support in the filesystem and an xattr handler for
the security namespace in the filesystem.  We have only implemented such
handlers for ext[23] as well as a "pseudo" handler for devpts to support
relabeling of ptys.  If you are using another filesystem type, e.g.
reiserfs, you'll need to apply the reiser xattr patches developed by
others and add a specific handler for the security namespace.  Also,
note that the support for genfs_contexts has been greatly reduced; the
problem is that mapping an inode to a pathname is not generally
supportable in the kernel except in specialized cases like proc.  We can
work on restoring support for other filesystem types on a case-by-case
basis if a reliable means can be found for performing such mappings for
that filesystem type.  devfs appears to be obsolete, so it isn't likely
worth spending time on reviving support for it.

2) We have found that vanilla 2.4 kernels will no longer boot after you
have assigned the SELinux EAs to the root filesystem.  2.4 kernels
patched with the EA patch from acl.bestbits.at will boot fine and
vanilla 2.6 kernels will boot fine.  The underlying cause is still being
investigated.  You may want to have a 2.4+EA kernel or a vanilla 2.6
kernel (with EA support enabled) available as a fallback to perform
emergency recovery and manual correction of xattr values.

3) The initial policy load has been moved into userspace and is
performed from an initrd.  You must build an initrd that includes the
new load_policy utility and a copy of your binary policy and that
performs the initial policy load before the real root filesystem is
mounted.  See the selinux-doc README for a sample patch to mkinitrd to
do this.

4) The SELinux network access controls (but not the socket access
controls) have been temporarily dropped, as the implementation depended
on the LSM networking security fields and hooks that were rejected for
mainline 2.5.  We plan on restoring a subset of the original
functionality in the future using only the set of hooks that were
accepted plus NetFilter, as well as revisiting the set of permission
checks to provide more effective controls.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
