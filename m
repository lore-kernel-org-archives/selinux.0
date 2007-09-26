Subject: Re: ANN:  Updated SELinux core userland release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Manoj Srivastava <manoj.srivastava@stdc.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1190750158.24726.166.camel@moss-spartans.epoch.ncsc.mil>
References: <1174593896.31436.158.camel@moss-spartans.epoch.ncsc.mil>
	 <1190750158.24726.166.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 13:03:34 +0000
Message-Id: <1190811814.1812.19.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-25 at 15:55 -0400, Stephen Smalley wrote:
> An updated release of the SELinux core userland code is available from
> the NSA web site, see:
> http://www.nsa.gov/selinux/news.cfm#R070925
> 
> Updated versions of the stable and development (trunk) series can be
> downloaded from:
> http://www.nsa.gov/selinux/code/
> 
> For those who use the sourceforge svn tree, the stable branch and trunk
> have been tagged as 20070925 under tags/stable and tags/devel
> respectively for this release.
> 
> It would be useful to know if anyone is using the stable branch; it was
> created for use by users and distributions that want maximal stability
> (bug fixes and trivial code cleanups only), e.g. to provide updates to
> an existing distribution release like Debian etch or Fedora Core 6 or
> RHEL 5 without risking the potentially more disruptive changes from the
> trunk/devel series.  However, I  haven't gotten the impression that it
> is being actively used.

Gentoo uses the stable branch, and currently doesn't have plans to use
2.0.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
