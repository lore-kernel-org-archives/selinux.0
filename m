Subject: Re: semanage and RHPL
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stephen Bennett <spb@gentoo.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <20060712210909.575163ad@localhost>
References: <20060712210909.575163ad@localhost>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 08:22:59 -0400
Message-Id: <1152793379.10075.191.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-12 at 21:09 +0100, Stephen Bennett wrote:
> Hi,
> 
> After encountering some problems with modular policy in the released
> toolchain packages, it was suggested to me that I try the svn
> toolchain. I did this, and found that semanage and genhomedircon both
> traceback when run, failing to import functions from rhpl.translate.
> This package doesn't appear to be available in Gentoo's repository, and
> a quick bit of searching suggests that it's a Red Hat-specific library.
> Is this dependency intentional or desirable? If yes, where can we get
> the sources to package it for other distros?
> 
> Thanks in advance for any input.

rhpl.translate is described as a "persistent global gettext service for
python programs".  Not sure why that is RH specific.

The source is available from the Fedora CVS tree
(http://cvs.fedora.redhat.com) as well as in the SRPMS.  You can grab it
via:
curl -O -R -S --fail --show-error http://cvs.fedora.redhat.com/repo/dist/rhpl/rhpl-0.187.tar.gz/7979e7677a5cb32c06d176052403c707/rhpl-0.187.tar.gz

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
