Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0PCSFsj003980
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 07:28:15 -0500 (EST)
Subject: Re: [PATCH] dpkg helper for libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1106610654.3778.9.camel@localhost.localdomain>
References: <1106610654.3778.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1106655718.21318.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 25 Jan 2005 07:21:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-24 at 18:50, Lorenzo Hernández García-Hierro wrote:
> Attached you can find a patch that adds Debian package manager (dpkg)
> helper code to libselinux so It will work under the proper dpkg_t
> context type (as Russell defines on his policy packages for Debian).
> Man page updated and such.

Thanks.  However, rather than adding another special purpose helper, I'd
prefer to create a general function that will work for both rpm and
dpkg, and any other package management software.  The only aspect that
is truly rpm-specific of rpm_execcon is the default type, and this could
be read from a config file instead; however, changing it to use a
configuration file needs to be done carefully because of the
bootstrapping problem, i.e. rpm_execcon has to work even for an initial
installation from scratch (and we are now also encountering an issue
with getting it to work in a chroot'd environment for rpm --root).  That
isn't too different than the issue with having file_contexts available
for matchpathcon(); the solution IIUC there was to change the installer
(anaconda) to create an initial file_contexts configuration for
bootstrapping; it could also create a pkghelper_context configuration
file or similar.  I've cc'd the list and several other people as I think
this is a issue of general interest.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
