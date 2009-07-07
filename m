Subject: Re: [PATCH 1/4 -v2] Namespacing of security/selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1246909386.28321.148.camel@moss-pluto.epoch.ncsc.mil>
References: <1246906718.2460.12.camel@Ares>
	 <1246909386.28321.148.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 08:06:34 -0400
Message-Id: <1246968394.28321.171.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 15:43 -0400, Stephen Smalley wrote:
> On Mon, 2009-07-06 at 14:58 -0400, Thomas Liu wrote:
> > This patch namespaces the functions in security/selinux, prefixing
> > non static functions with selinux_
> > 
> > Patch 1 includes namespacing of the security/selinux folder,
> > not including security/selinux/ss.
> > 
> > Added selinux_ as a prefix to non static functions, not including
> > functions beginning with avc_.  Swapped security_ with selinux_.
> > 
> > Signed-off-by: Thomas Liu <tliu@redhat.com>
> > ---
> > This new set of patches no longer uses selinux_ss_ and no longer
> > puts the selinux_ prefix in front of avc_.
> > 
> > Also fixed a minor mishap with a double underscore not compiling.
> 
> Two things:
> 1) The goal is for the kernel to build and work after each patch in a
> patch series, particularly to avoid breaking git bisect.  Yes, that's
> hard to achieve, and it may just mean folding all of the patches into
> one if you can't find a logical way to split them up that meets that
> requirement.  Or you could follow the original outline I gave, i.e. one
> patch to rename just the security_ functions to selinux_, then one to
> rename certain key global variables, and then progress to the rest of
> the code.
> 2) scripts/checkpatch.pl in the kernel tree warns about lines over 80
> characters, which are introduced as a result of the renaming and may
> require breaking and reformatting existing lines.
> 
> Also, it would be good at this point to get others' opinions on the
> scope of the renaming.  Renaming the SELinux security_ functions is
> useful to avoid confusion/conflicts with the security framework.
> Renaming ss_initialized, policydb and sidtab is likewise useful to avoid
> conflicts.  Not as sure about the generic data structures and their
> functions, which do at least have some prefix already.

Ok, why don't we proceed this way:
1)  Create one patch that only renames security_ functions within
selinux to sel_ or selinux_ (I don't care which; Paul seemed to prefer
sel_ - James or Eric?).  That should be non-controversial and easy to
merge.
2) Create a second patch that renames key global variables
(ss_initialized, policydb, sidtab, others?) to have the same prefix.
But don't yet rename the data types.

For both patches, check them with checkpatch.pl and reformat any lines
that are too long as a result.
Then wait on the changing the rest, until we have some consensus on what
is desired.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
