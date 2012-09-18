Message-ID: <1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid and policy version
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, William Roberts <bill.c.roberts@gmail.com>,
        Joman
	Chu <jcchu@tycho.ncsc.mil>
Date: Tue, 18 Sep 2012 13:33:31 -0400
In-Reply-To: <1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil>
References: <4FFCC3C7.8080602@tresys.com>
	 <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
	 <4FFDD7C7.4020703@tresys.com>
	 <1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-11 at 15:49 -0400, Stephen Smalley wrote:
> On Wed, 2012-07-11 at 15:45 -0400, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > On Tue, 2012-07-10 at 20:07 -0400, Joshua Brindle wrote:
> > >> I was looking at this:
> > >> <https://android-review.googlesource.com/#/c/36321/4/init/init.c>
> > >>
> > >> and remembered that years ago we had a discussion about the .policyver
> > >> filename syntax. I kind of get it for SELinux machines where there is
> > >> managed policy and could be multiple policies on the system but since
> > >> SEAndroid is targeting non-device managed policies, it adds extra code
> > >> to search for the right extension and you can tell what version the
> > >> policy is as soon as you open it, why not ditch the suffix?
> > >
> > > First, that patch doesn't introduce the use of the version suffix
> > > (that's in the already merged code); it just preserves it in the new
> > > logic for reloading policy at runtime.
> > 
> > I know, it just reminded me that I wanted to mention it :)
> > 
> > >
> > > I'm open to removing the use of the policy version suffix in a follow-on
> > > patch, although that would need to be coordinated across sepolicy and
> > > system/core.  But the current code is consistent with existing practice
> > > in Linux distributions (so follows principle of least surprise) and it
> > 
> >  From what I can tell most people doing anything with SEAndroid have never been 
> > exposed to SELinux so it probably is surprising to them that the file extension 
> > would change version to version.
> > 
> > > allows for different versions to be installed simultaneously (thereby
> > > supporting booting multiple kernels).  Also, we don't have libsepol on
> > 
> > I don't think this will ever be an issue on mobile devices (and I don't think it 
> > ever was an issue on real machines, more likely that stale policies were being 
> > enforced if there was some kernel or library change)
> > 
> > > the device so we cannot in fact determine the version when we open it
> > > there presently.  So I'm not convinced we should remove the suffix.
> > 
> > We don't need libsepol, just read the first few bytes, a la file.
> 
> We need libsepol at least if we want to support automatic downgrading of
> the policy to a version supported by the kernel.  So unless we think we
> can guarantee that Android userspace + kernel are always updated in
> lock-step and one will never want to support multiple kernels, it seems
> a bit inflexible to drop the versioning.

So this issue has come up again in the context of implementing device
admin APIs and a sample device admin app.  The device admin API
implementation in the system_server needs to know how to name the file
it creates under /data/system for the kernel policy, but it has no way
to determine the actual policy version of the supplied policy.  So it
doesn't know what suffix to use.  Options:
- Get rid of the version suffix altogether, or at least for the sepolicy
file under /data/system.
- Have the system_server parse the header of the policy image to
determine the policy version, and use that as the suffix.

Thoughts?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
