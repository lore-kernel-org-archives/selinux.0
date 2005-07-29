Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6TJWcgA003288
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 15:32:38 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6TJQdC2007135
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 19:26:39 GMT
Subject: Re: file context ordering
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ron Kuris <rk@unify.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <42EA7B30.8090207@unify.com>
References: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
	 <42E946ED.2050705@unify.com> <1122660123.20983.58.camel@sgc>
	 <42EA7B30.8090207@unify.com>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 15:26:56 -0400
Message-Id: <1122665216.20983.63.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-29 at 11:53 -0700, Ron Kuris wrote:
> Christopher J. PeBenito wrote:
> | On Thu, 2005-07-28 at 13:58 -0700, Ron Kuris wrote:
> |
> |> Use M4 diversions ... [snip]
> |
> |
> | Well this is definitely an interesting solution.  The problem is
> | that it doesn't apply to the loadable policy modules, since the
> | file contexts in a module don't have m4.  Preserving m4 into the
> | modules, and having semodule run m4 to reconstruct file_contexts is
> | probably a bad idea. Adding a weight to specs, which is what Steve
> | suggested, would be more general than leveraging m4.
> |
> I guess I don't know enough about the loadable module plans.
> 
> So that means the loadable modules cannot use any of the m4 macros either?

They can; the m4 is expanded before compiling the module.  So if you
divert something in the file_contexts, it would only be diverted for
that module.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
