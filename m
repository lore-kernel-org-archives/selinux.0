Subject: Re: changes in ~2.6.13 break postfix policy?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Russell Coker <russell@coker.com.au>, James Morris <jmorris@namei.org>,
   SELinux@tycho.nsa.gov
In-Reply-To: <1131148407.1355.21.camel@wintermute.xmldesign.de>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de>
	 <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
	 <20051104183551.GC2837@legolas.drinsama.de>
	 <1131130924.23420.326.camel@moss-spartans.epoch.ncsc.mil>
	 <1131148407.1355.21.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 11:58:01 -0500
Message-Id: <1131382681.20591.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-11-05 at 00:53 +0100, Erich Schubert wrote:
> Hi,
> > Linus' -git tree for 2.6.15.  Where might one be able to obtain the
> > patches included in the Debian kernel?  Any direct use of sock_alloc()
> 
> http://packages.debian.org/linux-image-2.6.14-1-686-smp
> is the kernel I'm using. There is a link to the sourcecode.
> All the linux-2.6 packages are built from the same codebase, so the
> download for the source package is
> http://ftp.debian.org/debian/pool/main/l/linux-2.6/linux-2.6_2.6.14.orig.tar.gz
> http://ftp.debian.org/debian/pool/main/l/linux-2.6/linux-2.6_2.6.14-2.diff.gz
> (or any other debian mirror)
> 
> With debian packages, the .orig.tar.gz file usually contains the
> upstream provided source code unmodified (if possible by licence
> restrictions, ocassionally single files have to be remove due to
> licencing issues)
> and the debian specific changes are in the .diff.gz file.
> 
> I did a quick search in the .diff.gz for "sock_", 0 matches; but I
> didn't check the .orig.tar.gz file.

Yes, offhand, I don't see anything under patches-debian that looks
suspect.

Hmmm...can you supply any more info to help reproduce the bug?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
