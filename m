Subject: Re: SELinux on Wheezy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "C.J. Adams-Collier" <cjac@colliertech.org>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <20120207210501.GE18478@colliertech.org>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328543813.1905.2.camel@x220.mydomain.internal>
	 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636826.2162.60.camel@moss-pluto>
	 <1328640976.4224.39.camel@foxtrot.cjac.ntr.f5net.com>
	 <20120207200224.GB18478@colliertech.org>
	 <1328645305.2162.105.camel@moss-pluto>
	 <20120207210501.GE18478@colliertech.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 08 Feb 2012 08:24:30 -0500
Message-ID: <1328707470.19254.16.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-02-07 at 13:05 -0800, C.J. Adams-Collier wrote:
> cjac@foxtrot:~$ sudo which seinfo
> cjac@foxtrot:~$ apt-file search seinfo | grep bin | wc -l
> 0

seinfo is part of the setools package.

> Sounds reasonable.  Do I get policy from my distribution, or should I
> generate one myself?

Normally from your distribution, assuming the selinux packages for
Debian are still being maintained.

IIRC, the Debian selinux policy package tries to minimize the set of
installed policy modules based on the set of installed packages, but
that isn't an exact mapping and might be leaving you without a complete
policy.  Whereas Fedora installs all policy modules unconditionally.

If the .pp files are on your filesystem and just not installed into the
policy store, you can manually add them by running semodule -i on them.
Try listing the files installed from your policy packages and see if
xserver.pp is among them.  

> cjac@foxtrot:~$ dpkg -l | grep selinux-policy
> ii  selinux-policy-default               2:2.20110726-3                 Strict and Targeted variants of the SELinux policy
> ii  selinux-policy-dev                   2:2.20110726-3                 Headers from the SELinux reference policy for building modules
> ii  selinux-policy-doc                   2:2.20110726-3                 Documentation for the SELinux reference policy
> 
> cjac@foxtrot:~$ apt-cache search selinux-policy
> selinux-policy-default - Strict and Targeted variants of the SELinux policy
> selinux-policy-dev - Headers from the SELinux reference policy for building modules
> selinux-policy-doc - Documentation for the SELinux reference policy
> selinux-policy-mls - MLS (Multi Level Security) variant of the SELinux policy
> selinux-policy-src - Source of the SELinux reference policy for customization
> 
> If I'm going to generate one myself, I need to understand them a bit
> better.  I would like anything I generate to be useable by the rest of
> the Debian world.  There seem to be some examples I ran review in the
> selinux-policy-doc and selinux-policy-mls packages.
> 
> Regarding re-labeling, every time I boot without the selinux arguments
> to my kernel and then boot with them, the filesystem seems to get
> re-labeled.  Is there a better way to do this?

On Fedora, you could touch /.autorelabel or pass "autorelabel" on the
kernel command line to force a relabel at boot.  You can also run
fixfiles relabel as a command after booting.  No need to disable SELinux
and then re-enable it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
