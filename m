Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA23258
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2001 16:33:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA00651
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2001 20:33:02 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id UAA00647
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2001 20:33:01 GMT
Date: Mon, 2 Apr 2001 16:32:37 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Hubertus Franke <frankeh@us.ibm.com>
cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov
Subject: Re: Rule Set Based Access Control (RSBAC)
In-Reply-To: <OF1FF569C0.58910115-ON85256A22.005148CB@pok.ibm.com>
Message-ID: <Pine.SOL.3.95.1010402145703.8569J-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


We've looked at RSBAC, since it has a number of similarities
to SELinux.  In the following discussion, I'll try to summarize
some of our observations about how RSBAC compares with SELinux.
Of course, I'll welcome correction if I am in error about
some aspect of RSBAC.

RSBAC is based on the Generalized Framework for Access Control
(GFAC), while SELinux is based on the Flask security architecture.
Like the Flask architecture, the GFAC separates policy from
enforcement and can support a variety of security policies.
With regard to the specific policy modules implemented in
the two systems, RSBAC provides a Role Compatibility policy module 
that has similarities to the SELinux Type Enforcement policy module.

However, RSBAC also differs from SELinux in a number of ways:

1) The GFAC does not specifically address the issue of atomic policy
changes, so RSBAC lacks the SELinux support for dynamic security 
policies and revocation.

2) RSBAC does not appear to provide policy-independent data types for
security labels (the security context and security identifier in
Flask/SELinux), and it appears to expose policy-specific data types in
its kernel ADF interfaces (through attribute parameters), new system
calls, and on-disk file labels.  Furthermore, the kernel ADF depends on
private kernel data structures and data types, and even takes pointers to
private kernel objects as parameters through an attribute structure for
some decisions.  This weakens the separation between policy and
enforcement.  SELinux provides cleaner separation between the policy and
enforcement through its data types, interfaces, and even in its
security server implementation.  In part, this cleaner separation is a
historical consequence of the fact that the security server was
originally a user space server running on a microkernel in the
predecessors of SELinux (DTMach, DTOS, and Flask).  In SELinux,
the security server is a kernel subsystem, like the RSBAC ADF,
but the interface still provides the same separation as in its
predecessor systems.

3) RSBAC does not appear to have an equivalent to the SELinux
access vector cache (AVC) or AVC entry references in order
to minimize the performance overhead of its controls.

4) RSBAC appears to lack equivalents for the extended API calls and new
API calls of SELinux, instead only providing calls for setting and getting
attributes of existing subjects and objects.  SELinux provides
extended versions of existing system calls for creating new subjects
and objects with specified labels (execve_secure, mkdir_secure).
It also provides new API calls to allow applications to obtain
security policy decisions from the security server in order to
support application policy enforcers.  For example, a windowing
system might be enhanced to provide labeling and separation of
windows, with controlled cut-and-paste between windows, or
a database management system might be enhanced to provide
labeling and separation of individual database records maintained
in a single file.  These application policy enforcers would
still be controlled by the kernel, but could further refine
the granularity of protection provided by the kernel.

5) RSBAC appears to lack a number of the controls provided by SELinux for
each of the kernel subsystems.  Some examples of such gaps in its
controls include:  consistent controls on changes in process
labels, controls on the inheritance and transfer of open file
descriptions across execve or via local IPC, control of asynchronous I/O
signals, control of receiving the exit status via wait, controls on
the use of Linux capabilities, failure to check permission to
all affected directories and files for several of the directory
operations, and the lack of an equivalent to the layered networking
controls provided by SELinux.  Furthermore, the SELinux controls are
designed to address both the case where the ordinary API call is used
(e.g. execve) and the case where the extended API call is used (e.g.
execve_secure) in a consistent manner, while the RSBAC controls
only address the ordinary API calls.

6) RSBAC uses the Linux real user identity attribute for its decisions
and must control changes to this attribute, so it is not completely
orthogonal to the existing Linux access controls.  There is
a configuration option for maintaining a separate user identity
attribute, but the option is not robust and is not recommended.
SELinux maintains a separate user identity attribute as part
of the process security context, and is not dependent on the Linux 
identity attributes for the correct enforcement of the mandatory 
security policy.

7) Most of the RSBAC policy modules are very hardwired in their
policy logic, and can be easily expressed using the SELinux Type
Enforcement (TE) configuration.  The RSBAC Role Compatibility (RC) module 
has many parallels to TE, but it seems to be weaker in its
controls over role/domain changes and it has special cases
that are more cleanly addressed in the TE configuration (e.g.
its special values for inheritance vs. TE transition rules).
The RC module also has some implementation limitations (e.g.
limitation to 64 roles and types) while the SELinux TE module
has no such fixed limitation.  RSBAC does not appear to have an equivalent
to the human-readable SELinux policy configuration files, and it requires
that the policy be configured through a set of new utilities that use new
system calls. 

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com









--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
