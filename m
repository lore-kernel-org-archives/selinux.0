Subject: Re: avtab reduction, binary policy format version change
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1123780887.7810.78.camel@moss-spartans.epoch.ncsc.mil>
References: <1123780887.7810.78.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 09:12:00 -0400
Message-Id: <1124457120.32663.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-11 at 13:21 -0400, Stephen Smalley wrote:
> The patches to libsepol and checkpolicy for reducing the size and number
> of avtab nodes have been committed to the sourceforge CVS tree as of
> libsepol 1.7.13 and checkpolicy 1.25.8.  The kernel patch is going to be
> submitted soon for -mm, but will not go into mainline until 2.6.14.  The
> binary policy format version has been incremented to version 20.  To
> build a policy for older kernels, you will need to use the -c 19 option
> to checkpolicy.  The patches for the kernel, libsepol, and checkpolicy
> are also available from http://www.flux.utah.edu/~sds/, as are complete
> patched tarballs of libsepol and checkpolicy.
> 
> The policy Makefile will likely need to be adjusted again to generate
> both version 19 and version 20 policies during the transition, and to
> load the appropriate one based on the kernel policy version.

FYI:  The kernel patch for these changes is now included in
2.6.13-rc6-mm1.  Also, the libsepol/checkpolicy changes are in rawhide.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
