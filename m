Subject: Re: SELinux on Wheezy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <1328736760.5174.11.camel@foxtrot.cjac.ntr.f5net.com>
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
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Feb 2012 08:55:56 -0500
Message-ID: <1328795756.6866.30.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-02-08 at 13:32 -0800, C.J. Adams-Collier KF7BMP wrote:
> Okay.  Do these ever get purged under any other circumstances?  I noted
> that when I booted without selinux enabled and then with it enabled, the
> filesystem was re-labeled.  Does anything else get triggered in this
> situation?  Specifically, do policies get removed?

No.

> It looks like the alsa.pp is failing, so my working and slightly
> modified command was:

That's interesting, and it might explain why your policy didn't get
fully installed originally.  Is that alsa.pp file from the current
selinux-policy package or is it a leftover of an older one?  What is the
error you get with it?  It should be removed if it doesn't work.

>         $ pushd /usr/share/selinux/default
>         $ time sudo \
>         semodule -i `ls *.pp | grep -v -e 'base.pp' -e 'alsa.pp'`
>         
>         real	0m24.148s
>         user	0m23.249s
>         sys	0m0.628s
>         
> This seems like it would take slightly less time than piping the output
> of ls to xargs, since it only runs semodule once.
> 
>         $ time ls *.pp | grep -v -e 'base.pp' -e 'alsa.pp' | \
>         xargs sudo semodule -b base.pp -i 
>         
>         real	0m25.659s
>         user	0m24.778s
>         sys	0m0.660s
> 
> But they both get the job done and the difference in run time is very
> small.

Feel free to submit a patch for the EXAMPLES section in the semodule man
page.  Even better would be to improve semodule so that it automatically
detects the base module and handles it so that you can just do semodule
-i *.pp in all cases and not have to worry about filtering the list and
handling base specially.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
