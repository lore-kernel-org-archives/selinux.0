Subject: Re: SELinux on Wheezy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <1328730315.5174.1.camel@foxtrot.cjac.ntr.f5net.com>
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
	 <1328723647.19254.62.camel@moss-pluto>
	 <1328730315.5174.1.camel@foxtrot.cjac.ntr.f5net.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 08 Feb 2012 15:17:45 -0500
Message-ID: <1328732265.19254.95.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-02-08 at 11:45 -0800, C.J. Adams-Collier KF7BMP wrote:
> > > $ locate xserver.pp
> > > /usr/share/selinux/default/xserver.pp
> > > 
> > > I'll run semodule -i after this morning's reboot.  I installed mutt
> > > yesterday, so I'll work from the console until you folks sign off for
> > > the evening.
> > 
> > I'd suggest installing all of the .pp files to ensure you aren't missing
> > anything else.  The man page for semodule has some examples of how to
> > install all modules from a directory.
> 
> What's the best way to do this at boot?

You just do it once and it remains until/unless you remove it with
semodule -r.  No need to do it on each boot.  Normally it is done when
you install the policy package, but since your policy package apparently
didn't install all modules, I'm suggesting that you do so manually.  

cd /usr/share/selinux/default
ls *.pp | grep -Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule -b base.pp -i
should install them all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
