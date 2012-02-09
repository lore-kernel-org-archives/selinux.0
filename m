Subject: Re: SELinux on Wheezy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <1328808846.5174.41.camel@foxtrot.cjac.ntr.f5net.com>
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
	 <1328732265.19254.95.camel@moss-pluto>
	 <1328736760.5174.11.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328795756.6866.30.camel@moss-pluto>
	 <1328808846.5174.41.camel@foxtrot.cjac.ntr.f5net.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Feb 2012 12:53:31 -0500
Message-ID: <1328810011.6866.65.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-02-09 at 09:34 -0800, C.J. Adams-Collier KF7BMP wrote:
> > That's interesting, and it might explain why your policy didn't get
> > fully installed originally.  Is that alsa.pp file from the current
> > selinux-policy package or is it a leftover of an older one?  What is the
> > error you get with it?  It should be removed if it doesn't work.
> 
> cjac@foxtrot:~$ locate alsa.pp | xargs dpkg -S | awk -F: '{print $1}' | xargs debsums | grep alsa.pp
> /usr/share/selinux/default/alsa.pp                                            OK
> cjac@foxtrot:~$ 
> 
> How do I check for an error.  Not on STDOUT or STDERR it seems...  This
> may be one of the strangest, least useful error message I've ever seen.
> But it's got stiff competition.
>
> cjac@foxtrot:~$ locate alsa.pp | xargs dpkg -S | awk -F: '{print $1}' | xargs debsums | grep alsa.pp | sudo xargs semodule -i
> semodule:  Failed on OK!

I'm not sure what you are trying to do, but the above command will
ultimately call semodule -i on both alsa.pp and the "OK" string from the
output above, and as OK is not a module or even a file it naturally
fails.  I just wanted to know what semodule -i alsa.pp reports, since
you said it failed in some way.

> > Feel free to submit a patch for the EXAMPLES section in the semodule man
> > page.  Even better would be to improve semodule so that it automatically
> > detects the base module and handles it so that you can just do semodule
> > -i *.pp in all cases and not have to worry about filtering the list and
> > handling base specially.
> 
> sounds reasonable.  git uri anyone?

SELinux userspace lives at http://userspace.selinuxproject.org.
You can clone via git clone http://oss.tresys.com/git/selinux.git .
semodule is under policycoreutils.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
