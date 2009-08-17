Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7HCb67N011639
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 08:37:06 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n7HCcCST018471
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 12:38:13 GMT
Subject: Re: policycoreutils, sepolgen (sepolgen-ifgen) issues on Debian
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Manoj Srivastava <srivasta@golden-gryphon.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <878whm1gr5.fsf@anzu.internal.golden-gryphon.com>
References: <87d46y1lwd.fsf@anzu.internal.golden-gryphon.com>
	 <878whm1gr5.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Mon, 17 Aug 2009 08:36:29 -0400
Message-Id: <1250512589.27712.89.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-08-14 at 11:50 -0500, Manoj Srivastava wrote:
> On Fri, Aug 14 2009, Manoj Srivastava wrote:
> 
> >         I am running into an issue with sepolgen on Debian. Debian ships
> >  more than one  version of the refpolicy, a default one, and a
> >  MLS enabled one. So, the include files live in either
> >  /usr/share/selinux/{default,mls}/include
> >
> >         sepolgen (in src/sepolgen/defaults.py) sets refpolicy_devel() to
> >  a single location -- and thus, only one version of the security policy
> >  may be supported. So, sepolgen-ifgen from policycoreutils can only work
> >  with one policy, which may not be the one installed on the target
> >  machine. Could this be made configurable, somehow? As far as I can
> >  see, sepolgen's python library does not offer any way to set the value.
> >
> >         It would be nice if the location of the include directory could
> >  be looked for from a PATH like variable setting, to make it easier for
> >  distributions to ship more than one policy, or for end users to
> >  experiment with other policies without have to overwrite the single
> >  default. 
> 
>         Well, here is a kind of proof-of-concept patch (python is not my
>  strong suit), and I have only tested in that it allows the package to
>  compile, and the following code works:
[...]
>  def refpolicy_makefile():
> -    return refpolicy_devel() + "/Makefile"
> +    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
> +    return chooser("Makefile")
>  
>  def headers():
> -    return refpolicy_devel() + "/include"
> -    
> +    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
> +    return chooser("include")
> +

Why are you making another config file rather than just get the policy
name from /etc/selinux/config via selinux_getpolicytype()?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
