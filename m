Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Howard Holm <hdholm@epoch.ncsc.mil>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: SELinux RPM Version
Date: Sat, 20 Apr 2002 11:51:00 +0200
Cc: SELinux@tycho.nsa.gov
References: <72222DC86846D411ABD300A0C9EB08A101524351@csoc-mail-box.csoconline.com> <20020419190749.B26414@gricklegrass.epoch.ncsc.mil>
In-Reply-To: <20020419190749.B26414@gricklegrass.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020420095100.EDD0723BE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 20 Apr 2002 01:07, Howard Holm wrote:
> developmental kernel versions.  The best I've been able to
> come up with so far (and I'm not very happy with it so I hope
> you've come up with something better) is to name "Packages" in
> the SourceForge, not RPM sense, something like:
>
> Red Hat 7.2 SELinux Stable
> Red Hat 7.2 SELinux Developer
> Debian Woody SELinux Stable
> Debian Woody SELinux Developer

I have no plans to ever upload Debian packages to Sourceforge.

My "selinux" and "linselinux-dev" packages are already in Debian/unstable, 
the packages of modified utilities are on my web site at the moment, I aim to 
eventually get most of them in unstable too.

For the ones that I can't get into the main Debian tree I'll setup my own apt 
source.

> completely different version numbering scheme to avoid
> confusion with NSA base releases, but that makes it difficult
> to know which NSA base release 1.23SF is based on.

This is a problem.  But as we get the SE changes into the upstream 
distribution it'll become less of a problem.

> Ideally, I think you would want a kernel package (kernel-selinux?)
> that Provides: selinux (as a virtual package) so that packages

Do you mean having a kernel-binary package?  If so that's a bad idea.

Having a kernel binary package installed does NOT mean you are running that 
kernel.  You can have several kernels installed and be running any of them.

Also many people don't like packaged kernels and build their own.

But one thing you need is a kernel-patch package for the LSM patch.  I have a 
kernel-patch-2.4-lsm and a kernel-patch-2.5-lsm package.  Then I have the 
main selinux package build-depending on the kernel-patch-2.4-lsm package, it 
extracts the patch itself (doesn't rely on having full kernel source 
available) for the header files.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
