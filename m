Subject: Re: Debian users: don't upgrade for now
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <1136133684.27906.59.camel@wintermute.xmldesign.de>
References: <1136133436.27906.56.camel@wintermute.xmldesign.de>
	 <1136133684.27906.59.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 11:52:19 -0500
Message-Id: <1136307139.27632.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-01-01 at 17:41 +0100, Erich Schubert wrote:
> Hello again:
> to all Debian users of SELinux:
> Avoid upgrading to either unstable or my backports.
> 
> This is not good:
> system_u:object_r:default_t      root
> 
> But I don't know how to get genhomedircon working properly any more.

As noted in the release announcement, genhomedircon does not yet support
ROLE expansion in homedir_template for managed policies (i.e. policies
built as modules and installed via semodule -> libsemanage).  But it
should fall back to the old behavior for monolithic policies.  Debian
policy package shouldn't be converted over to modular form until a)
refpolicy covers everything from strict policy and b) genhomedircon is
updated to deal with ROLE expansion in the managed case.

> Oh, and does anyone have a hint for me how to get /dev/log
> and /dev/initctl labeled properly with udev? Udev with SELinux is
> serious pain...

Fedora does a restorecon -R /dev from rc.sysinit to fix up the security
contexts on /dev, and then everything just works (assuming your udev has
SELinux support enabled).  There is a further SELinux patch to udev in
Fedora's CVS tree presently, but that is just an optimization; the basic
SELinux support should be in the upstream udev.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
