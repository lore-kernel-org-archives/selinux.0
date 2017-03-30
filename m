Message-ID: <1490896334.2099.4.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Fix SBLABEL_MNT for NFS mounts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "J. Bruce Fields" <bfields@redhat.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, James Morris
 <james.l.morris@oracle.com>, selinux@tycho.nsa.gov
Date: Thu, 30 Mar 2017 13:52:14 -0400
In-Reply-To: <20170330174147.GA11004@parsley.fieldses.org>
References: <20170329152724.19030-1-tomeu.vizoso@collabora.com>
 <20170329213439.GC19617@parsley.fieldses.org>
 <CAAObsKDThPAQpgO7R+JT=foU1=BEor-Zy7DES2tnGe=rGe=REw@mail.gmail.com>
 <1490894827.2099.2.camel@tycho.nsa.gov>
 <20170330174147.GA11004@parsley.fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-03-30 at 13:41 -0400, J. Bruce Fields wrote:
> On Thu, Mar 30, 2017 at 01:27:07PM -0400, Stephen Smalley wrote:
> > On Thu, 2017-03-30 at 09:49 +0200, Tomeu Vizoso wrote:
> > > On 29 March 2017 at 23:34, J. Bruce Fields <bfields@redhat.com>
> > > wrote:
> > > > On Wed, Mar 29, 2017 at 05:27:23PM +0200, Tomeu Vizoso wrote:
> > > > > Labelling of files in a NFSv4.2 currently fails with ENOTSUPP
> > > > > because
> > > > > the mount point doesn't have SBLABEL_MNT.
> > > > > 
> > > > > Add specific condition for NFS4 filesystems so it gets
> > > > > correctly
> > > > > labeled.
> > > > 
> > > > Huh.  Looking at the code, I think this is meant to be handled
> > > > by
> > > > the
> > > > SECURITY_FS_USE_NATIVE case--there was a similar failure fixed
> > > > some
> > > > time
> > > > ago by 9fc2b4b436cf.  What kernel are you seeing this on?  Is
> > > > it a
> > > > recent regression (in which case, what's the latest kernel that
> > > > worked
> > > > for you)?
> > > 
> > > I have seen this on 4.11-rc4, but I never tried to get this
> > > working
> > > before.
> > > 
> > > I will try to find time to see why SECURITY_FS_USE_NATIVE isn't
> > > working here.
> > 
> > Does your exports file specify the "security_label" option, e.g.
> > /path/to/dir example.com(rw,security_label)
> 
> Oops, right, that should have been the first thing I asked about....
> 
> > It appears that with recent kernels that is now required;
> > otherwise,
> > the mount defaults to not enabling native labeling and all of the
> > files
> > are treated as having a single, fixed label defined by the client
> > policy (and hence setxattr is not supported).  This was kernel
> > commit
> > 32ddd944a056c786f6acdd95ed29e994adc613a2.  I don't recall seeing
> > any
> > discussion of this on selinux list.  I understand the rationale,
> > but it
> > seems like a user-visible regression
> 
> It is.  I also want to keep new protocol upgrades free of user
> regressions, which the 4.1->4.2 upgrade is in most cases if we turn
> on
> security labeling by default.  So I was stuck choosing between two
> regresisons, and figured 4.2 user depending on security labeling was
> still the much rarer case.
> 
> So I'd like to keep security labeling off by default, but if there's
> anything I can do to smooth the transition obviously that's good.

Yes, I understand - wish though that it could have been communicated
better, e.g. on selinux list (unless I just missed it somehow).

> 
> > and at the very least, it seems odd that they didn't just use
> > "seclabel" as the kernel does in /proc/mounts to signify a
> > filesystem
> > that supports security labeling by userspace.
> 
> I see logic in sb_finish_set_opts() that sets SBLABEL_MNT in the
> selinux_is_sblabel_mnt() case.  Doesn't that mean "seclabel" shows up
> in
> /proc/mounts when we nfs sets SECURITY_LSM_NATIVE_LABELS?
> 
> I may not understand your comment, I'm pretty unfamiliar with this
> area.

Correct, I just meant it seems potentially confusing to users to use
"security_label" in exports when we show it as "seclabel" in
/proc/mounts.  I know, they are totally different namespaces (in the
conventional sense), but consistency might have been more user-
friendly.
