Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA14251
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 07:35:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA11672
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 11:34:11 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA11668 for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 11:34:10 GMT
Date: Fri, 26 Jul 2002 07:35:20 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: Policy changes for policy management
In-Reply-To: <ACEHIKGIGFEDAIKEMMMIAEPCKEAA.mayerf@tresys.com>
Message-ID: <Pine.GSO.4.33.0207260729031.13369-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 25 Jul 2002, Frank Mayer wrote:

> PROBLEM: Currently the Makefile uses gzip to compress the binary file.
> This is the only issue we can't resolve so far via changes to the
> Makefile.  We would like (hint, hint) checkpolicy to incorporate the zlib
> or similar library so that the src-->binary translation is all handled
> within the checkpolicy program (and domain). An interim solution might be
> for checkpolicy to fork/exec a gzip process directly within its current
> domain??

This can certainly be done, although no promises on when it will be done.
Unless, of course, someone wants to submit a patch for it (hint, hint).
As a side note, notice that it is not necessary to gzip the binary file
prior to loading - the kernel security server will accept either form,
gzipped or not.  We could simply refrain from gzip'ing the policy by
default, only doing this for initrd policies where space is at a premium.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
