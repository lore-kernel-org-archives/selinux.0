Subject: Re: Updated SELinux Release
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 13:19:48 -0500
Message-Id: <1099505988.20150.45.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 10:39 -0500, Stephen Smalley wrote:
> I'd like to propose a couple of changes for future SELinux releases for
> discussion:
> 
> 1) I'd like to revive the proposal I originally made in 
> http://marc.theaimsgroup.com/?l=selinux&m=107669747828428&w=2, i.e. drop
> patched userland packages from the upstream SELinux releases and simply
> refer people to the appropriate sites for the various distros (as is
> already done in the selinux-doc README).  Maintenance of the SELinux
> userland patches has been handled entirely by others for quite some
> time, and I don't see any valid reason for us to continue carrying them
> on the NSA site.  We only carry a small subset of the patched userland
> packages on our site anyway (compared to the far more extensive set in
> Fedora), and our site will always lag behind the latest versions
> available for the various distros.  If a reference set is desired, it
> could always be placed on the sourceforge site, although I think that a
> review should be done of the complete set of patched packages in Fedora
> to see whether any other packages should be included in the reference
> set (and note that in some cases, SELinux modifications have been
> directly integrated into the Fedora source tree and are not carried as
> separate patches anymore).
> 

This certainly seems reasonable to me - I for one haven't used these for
almost a year.

> 2) I'd like to do away with the complete prepatched kernel tarball and
> full userland tarball, and only distribute a kernel patch and the
> individual component tarballs for checkpolicy, libsepol, libselinux,
> policycoreutils, etc.  The prepatched kernel tarball doesn't seem very
> useful to me, as most people likely want to combine the SELinux kernel
> patch with other patches and prebuilt kernel packages with SELinux
> support are available for the various distros now.  The full userland
> tarball seems redundant to me, and packagers of SELinux are using the
> individual component tarballs anyway.  Any objections to dropping these
> two tarballs?
> 

This also sounds appropriate to me.

I would also suggest that the external contributed tools be moved out of
the cvs repository. I think it is still nice to distribute tarballs of
the tools with the release, but the tools in cvs end up just being
snapshots (sometimes out of date). That would make the selinux sf cvs
repository just for core SELinux code, which seems like the right model.
The release process would become simply collecting tarballs from
contributors some days before the release and then placing them on the
webpage with the rest of the code on sf.

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
