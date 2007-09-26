Subject: Re: ANN:  Updated SELinux core userland release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, Manoj Srivastava <manoj.srivastava@stdc.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1190811814.1812.19.camel@gorn.columbia.tresys.com>
References: <1174593896.31436.158.camel@moss-spartans.epoch.ncsc.mil>
	 <1190750158.24726.166.camel@moss-spartans.epoch.ncsc.mil>
	 <1190811814.1812.19.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 09:25:48 -0400
Message-Id: <1190813148.15779.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 13:03 +0000, Christopher J. PeBenito wrote:
> On Tue, 2007-09-25 at 15:55 -0400, Stephen Smalley wrote:
> > An updated release of the SELinux core userland code is available from
> > the NSA web site, see:
> > http://www.nsa.gov/selinux/news.cfm#R070925
> > 
> > Updated versions of the stable and development (trunk) series can be
> > downloaded from:
> > http://www.nsa.gov/selinux/code/
> > 
> > For those who use the sourceforge svn tree, the stable branch and trunk
> > have been tagged as 20070925 under tags/stable and tags/devel
> > respectively for this release.
> > 
> > It would be useful to know if anyone is using the stable branch; it was
> > created for use by users and distributions that want maximal stability
> > (bug fixes and trivial code cleanups only), e.g. to provide updates to
> > an existing distribution release like Debian etch or Fedora Core 6 or
> > RHEL 5 without risking the potentially more disruptive changes from the
> > trunk/devel series.  However, I  haven't gotten the impression that it
> > is being actively used.
> 
> Gentoo uses the stable branch, and currently doesn't have plans to use
> 2.0.

Ok, maybe you can help give feedback then on what if any features you'd
like to see back ported from the trunk to the stable branch.  Examples
of things that are only presently in the 2.x series include:
- sepolgen and rewrite of audit2allow to use it,
- merge of setfiles and restorecon into a single program,
- merge of genhomedircon script into libsemanage,
- dlopen of libsepol by libselinux to avoid build-time dependency,
- disable dontaudit support in semodule and the libraries,
- improved error reporting in semodule and libsemanage for e.g. disk
full, read-only filesystem, etc.
- object class and permission discovery and mapping support,
- selabel interfaces and rewrite of setfiles to use them,
- per-command pam configs for newrole,
- refactored swig bindings for libselinux

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
