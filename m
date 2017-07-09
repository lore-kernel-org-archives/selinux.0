Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v69ACbgp029197
 for <selinux@tycho.nsa.gov>; Sun, 9 Jul 2017 06:12:37 -0400
Received: by mail-pg0-f53.google.com with SMTP id j186so35921772pge.2
 for <selinux@tycho.nsa.gov>; Sun, 09 Jul 2017 03:12:35 -0700 (PDT)
Date: Sun, 9 Jul 2017 18:12:29 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: ANN: SELinux userspace 2.7-rc4 release candidate
Message-ID: <20170709101229.GA806@meriadoc.perfinion.com>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1498237648.2063.4.camel@tycho.nsa.gov>
 <1498845208.16913.17.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1498845208.16913.17.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

https://bugs.gentoo.org/show_bug.cgi?id=621062
I'm fairly short on time lately. Does the patch in this bug seem right?
If it does can you apply it before the final release?

Thanks,
Jason

On Fri, Jun 30, 2017 at 01:53:28PM -0400, Stephen Smalley wrote:
> A fourth (and hopefully final) release candidate for the SELinux
> userspace is now available at:
> https://github.com/SELinuxProject/selinux/wiki/Releases
> 
> Please give it a test and let us know if there are any issues.
> Barring any significant further changes, a final 2.7 release is likely
> the week of July 10th.
> 
> Changes from the -rc3 release:
> 
> Laurent Bigonville (1):
>       Fix consistency of PYTHONLIBDIR variable across modules
> 
> Nicolas Iooss (3):
>       Travis-CI: update the list of Ruby's and Python's versions
>       libsepol/tests: override CPPFLAGS too
>       Travis-CI: test defining CFLAGS, LDFLAGS, etc. on make command
> line
> 
> Stephen Smalley (2):
>       libselinux,libsemanage: fix RUBYLIBS definition
>       Update VERSION files for 2.7-rc4 release.
> 
> 
> 
> 
