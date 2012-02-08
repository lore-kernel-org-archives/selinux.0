Subject: Re: SELinux on Wheezy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <1328722790.23833.9.camel@foxtrot.cjac.ntr.f5net.com>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328543813.1905.2.camel@x220.mydomain.internal>
	 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636826.2162.60.camel@moss-pluto>
	 <1328640976.4224.39.camel@foxtrot.cjac.ntr.f5net.com>
	 <20120207200224.GB18478@colliertech.org>
	 <1328645305.2162.105.camel@moss-pluto>
	 <20120207210501.GE18478@colliertech.org>
	 <1328707470.19254.16.camel@moss-pluto>
	 <1328722790.23833.9.camel@foxtrot.cjac.ntr.f5net.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 08 Feb 2012 12:54:07 -0500
Message-ID: <1328723647.19254.62.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-02-08 at 09:39 -0800, C.J. Adams-Collier KF7BMP wrote:
> On Wed, 2012-02-08 at 08:24 -0500, Stephen Smalley wrote:
> > On Tue, 2012-02-07 at 13:05 -0800, C.J. Adams-Collier wrote:
> > > cjac@foxtrot:~$ sudo which seinfo
> > > cjac@foxtrot:~$ apt-file search seinfo | grep bin | wc -l
> > > 0
> > 
> > seinfo is part of the setools package.
> 
> $ apt-cache search -n setools
> erlang-parsetools - Erlang/OTP parsing tools
> 
> Hmm.
> 
> Would it be safe to build seinfo from source and use it along with the
> distro-installed tools?  If so, what's the git repo I should clone from?

Curious, as setools is packaged for Debian squeeze per
packages.debian.org.  Did the package go un-maintained before wheezy?

Upstream is at:
http://oss.tresys.com/projects/setools

> $ locate xserver.pp
> /usr/share/selinux/default/xserver.pp
> 
> I'll run semodule -i after this morning's reboot.  I installed mutt
> yesterday, so I'll work from the console until you folks sign off for
> the evening.

I'd suggest installing all of the .pp files to ensure you aren't missing
anything else.  The man page for semodule has some examples of how to
install all modules from a directory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
