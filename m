Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA12061
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 18:30:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA16220
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 22:28:34 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
        by jazzband.ncsc.mil  with ESMTP id WAA16216 for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 22:28:34 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: Policy changes for policy management
Date: Thu, 25 Jul 2002 18:32:56 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIAEPCKEAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We're in the middle of putting together policy changes for managing the
policy itself.  Among other reasons, we need this to build a policy for
our seuser tool.  Others have mentioned similar work  looking at
operational management policies.  This is not as straightforward as I had
hope. The current best solution we can devise can only be a partial
solution until we create a policy management daemon that will manage the
policy pieces and run in a very controlled domain.  Until then we must
still allow the sysadm_t domain, with its ability to run just about any
program, significant access to policy files.  Nonetheless I see that as a
temporary issue; we can put the infrastructure in place using
policy_config_t and policy_src_t, with some additions, and begin the
discipline of a DTE policy for policy management.

I want to outline what we're doing and raise some issues, in order to see
what others think as well as hopefully motivate some changes in
checkpolicy.

The primary types and domains we are using are as such:

policy_src_t: The source files used to create a policy.  As I and others
have mentioned before, we believe that the policy.conf file is the
ultimate source file.  We are making proposed changes to the Makefile to
install the policy.conf file as well as the ./policy/ make directory, and
to ensure that the installed binary policy file is only ever built from
the installed policy.conf file (the policy make directory is one means of
generating the plicy.conf file).

policy_config_t: The label for the binary file as is currently used.

checkpolicy_t: The domain for the checkpolicy program.  Our goal is that
this domain be restricted to read only policy_sr_t files, and is the ONLY
domain capable of writing the installed binary file type (policy_config_t).

PROBLEM: Currently the Makefile uses gzip to compress the binary file.
This is the only issue we can't resolve so far via changes to the
Makefile.  We would like (hint, hint) checkpolicy to incorporate the zlib
or similar library so that the src-->binary translation is all handled
within the checkpolicy program (and domain). An interim solution might be
for checkpolicy to fork/exec a gzip process directly within its current
domain??

load_policy_t: The domain for load_policy program.  The goal is that this
domain (except for kernel_t) be the only domain with load_policy access to
the security object.  We haven't tested this yet, but foresee no problems.

We're also making several other proposed changes to the current policy
Makefile to conform with the above.

Comments, complaints, suggestions, etc?? We're still testing.

Also, any suggestions where the policy source files (both the installed
policy.conf and the policy make directory) might be installed.  For now
we're using /etc/security/selinux/src for both, but really have no strong
opinion about the location of these.


Frank



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
