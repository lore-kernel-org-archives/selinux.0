Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14827
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 08:59:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA15447
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 12:58:14 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
        by jazzband.ncsc.mil  with ESMTP id MAA15442 for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 12:58:14 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "Brian May" <bam@snoopy.apana.org.au>
Cc: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: RE: Policy changes for policy management
Date: Fri, 26 Jul 2002 09:02:21 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIIEPGKEAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020726031453.GC27354@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > policy_src_t: The source files used to create a policy.  As I and others
> > have mentioned before, we believe that the policy.conf file is the
> > ultimate source file.  We are making proposed changes to the Makefile to
> > install the policy.conf file as well as the ./policy/ make directory,
and
> > to ensure that the installed binary policy file is only ever built from
> > the installed policy.conf file (the policy make directory is one means
of
> > generating the plicy.conf file).
>
> What do you mean by "source"? When I here the word "source" I think of
> the M4 files the sysadm edits.
>
> Do you plan to remove this M4 processing, or do you have another
> definition for the word source?
>
> I am working on a proposal to insert more structure into the
> source file for policy.conf, so I don't want to step on anybodies
> toes (if at all possible).

My definition of "policy source" is the policy.conf file and anything used
to build it.  In the current distribution, the ./selinux/policy/ directory
and all its files are one method for building a policy.conf file and
would all be labeled source.  Eventually the SE Linux community willhave
other
methods of building all or parts of the policy.conf file by other methods,
and
those methods' source files will also be "policy source" files.

> > PROBLEM: Currently the Makefile uses gzip to compress the binary file.
> > This is the only issue we can't resolve so far via changes to the
> > Makefile.  We would like (hint, hint) checkpolicy to incorporate the
zlib
> > or similar library so that the src-->binary translation is all handled
> > within the checkpolicy program (and domain). An interim solution might
be
> > for checkpolicy to fork/exec a gzip process directly within its current
> > domain??
>
> Another suggestion (which you may not like): Make the Makefile
> executeable by putting "#!/usr/bin/make -f" at the top, and use this
> to trigger the domain transition.

The problem with this is that we don't want the checkpolicy_t domain able to
execute arbitrary programs.  With the above suggestions, we have to give
checkpolicy execute access to bin_t and shells, which essentially means
we provided no isolated domain.  We're already stuck with this problem
for writing policy_src_t when using make.  It would be nice if we can avoid
this
problem for write access to policy_config_t.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
