Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA15753
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 09:08:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA19482
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 14:07:50 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA19478 for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 14:07:49 GMT
Date: Tue, 19 Mar 2002 09:08:36 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: file_contexts
In-Reply-To: <20020318224643.A12F922B0@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203190852330.2799-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 18 Mar 2002, Russell Coker wrote:

> I think that the reasonable use of the sample domains/programs/*.te files is
> to remove the ones that don't apply to your system.
>
> After removing unwanted *.te files and loading the policy I then can't run
> setfiles.

Even ignoring the setfiles problem, you are still likely to encounter
problems with removing unwanted domain .te files due to interactions among
domains.  To some degree, we can reduce this problem by relocating some of
the rules and by using type attributes in some cases to better encapsulate
each domain.  But we can't completely eliminate such inter-domain
dependencies.

> To solve this problem I am thinking of modifying the setfiles program to make
> it silently (unless in verbose mode) ignore any lines that refer to a type
> that's not in policy.  So for example if I remove the policy file for ppp
> then after running setfiles /usr/sbin/pppd will have sbin_t instead of
> pppd_exec_t.
>
> What do you think?

I'm uneasy about the lack of any error checking in that case (e.g. someone
makes a typo in file_contexts).  David Wheeler suggested a while back that
we partition file_contexts into a collection of files, like the policy,
that are merged together during the build, with each file corresponding to
one of the domain .te files.  He suggested the convention of a foo.fc file
(fc == file context) for each foo.te file.  The challenge in that case is
ensuring that the ordering dependencies of file_contexts are preserved.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
