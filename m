Subject: Re: ANN:  Updated SELinux core userland release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, Manoj Srivastava <manoj.srivastava@stdc.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1190815607.1812.27.camel@gorn.columbia.tresys.com>
References: <1174593896.31436.158.camel@moss-spartans.epoch.ncsc.mil>
	 <1190750158.24726.166.camel@moss-spartans.epoch.ncsc.mil>
	 <1190811814.1812.19.camel@gorn.columbia.tresys.com>
	 <1190813148.15779.53.camel@moss-spartans.epoch.ncsc.mil>
	 <1190815607.1812.27.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 27 Sep 2007 09:35:12 -0400
Message-Id: <1190900112.28872.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 14:06 +0000, Christopher J. PeBenito wrote:
> On Wed, 2007-09-26 at 09:25 -0400, Stephen Smalley wrote:
> > On Wed, 2007-09-26 at 13:03 +0000, Christopher J. PeBenito wrote:
> > > On Tue, 2007-09-25 at 15:55 -0400, Stephen Smalley wrote:
> > > > An updated release of the SELinux core userland code is available from
> > > > the NSA web site, see:
> > > > http://www.nsa.gov/selinux/news.cfm#R070925
> > > > 
> > > > Updated versions of the stable and development (trunk) series can be
> > > > downloaded from:
> > > > http://www.nsa.gov/selinux/code/
> > > > 
> > > > For those who use the sourceforge svn tree, the stable branch and trunk
> > > > have been tagged as 20070925 under tags/stable and tags/devel
> > > > respectively for this release.
> > > > 
> > > > It would be useful to know if anyone is using the stable branch; it was
> > > > created for use by users and distributions that want maximal stability
> > > > (bug fixes and trivial code cleanups only), e.g. to provide updates to
> > > > an existing distribution release like Debian etch or Fedora Core 6 or
> > > > RHEL 5 without risking the potentially more disruptive changes from the
> > > > trunk/devel series.  However, I  haven't gotten the impression that it
> > > > is being actively used.
> > > 
> > > Gentoo uses the stable branch, and currently doesn't have plans to use
> > > 2.0.
> > 
> > Ok, maybe you can help give feedback then on what if any features you'd
> > like to see back ported from the trunk to the stable branch.  Examples
> > of things that are only presently in the 2.x series include:
> 
> > - disable dontaudit support in semodule and the libraries,
> 
> If nothing else, this would be choice.  And/or the unknown perms
> handling.
> 
> > - refactored swig bindings for libselinux
> 
> If this fixes bugs in the current bindings, that'd be good choice too.

Ok, I've merged these changes and the improved error reporting for
libsemanage/semodule from trunk to stable in svn.  Let me know if you
spot any regressions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
