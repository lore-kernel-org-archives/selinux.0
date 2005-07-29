Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6TI8pgA002387
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 14:08:51 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6TI2qC2029269
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 18:02:52 GMT
Subject: Re: file context ordering
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ron Kuris <rk@unify.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <42E946ED.2050705@unify.com>
References: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
	 <42E946ED.2050705@unify.com>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 14:02:03 -0400
Message-Id: <1122660123.20983.58.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-28 at 13:58 -0700, Ron Kuris wrote:
> My suggestion:
> 
> Use M4 diversions to raise the priority of the more important rules.
> M4 will output diverted text at the end of the script, and you can
> prioritize each section this way.
> 
> This worked perfectly for me when I had a similar problem:
> 
> divert(3)
> [ insert selinux rules here ]
> divert(0)
> 
> The rules between the diverts will be output at the end, in order by
> the diversion number (in this case, 3).

Well this is definitely an interesting solution.  The problem is that it
doesn't apply to the loadable policy modules, since the file contexts in
a module don't have m4.  Preserving m4 into the modules, and having
semodule run m4 to reconstruct file_contexts is probably a bad idea.
Adding a weight to specs, which is what Steve suggested, would be more
general than leveraging m4.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
