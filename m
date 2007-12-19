Subject: Re: Propper labeling of files under /var/www
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stefan Schulze Frielinghaus <stefan@seekline.net>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <47693353.7070809@redhat.com>
References: <1198003507.3705.15.camel@localhost6.localdomain6>
	 <1198004134.11568.4.camel@moss-spartans.epoch.ncsc.mil>
	 <1198059185.3342.3.camel@localhost6.localdomain6>
	 <1198073575.19081.1.camel@moss-spartans.epoch.ncsc.mil>
	 <47693353.7070809@redhat.com>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 10:29:05 -0500
Message-Id: <1198078145.19081.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-19 at 10:05 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Wed, 2007-12-19 at 10:13 +0000, Stefan Schulze Frielinghaus wrote:
> >> On Tue, 2007-12-18 at 13:55 -0500, Stephen Smalley wrote:
> >> [...]
> >>> Try restorecon -FRv /var/www
> >> Yeah that solved the problem. The -F option is a little bit tricky ;-)
> >> Never expected something like that.
> > 
> > /etc/selinux/targeted/contexts/customizable_types was created to allow
> > programs like restorecon to omit files with certain types from being
> > relabeled by default, so that admin customizations wouldn't be lost.
> > The httpd-related types are a common case of this, where the admin wants
> > to manually manage the type under the web root and not have them
> > clobbered.  As to whether it still makes sense when we have semanage
> > fcontext, I'm not sure.
> > 
> Yes I would like to remove it, it is more trouble then it is worth at
> this point.   semanage is the way things should be customized.  We
> should remove it from Fedora 9 and going forward.
> 
> Added munin cgi defitions to rawhide, but update does not fix them since
> they were already labeled httpd_sys_content_t.

So just ship an empty customizable_types file, and restorecon/setfiles
will relabel everything (aside from what is excluded via <<none>>).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
