Subject: Re: Installation of policy source
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Diyab <diyab@diyab.net>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1063639184.30627.38.camel@colossus.columbia.tresys.com>
References: <1063388343.30627.9.camel@colossus.columbia.tresys.com>
	 <1063388536.19531.185.camel@moss-spartans.epoch.ncsc.mil>
	 <3F624B45.2050109@diyab.net>
	 <1063636005.13311.98.camel@moss-spartans.epoch.ncsc.mil>
	 <1063639184.30627.38.camel@colossus.columbia.tresys.com>
Content-Type: multipart/mixed; boundary="=-iY+bbzoDOyNqSVhoLbcx"
Message-Id: <1063639604.13311.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Sep 2003 11:26:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-iY+bbzoDOyNqSVhoLbcx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-09-15 at 11:19, Karl MacMillan wrote:
> I think it would be clearer if the tarball creation was explicitly
> mentioned. Below is a modified patch that does that. Other than that
> this certainly meets my initial goals.

The expectation was that people using the rpm-based approach had
directly downloaded the individual tarballs from the NSA site, e.g. wget
http://www.nsa.gov/selinux/archives/policy-1.1.tgz.  However, I suppose
that this isn't a good assumption, as the patched SRPMS will have
problems building unless you've installed libselinux via rpm, since
rpm won't know about libselinux if you install it the old-fashioned way.

Unless I'm missing something, your revised instructions won't work;
rpmbuild will fail as it expects the tarball and directory name to
include the version suffix.  I've attached a README patch relative to my
prior one and a little script that can be used to build the tarballs in
the desired form from the selinux-usr tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-iY+bbzoDOyNqSVhoLbcx
Content-Disposition: attachment; filename=README.patch2
Content-Type: text/x-patch; name=README.patch2; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: selinux-doc/README
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/selinux-doc/README,v
retrieving revision 1.5
diff -u -r1.5 README
--- selinux-doc/README	15 Sep 2003 14:07:51 -0000	1.5
+++ selinux-doc/README	15 Sep 2003 15:17:40 -0000
@@ -161,6 +161,18 @@
 to boot 2.4 kernels on your system, as unmodified 2.4 kernels will not
 boot after you have assigned the SELinux EAs to the root filesystem.
 
+
+NOTE: If you downloaded the 'selinux-usr' archive, the 'build' script
+can be run to build and install the new SELinux packages via rpm so
+that the rpm database is properly updated and any other packages that
+depend on the new SELinux packages can be built with rpm.  This
+handles steps 2-5, although you will want to customize the policy as
+described in step 5 prior to building and installing it.
+	cd selinux-usr
+	su
+	./build
+
+
 2) Build and install the checkpolicy policy compiler.
 	rpmbuild -tb checkpolicy-*.tgz
 	rpm -Uvh /usr/src/redhat/RPMS/i386/checkpolicy*.rpm

--=-iY+bbzoDOyNqSVhoLbcx
Content-Disposition: attachment; filename=build
Content-Type: text/x-sh; name=build; charset=UTF-8
Content-Transfer-Encoding: 7bit

#!/bin/sh

# Build and install the new SELinux packages via rpm from the selinux-usr
# source tree.

# Note that this only installs the _new_ packages that we provide,
# not the SELinux-patched daemons and utilities or externally-produced
# new packages like Tresys setools.  The patched packages can be built via
# rpmbuild --define "WITH_SELINUX 1" --rebuild SRPMS/*.src.rpm, and
# can then be installed via rpm in the usual manner.

set -e

for d in checkpolicy libselinux policycoreutils 
do
	ver=`cat $d/VERSION`
	mv $d $d-$ver
	tar czf $d-$ver.tgz $d-$ver
	mv $d-$ver $d
	rpmbuild -tb $d-$ver.tgz
	rpm -Uvh --force /usr/src/redhat/RPMS/i386/$d*$ver*rpm
done

for d in policy selinux-doc
do
	ver=`cat $d/VERSION`
	mv $d $d-$ver
	tar czf $d-$ver.tgz $d-$ver
	mv $d-$ver $d
	rpmbuild -tb $d-$ver.tgz
	rpm -Uvh --force /usr/src/redhat/RPMS/noarch/$d*$ver*rpm
done

--=-iY+bbzoDOyNqSVhoLbcx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
