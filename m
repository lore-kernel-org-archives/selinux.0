Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4PEqWRb018472
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 10:52:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4PEqSAR029114
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 14:52:28 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4PEqSHn029110 for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 14:52:28 GMT
Subject: Re: [PATCH][RFC] Allow administrator control over per-user
	default_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Timothy <timothy@diyab.net>, Russell Coker <russell@coker.com.au>,
   Valdis.Kletnieks@vt.edu, selinux@tycho.nsa.gov,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <20040525083744.GB3264@lkcl.net>
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil>
	 <200405240612.15645.russell@coker.com.au>
	 <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil>
	 <200405241004.07827.timothy@diyab.net>
	 <1085408849.26446.98.camel@moss-spartans.epoch.ncsc.mil>
	 <20040525083744.GB3264@lkcl.net>
Content-Type: text/plain
Message-Id: <1085496677.30578.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 25 May 2004 10:51:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-25 at 04:37, Luke Kenneth Casson Leighton wrote:
> the important bit that i wanted to mention to you is that in
> the NT security model GROUPS can own objects (files, processes
> etc).
> 
> this is distinctly different from unix, whereby only users can
> own files (and it causes a lot of problems for anyone implementing
> an SMB server if they choose to map direct to any kind of
> unix file system rather than provide their own)
>  
> 
> groups being able to own objects means greatly simplified management.
> 
> so, what i was wondering: is there a similar such concept in
> SE/Linux, with domains?

Objects are labeled with security types, processes are labeled with
security domains, and an access matrix defines allowable interactions
among them.  We were talking about derived types, i.e. types that encode
information about both the creating domain and object type and preserve
separation among the domains, e.g. user_default_context_t for
$HOME/.default_contexts files created by user_r:user_t processes.  This
is commonly done via parameterized macros in the policy configuration.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
