Message-ID: <72222DC86846D411ABD300A0C9EB08A101524354@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Howard Holm'" <hdholm@epoch.ncsc.mil>, SELinux@tycho.nsa.gov
Subject: RE: SELinux RPM Version
Date: Mon, 22 Apr 2002 07:40:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, April 19, 2002 6:08 PM, Howard Holm wrote:


> That is excellent news.  I think that will make things a lot easier
> for many people.  Do you have a plan for "naming" the release?
> SELinux is a complicated case since there are source/RPM/deb
> releases for the parts of SELinux (e.g., fileutils) which may
> need to be different for different "base" distributions (e.g.,
> RedHat 7.1, Red Hat 7.3) and which may have both stable and
> developmental kernel versions.  The best I've been able to
> come up with so far (and I'm not very happy with it so I hope
> you've come up with something better) is to name "Packages" in
> the SourceForge, not RPM sense, something like:
> 
> Red Hat 7.2 SELinux Stable
> Red Hat 7.2 SELinux Developer
> Debian Woody SELinux Stable
> Debian Woody SELinux Developer
> 
Current SELinux package
	selinux-<kernel version>-<NSA Release number>
	Current planed release:
		selinux-2.4.18-2002031409.i386.rpm
		selinux-dev-2.4.18-2002031409.i838.rpm
	This package contains all Selinux programs
	such as the policy files, newrole, and setfiles.
	Where dev is for development mode kernel.

The modified utilities are in a separate package.
	fileutils-selinux-4.1-4.i386.rpm

If future releases of selinux I think we should sub-divided into
more packages
	selinux-kernel-<kernel version>-<NSA Release number>
	selinux-policy-<version number>-<release>
	selinxu-utils-<version number>-<release>
		To include newrole, run_init and ......
		Or a separate rpm for utility ?

For the policy maker
	selinux-policy-<policy name>-<version number>-<release>

> I think if you use both Provides: fileutils-4.1-4 and
> Obsoletes: fileutils-4.1-4 you don't need to --replacefiles
> and fileutils-4.2 won't automatically upgrade (you'll have
> to use a fileutils-selinux-4.2 or a fileutils-4.2 which
> obsoletes fileutils-selinux).  At least that's how I read
> the CHANGES file and dependencies files in /usr/share/doc/rpm-4.0.3
> (look at 2.4.7 -> 2.4.8 in CHANGES and later.)  Note that I
> have not tested this so I could be wrong about the effect.

I am going to add the Obsoletes, if it works, the to rpms.

Currently there is a question if any package should rebuild the 
policy. The current rpm I am building will only build a policy
if /etc/selinux/policy does not exist. It created it and installs
the example policy. Other wise if /etc/selinux/policy exist the
install will not touch the policy.



Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
