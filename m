Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u04GbRRo005719
 for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2016 11:37:27 -0500
Received: by mail-wm0-f43.google.com with SMTP id l65so169336176wmf.1
 for <selinux@tycho.nsa.gov>; Mon, 04 Jan 2016 08:37:11 -0800 (PST)
Date: Mon, 4 Jan 2016 17:37:08 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] update deps and change yum to dnf
Message-ID: <20160104163708.GB8382@x250>
References: <1451917434-40069-1-git-send-email-brindle@quarksecurity.com>
 <20160104163031.GA8382@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20160104163031.GA8382@x250>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Mon, Jan 04, 2016 at 05:30:31PM +0100, Dominick Grift wrote:
> On Mon, Jan 04, 2016 at 09:23:54AM -0500, Joshua Brindle wrote:
> > ---
> >  README | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/README b/README
> > index dae1eb9..2497485 100644
> > --- a/README
> > +++ b/README
> > @@ -2,7 +2,7 @@ Please submit all bug reports and patches to selinux@tycho.nsa.gov.
> >  Subscribe via selinux-join@tycho.nsa.gov.
> >  
> >  Build dependencies on Fedora:
> > -yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig ustr-devel
> > +dnf install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig ustr-devel gcc redhat-rpm-config xmlto
> 
> What are xmlto, and redhat-rpm-config for?

Oh i see it is to build man pages (https://github.com/SELinuxProject/selinux/blob/master/secilc/Makefile#L14)

redhat-rpm-config seems only needed if you use rpm to build? If you use
rpm to build then there are probably other requirements as well, and
then i believe you do not strictly require that package or gcc for that
matter since those are part of the core build tools (1):

 Exceptions

There is no need to include the following packages or their dependencies
as Build Requires because they would occur too often. These packages are
considered the minimum build environment.

bash
bzip2
coreutils
cpio
diffutils
fedora-release (and/or redhat-release)
gcc
gcc-c++
gzip
make
patch
perl
rpm-build
redhat-rpm-config
sed
tar
unzip

(1) https://fedoraproject.org/wiki/HOWTOFindMissingBuildRequires

> 
> Building secilc html and pdf docs requires pandoc as per: https://github.com/SELinuxProject/selinux/blob/master/secilc/README#L59
> 
> >  
> >  To build and install everything under a private directory, run:
> >  make DESTDIR=~/obj install install-pywrap
> > -- 
> > 2.5.0
> > 
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> -- 
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> Dominick Grift

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWip+uAAoJENAR6kfG5xmcdgwL/22baZ8MBVEiE9adrKSgUKal
ig/DmEchlYHuRYvpyEYK7M85vVHpom0vs7X2nAQbxmEnLLYlBdmQzrl872f4lqY8
xR7RPoA1NPKaBtY0yvj4h8AD/AtlSioXB81XMzOTXpss+y1D6HyDur/Grakx86kN
7wA6KVhlQaZEVbuAjBJ3mYt/sQFH6zRg4EKP1r5ebpxWTDdZfI0kwoSD/+cHPct6
HI3/CfOAVBULd/zHn35MKe9njIq2g+5KP7M99h4mziraiA2kVo0mngoWw8yFMjE9
H+4lrG9/J2T8eiPiThqXdw6oFaK7Wu3AP/HYSOcsuFn9U9stMmr7SKG9gBBGn3BL
SUuiekmsG2bNGWf3EmjxUMTlZDxwyVEGv25BgNX0UoxbvHKDAOQS7jYezHqOh6/g
AV5uPa2b27cwRKm03I5R3HtPOJppShjINWuaMDvn7XUD33oNrsH55tWYOiXF6D0E
esIJeUrwtyiGlOiUAYltMtLvqaFvClppxRCMo1545Q==
=EmOE
-----END PGP SIGNATURE-----
