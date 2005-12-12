Subject: Re: Latest Ref Policy Diffs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@namei.org>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4398A239.1080005@redhat.com>
References: <4398A239.1080005@redhat.com>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 09:54:46 -0500
Message-Id: <1134399286.7305.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-12-08 at 16:14 -0500, Daniel J Walsh wrote:
> Major change in targeted policy is about to hit.  Basically we are going 
> to turn off allow_execmod, allow_execmem, and allow_execstack by default 
> for unconfined_t programs.
> 
> So several of these patches are to allow that to happen.  Including 
> turning on a real xdm policy.  Getting rid of the alias of 
> texrel_shlib_t to shlib_t.  Mozilla libraries all marked 
> texrel_shlib_t.  ( A bug has been reported on this and hopefully a fix will
> be added.)
> 
> So far I see hal and Xorg as needing execmem.

As I recall, targeted policy was _very_ permissive in its granting of
execmod and execmem due to the early breakage problems when kernels with
those checks were shipped as updates to older Fedora releases
(particularly due to the ppc kernel problems).  From a quick look at
reference policy, it looks like this has been preserved in its
files_unconfined(), domain_base_type(), and unconfined_domain_template()
interfaces.  I'm also not sure that all occurrences of execmem et al are
wrapped with the booleans (execmod to texrel_shlib_t should remain
outside of the boolean, as that is the purpose of texrel_shlib_t, but
any other occurrences should be wrapped).

Nit:  It is more difficult to search through reference policy for
occurrences of execmem et al due to the inlining of
general_domain_access() everywhere (which happens to include it in an
exclusion list of permissions to not allow to self:process).  It will
also be harder to add further excluded permissions to that list in the
future due to such inlining.  Rationale for such inlining in the
reference policy?

> gfs support is added

I don't think gfs supports security xattrs yet, so I don't think you
want it to use fs_use_xattr as its labeling mechanism.  Even if it did
support security xattrs, we are going to run into a problem with
performing the inode security initialization on d_instantiate for remote
(or userspace) filesystems, because we cannot propagate ERESTARTSYS from
d_instantiate up the call chain presently, and such filesystems may need
to return that when they have to wait on a reply from the peer.  We'll
have the same issue for NFSv4.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
