Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>, Jeremy Katz <katzj@redhat.com>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1147890417.30789.384.camel@moss-spartans.epoch.ncsc.mil>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147890417.30789.384.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 17 May 2006 14:28:15 -0400
Message-Id: <1147890495.22880.172.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-17 at 14:26 -0400, Stephen Smalley wrote:
> On Wed, 2006-05-17 at 09:54 +0200, Thomas Bleher wrote:
> > In http://marc.theaimsgroup.com/?l=selinux&m=114677075207486&w=2, I
> > outlined how rpm could work with the current kernel. I think this scheme
> > is preferable to changing the kernel, mainly because of two points:
> > 
> > * It makes it possible to later confine rpm more strictly:
> >   If you load policy before installing the package, you can use the
> >   policy server to prevent rpm from loading certain policies; rpm will
> >   only be able to put labels on disk it is allowed to by policy.
> >   If you load policy after package installation, rpm needs the labelpriv
> >   privilege, so you can't confine rpm in any meaningful sense.
> 
> >From the policy's perspective, rpm is being allowed to create/label
> files with unlabeled_t (as the files are treated as such while the
> labels are invalid) and to insert a policy module.  Access control on
> what the policy module can contain (what types it may define and what
> rules it may add) is the key to confining rpm (or rather, confining the
> particular process spawned by rpm in a suitable domain for the package
> being installed if rpm ever does that), and that is true regardless of
> whether rpm loads policy before or after setting down the files.  To
> close the loop between the undefined file labels and the policy module
> that was checked, it is important that rpm verify that all of the file
> labels set down by rpm became valid upon the policy load, and either
> warn the admin or take some corrective action (whether that means
> relabeling those files to truly be unlabeled_t, removing those files, or
> reverting the package install altogether) if they are not.  I suppose
> calling security_check_context() on each context from the header would
> suffice, followed by either a warning or corrective action if it fails
> on any of them.
> 

Only checking the contexts in the header would protect against malicious
packages but not a subverted rpm, right?

Karl

-- 
Karl MacMillan
Tresys Technology
www.tresys.com

> > * It allows rpm to know beforehand if the policy module will actually 
> >   apply on top of the current system policy (which is important if you 
> >   think of the differences between strict and targeted policy). It is
> >   better to abort install before than to have invalid labels on disk
> >   later.
> 
> I agree that rpm shouldn't leave invalid labels around on disk.  This is
> similar to the above problem.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
