Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA12929
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 23:15:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA27244
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 03:13:48 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id DAA27240 for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 03:13:44 GMT
Date: Fri, 26 Jul 2002 13:14:53 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Frank Mayer <mayerf@tresys.com>
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: Policy changes for policy management
Message-ID: <20020726031453.GC27354@snoopy.apana.org.au>
References: <ACEHIKGIGFEDAIKEMMMIAEPCKEAA.mayerf@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIAEPCKEAA.mayerf@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 25, 2002 at 06:32:56PM -0400, Frank Mayer wrote:
> The primary types and domains we are using are as such:
> 
> policy_src_t: The source files used to create a policy.  As I and others
> have mentioned before, we believe that the policy.conf file is the
> ultimate source file.  We are making proposed changes to the Makefile to
> install the policy.conf file as well as the ./policy/ make directory, and
> to ensure that the installed binary policy file is only ever built from
> the installed policy.conf file (the policy make directory is one means of
> generating the plicy.conf file).

What do you mean by "source"? When I here the word "source" I think of
the M4 files the sysadm edits.

Do you plan to remove this M4 processing, or do you have another
definition for the word source?

I am working on a proposal to insert more structure into the
source file for policy.conf, so I don't want to step on anybodies
toes (if at all possible).

> policy_config_t: The label for the binary file as is currently used.
> 
> checkpolicy_t: The domain for the checkpolicy program.  Our goal is that
> this domain be restricted to read only policy_sr_t files, and is the ONLY
> domain capable of writing the installed binary file type (policy_config_t).

Sounds good.

> PROBLEM: Currently the Makefile uses gzip to compress the binary file.
> This is the only issue we can't resolve so far via changes to the
> Makefile.  We would like (hint, hint) checkpolicy to incorporate the zlib
> or similar library so that the src-->binary translation is all handled
> within the checkpolicy program (and domain). An interim solution might be
> for checkpolicy to fork/exec a gzip process directly within its current
> domain??

Another suggestion (which you may not like): Make the Makefile
executeable by putting "#!/usr/bin/make -f" at the top, and use this
to trigger the domain transition.

> load_policy_t: The domain for load_policy program.  The goal is that this
> domain (except for kernel_t) be the only domain with load_policy access to
> the security object.  We haven't tested this yet, but foresee no problems.

Again sounds good.

> We're also making several other proposed changes to the current policy
> Makefile to conform with the above.
> 
> Comments, complaints, suggestions, etc?? We're still testing.
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
