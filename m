Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14CiC53006799
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 07:44:12 -0500 (EST)
Subject: Re: Restart
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Subba Rao <castellan2004-member@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4202D376.7040009@yahoo.com>
References: <4202D376.7040009@yahoo.com>
Content-Type: text/plain
Message-Id: <1107520656.8078.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 07:37:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-03 at 20:44, Subba Rao wrote:
> Hello everyone,
> 
> In the past I have tried and droped building a SELinux system.   This 
> time I want to get back into it and get it working right.  One of the 
> primary reason for failure in the past was due to my choice of distro 
> (Slackware).  I tried to compile in the kernel patches and got several 
> errors or warnings.  I still use Slackware, however I will try to 
> compile it on Debian or Fedora.
> 
> I want to build the SELinux kernel.  The big question I have is, what 
> are the libaries or utilities that need to be installed?  Do you need 
> PAM, Kerberos....etc?  My last compile attempt (years ago) on Debian 
> prompted for several such packages.  I used apt_get and installed such 
> packages but that did not resolve the issue.  Please let me know what 
> are the basic requirements for building a SELinux patch kernel.

First, I think your dependency issues (on PAM, etc) had to do with the
patched userland, not the kernel.  Status of SELinux for distros is
summarized at http://selinux.sf.net.

Fedora Core 3 (http://fedora.redhat.com) already includes SELinux
support in the kernel and userland.  Hardened Gentoo likewise already
includes SELinux support, see
http://www.gentoo.org/proj/en/hardened/selinux/index.xml, although they
only support SELinux for servers AFAIK.  Hence, with those two distros,
you shouldn't need to rebuild the kernel or install any modified or
extra userland packages outside of the main distro.  

I believe that SELinux support was enabled in the Debian unstable
kernels recently, but possibly defaulting to off, so you might have to
boot with selinux=1.  Debian userland doesn't have SELinux support
integrated yet; you still need separate packages, e.g. see
http://www.coker.com.au/selinux and
http://people.debian.org/~adric/selinux/coreutils/, but I think that
there is an effort underway to get the SELinux support integrated into
Debian post-sarge.  For SuSE, there was partial support included in SuSE
Linux 9.x, and Thomas Bleher has a set of packages from
http://www.cip.ifi.lmu.de/~bleher/selinux/.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
